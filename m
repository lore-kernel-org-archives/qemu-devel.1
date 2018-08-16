Received: from eggs.gnu.org ([2001:4830:134:3::10]:53604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqMOi-0000w1-RP
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fqMOh-000739-NL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:49:24 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fqMOh-000733-Gx
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:49:23 -0400
Received: by mail-wm0-x244.google.com with SMTP id o18-v6so5129541wmc.0
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 10:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180306053320.15401-1-peterx@redhat.com>
	<20180306053320.15401-8-peterx@redhat.com>
In-Reply-To: <20180306053320.15401-8-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 16 Aug 2018 19:49:11 +0200
Message-ID: <CAJ+F1CKL3yunvzx3_uNeCjecoCdM2Cm+LwGBgSxfxChS=d_D6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/9] chardev: tcp: postpone async
 connection setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Hi
On Tue, Mar 6, 2018 at 6:41 AM Peter Xu <peterx@redhat.com> wrote:
>
> This patch allows the socket chardev async connection be setup with
> non-default gcontext.  We do it by postponing the setup to machine done,
> since until then we can know which context we should run the async
> operation on.
>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 1ce5adad9a..165612845a 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -1004,9 +1004,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          s->reconnect_time =3D reconnect;
>      }
>
> -    if (s->reconnect_time) {
> -        tcp_chr_connect_async(chr);
> -    } else {
> +    /* If reconnect_time is set, will do that in chr_machine_done. */
> +    if (!s->reconnect_time) {
>          if (s->is_listen) {
>              char *name;
>              s->listener =3D qio_net_listener_new();
> @@ -1138,6 +1137,17 @@ char_socket_get_connected(Object *obj, Error **err=
p)
>      return s->connected;
>  }
>
> +static int tcp_chr_machine_done_hook(Chardev *chr)
> +{
> +    SocketChardev *s =3D SOCKET_CHARDEV(chr);
> +
> +    if (s->reconnect_time) {
> +        tcp_chr_connect_async(chr);
> +    }
> +
> +    return 0;
> +}

This patch broke /vhost-user/reconnect test, since it is using
reconnect chardev sockets under a test program, where no machine done
hook exist.

> +
>  static void char_socket_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
> @@ -1153,6 +1163,7 @@ static void char_socket_class_init(ObjectClass *oc,=
 void *data)
>      cc->chr_add_client =3D tcp_chr_add_client;
>      cc->chr_add_watch =3D tcp_chr_add_watch;
>      cc->chr_update_read_handler =3D tcp_chr_update_read_handler;
> +    cc->chr_machine_done =3D tcp_chr_machine_done_hook;
>
>      object_class_property_add(oc, "addr", "SocketAddress",
>                                char_socket_get_addr, NULL,
> --
> 2.14.3
>
>


--=20
Marc-Andr=C3=A9 Lureau
