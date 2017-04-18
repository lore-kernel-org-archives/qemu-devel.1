Received: from eggs.gnu.org ([2001:4830:134:3::10]:41060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0SzF-0005jL-6J
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d0SzD-0007eO-R1
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 09:16:05 -0400
References: <20170314023933.12118-1-famz@redhat.com>
	<20170314023933.12118-2-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4086fd79-3226-0be2-a258-137b48095f94@redhat.com>
Date: Tue, 18 Apr 2017 08:15:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170314023933.12118-2-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3eiJhGxLhqQaHPr947d9gB1ExnfVO9ur9"
Subject: Re: [Qemu-devel] [PATCH RFC 1/3] block: Introduce BDRV_O_UNSAFE_READ
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3eiJhGxLhqQaHPr947d9gB1ExnfVO9ur9
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <4086fd79-3226-0be2-a258-137b48095f94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/3] block: Introduce BDRV_O_UNSAFE_READ
References: <20170314023933.12118-1-famz@redhat.com>
 <20170314023933.12118-2-famz@redhat.com>
In-Reply-To: <20170314023933.12118-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 09:39 PM, Fam Zheng wrote:
> This flag clears out the "consistent read" permission that blk_new_open=

> requests.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/block-backend.c | 2 +-
>  include/block/block.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 5742c09..99428ee 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -197,7 +197,7 @@ BlockBackend *blk_new_open(const char *filename, co=
nst char *reference,
>       * caller of blk_new_open() doesn't make use of the permissions, b=
ut they
>       * shouldn't hurt either. We can still share everything here becau=
se the
>       * guest devices will add their own blockers if they can't share. =
*/
> -    perm =3D BLK_PERM_CONSISTENT_READ;
> +    perm =3D flags & BDRV_O_UNSAFE_READ ? 0 : BLK_PERM_CONSISTENT_READ=
;

A bit awkward that we have to add an option that requests negation of a
permission under the hood, but looks like it is the least-invasive way
to get what we want.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3eiJhGxLhqQaHPr947d9gB1ExnfVO9ur9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY9hF6AAoJEKeha0olJ0Nq7NQH/3b6yREnmRGqM15txLkE5cVz
jXmSMFsbl42VXKxvs2c5FWITmY/nPlUvwpHeOp9t4dwkB8DWCRJwt8BXdBdPPtDH
N8JEcfpqS1LDqKIfu4i/sZqEEhQzFXOslU0BMw+BSEYYD9HUQebtgiW5jgQan1PZ
LaOpGDtYYgfYQiNCU/+ebmVv2ClzC5JXWwBEDbHB0QDvFeg9G4dFv8mP6SGkS1Ay
NyfHIQghJj7ZHA93Q8jxpw9uCx9yhv/aZtzZj9X75AOIyYcVR6OWmkTkCcWUN8sX
xNl5wnirOOxzyRDALmIL3reomwSKZZHHijCdUWj4EPES7kbxus+sBDIko2xuDmQ=
=KEJ8
-----END PGP SIGNATURE-----

--3eiJhGxLhqQaHPr947d9gB1ExnfVO9ur9--
