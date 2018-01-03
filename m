Received: from eggs.gnu.org ([2001:4830:134:3::10]:33337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eWn3A-0005Y5-Ce
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:42:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eWn36-0007qG-CJ
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:42:00 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eWn36-0007pq-23
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 12:41:56 -0500
Received: by mail-wr0-x241.google.com with SMTP id f8so2361639wre.4
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 09:41:55 -0800 (PST)
Date: Wed, 3 Jan 2018 17:41:53 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180103174152.GC21894@stefanha-x1.localdomain>
References: <20180103021456.22526-4-peterx@redhat.com>
	<20180103022418.23165-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <20180103022418.23165-1-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2.1 3/3] chardev: introduce
 qemu_chr_timeout_add() and use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, stefanha@redhat.com, marcandre.lureau@redhat.com


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 03, 2018 at 10:24:18AM +0800, Peter Xu wrote:
> It's a replacement of g_timeout_add[_seconds]() for chardevs.  Chardevs
> now can have dedicated gcontext, we should always bind chardev tasks
> onto those gcontext rather than the default main context.  Since there
> are quite a few of g_timeout_add[_seconds]() callers, a new function
> qemu_chr_timeout_add() is introduced.
>=20
> One thing to mention is that, terminal3270 is still always running on
> main gcontext.  However let's convert that as well since it's still part
> of chardev codes and in case one day we'll miss that when we move it out
> of main gcontext too.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>=20
> v2 -> v2.1: Sorry I forgot to do the move in char.h.  Did it in this
> minor version.
>=20
>  chardev/char-pty.c     |  9 ++-------
>  chardev/char-socket.c  |  4 ++--
>  chardev/char.c         | 20 ++++++++++++++++++++
>  hw/char/terminal3270.c |  7 ++++---
>  include/chardev/char.h |  3 +++
>  5 files changed, 31 insertions(+), 12 deletions(-)
>=20
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index dd17b1b823..cbd8ac5eb7 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -78,13 +78,8 @@ static void pty_chr_rearm_timer(Chardev *chr, int ms)
>          s->timer_tag =3D 0;
>      }
> =20
> -    if (ms =3D=3D 1000) {
> -        name =3D g_strdup_printf("pty-timer-secs-%s", chr->label);
> -        s->timer_tag =3D g_timeout_add_seconds(1, pty_chr_timer, chr);
> -    } else {
> -        name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
> -        s->timer_tag =3D g_timeout_add(ms, pty_chr_timer, chr);
> -    }
> +    name =3D g_strdup_printf("pty-timer-ms-%s", chr->label);
> +    s->timer_tag =3D qemu_chr_timeout_add(chr, ms, pty_chr_timer, chr);

The label is user-visible.  Why did you remove the seconds label format?

Please either include justification in the commit description or avoid
spurious changes like this so reviewers don't need to worry about code
changes that are not essential.

>      g_source_set_name_by_id(s->timer_tag, name);
>      g_free(name);
>  }
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 630a7f2995..5cca32f963 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -73,8 +73,8 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
>      char *name;
> =20
>      assert(s->connected =3D=3D 0);
> -    s->reconnect_timer =3D g_timeout_add_seconds(s->reconnect_time,
> -                                               socket_reconnect_timeout,=
 chr);

Here it was clear that reconnect_time is in seconds...

> +    s->reconnect_timer =3D qemu_chr_timeout_add(chr, s->reconnect_time *=
 1000,
> +                                              socket_reconnect_timeout, =
chr);

=2E..now I can't tell what the unit is.

Please rename qemu_chr_timeout_add() to include the units:

  s->reconnect_timer =3D qemu_chr_timeout_add_ms(chr, s->reconnect_time * 1=
000,

>      name =3D g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
>      g_source_set_name_by_id(s->reconnect_timer, name);
>      g_free(name);
> diff --git a/chardev/char.c b/chardev/char.c
> index 8c3765ee99..a1de662fec 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -1084,6 +1084,26 @@ void qmp_chardev_send_break(const char *id, Error =
**errp)
>      qemu_chr_be_event(chr, CHR_EVENT_BREAK);
>  }
> =20
> +/*
> + * Add a timeout callback for the chardev (in milliseconds). Please
> + * use this to add timeout hook for chardev instead of g_timeout_add()
> + * and g_timeout_add_seconds(), to make sure the gcontext that the
> + * task bound to is correct.
> + */

What is the return value?

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaTRXgAAoJEJykq7OBq3PIV04H/3hrEgyDFzWqZ3Dri9uBfwKY
QcUhmLIVMbcVkK+3zCe1+6ImL7dnhxXQQCg/DSND9wxttO8snsiJVkk9TU87xQic
XQQSX4/CI/bAss1g3phNfU+0K+U8OKMF6QYQ+c/kk6Oy6OBLK0XjgPbQ5G9ylRrX
re1SOlPiGJqm0sOIVizK8/Yx0pyU/dGinYeX2j92/nQKIxXXY/4dhUqMOmKrwGOi
JxR9ke7TmhTQ2hpCeuqlpC+uoypfYls1dT7zb1azD3AoKaaW9WUeJYznP9/pcdhF
E/fLbB4O3qTf/FEbT9MdbR5+y4WX8qdgmGJOWv3S4CEqX9IOijc7xC5Z9GBxX+Q=
=ONtb
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
