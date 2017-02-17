Received: from eggs.gnu.org ([2001:4830:134:3::10]:34787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ced4d-00070R-RH
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 02:35:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ced4a-00075j-La
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 02:35:23 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:49286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ced4a-00074y-Cd
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 02:35:20 -0500
Date: Fri, 17 Feb 2017 02:35:01 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1598585072.6518123.1487316901556.JavaMail.zimbra@redhat.com>
In-Reply-To: <1487299994-98348-4-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1487299994-98348-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487299994-98348-4-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] char: remove the right fd been
 watched in qemu_chr_fe_set_handlers()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: jasowang@redhat.com, zhangchen fnst <zhangchen.fnst@cn.fujitsu.com>, lizhijian@cn.fujitsu.com, qemu-devel@nongnu.org, xuquan8@huawei.com, pss wulizhen <pss.wulizhen@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Hi

----- Original Message -----
> We can call qemu_chr_fe_set_handlers() to add/remove fd been watched
> in 'context' which can be either default main context or other explicit
> context. But the original logic is not correct, we didn't remove
> the right fd because we call g_main_context_find_source_by_id(NULL, tag)
> which always try to find the Gsource from default context.
>=20
> Fix it by passing the right context to g_main_context_find_source_by_id()=
.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/char-fd.c     | 6 +++---
>  chardev/char-io.c     | 8 ++++----
>  chardev/char-io.h     | 2 +-
>  chardev/char-pty.c    | 2 +-
>  chardev/char-socket.c | 4 ++--
>  chardev/char-udp.c    | 6 +++---
>  chardev/char.c        | 2 +-
>  7 files changed, 15 insertions(+), 15 deletions(-)
>=20
> diff --git a/chardev/char-fd.c b/chardev/char-fd.c
> index fb51ab4..548dd4c 100644
> --- a/chardev/char-fd.c
> +++ b/chardev/char-fd.c
> @@ -58,7 +58,7 @@ static gboolean fd_chr_read(QIOChannel *chan, GIOCondit=
ion
> cond, void *opaque)
>      ret =3D qio_channel_read(
>          chan, (gchar *)buf, len, NULL);
>      if (ret =3D=3D 0) {
> -        remove_fd_in_watch(chr);
> +        remove_fd_in_watch(chr, NULL);
>          qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>          return FALSE;
>      }
> @@ -89,7 +89,7 @@ static void fd_chr_update_read_handler(Chardev *chr,
>  {
>      FDChardev *s =3D FD_CHARDEV(chr);
> =20
> -    remove_fd_in_watch(chr);
> +    remove_fd_in_watch(chr, NULL);
>      if (s->ioc_in) {
>          chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc_in,
>                                             fd_chr_read_poll,
> @@ -103,7 +103,7 @@ static void char_fd_finalize(Object *obj)
>      Chardev *chr =3D CHARDEV(obj);
>      FDChardev *s =3D FD_CHARDEV(obj);
> =20
> -    remove_fd_in_watch(chr);
> +    remove_fd_in_watch(chr, NULL);
>      if (s->ioc_in) {
>          object_unref(OBJECT(s->ioc_in));
>      }
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index 7dfc3f2..b4bb094 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -127,14 +127,14 @@ guint io_add_watch_poll(Chardev *chr,
>      return tag;
>  }
> =20
> -static void io_remove_watch_poll(guint tag)
> +static void io_remove_watch_poll(guint tag, GMainContext *context)
>  {
>      GSource *source;
>      IOWatchPoll *iwp;
> =20
>      g_return_if_fail(tag > 0);
> =20
> -    source =3D g_main_context_find_source_by_id(NULL, tag);
> +    source =3D g_main_context_find_source_by_id(context, tag);
>      g_return_if_fail(source !=3D NULL);
> =20
>      iwp =3D io_watch_poll_from_source(source);
> @@ -146,10 +146,10 @@ static void io_remove_watch_poll(guint tag)
>      g_source_destroy(&iwp->parent);
>  }
> =20
> -void remove_fd_in_watch(Chardev *chr)
> +void remove_fd_in_watch(Chardev *chr, GMainContext *context)
>  {
>      if (chr->fd_in_tag) {
> -        io_remove_watch_poll(chr->fd_in_tag);
> +        io_remove_watch_poll(chr->fd_in_tag, context);
>          chr->fd_in_tag =3D 0;
>      }
>  }
> diff --git a/chardev/char-io.h b/chardev/char-io.h
> index d7ae5f1..842be56 100644
> --- a/chardev/char-io.h
> +++ b/chardev/char-io.h
> @@ -36,7 +36,7 @@ guint io_add_watch_poll(Chardev *chr,
>                          gpointer user_data,
>                          GMainContext *context);
> =20
> -void remove_fd_in_watch(Chardev *chr);
> +void remove_fd_in_watch(Chardev *chr, GMainContext *context);
> =20
>  int io_channel_send(QIOChannel *ioc, const void *buf, size_t len);
> =20
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index ecf2c7a..a6337be 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -199,7 +199,7 @@ static void pty_chr_state(Chardev *chr, int connected=
)
>              g_source_remove(s->open_tag);
>              s->open_tag =3D 0;
>          }
> -        remove_fd_in_watch(chr);
> +        remove_fd_in_watch(chr, NULL);
>          s->connected =3D 0;
>          /* (re-)connect poll interval for idle guests: once per second.
>           * We check more frequently in case the guests sends data to
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 865c527..d7e92e1 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -328,7 +328,7 @@ static void tcp_chr_free_connection(Chardev *chr)
>      }
> =20
>      tcp_set_msgfds(chr, NULL, 0);
> -    remove_fd_in_watch(chr);
> +    remove_fd_in_watch(chr, NULL);
>      object_unref(OBJECT(s->sioc));
>      s->sioc =3D NULL;
>      object_unref(OBJECT(s->ioc));
> @@ -498,7 +498,7 @@ static void tcp_chr_update_read_handler(Chardev *chr,
>          return;
>      }
> =20
> -    remove_fd_in_watch(chr);
> +    remove_fd_in_watch(chr, NULL);
>      if (s->ioc) {
>          chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
>                                             tcp_chr_read_poll,
> diff --git a/chardev/char-udp.c b/chardev/char-udp.c
> index 2c6c7dd..804bd22 100644
> --- a/chardev/char-udp.c
> +++ b/chardev/char-udp.c
> @@ -81,7 +81,7 @@ static gboolean udp_chr_read(QIOChannel *chan, GIOCondi=
tion
> cond, void *opaque)
>      ret =3D qio_channel_read(
>          s->ioc, (char *)s->buf, sizeof(s->buf), NULL);
>      if (ret <=3D 0) {
> -        remove_fd_in_watch(chr);
> +        remove_fd_in_watch(chr, NULL);
>          return FALSE;
>      }
>      s->bufcnt =3D ret;
> @@ -101,7 +101,7 @@ static void udp_chr_update_read_handler(Chardev *chr,
>  {
>      UdpChardev *s =3D UDP_CHARDEV(chr);
> =20
> -    remove_fd_in_watch(chr);
> +    remove_fd_in_watch(chr, NULL);
>      if (s->ioc) {
>          chr->fd_in_tag =3D io_add_watch_poll(chr, s->ioc,
>                                             udp_chr_read_poll,
> @@ -115,7 +115,7 @@ static void char_udp_finalize(Object *obj)
>      Chardev *chr =3D CHARDEV(obj);
>      UdpChardev *s =3D UDP_CHARDEV(obj);
> =20
> -    remove_fd_in_watch(chr);
> +    remove_fd_in_watch(chr, NULL);
>      if (s->ioc) {
>          object_unref(OBJECT(s->ioc));
>      }
> diff --git a/chardev/char.c b/chardev/char.c
> index abd525f..8af3634 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -560,7 +560,7 @@ void qemu_chr_fe_set_handlers(CharBackend *b,
>      cc =3D CHARDEV_GET_CLASS(s);
>      if (!opaque && !fd_can_read && !fd_read && !fd_event) {
>          fe_open =3D 0;
> -        remove_fd_in_watch(s);
> +        remove_fd_in_watch(s, context);
>      } else {
>          fe_open =3D 1;
>      }
> --
> 1.8.3.1
>=20
>=20
>=20
