Received: from eggs.gnu.org ([2001:4830:134:3::10]:37561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyhVd-0002Q8-TF
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyhVc-0001sp-GF
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:22:13 -0400
References: <20170413154334.23708-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51602802-a7ce-478d-83bf-d6438a579a52@redhat.com>
Date: Thu, 13 Apr 2017 11:21:56 -0500
MIME-Version: 1.0
In-Reply-To: <20170413154334.23708-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AS1IorJ0iP9EadPUd4oGJcm0muanJuFt4"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block: Do not unref bs->file on
 error in BD's open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AS1IorJ0iP9EadPUd4oGJcm0muanJuFt4
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <51602802-a7ce-478d-83bf-d6438a579a52@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] block: Do not unref bs->file on
 error in BD's open
References: <20170413154334.23708-1-mreitz@redhat.com>
In-Reply-To: <20170413154334.23708-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/13/2017 10:43 AM, Max Reitz wrote:
> The block layer takes care of removing the bs->file child if the block
> driver's bdrv_open()/bdrv_file_open() implementation fails. The block
> driver therefore does not need to do so, and indeed should not unless i=
t
> sets bs->file to NULL afterwards -- because if this is not done, the
> bdrv_unref_child() in bdrv_open_inherit() will dereference the freed
> memory block at bs->file afterwards, which is not good.
>=20
> We can now decide whether to add a "bs->file =3D NULL;" after each of t=
he
> offending bdrv_unref_child() invocations, or just drop them altogether.=

> The latter is simpler, so let's do that.
>=20
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> It's an issue only in blkdebug, blkreplace and blkverify, and only when=

> an error occurs in their open functions; therefore I think this is fine=

> to delay until 2.10.
>=20
> However, it *is* a use-after-free newly introduced in 2.9, so that's
> where the question mark comes from...
> ---
>  block/blkdebug.c  | 4 +---
>  block/blkreplay.c | 3 ---
>  block/blkverify.c | 3 ---
>  3 files changed, 1 insertion(+), 9 deletions(-)

On its own, this patch is not worthy of an -rc5 (it only affects failure
paths, and 2 of the 3 affected drivers are not for production use). But
use-after-free is annoying, and the fact that blkreplay is affected
could trip up a user that mistypes arguments causing a BD open to fail.
I'd argue that since we're looking at -rc5 anyways, this is fair game
for inclusion in that build, since it is a small enough patch and easy
to review for correctness.  Hence I changed the subject in my reply to
'2.9?'

But I won't lose any sleep if we just wait for 2.9.1 and 2.10.

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/block/blkdebug.c b/block/blkdebug.c
> index 67e8024e36..cc4a146e84 100644
> --- a/block/blkdebug.c
> +++ b/block/blkdebug.c
> @@ -389,14 +389,12 @@ static int blkdebug_open(BlockDriverState *bs, QD=
ict *options, int flags,
>      } else if (align) {
>          error_setg(errp, "Invalid alignment");
>          ret =3D -EINVAL;
> -        goto fail_unref;
> +        goto out;
>      }
> =20

And this means I get to rebase my blkdebug patches on top of yours, if
yours goes in first.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AS1IorJ0iP9EadPUd4oGJcm0muanJuFt4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY76WkAAoJEKeha0olJ0NqZJMIAIDy04+J0eWn21CDALV6dbHB
6MebB+A7gLrka5RBD1RPrZMELY+wYOYQZssXlXbYmd9emcc+lujLs+phLHqZpoQ4
tEohxdJ/3e3aPusmVTrdaooQrGaHO3NRh5PNDMxx3pGWIgi+kEUxWjyzQ+sfbTYw
yBSrNej85grg5jeeNaIZSWhYA+dpzwfk2dCqZnXnqn84g2m4q4ksUciKRUkM549P
upeO1SIPqVwWsoFvaA8lw4/GoIbXJNh7eY/hprsdbWVWdLjbFfHDiWkap1GWFwsu
hAjoB4QewriNtDvTVsCx1CJUHoutD50EXMs+iYeLUEvuRzTaQw4hNrBXw+QWWHM=
=XR2y
-----END PGP SIGNATURE-----

--AS1IorJ0iP9EadPUd4oGJcm0muanJuFt4--
