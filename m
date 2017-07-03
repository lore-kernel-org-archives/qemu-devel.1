Received: from eggs.gnu.org ([2001:4830:134:3::10]:53308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dRzrx-0001W5-0a
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dRzrr-0001YO-UD
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:50:21 -0400
Received: from mail-ve1eur01on0119.outbound.protection.outlook.com
	([104.47.1.119]:43402
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dRzrr-0001WA-0r
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:50:15 -0400
References: <1498495550-72357-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1498495550-72357-12-git-send-email-anton.nefedov@virtuozzo.com>
	<416200823.44425042.1498730528050.JavaMail.zimbra@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <2e0cd377-3320-3e93-55a7-ca7de66a36a6@virtuozzo.com>
Date: Mon, 3 Jul 2017 14:50:07 +0300
MIME-Version: 1.0
In-Reply-To: <416200823.44425042.1498730528050.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 11/13] virtio-console: chardev hotswap
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Amit Shah <amit@kernel.org>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, pbonzini@redhat.com

On 06/29/2017 01:02 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> Looks good, but please write something in the commit message about what n=
eeds to be done for be-change (what this patch does).
>=20
> thanks
>=20

Hi,

thank you! I guess the description should look like

   virtio-console: chardev hotswap support

   In case of a backend change, the handler functions and the watch have
   to be reset.
   Also, avoid unsafe qemu_chr_fe_get_driver() usage even though the pointe=
r
   is not really stored.



Amit, have you had a chance to kindly look at this?


/Anton

> ----- Original Message -----
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> CC: Amit Shah <amit@kernel.org>
>> ---
>>   hw/char/virtio-console.c | 35 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
>> index afb4949..198b2a8 100644
>> --- a/hw/char/virtio-console.c
>> +++ b/hw/char/virtio-console.c
>> @@ -49,7 +49,7 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
>>       VirtConsole *vcon =3D VIRTIO_CONSOLE(port);
>>       ssize_t ret;
>>  =20
>> -    if (!qemu_chr_fe_get_driver(&vcon->chr)) {
>> +    if (!qemu_chr_fe_backend_connected(&vcon->chr)) {
>>           /* If there's no backend, we can just say we consumed all data=
. */
>>           return len;
>>       }
>> @@ -163,12 +163,35 @@ static void chr_event(void *opaque, int event)
>>       }
>>   }
>>  =20
>> +static int chr_be_change(void *opaque)
>> +{
>> +    VirtConsole *vcon =3D opaque;
>> +    VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(vcon);
>> +    VirtIOSerialPortClass *k =3D VIRTIO_SERIAL_PORT_GET_CLASS(port);
>> +
>> +    if (k->is_console) {
>> +        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
>> +                                 NULL, chr_be_change, vcon, NULL, true)=
;
>> +    } else {
>> +        qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
>> +                                 chr_event, chr_be_change, vcon, NULL,
>> false);
>> +    }
>> +
>> +    if (vcon->watch) {
>> +        g_source_remove(vcon->watch);
>> +        vcon->watch =3D qemu_chr_fe_add_watch(&vcon->chr,
>> +                                            G_IO_OUT | G_IO_HUP,
>> +                                            chr_write_unblocked, vcon);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static void virtconsole_realize(DeviceState *dev, Error **errp)
>>   {
>>       VirtIOSerialPort *port =3D VIRTIO_SERIAL_PORT(dev);
>>       VirtConsole *vcon =3D VIRTIO_CONSOLE(dev);
>>       VirtIOSerialPortClass *k =3D VIRTIO_SERIAL_PORT_GET_CLASS(dev);
>> -    Chardev *chr =3D qemu_chr_fe_get_driver(&vcon->chr);
>>  =20
>>       if (port->id =3D=3D 0 && !k->is_console) {
>>           error_setg(errp, "Port number 0 on virtio-serial devices reser=
ved "
>> @@ -176,7 +199,7 @@ static void virtconsole_realize(DeviceState *dev, Er=
ror
>> **errp)
>>           return;
>>       }
>>  =20
>> -    if (chr) {
>> +    if (qemu_chr_fe_backend_connected(&vcon->chr)) {
>>           /*
>>            * For consoles we don't block guest data transfer just
>>            * because nothing is connected - we'll just let it go
>> @@ -188,11 +211,13 @@ static void virtconsole_realize(DeviceState *dev, =
Error
>> **errp)
>>            */
>>           if (k->is_console) {
>>               qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_rea=
d,
>> -                                     NULL, NULL, vcon, NULL, true);
>> +                                     NULL, chr_be_change,
>> +                                     vcon, NULL, true);
>>               virtio_serial_open(port);
>>           } else {
>>               qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_rea=
d,
>> -                                     chr_event, NULL, vcon, NULL, false=
);
>> +                                     chr_event, chr_be_change,
>> +                                     vcon, NULL, false);
>>           }
>>       }
>>   }
>> --
>> 2.7.4
>>
>>

--=20
/Anton
