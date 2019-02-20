Received: from eggs.gnu.org ([209.51.188.92]:36975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwOSA-0003tf-Ak
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwOS8-0003Xw-SE
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:46:10 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:39665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwOS8-0003We-Nr
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 04:46:08 -0500
Received: by mail-qt1-f195.google.com with SMTP id o6so26445629qtk.6
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 01:46:07 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-2-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-2-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 10:45:55 +0100
Message-ID: <CAMxuvaw01BjjoshjUc+9F5P53oSNrZU_n0OebiPOnp_q5MA58w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/25] chardev: Simplify
 IOWatchPoll::fd_can_read as a GSourceFunc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Feb 20, 2019 at 2:03 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> IOWatchPoll::fd_can_read() really is a GSourceFunc type, it simply
> returns a boolean value.
> Update the backends to return a boolean, whether there is data to
> read from the source or not.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-fd.c         | 4 ++--
>  chardev/char-io.c         | 6 +++---
>  chardev/char-pty.c        | 4 ++--
>  chardev/char-socket.c     | 6 +++---
>  chardev/char-udp.c        | 4 ++--
>  include/chardev/char-io.h | 2 +-
>  6 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index 2c9b2ce567..2421d8e216 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -69,13 +69,13 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCond=
ition cond, void *opaque)
>      return TRUE;
>  }
>
> -static int fd_chr_read_poll(void *opaque)
> +static gboolean fd_chr_read_poll(void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
>      FDChardev *s =3D FD_CHARDEV(opaque);
>
>      s->max_size =3D qemu_chr_be_can_write(chr);
> -    return s->max_size;
> +    return s->max_size > 0;
>  }
>
>  static GSource *fd_chr_add_watch(Chardev *chr, GIOCondition cond)
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index 8ced184160..2c1c69098e 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -30,7 +30,7 @@ typedef struct IOWatchPoll {
>      QIOChannel *ioc;
>      GSource *src;
>
> -    IOCanReadHandler *fd_can_read;
> +    GSourceFunc fd_can_read;
>      GSourceFunc fd_read;
>      void *opaque;
>  } IOWatchPoll;
> @@ -44,7 +44,7 @@ static gboolean io_watch_poll_prepare(GSource *source,
>                                        gint *timeout)
>  {
>      IOWatchPoll *iwp =3D io_watch_poll_from_source(source);
> -    bool now_active =3D iwp->fd_can_read(iwp->opaque) > 0;
> +    bool now_active =3D iwp->fd_can_read(iwp->opaque);
>      bool was_active =3D iwp->src !=3D NULL;
>      if (was_active =3D=3D now_active) {
>          return FALSE;
> @@ -76,7 +76,7 @@ static GSourceFuncs io_watch_poll_funcs =3D {
>
>  GSource *io_add_watch_poll(Chardev *chr,
>                          QIOChannel *ioc,
> -                        IOCanReadHandler *fd_can_read,
> +                        GSourceFunc fd_can_read,
>                          QIOChannelFunc fd_read,
>                          gpointer user_data,
>                          GMainContext *context)
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index b034332edd..7777f6ddef 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -119,13 +119,13 @@ static GSource *pty_chr_add_watch(Chardev *chr, GIO=
Condition cond)
>      return qio_channel_create_watch(s->ioc, cond);
>  }
>
> -static int pty_chr_read_poll(void *opaque)
> +static gboolean pty_chr_read_poll(void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
>      PtyChardev *s =3D PTY_CHARDEV(opaque);
>
>      s->read_bytes =3D qemu_chr_be_can_write(chr);
> -    return s->read_bytes;
> +    return s->read_bytes > 0;
>  }
>
>  static gboolean pty_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4fcdd8aedd..262a59b64f 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -147,7 +147,7 @@ static void tcp_chr_accept(QIONetListener *listener,
>                             QIOChannelSocket *cioc,
>                             void *opaque);
>
> -static int tcp_chr_read_poll(void *opaque);
> +static gboolean tcp_chr_read_poll(void *opaque);
>  static void tcp_chr_disconnect(Chardev *chr);
>
>  /* Called with chr_write_lock held.  */
> @@ -184,7 +184,7 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
>      }
>  }
>
> -static int tcp_chr_read_poll(void *opaque)
> +static gboolean tcp_chr_read_poll(void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
>      SocketChardev *s =3D SOCKET_CHARDEV(opaque);
> @@ -192,7 +192,7 @@ static int tcp_chr_read_poll(void *opaque)
>          return 0;
>      }
>      s->max_size =3D qemu_chr_be_can_write(chr);
> -    return s->max_size;
> +    return s->max_size > 0;
>  }
>
>  static void tcp_chr_process_IAC_bytes(Chardev *chr,
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 097a2f0f42..b6e399e983 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -65,7 +65,7 @@ static void udp_chr_flush_buffer(UdpChardev *s)
>      }
>  }
>
> -static int udp_chr_read_poll(void *opaque)
> +static gboolean udp_chr_read_poll(void *opaque)
>  {
>      Chardev *chr =3D CHARDEV(opaque);
>      UdpChardev *s =3D UDP_CHARDEV(opaque);
> @@ -77,7 +77,7 @@ static int udp_chr_read_poll(void *opaque)
>       */
>      udp_chr_flush_buffer(s);
>
> -    return s->max_size;
> +    return s->max_size > 0;
>  }
>
>  static gboolean udp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
> diff --git a/include/chardev/char-io.h b/include/chardev/char-io.h
> index 9638da5100..a173874538 100644
> --- a/include/chardev/char-io.h
> +++ b/include/chardev/char-io.h
> @@ -31,7 +31,7 @@
>  /* Can only be used for read */
>  GSource *io_add_watch_poll(Chardev *chr,
>                          QIOChannel *ioc,
> -                        IOCanReadHandler *fd_can_read,
> +                        GSourceFunc fd_can_read,
>                          QIOChannelFunc fd_read,
>                          gpointer user_data,
>                          GMainContext *context);
> --
> 2.20.1
>
