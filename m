Received: from eggs.gnu.org ([2001:4830:134:3::10]:36704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTi3-0000bV-F4
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwTi2-0001tM-3j
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 09:46:07 -0400
References: <20170919201910.25656-1-eblake@redhat.com>
	<20170919201910.25656-6-eblake@redhat.com>
	<697b6a91-5122-bc0d-569c-3ac6d94ec96a@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fef06662-de40-73bd-46e5-2551f9a260ff@redhat.com>
Date: Mon, 25 Sep 2017 08:45:50 -0500
MIME-Version: 1.0
In-Reply-To: <697b6a91-5122-bc0d-569c-3ac6d94ec96a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w9NuVO49csUlOD9jEaTT1vuKuUoPsXvWA"
Subject: Re: [Qemu-devel] [PATCH v9 05/20] dirty-bitmap: Avoid size query
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
--w9NuVO49csUlOD9jEaTT1vuKuUoPsXvWA
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <fef06662-de40-73bd-46e5-2551f9a260ff@redhat.com>
Subject: Re: [PATCH v9 05/20] dirty-bitmap: Avoid size query failure during
 truncate
References: <20170919201910.25656-1-eblake@redhat.com>
 <20170919201910.25656-6-eblake@redhat.com>
 <697b6a91-5122-bc0d-569c-3ac6d94ec96a@virtuozzo.com>
In-Reply-To: <697b6a91-5122-bc0d-569c-3ac6d94ec96a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/23/2017 07:04 AM, Vladimir Sementsov-Ogievskiy wrote:
> 19.09.2017 23:18, Eric Blake wrote:
>> We've previously fixed several places where we failed to account
>> for possible errors from bdrv_nb_sectors().=C2=A0 Fix another one by
>> making bdrv_dirty_bitmap_truncate() take the new size from the
>> caller instead of querying itself; then adjust the sole caller
>> bdrv_truncate() to pass the size just determined by a successful
>> resize, or to skip the bitmap resize on failure, thus avoiding
>> sizing the bitmaps to -1.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v9: skip only bdrv_dirty_bitmap_truncate on error [Fam]
>> v8: retitle and rework to avoid possibility of secondary failure [John=
]
>> v7: new patch [Kevin]
>> ---
>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0 2 +-
>> =C2=A0 block.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
5 ++++++++++-----
>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++---
>> =C2=A0 3 files changed, 14 insertions(+), 9 deletions(-)
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

>=20
> why not uint64_t as in following patches?

Because off_t is signed, so you can never have more than 2^63 (and NOT
2^64) bytes for your size anyways.  The following patches use int64_t,
rather than uint64_t, both because of off_t, and because it leaves room
for returning negative values on error.

>=20
>> =C2=A0 bool bdrv_dirty_bitmap_readonly(const BdrvDirtyBitmap *bitmap);=

>> =C2=A0 bool bdrv_has_readonly_bitmaps(BlockDriverState *bs);
>> =C2=A0 bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitm=
ap);
>> diff --git a/block.c b/block.c
>> index ee6a48976e..89261a7a53 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3450,12 +3450,17 @@ int bdrv_truncate(BdrvChild *child, int64_t
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
>=20
> looks like a separate bug - we didn't set errp with <0 return value

Yes, it was a pre-existing bug.  If I have to respin, I can update the
commit message to mention it.

>=20
> Looks like this all needs more work to make it really correct and safe
> (reading last John's comment)..
> And this patch don't really relate to the series, so if it will be the
> only obstacle for merging, can we
> merge all other patches first? I'll then rebase dirty bitmap migration
> series on master..

But it does relate, because I have to do something to avoid calling a
failing bdrv_nb_sectors/bdrv_getlength.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--w9NuVO49csUlOD9jEaTT1vuKuUoPsXvWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJCI4ACgkQp6FrSiUn
Q2rkDAf+JF3faUMFfOIDji8r/EEGLBGu0g0GnMCUoBOipyWndpaiVFkoT8ABjZuN
yxbFGj9H5zob33NGqHzU46JkUC8loTEE/8weHULsVwFPwzocCuJwCCY36CnNwZ+a
rli09tDx2usDODd06gxEGAI+v5DYFi2yryOgSTuBbe+epGSyAgoopRuXMsGa3dwu
+GNWkP9tj3k76mM7l4VOHI8WxE8Knhj+k724BzPHwWJEHZ+nN6EIhAEKS86FLOEW
2kuzVla4y1TPppPXBzQlZckChC3pxaKg/3yVAuMMIP2Lf+3mVR+XBFreESXRcSFa
+bDzxaOps0M4MWkbiorvwb8VjU4pKQ==
=ujDH
-----END PGP SIGNATURE-----

--w9NuVO49csUlOD9jEaTT1vuKuUoPsXvWA--
