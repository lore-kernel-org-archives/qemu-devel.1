Received: from eggs.gnu.org ([2001:4830:134:3::10]:48471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ecCtb-0001lq-NY
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1ecCtX-0005CY-M5
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:18:31 -0500
Received: from mail-eopbgr20101.outbound.protection.outlook.com
	([40.107.2.101]:5312
	helo=EUR02-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1ecCtX-0005BX-2U
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:18:27 -0500
References: <20180118143301.10864-1-klim.kireev@virtuozzo.com>
	<CAJ+F1CJk0iiy_iFv3zFkNkumbj2ee+OD=GDcuVLWb8xWUGSrjg@mail.gmail.com>
From: klim <klim.kireev@virtuozzo.com>
Message-ID: <aaded7d7-7c92-6692-c9cd-555c3dfbf1a2@virtuozzo.com>
Date: Thu, 18 Jan 2018 19:18:17 +0300
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJk0iiy_iFv3zFkNkumbj2ee+OD=GDcuVLWb8xWUGSrjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, den@virtuozzo.com

On 01/18/2018 06:49 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Jan 18, 2018 at 3:33 PM, Klim Kireev <klim.kireev@virtuozzo.com> =
wrote:
>> The following behavior was observed for QEMU configured by libvirt
>> to use guest agent as usual for the guests without virtio-serial
>> driver (Windows or the guest remaining in BIOS stage).
>>
>> In QEMU on first connect to listen character device socket
>> the listen socket is removed from poll just after the accept().
>> virtio_serial_guest_ready() returns 0 and the descriptor
>> of the connected Unix socket is removed from poll and it will
>> not be present in poll() until the guest will initialize the driver
>> and change the state of the serial to "guest connected".
>>
>> In libvirt connect() to guest agent is performed on restart and
>> is run under VM state lock. Connect() is blocking and can
>> wait forever.
>> In this case libvirt can not perform ANY operation on that VM.
>>
>> The bug can be easily reproduced this way:
>>
>> Terminal 1:
>> qemu-system-x86_64 -m 512 -device pci-serial,chardev=3Dserial1 -chardev =
socket,id=3Dserial1,path=3D/tmp/console.sock,server,nowait
>> (virtio-serial and isa-serial also fit)
>>
>> Terminal 2:
>> minicom -D unix\#/tmp/console.sock
>> (type something and press enter)
>> C-a x (to exit)
>>
>> Do 3 times:
>> minicom -D unix\#/tmp/console.sock
>> C-a x
>>
>> It needs 4 connections, because the first one is accepted by QEMU, then =
two are queued by
>> the kernel, and the 4th blocks.
>>
>> The problem is that QEMU doesn't add a read watcher after succesful read
>> until the guest device wants to acquire recieved data, so
>> I propose to install a separate pullhup watcher regardless of
>> whether the device waits for data or not.
>>
>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>> ---
>> Changelog:
>> v2: Remove timer as a redundant feature
>>
>>   chardev/char-socket.c | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>> index 77cdf487eb..d3fe903ab6 100644
>> --- a/chardev/char-socket.c
>> +++ b/chardev/char-socket.c
>> @@ -42,6 +42,7 @@ typedef struct {
>>       QIOChannel *ioc; /* Client I/O channel */
>>       QIOChannelSocket *sioc; /* Client master channel */
>>       QIONetListener *listener;
>> +    guint hup_tag;
>>       QCryptoTLSCreds *tls_creds;
>>       int connected;
>>       int max_size;
>> @@ -352,6 +353,11 @@ static void tcp_chr_free_connection(Chardev *chr)
>>           s->read_msgfds_num =3D 0;
>>       }
>>
>> +    if (s->hup_tag !=3D 0) {
>> +        g_source_remove(s->hup_tag);
>> +        s->hup_tag =3D 0;
>> +    }
>> +
>>       tcp_set_msgfds(chr, NULL, 0);
>>       remove_fd_in_watch(chr);
>>       object_unref(OBJECT(s->sioc));
>> @@ -455,6 +461,19 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOC=
ondition cond, void *opaque)
>>       return TRUE;
>>   }
>>
>> +static gboolean tcp_chr_hup(QIOChannel *channel,
>> +                               GIOCondition cond,
>> +                               void *opaque)
>> +{
>> +    Chardev *chr =3D CHARDEV(opaque);
>> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
>> +    tcp_chr_read(channel, cond, opaque);
>> +    if (s->connected !=3D 0) {
> tcp_chr_read() shouldn't be called unless frontend is ready to read.
> qemu_chr_be_can_write() is regularly updated with tcp_chr_read_poll()
> but this may create some race here (if it read all it could read
> previously for example)
>
> If frontend can't read, s->connected won't be updated, so you'll busy
> loop in the source callback, not good.
>
> I think it needs further rework of how s->connected is updated.
>
> Why call tcp_chr_read() if you received HUP event ? could it call
> tcp_chr_free_connection()?

The reason is that:

if client sends data and closes the socket between two ppoll(), POLLHUP=20
handler is called
and data in channel is lost, so read is used to pass it to guest.

if there is no data in channel, tcp_chr_recv() returns 0
and tcp_chr_read() calls tcp_chr_disconnect() which calls=20
tcp_chr_free_connection().

If there is some data in channel it calls qemu_chr_be_write() and then=20
in tcp_chr_disconnect()
tcp_free_connection() will be called.

In any case connection will be closed, so where is busy loop?
>> +        tcp_chr_disconnect(chr);
>> +    }
>> +    return TRUE;
> please use G_SOURCE_CONTINUE/REMOVE (I know it's not being used
> widely, but we have define now, and it is much clearer)
>
>> +}
>> +
>>   static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len=
)
>>   {
>>       SocketChardev *s =3D SOCKET_CHARDEV(chr);
>> @@ -528,6 +547,10 @@ static void tcp_chr_connect(void *opaque)
>>                                              tcp_chr_read,
>>                                              chr, chr->gcontext);
>>       }
>> +    if (s->hup_tag =3D=3D 0) {
>> +        s->hup_tag =3D qio_channel_add_watch(s->ioc, G_IO_HUP,
>> +                                           tcp_chr_hup, chr, NULL);
>> +    }
>>       qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>>   }
>>
>> @@ -546,7 +569,11 @@ static void tcp_chr_update_read_handler(Chardev *ch=
r)
>>                                              tcp_chr_read, chr,
>>                                              chr->gcontext);
>>       }
>> -}
>> +    if (s->hup_tag =3D=3D 0) {
>> +        s->hup_tag =3D qio_channel_add_watch(s->ioc, G_IO_HUP,
>> +                                           tcp_chr_hup, chr, NULL);
>> +    }
>> + }
>>
>>   typedef struct {
>>       Chardev *chr;
>> --
>> 2.14.3
>>
>>
>
>
