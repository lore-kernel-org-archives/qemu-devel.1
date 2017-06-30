Received: from eggs.gnu.org ([2001:4830:134:3::10]:36497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQkqL-0005wm-AP
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQkqK-0004dv-6c
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 21:35:33 -0400
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-12-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6b56a9ab-86a5-967a-8ece-75e7ab8d0e0b@redhat.com>
Date: Thu, 29 Jun 2017 20:35:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170628120530.31251-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lK4T9lsMGTTTks6U2C9W1P8NshVSNVbli"
Subject: Re: [Qemu-devel] [PATCH v22 11/30] qcow2: autoloading dirty bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lK4T9lsMGTTTks6U2C9W1P8NshVSNVbli
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <6b56a9ab-86a5-967a-8ece-75e7ab8d0e0b@redhat.com>
Subject: Re: [PATCH v22 11/30] qcow2: autoloading dirty bitmaps
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
 <20170628120530.31251-12-vsementsov@virtuozzo.com>
In-Reply-To: <20170628120530.31251-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 07:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They=

> are loaded when the image is opened and become BdrvDirtyBitmaps for the=

> corresponding drive.
>=20
> Extra data in bitmaps is not supported for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  block/qcow2-bitmap.c | 389 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |  17 ++-
>  block/qcow2.h        |   2 +
>  3 files changed, 406 insertions(+), 2 deletions(-)

> +
> +/* load_bitmap_data
> + * @bitmap_table entries must satisfy specification constraints.
> + * @bitmap must be cleared */
> +static int load_bitmap_data(BlockDriverState *bs,
> +                            const uint64_t *bitmap_table,
> +                            uint32_t bitmap_table_size,
> +                            BdrvDirtyBitmap *bitmap)
> +{
> +    int ret =3D 0;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t sector, sbc;
> +    uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);

Right now, this is returned as the size in sectors (my series changes it
to be the size in bytes, but that's being rebased on top of yours)

> +    uint8_t *buf =3D NULL;
> +    uint64_t i, tab_size =3D
> +            size_to_clusters(s,
> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_siz=
e));

But bdrv_dirty_bitmap_serialization_size() takes count according to the
underlying hbitmap granularity.  Hmm - you found a bug in my series -
when I convert dirty-bitmap.c to use byte-based counts everywhere, I
forgot to convert bdrv_dirty_bitmap_serialization_size().  Good thing
yours is going in first ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lK4T9lsMGTTTks6U2C9W1P8NshVSNVbli
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVarUAAoJEKeha0olJ0NqZ9cH/1P77oY2Gn3l3exNGslB5aZh
daNdIj3GPHE4w7M7bq49a5DbWlDQLfz5wsAKC3DykusHf/V97JoeqC0Jes/C5HmR
jeYjmYnXeh0lMmoX55sStjnJESFyLepSiF+rKVG91oAAV12Zk9lK2y/qetBOzWGo
1mI/WneUs2zbVqe+6vmDU8UWmwIooAQkoDSCmbv2U4GDeal4Q1OQoP2b377nffVb
aaSlkqkpXIqS2HyGaGMiZ61DkUi+38dClWjD5Kwz0lNYdnjQHKOuWWuNJScwIPS/
bZKIXm/MSJFoihl/SgQyQ5kC5NZX8oJxG0kZUCSmLK37OFg8HCaP5zXW3BILEZQ=
=W6b5
-----END PGP SIGNATURE-----

--lK4T9lsMGTTTks6U2C9W1P8NshVSNVbli--
