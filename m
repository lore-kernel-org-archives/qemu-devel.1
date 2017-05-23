Received: from eggs.gnu.org ([2001:4830:134:3::10]:53569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDwh-00008T-Jm
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDDwg-0007PU-Hg
	for qemu-devel@nongnu.org; Tue, 23 May 2017 13:50:11 -0400
References: <87c0140e9407c08f6e74b04131b610f2e27c014c.1495560397.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ede19401-6025-19f1-9c34-d1dd3ab5b073@redhat.com>
Date: Tue, 23 May 2017 12:50:00 -0500
MIME-Version: 1.0
In-Reply-To: <87c0140e9407c08f6e74b04131b610f2e27c014c.1495560397.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uh9e8GPH4vn9XQhLoLACKf78KrR42nbqK"
Subject: Re: [Qemu-devel] [PATCH] block/gluster: glfs_lseek() workaround
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, ndevos@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uh9e8GPH4vn9XQhLoLACKf78KrR42nbqK
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, ndevos@redhat.com
Message-ID: <ede19401-6025-19f1-9c34-d1dd3ab5b073@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/gluster: glfs_lseek() workaround
References: <87c0140e9407c08f6e74b04131b610f2e27c014c.1495560397.git.jcody@redhat.com>
In-Reply-To: <87c0140e9407c08f6e74b04131b610f2e27c014c.1495560397.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 12:27 PM, Jeff Cody wrote:
> On current released versions of glusterfs, glfs_lseek() will sometimes
> return invalid values for SEEK_DATA or SEEK_HOLE.  For SEEK_DATA and
> SEEK_HOLE, the returned value should be >=3D the passed offset, or < 0 =
in
> the case of error:
>=20

> However, occasionally glfs_lseek() for SEEK_HOLE/DATA will return a
> value less than the passed offset, yet greater than zero.

Ouch.

>=20
> Although this is being fixed in gluster, we still should work around it=

> in QEMU, given that multiple released versions of gluster behave this
> way.

Fair enough.

>=20
> This patch treats the return case of (offs < start) the same as if an
> error value other than ENXIO is returned; we will assume we learned
> nothing, and there are no holes in the file.

Yes, holes are merely an optimization, so treating bugs by the
pessimistic fallback of no holes rather than aborting is reasonable.


> +++ b/block/gluster.c
> @@ -1275,7 +1275,14 @@ static int find_allocation(BlockDriverState *bs,=
 off_t start,
>      if (offs < 0) {
>          return -errno;          /* D3 or D4 */
>      }
> -    assert(offs >=3D start);
> +
> +    if (offs < start) {
> +        /* This is not a valid return by lseek().  We are safe to just=
 return
> +         * -EIO in this case, and we'll treat it like D4. Unfortunatel=
y some
> +         *  versions of libgfapi will return offs < start, so an asser=
t here
> +         *  will unneccesarily abort QEMU. */

s/unneccesarily/unnecessarily/ (twice)

With spelling fix,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--uh9e8GPH4vn9XQhLoLACKf78KrR42nbqK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJHZIAAoJEKeha0olJ0NqNbYH/2u+hmRedgdVoWnFAQ0DrYRf
BDKBLerjQdrZp9shUJo800nSXJdI1Ofdi0Qd5e7rlCEMS+2XjjfcxOhyrcM7qHvs
pIHiJnFgCmkei0/AstP6e6d0Ltcjus4FGxk3qwV/fYywTpL5ZQKeYxU0zHv89yYr
7yb7oMjlzDrT41147oSB8ebEWv6/vGEBuVF7TubE3vWAh9PGGWKXY5cdO3UbocjA
sJdsSHn6V42M8fhzEOdnOjP80WkO7bfNmPpFm77YVSvWk3Sy0WwGNTx75qWWzf9v
N2f7oX6Cjs+8hwhOnUHN0weuIXo7VlhkZoLIFCoj/BSUOUXl0rlPdCDTctPvmfc=
=d6Aa
-----END PGP SIGNATURE-----

--uh9e8GPH4vn9XQhLoLACKf78KrR42nbqK--
