Received: from eggs.gnu.org ([2001:4830:134:3::10]:51481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJJSt-0001At-6F
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJJSs-0000KO-Ev
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 08:56:35 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-11-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <078d5806-4b24-b793-a12a-796afa3c6fd0@redhat.com>
Date: Fri, 9 Jun 2017 14:56:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-11-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r0cCdDiaq8KU3al811CKhohToA7Xjux6L"
Subject: Re: [Qemu-devel] [PATCH v20 10/30] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
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
--r0cCdDiaq8KU3al811CKhohToA7Xjux6L
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <078d5806-4b24-b793-a12a-796afa3c6fd0@redhat.com>
Subject: Re: [PATCH v20 10/30] block/dirty-bitmap: add readonly field to
 BdrvDirtyBitmap
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
 <20170602112158.232757-11-vsementsov@virtuozzo.com>
In-Reply-To: <20170602112158.232757-11-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-02 13:21, Vladimir Sementsov-Ogievskiy wrote:
> It will be needed in following commits for persistent bitmaps.
> If bitmap is loaded from read-only storage (and we can't mark it
> "in use" in this storage) corresponding BdrvDirtyBitmap should be
> read-only.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 32 ++++++++++++++++++++++++++++++++
>  block/io.c                   |  8 ++++++++
>  blockdev.c                   |  6 ++++++
>  include/block/dirty-bitmap.h |  4 ++++
>  4 files changed, 50 insertions(+)
>=20
> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
> index f25428868c..1c9ffb292a 100644
> --- a/block/dirty-bitmap.c
> +++ b/block/dirty-bitmap.c
> @@ -45,6 +45,12 @@ struct BdrvDirtyBitmap {
>      bool disabled;              /* Bitmap is disabled. It skips all wr=
ites to
>                                     the device */
>      int active_iterators;       /* How many iterators are active */
> +    bool readonly;              /* Bitmap is read-only and may be chan=
ged only
> +                                   by deserialize* functions. This fie=
ld blocks
> +                                   any changing operations on owning i=
mage
> +                                   (writes and discards), if bitmap is=
 readonly
> +                                   such operations must fail and not c=
hange
> +                                   image or this bitmap */

"This fields blocks any modifying operations on the respective image
(writes and discards). If the bitmap is read-only, such operations must
fail and not change the image or this bitmap."

Or, what I'd think to be more natural:

"This fields also prevents the respective image from being modified
(i.e. blocks writes and discards). Such operations must fail and both
the image and this bitmap must remain unchanged while this flag is set."

Sorry to be so fussy about grammar and the like, but I'd just like the
comments which land in the code to be easily and clearly understandable..=
=2E

But just nit picking, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--r0cCdDiaq8KU3al811CKhohToA7Xjux6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOprvEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPBf
B/4yqT8/AZtIZM/2f8MWziTkzhk1Jy7wPLwdtlgVEyRayRyHQ6Ou4psIbF4ZeVG6
h56XnT7LpHhg8bSW1+2GNTTMHrrWqInAK2BK1yR+eqXPAZABi/zzgSSybjCW9Tnn
ld/F37UatQd0cdJG81T/d2UtIEaJ0krtjr9qhm0Wyzr09HURVcF5dvjI863U6qat
OAm8+zpBv5VHeXMAHsr8dn3423MOYYll3+MwnEsqmlGa/BOzZagMOJ4KjC8ryu69
SfGMEyTaWl5ldLghdOw47ZKM2Eec5ikz0PCCIu3NWQRLX4IlBwc0b9X4ZQcx/9dL
z/fO1+lEM0K1K/l/JSdI2czg
=iwr5
-----END PGP SIGNATURE-----

--r0cCdDiaq8KU3al811CKhohToA7Xjux6L--
