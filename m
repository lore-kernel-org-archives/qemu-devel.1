Received: from eggs.gnu.org ([2001:4830:134:3::10]:52865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ecD4G-0006gU-Ui
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:29:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ecD4F-0002aZ-CY
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:29:32 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:37491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ecD4F-0002a9-2R
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:29:31 -0500
Received: by mail-wm0-x242.google.com with SMTP id v71so24178118wmv.2
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:29:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <aaded7d7-7c92-6692-c9cd-555c3dfbf1a2@virtuozzo.com>
References: <20180118143301.10864-1-klim.kireev@virtuozzo.com>
	<CAJ+F1CJk0iiy_iFv3zFkNkumbj2ee+OD=GDcuVLWb8xWUGSrjg@mail.gmail.com>
	<aaded7d7-7c92-6692-c9cd-555c3dfbf1a2@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 18 Jan 2018 17:29:29 +0100
Message-ID: <CAJ+F1CKkBBaWON97mqjPGmdty8koAG5WEj8PYiD_h+uejLojyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: klim <klim.kireev@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, den@virtuozzo.com

Hi

On Thu, Jan 18, 2018 at 5:18 PM, klim <klim.kireev@virtuozzo.com> wrote:
> On 01/18/2018 06:49 PM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> Hi
>>
>> On Thu, Jan 18, 2018 at 3:33 PM, Klim Kireev <klim.kireev@virtuozzo.com>
>> wrote:
>>>
>>> The following behavior was observed for QEMU configured by libvirt
>>> to use guest agent as usual for the guests without virtio-serial
>>> driver (Windows or the guest remaining in BIOS stage).
>>>
>>> In QEMU on first connect to listen character device socket
>>> the listen socket is removed from poll just after the accept().
>>> virtio_serial_guest_ready() returns 0 and the descriptor
>>> of the connected Unix socket is removed from poll and it will
>>> not be present in poll() until the guest will initialize the driver
>>> and change the state of the serial to "guest connected".
>>>
>>> In libvirt connect() to guest agent is performed on restart and
>>> is run under VM state lock. Connect() is blocking and can
>>> wait forever.
>>> In this case libvirt can not perform ANY operation on that VM.
>>>
>>> The bug can be easily reproduced this way:
>>>
>>> Terminal 1:
>>> qemu-system-x86_64 -m 512 -device pci-serial,chardev=3Dserial1 -chardev
>>> socket,id=3Dserial1,path=3D/tmp/console.sock,server,nowait
>>> (virtio-serial and isa-serial also fit)
>>>
>>> Terminal 2:
>>> minicom -D unix\#/tmp/console.sock
>>> (type something and press enter)
>>> C-a x (to exit)
>>>
>>> Do 3 times:
>>> minicom -D unix\#/tmp/console.sock
>>> C-a x
>>>
>>> It needs 4 connections, because the first one is accepted by QEMU, then
>>> two are queued by
>>> the kernel, and the 4th blocks.
>>>
>>> The problem is that QEMU doesn't add a read watcher after succesful rea=
d
>>> until the guest device wants to acquire recieved data, so
>>> I propose to install a separate pullhup watcher regardless of
>>> whether the device waits for data or not.
>>>
>>> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
>>> ---
>>> Changelog:
>>> v2: Remove timer as a redundant feature
>>>
>>>   chardev/char-socket.c | 29 ++++++++++++++++++++++++++++-
>>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
>>> index 77cdf487eb..d3fe903ab6 100644
>>> --- a/chardev/char-socket.c
>>> +++ b/chardev/char-socket.c
>>> @@ -42,6 +42,7 @@ typedef struct {
>>>       QIOChannel *ioc; /* Client I/O channel */
>>>       QIOChannelSocket *sioc; /* Client master channel */
>>>       QIONetListener *listener;
>>> +    guint hup_tag;
>>>       QCryptoTLSCreds *tls_creds;
>>>       int connected;
>>>       int max_size;
>>> @@ -352,6 +353,11 @@ static void tcp_chr_free_connection(Chardev *chr)
>>>           s->read_msgfds_num =3D 0;
>>>       }
>>>
>>> +    if (s->hup_tag !=3D 0) {
>>> +        g_source_remove(s->hup_tag);
>>> +        s->hup_tag =3D 0;
>>> +    }
>>> +
>>>       tcp_set_msgfds(chr, NULL, 0);
>>>       remove_fd_in_watch(chr);
>>>       object_unref(OBJECT(s->sioc));
>>> @@ -455,6 +461,19 @@ static gboolean tcp_chr_read(QIOChannel *chan,
>>> GIOCondition cond, void *opaque)
>>>       return TRUE;
>>>   }
>>>
>>> +static gboolean tcp_chr_hup(QIOChannel *channel,
>>> +                               GIOCondition cond,
>>> +                               void *opaque)
>>> +{
>>> +    Chardev *chr =3D CHARDEV(opaque);
>>> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
>>> +    tcp_chr_read(channel, cond, opaque);
>>> +    if (s->connected !=3D 0) {
>>
>> tcp_chr_read() shouldn't be called unless frontend is ready to read.
>> qemu_chr_be_can_write() is regularly updated with tcp_chr_read_poll()
>> but this may create some race here (if it read all it could read
>> previously for example)
>>
>> If frontend can't read, s->connected won't be updated, so you'll busy
>> loop in the source callback, not good.
>>
>> I think it needs further rework of how s->connected is updated.
>>
>> Why call tcp_chr_read() if you received HUP event ? could it call
>> tcp_chr_free_connection()?
>
>
> The reason is that:
>
> if client sends data and closes the socket between two ppoll(), POLLHUP
> handler is called
> and data in channel is lost, so read is used to pass it to guest.

I thought we agree we don't need to handle reliability of client data
if it disconnects.

> if there is no data in channel, tcp_chr_recv() returns 0
> and tcp_chr_read() calls tcp_chr_disconnect() which calls
> tcp_chr_free_connection().

tcp_chr_read() won't try to read if max_size =3D 0 (set when
!qemu_chr_be_can_write)

This is where it will busy loop I believe

> If there is some data in channel it calls qemu_chr_be_write() and then in
> tcp_chr_disconnect()
> tcp_free_connection() will be called.
> In any case connection will be closed, so where is busy loop?
>
>>> +        tcp_chr_disconnect(chr);
>>> +    }
>>> +    return TRUE;
>>
>> please use G_SOURCE_CONTINUE/REMOVE (I know it's not being used
>> widely, but we have define now, and it is much clearer)
>>
>>> +}
>>> +
>>>   static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int le=
n)
>>>   {
>>>       SocketChardev *s =3D SOCKET_CHARDEV(chr);
>>> @@ -528,6 +547,10 @@ static void tcp_chr_connect(void *opaque)
>>>                                              tcp_chr_read,
>>>                                              chr, chr->gcontext);
>>>       }
>>> +    if (s->hup_tag =3D=3D 0) {
>>> +        s->hup_tag =3D qio_channel_add_watch(s->ioc, G_IO_HUP,
>>> +                                           tcp_chr_hup, chr, NULL);
>>> +    }
>>>       qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>>>   }
>>>
>>> @@ -546,7 +569,11 @@ static void tcp_chr_update_read_handler(Chardev
>>> *chr)
>>>                                              tcp_chr_read, chr,
>>>                                              chr->gcontext);
>>>       }
>>> -}
>>> +    if (s->hup_tag =3D=3D 0) {
>>> +        s->hup_tag =3D qio_channel_add_watch(s->ioc, G_IO_HUP,
>>> +                                           tcp_chr_hup, chr, NULL);
>>> +    }
>>> + }
>>>
>>>   typedef struct {
>>>       Chardev *chr;
>>> --
>>> 2.14.3
>>>
>>>
>>
>>
>



--=20
Marc-Andr=C3=A9 Lureau
