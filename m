Received: from eggs.gnu.org ([2001:4830:134:3::10]:55748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYkGz-0000fZ-QW
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cYkGy-0004ca-W3
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 21:03:49 -0500
References: <20170131112308.54189-1-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e735b235-4502-f779-16db-ea3b2b86ae27@redhat.com>
Date: Wed, 1 Feb 2017 03:03:38 +0100
MIME-Version: 1.0
In-Reply-To: <20170131112308.54189-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="V6Vb9tiMuUjle1CnxDwbRffItSm0E0jE1"
Subject: Re: [Qemu-devel] [PATCH] block: bdrv_invalidate_cache: invalidate
 children first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V6Vb9tiMuUjle1CnxDwbRffItSm0E0jE1
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <e735b235-4502-f779-16db-ea3b2b86ae27@redhat.com>
Subject: Re: [PATCH] block: bdrv_invalidate_cache: invalidate children first
References: <20170131112308.54189-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170131112308.54189-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.01.2017 12:23, Vladimir Sementsov-Ogievskiy wrote:
> Current implementation invalidates firstly parent bds and then its
> children. This leads to the following bug:
>=20
> after incoming migration, in bdrv_invalidate_cache_all:
> 1. invalidate parent bds - reopen it with BDRV_O_INACTIVE cleared
> 2. child is not yet invalidated
> 3. parent check that its BDRV_O_INACTIVE is cleared
> 4. parent writes to child
> 5. assert in bdrv_co_pwritev, as BDRV_O_INACTIVE is set for child
>=20
> This patch fixes it by just changing invalidate sequence: invalidate
> children first.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> v2: I've missed that bdrv_invalidate_cache is already recursive, so we
> can change sequence here. Also v1 doesn't cover the case when
> bdrv_invalidate_cache is called not from bdrv_invalidate_cache_all.
>=20
>  block.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

I'll wait a bit until I apply this patch (please remind me next week if
I forget it...), though, because migration-related things are not
exactly my forte, so maybe someone else has something to say.

Max


--V6Vb9tiMuUjle1CnxDwbRffItSm0E0jE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliRQfoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AAF8H/3hEHPxey0S9g/eCzXRqtg+k779rXE4H
Rrtn+yTgb7GWFP4kvWtoluYub51CKCfhRUz2JRjolTb3gUXWcAFX+Ysfjvc39Z7d
NO+/kwqcN7I8DCZqVrWNL5moGqGfsLdhMEM2MAM+jLA/KLAjPME8qrneZjq9TfCk
OGEHNrPqyY2Oyl12AUtee0HRg3TUWZ/nd5A2LYaKPYQuat5PbcFxvM+ogkzb4w/I
svK9DnrqOlaLuWdFj9KK1g6uYRvs8Ki5siZg7/FwRlFBSWumZlxickwwb3VFMnUn
FL6Ow4wS/6Z5ZBXH3DcCSA3QvC38yppJ9j5Gj42glP3g0qGGJiDM4yI=
=tKfj
-----END PGP SIGNATURE-----

--V6Vb9tiMuUjle1CnxDwbRffItSm0E0jE1--
