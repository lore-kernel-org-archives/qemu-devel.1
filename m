Received: from eggs.gnu.org ([2001:4830:134:3::10]:54203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec5Sk-0002t8-MG
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:22:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ec5Sf-0004Lo-Ls
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:22:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ec5Sf-0004L3-D0
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 03:22:13 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 834797E425
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 08:22:12 +0000 (UTC)
References: <20180118052049.31119-1-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0eb8e22a-bc5e-9314-573e-28e8323c34f1@redhat.com>
Date: Thu, 18 Jan 2018 09:22:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180118052049.31119-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev: fix incorrect unref of source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 18/01/2018 06:20, Peter Xu wrote:
> glib reported error when pty chardev used:
>=20
> $ ./qemu-system-x86_64 -chardev pty,id=3Dfoo -device isa-serial,chardev=
=3Dfoo
> qemu-system-x86_64: -chardev pty,id=3Dfoo: char device redirected to /d=
ev/pts/2 (label foo)
> (qemu-system-x86_64:27885): GLib-CRITICAL **: g_source_unref: assertion=
 'source !=3D NULL' failed
> (qemu-system-x86_64:27885): GLib-CRITICAL **: g_source_unref: assertion=
 'source !=3D NULL' failed
>=20
> This patch fixes that.
>=20
> Fixes: 2c716ba150 ("chardev: introduce qemu_chr_timeout_add_ms()")
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-pty.c | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
>=20
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index 89315e6807..68fd4e20c3 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -51,15 +51,32 @@ typedef struct {
>  static void pty_chr_update_read_handler_locked(Chardev *chr);
>  static void pty_chr_state(Chardev *chr, int connected);
> =20
> +static void pty_chr_timer_cancel(PtyChardev *s)
> +{
> +    if (s->timer_src) {
> +        g_source_destroy(s->timer_src);
> +        g_source_unref(s->timer_src);
> +        s->timer_src =3D NULL;
> +    }
> +}
> +
> +static void pty_chr_open_src_cancel(PtyChardev *s)
> +{
> +    if (s->open_source) {
> +        g_source_destroy(s->open_source);
> +        g_source_unref(s->open_source);
> +        s->open_source =3D NULL;
> +    }
> +}
> +
>  static gboolean pty_chr_timer(gpointer opaque)
>  {
>      struct Chardev *chr =3D CHARDEV(opaque);
>      PtyChardev *s =3D PTY_CHARDEV(opaque);
> =20
>      qemu_mutex_lock(&chr->chr_write_lock);
> -    s->timer_src =3D NULL;
> -    g_source_unref(s->open_source);
> -    s->open_source =3D NULL;
> +    pty_chr_timer_cancel(s);
> +    pty_chr_open_src_cancel(s);
>      if (!s->connected) {
>          /* Next poll ... */
>          pty_chr_update_read_handler_locked(chr);
> @@ -68,15 +85,6 @@ static gboolean pty_chr_timer(gpointer opaque)
>      return FALSE;
>  }
> =20
> -static void pty_chr_timer_cancel(PtyChardev *s)
> -{
> -    if (s->timer_src) {
> -        g_source_destroy(s->timer_src);
> -        g_source_unref(s->timer_src);
> -        s->timer_src =3D NULL;
> -    }
> -}
> -
>  /* Called with chr_write_lock held.  */
>  static void pty_chr_rearm_timer(Chardev *chr, int ms)
>  {
> @@ -195,11 +203,7 @@ static void pty_chr_state(Chardev *chr, int connec=
ted)
>      PtyChardev *s =3D PTY_CHARDEV(chr);
> =20
>      if (!connected) {
> -        if (s->open_source) {
> -            g_source_destroy(s->open_source);
> -            g_source_unref(s->open_source);
> -            s->open_source =3D NULL;
> -        }
> +        pty_chr_open_src_cancel(s);
>          remove_fd_in_watch(chr);
>          s->connected =3D 0;
>          /* (re-)connect poll interval for idle guests: once per second=
.
>=20

Queued, thanks.

Paolo
