Received: from eggs.gnu.org ([2001:4830:134:3::10]:42832)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGkFd-0005Nw-SD
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eGkFa-0000DX-OQ
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 06:28:33 -0500
Date: Mon, 20 Nov 2017 11:28:26 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171120112826.GC4516@stefanha-x1.localdomain>
References: <cover.1511145863.git.jcody@redhat.com>
	<5bec37564f83e39e216d2ebcf7a380b0c7704e0e.1511145863.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline
In-Reply-To: <5bec37564f83e39e216d2ebcf7a380b0c7704e0e.1511145863.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/5] coroutine: abort if we
 try to enter coroutine scheduled for another ctx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:46:43PM -0500, Jeff Cody wrote:
> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> index cb98892..931cdc9 100644
> --- a/include/qemu/coroutine_int.h
> +++ b/include/qemu/coroutine_int.h
> @@ -53,6 +53,9 @@ struct Coroutine {
> =20
>      /* Only used when the coroutine has yielded.  */
>      AioContext *ctx;
> +
> +    int scheduled;

s/int/bool/

> diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> index d6095c1..2edab63 100644
> --- a/util/qemu-coroutine.c
> +++ b/util/qemu-coroutine.c
> @@ -109,6 +109,15 @@ void qemu_aio_coroutine_enter(AioContext *ctx, Corou=
tine *co)
> =20
>      trace_qemu_aio_coroutine_enter(ctx, self, co, co->entry_arg);
> =20
> +    /* if the Coroutine has already been scheduled, entering it again wi=
ll
> +     * cause us to enter it twice, potentially even after the coroutine =
has
> +     * been deleted */
> +    if (co->scheduled =3D=3D 1) {
> +        fprintf(stderr, "Cannot enter a co-routine that has already "
> +                        "been scheduled to run in a different AioContext=
\n");

This error message is too specific, the AioContext doesn't have to be
different from the current one:

block/blkdebug.c:        aio_co_schedule(qemu_get_current_aio_context(), qe=
mu_coroutine_self());

If something calls qemu_aio_coroutine_enter() on the coroutine it might
be from the same AioContext - but still an error condition worth failing
loudly on.

I suggest simplifying the error message:

  fprintf(stderr, "Cannot enter a co-routine that has already "
                  "been scheduled\n");

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaErxaAAoJEJykq7OBq3PISHwIAJOqU9SW76Y9Anqq0rF3kMWO
bRGEfgaKJtBUEuZKTeelxU6RUrj673eA3LUPLDen7fSZ7K4csMHD9Mjt2DyMXGlo
lfMNbrXLQ240LvBrl89SCL4N56vl5x43+nIKasVfCBStuJDa2YRRMGX3gtiIu4Cl
HDQflUwZVsfWYezEEdCGvBQrvya7FW93yHr6VK3f+fsc7TeewJwJ7QB7y3yLYtbV
8Za9PX5j+QrwudIoIpukSfvfPpnYteP1pnlo8F+ABI9DRQufpFqWDk/oognIucre
fZj92N9adwnnuJKiVwtj8je0W0ahS7Y2QkKTAK8QBjNs8+PpYwjKgH96e1qVrBg=
=ImYc
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--
