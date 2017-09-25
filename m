Received: from eggs.gnu.org ([2001:4830:134:3::10]:43034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwVal-0006sk-La
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwVak-00007N-AG
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 11:46:43 -0400
References: <20170925145526.32690-1-eblake@redhat.com>
	<20170925145526.32690-6-eblake@redhat.com>
	<f305e22b-963e-f1eb-710c-d74c6efc9628@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b10bd108-0387-34eb-9aa4-7c5e3f9f63a1@redhat.com>
Date: Mon, 25 Sep 2017 10:46:05 -0500
MIME-Version: 1.0
In-Reply-To: <f305e22b-963e-f1eb-710c-d74c6efc9628@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wjvSxnD0glrK8Tb1pnl773RDSi1PlPs1m"
Subject: Re: [Qemu-devel] [PATCH v10 05/20] dirty-bitmap: Avoid size query
 failure during truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wjvSxnD0glrK8Tb1pnl773RDSi1PlPs1m
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <b10bd108-0387-34eb-9aa4-7c5e3f9f63a1@redhat.com>
Subject: Re: [PATCH v10 05/20] dirty-bitmap: Avoid size query failure during
 truncate
References: <20170925145526.32690-1-eblake@redhat.com>
 <20170925145526.32690-6-eblake@redhat.com>
 <f305e22b-963e-f1eb-710c-d74c6efc9628@virtuozzo.com>
In-Reply-To: <f305e22b-963e-f1eb-710c-d74c6efc9628@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/25/2017 10:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> 25.09.2017 17:55, Eric Blake wrote:
>> We've previously fixed several places where we failed to account
>> for possible errors from bdrv_nb_sectors().=C2=A0 Fix another one by
>> making bdrv_dirty_bitmap_truncate() take the new size from the
>> caller instead of querying itself; then adjust the sole caller
>> bdrv_truncate() to pass the size just determined by a successful
>> resize, or to skip the bitmap resize on failure, thus avoiding
>=20
> nothing is skipped in this version

So much for me squashing in a change.  If the maintainer is willing
(Kevin, is this going through your tree?), we can reword that to:

"...pass the size just determined by a successful resize, or to reuse
the size given to the original truncate operation when
refresh_total_sectors() was not able to confirm the actual size (the two
sizes can potentially differ according to rounding constraints), thus
avoiding..."

>=20
>> sizing the bitmaps to -1.=C2=A0 This also fixes a bug where not all
>> failure paths in bdrv_truncate() would set errp.
>>
>> Note that bdrv_truncate() is still a bit awkward.=C2=A0 We may want
>> to revisit it later and clean up things to better guarantee that
>> a resize attempt either fails cleanly up front, or cannot fail
>> after guest-visible changes have been made (if temporary changes
>> are made, then they need to be cleanly rolled back).=C2=A0 But that
>> is a task for another day; for now, the goal is the bare minimum
>> fix to ensure that just bdrv_dirty_bitmap_truncate() cannot fail.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>=20
>=20
>>
>> ---
>> v10: always resize bitmap as before [John], enhance commit message to
>> point out errp bugfix [Vladimir]
>> v9: skip only bdrv_dirty_bitmap_truncate on error [Fam]
>> v8: retitle and rework to avoid possibility of secondary failure [John=
]
>> v7: new patch [Kevin]
>> ---
>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0 2 +-
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
6 +++++++++++-----
>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++---
>> =C2=A0 3 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitmap=
=2Eh
>> index 8fd842eac9..7a27590047 100644
>> --- a/include/block/dirty-bitmap.h
>> +++ b/include/block/dirty-bitmap.h
>> @@ -83,7 +83,7 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter
>> *iter);
>> =C2=A0 void bdrv_set_dirty_iter(BdrvDirtyBitmapIter *hbi, int64_t sect=
or_num);
>> =C2=A0 int64_t bdrv_get_dirty_count(BdrvDirtyBitmap *bitmap);
>> =C2=A0 int64_t bdrv_get_meta_dirty_count(BdrvDirtyBitmap *bitmap);
>> -void bdrv_dirty_bitmap_truncate(BlockDriverState *bs);
>> +void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes);=

>> =C2=A0 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);=

>> =C2=A0 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>> =C2=A0 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitm=
ap);
>> diff --git a/block.c b/block.c
>> index 528cda7b2c..ef5af81f66 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3545,12 +3545,18 @@ int bdrv_truncate(BdrvChild *child, int64_t
>> offset, PreallocMode prealloc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(!(bs->open_flags & BDRV_O_INACTI=
VE));
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D drv->bdrv_truncate(bs, offset, =
prealloc, errp);
>> -=C2=A0=C2=A0=C2=A0 if (ret =3D=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D refresh_total_sect=
ors(bs, offset >> BDRV_SECTOR_BITS);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_truncate=
(bs);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_parent_cb_resize(bs);=

>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atomic_inc(&bs->write_gen)=
;
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 ret =3D refresh_total_sectors(bs, offset >> BDRV_S=
ECTOR_BITS);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg_errno(errp, -re=
t, "Could not refresh total sector
>> count");
>> +=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D bs->total_secto=
rs * BDRV_SECTOR_SIZE;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_truncate(bs, offset);
>> +=C2=A0=C2=A0=C2=A0 bdrv_parent_cb_resize(bs);
>> +=C2=A0=C2=A0=C2=A0 atomic_inc(&bs->write_gen);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>>
>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>> index 42a55e4a4b..ee164fb518 100644
>> --- a/block/dirty-bitmap.c
>> +++ b/block/dirty-bitmap.c
>> @@ -1,7 +1,7 @@
>> =C2=A0 /*
>> =C2=A0=C2=A0 * Block Dirty Bitmap
>> =C2=A0=C2=A0 *
>> - * Copyright (c) 2016 Red Hat. Inc
>> + * Copyright (c) 2016-2017 Red Hat. Inc
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * Permission is hereby granted, free of charge, to any pe=
rson
>> obtaining a copy
>> =C2=A0=C2=A0 * of this software and associated documentation files (th=
e
>> "Software"), to deal
>> @@ -302,10 +302,10 @@ BdrvDirtyBitmap
>> *bdrv_reclaim_dirty_bitmap(BlockDriverState *bs,
>> =C2=A0=C2=A0 * Truncates _all_ bitmaps attached to a BDS.
>> =C2=A0=C2=A0 * Called with BQL taken.
>> =C2=A0=C2=A0 */
>> -void bdrv_dirty_bitmap_truncate(BlockDriverState *bs)
>> +void bdrv_dirty_bitmap_truncate(BlockDriverState *bs, int64_t bytes)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>> -=C2=A0=C2=A0=C2=A0 uint64_t size =3D bdrv_nb_sectors(bs);
>> +=C2=A0=C2=A0=C2=A0 int64_t size =3D DIV_ROUND_UP(bytes, BDRV_SECTOR_S=
IZE);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmaps_lock(bs);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QLIST_FOREACH(bitmap, &bs->dirty_bitmap=
s, list) {
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wjvSxnD0glrK8Tb1pnl773RDSi1PlPs1m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJJL0ACgkQp6FrSiUn
Q2o5Hgf/Rh/tJLaJHHsUQQL1HPdpweBTF4r4NkTAhoNY3gcT7Zt/MtJmK+VS818k
6MP/D/VrnVoXdgWPnty2HjNZAPVC5Qulrbo3zA6OhztNJFb4CRlLcluzLjq8I9zy
Mee26mwwRfHY3P8vox+tNUW56RkarsQkl++sdHrK3fcG6RhMeSJn3JtYsZbspgY/
r8wA/JVuJ0mfEvODPn263n93DTVyUZgEJxofM1x8Z5klaIf4Jgw/AHxnSeMWBiyn
GyyaneGIvFOz97jmvfzoJwkFfawKGXbpD+b/0wkDdLaokS4sGu5E7kixZtkjbwq5
dOh5IheMDEZ093QS5xhzpfY6aq/4PA==
=1EOP
-----END PGP SIGNATURE-----

--wjvSxnD0glrK8Tb1pnl773RDSi1PlPs1m--
