Received: from eggs.gnu.org ([2001:4830:134:3::10]:39129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQuW2-0008Rs-8y
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQuVx-0003kd-NM
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:22:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51596)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQuVx-0003kA-ER
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 06:22:53 -0500
References: <20170110110621.15287-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf314a15-d2aa-f0bb-8a59-5589e623d650@redhat.com>
Date: Tue, 10 Jan 2017 12:22:49 +0100
MIME-Version: 1.0
In-Reply-To: <20170110110621.15287-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] char: fix ctrl-a b not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: gson@gson.org, 1654137@bugs.launchpad.net



On 10/01/2017 12:06, Marc-Andr=C3=A9 Lureau wrote:
> CharDriverState.be should be updated to point to the current
> associated backend.
>=20
> Fix the regression introduced in the "mux" chardev from commit
> a4afa548fc6dd9842ed86639b4d37d4d1c4ad480.
>=20
> https://bugs.launchpad.net/bugs/1654137

Queued.

However, can you also simplify mux_chr_accept_input, mux_chr_can_read
and mux_chr_read to use d->be directly, with this change?

Thanks,

Paolo

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-char.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/qemu-char.c b/qemu-char.c
> index 2c9940cea4..676944a765 100644
> --- a/qemu-char.c
> +++ b/qemu-char.c
> @@ -499,7 +499,7 @@ void qemu_chr_fe_printf(CharBackend *be, const char=
 *fmt, ...)
> =20
>  static void remove_fd_in_watch(CharDriverState *chr);
>  static void mux_chr_set_handlers(CharDriverState *chr, GMainContext *c=
ontext);
> -static void mux_set_focus(MuxDriver *d, int focus);
> +static void mux_set_focus(CharDriverState *chr, int focus);
> =20
>  static int null_chr_write(CharDriverState *chr, const uint8_t *buf, in=
t len)
>  {
> @@ -666,7 +666,7 @@ static int mux_proc_byte(CharDriverState *chr, MuxD=
river *d, int ch)
>          case 'c':
>              assert(d->mux_cnt > 0); /* handler registered with first f=
e */
>              /* Switch to the next registered device */
> -            mux_set_focus(d, (d->focus + 1) % d->mux_cnt);
> +            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
>              break;
>          case 't':
>              d->timestamps =3D !d->timestamps;
> @@ -826,8 +826,10 @@ static void mux_chr_set_handlers(CharDriverState *=
chr, GMainContext *context)
>                               context, true);
>  }
> =20
> -static void mux_set_focus(MuxDriver *d, int focus)
> +static void mux_set_focus(CharDriverState *chr, int focus)
>  {
> +    MuxDriver *d =3D chr->opaque;
> +
>      assert(focus >=3D 0);
>      assert(focus < d->mux_cnt);
> =20
> @@ -836,6 +838,7 @@ static void mux_set_focus(MuxDriver *d, int focus)
>      }
> =20
>      d->focus =3D focus;
> +    chr->be =3D d->backends[focus];
>      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
>  }
> =20
> @@ -935,7 +938,9 @@ void qemu_chr_fe_deinit(CharBackend *b)
> =20
>      if (b->chr) {
>          qemu_chr_fe_set_handlers(b, NULL, NULL, NULL, NULL, NULL, true=
);
> -        b->chr->be =3D NULL;
> +        if (b->chr->be =3D=3D b) {
> +            b->chr->be =3D NULL;
> +        }
>          if (b->chr->is_mux) {
>              MuxDriver *d =3D b->chr->opaque;
>              d->backends[b->tag] =3D NULL;
> @@ -999,7 +1004,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
>      }
> =20
>      if (b->chr->is_mux) {
> -        mux_set_focus(b->chr->opaque, b->tag);
> +        mux_set_focus(b->chr, b->tag);
>      }
>  }
> =20
>=20
