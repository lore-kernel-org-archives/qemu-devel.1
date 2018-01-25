Received: from eggs.gnu.org ([2001:4830:134:3::10]:42723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eegwo-0006ay-FJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:48:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eegwn-0006vy-AA
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:48:06 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37775)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eegwn-0006uR-2L
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 07:48:05 -0500
Received: by mail-wr0-x242.google.com with SMTP id f11so7534396wre.4
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 04:48:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180125123955.4919-1-klim.kireev@virtuozzo.com>
References: <20180125123955.4919-1-klim.kireev@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 25 Jan 2018 13:48:02 +0100
Message-ID: <CAJ+F1CK_mEH=UjT9gt=HebG_AUDKwp_S92PR+P8+rpOGgpP44w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] chardev/char-socket: add POLLHUP handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Klim Kireev <klim.kireev@virtuozzo.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Thu, Jan 25, 2018 at 1:39 PM, Klim Kireev <klim.kireev@virtuozzo.com> wr=
ote:
> The following behavior was observed for QEMU configured by libvirt
> to use guest agent as usual for the guests without virtio-serial
> driver (Windows or the guest remaining in BIOS stage).
>
> In QEMU on first connect to listen character device socket
> the listen socket is removed from poll just after the accept().
> virtio_serial_guest_ready() returns 0 and the descriptor
> of the connected Unix socket is removed from poll and it will
> not be present in poll() until the guest will initialize the driver
> and change the state of the serial to "guest connected".
>
> In libvirt connect() to guest agent is performed on restart and
> is run under VM state lock. Connect() is blocking and can
> wait forever.
> In this case libvirt can not perform ANY operation on that VM.
>
> The bug can be easily reproduced this way:
>
> Terminal 1:
> qemu-system-x86_64 -m 512 -device pci-serial,chardev=3Dserial1 -chardev s=
ocket,id=3Dserial1,path=3D/tmp/console.sock,server,nowait
> (virtio-serial and isa-serial also fit)
>
> Terminal 2:
> minicom -D unix\#/tmp/console.sock
> (type something and press enter)
> C-a x (to exit)
>
> Do 3 times:
> minicom -D unix\#/tmp/console.sock
> C-a x
>
> It needs 4 connections, because the first one is accepted by QEMU, then t=
wo are queued by
> the kernel, and the 4th blocks.
>
> The problem is that QEMU doesn't add a read watcher after succesful read
> until the guest device wants to acquire recieved data, so
> I propose to install a separate pullhup watcher regardless of
> whether the device waits for data or not.
>
> Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
> ---
> Changelog:
> v2: Remove timer as a redundant feature
>
> v3: Remove read call and return G_SOURCE_REMOVE
>
> v4: Move to GSource API
>
>  chardev/char-socket.c | 22 ++++++++++++++++++++++
>  dtc                   |  2 +-
>  2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 77cdf487eb..062d131079 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -42,6 +42,7 @@ typedef struct {
>      QIOChannel *ioc; /* Client I/O channel */
>      QIOChannelSocket *sioc; /* Client master channel */
>      QIONetListener *listener;
> +    GSource *hup_source;
>      QCryptoTLSCreds *tls_creds;
>      int connected;
>      int max_size;
> @@ -352,6 +353,12 @@ static void tcp_chr_free_connection(Chardev *chr)
>          s->read_msgfds_num =3D 0;
>      }
>
> +    if (s->hup_source !=3D NULL) {
> +        g_source_destroy(s->hup_source);
> +        g_source_unref(s->hup_source);
> +        s->hup_source =3D NULL;
> +    }
> +
>      tcp_set_msgfds(chr, NULL, 0);
>      remove_fd_in_watch(chr);
>      object_unref(OBJECT(s->sioc));
> @@ -455,6 +462,15 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCo=
ndition cond, void *opaque)
>      return TRUE;
>  }
>
> +static gboolean tcp_chr_hup(QIOChannel *channel,
> +                               GIOCondition cond,
> +                               void *opaque)
> +{
> +    Chardev *chr =3D CHARDEV(opaque);
> +    tcp_chr_disconnect(chr);

you should set s->hup_source to NULL

> +    return G_SOURCE_REMOVE;
> +}
> +
>  static int tcp_chr_sync_read(Chardev *chr, const uint8_t *buf, int len)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> @@ -528,6 +544,12 @@ static void tcp_chr_connect(void *opaque)
>                                             tcp_chr_read,
>                                             chr, chr->gcontext);
>      }
> +
> +    s->hup_source =3D qio_channel_create_watch(s->ioc, G_IO_HUP);
> +    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
> +                          chr, NULL);
> +    g_source_attach(s->hup_source, chr->gcontext);
> +
>      qemu_chr_be_event(chr, CHR_EVENT_OPENED);
>  }
>
> diff --git a/dtc b/dtc
> index e54388015a..558cd81bdd 160000
> --- a/dtc
> +++ b/dtc
> @@ -1 +1 @@
> -Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
> +Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
> --

unrelated

looks good otherwise



--=20
Marc-Andr=C3=A9 Lureau
