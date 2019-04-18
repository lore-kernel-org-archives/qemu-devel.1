Received: from eggs.gnu.org ([209.51.188.92]:59523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hHCG9-0008U8-Fd
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hHCG8-0007Tm-Hv
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:59:45 -0400
References: <20180713111424.23670-1-mreitz@redhat.com>
	<20180713111424.23670-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
Date: Thu, 18 Apr 2019 13:59:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180713111424.23670-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6tsdUPzkgeRjZ90Oe2fB5opuWAPBvXaPT"
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6tsdUPzkgeRjZ90Oe2fB5opuWAPBvXaPT
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <cec09e49-6702-cb66-e668-42d728800a75@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] qemu-img: Use zero writes after source
 backing EOF
References: <20180713111424.23670-1-mreitz@redhat.com>
 <20180713111424.23670-3-mreitz@redhat.com>
In-Reply-To: <20180713111424.23670-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7/13/18 6:14 AM, Max Reitz wrote:
> Past the end of the source backing file, we memset() buf_old to zero, s=
o
> it is clearly easy to use blk_pwrite_zeroes() instead of blk_pwrite()
> then.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  qemu-img.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20

> @@ -3458,8 +3461,12 @@ static int img_rebase(int argc, char **argv)
>                  if (compare_buffers(buf_old + written, buf_new + writt=
en,
>                                      n - written, &pnum))
>                  {
> -                    ret =3D blk_pwrite(blk, offset + written,
> -                                     buf_old + written, pnum, 0);
> +                    if (buf_old_is_zero) {
> +                        ret =3D blk_pwrite_zeroes(blk, offset + writte=
n, pnum, 0);

Should we allow BDRV_REQ_MAY_UNMAP here, either unconditionally, or
based on a command line knob that told us whether the user is more
interested in a sparse result (that still reads as zero) vs. a
fully-allocated result?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6tsdUPzkgeRjZ90Oe2fB5opuWAPBvXaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly4yRwACgkQp6FrSiUn
Q2rDrgf+LBdI8qFj1fcFP6aiBfUoHlkGctRdYHjzAOSTE7pfYFNOMED0KpA+0obj
9F9jZlqG9r5tbhbe1iXVKSYY5fGsNYwN7SfOIxnsdhFuYMon9LwCvKeECA8bVIb2
N6AG8/zsrnsZB6iBjlDZVhBcNQ0oJDCQL4nY8oqGvmHM+2eSdNtZexD7v0DWbgRT
1j8ZBTILl+un9ZLPiwq5Fik/HQKsxkrTSHiBOH/Pq83o2v/+X1RbqWooOxfj+mvx
zaH57gfgMlKivnydxLa4N93sgD+rDrYltawy1RhTpOR+P2nAK27I5TRBo0qnIbz6
+R+xneAMdfUcm4UD9Yl2IuAhcYxswg==
=ud4M
-----END PGP SIGNATURE-----

--6tsdUPzkgeRjZ90Oe2fB5opuWAPBvXaPT--
