Received: from eggs.gnu.org ([2001:4830:134:3::10]:37037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cIzeS-000529-Ig
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cIzeO-0001ME-D7
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 10:14:56 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
	<919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
	<6d72606d-7e76-8f53-ed5f-b37838666e1e@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <a8e92d90-b8d2-a26d-458e-82fd1f1a00dd@redhat.com>
Date: Mon, 19 Dec 2016 16:14:28 +0100
MIME-Version: 1.0
In-Reply-To: <6d72606d-7e76-8f53-ed5f-b37838666e1e@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N7Bx7lpRJOW3O9cr9grhVWGEEaobN0g8v"
Subject: Re: [Qemu-devel] [PATCH 13/21] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
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
--N7Bx7lpRJOW3O9cr9grhVWGEEaobN0g8v
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <a8e92d90-b8d2-a26d-458e-82fd1f1a00dd@redhat.com>
Subject: Re: [PATCH 13/21] qcow2: add .bdrv_store_persistent_dirty_bitmaps()
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
 <919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
 <6d72606d-7e76-8f53-ed5f-b37838666e1e@virtuozzo.com>
In-Reply-To: <6d72606d-7e76-8f53-ed5f-b37838666e1e@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 17.12.2016 15:58, Vladimir Sementsov-Ogievskiy wrote:
> 09.12.2016 20:05, Max Reitz wrote:
>> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>> Realize block bitmap storing interface, to allow qcow2 images store
>>> persistent bitmaps.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>  block/qcow2-bitmap.c | 451 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  block/qcow2.c        |   1 +
>=20
> [...]
>=20
>>> +
>>> +/* store_bitmap_data()
>>> + * Store bitmap to image, filling bitmap table accordingly.
>>> + */
>>> +static uint64_t *store_bitmap_data(BlockDriverState *bs,
>>> +                                   BdrvDirtyBitmap *bitmap,
>>> +                                   uint32_t *bitmap_table_size, Erro=
r **errp)
>>> +{
>>> +    int ret;
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    int64_t sector;
>>> +    uint64_t dsc;
>>> +    uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);
>>> +    const char *bm_name =3D bdrv_dirty_bitmap_name(bitmap);
>>> +    uint8_t *buf =3D NULL;
>>> +    BdrvDirtyBitmapIter *dbi;
>>> +    uint64_t *tb;
>>> +    uint64_t tb_size =3D
>>> +            size_to_clusters(s,
>>> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_s=
ize));
>>> +
>>> +    if (tb_size > BME_MAX_TABLE_SIZE ||
>>> +            tb_size * s->cluster_size > BME_MAX_PHYS_SIZE) {
>> Alignment to the opening parenthesis, please.
>>
>>> +        error_setg(errp, "Bitmap '%s' is too big", bm_name);
>>> +        return NULL;
>>> +    }
>>> +
>>> +    tb =3D g_try_new0(uint64_t, tb_size);
>>> +    if (tb =3D=3D NULL) {
>>> +        error_setg(errp, "No memory");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    dbi =3D bdrv_dirty_iter_new(bitmap, 0);
>>> +    buf =3D g_malloc(s->cluster_size);
>>> +    dsc =3D disk_sectors_in_bitmap_cluster(s, bitmap);
>>> +
>>> +    while ((sector =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
>>> +        uint64_t cluster =3D sector / dsc;
>>> +        uint64_t end, write_size;
>>> +        int64_t off;
>>> +
>>> +        sector =3D cluster * dsc;
>>> +        end =3D MIN(bm_size, sector + dsc);
>>> +        write_size =3D
>>> +            bdrv_dirty_bitmap_serialization_size(bitmap, sector, end=
 - sector);
>>> +
>>> +        off =3D qcow2_alloc_clusters(bs, s->cluster_size);
>>> +        if (off < 0) {
>>> +            error_setg_errno(errp, -off,
>>> +                             "Failed to allocate clusters for bitmap=
 '%s'",
>>> +                             bm_name);
>>> +            goto fail;
>>> +        }
>>> +        tb[cluster] =3D off;
>> Somehow I would feel better with either an assert(cluster < tb_size);
>> here or an assert(bdrv_nb_sectors(bs) / dsc =3D=3D tb_size); (plus the=
 error
>> handling for bdrv_nb_sectors()) above the loop.
>=20
> assert((bm_size - 1) / dsc =3D=3D tb_size - 1) seems ok. and no additio=
nal
> error handling. Right?

Right, bm_size is already equal to bdrv_nb_sectors(bs), and it's not
necessarily a multiple of dsc. So that should be good. Alternatively, I
think the following would be slightly easier to read:

assert(DIV_ROUND_UP(bm_size, dsc) =3D=3D tb_size);

>=20
>>> +
>>> +        bdrv_dirty_bitmap_serialize_part(bitmap, buf, sector, end - =
sector);
>>> +        if (write_size < s->cluster_size) {
>>> +            memset(buf + write_size, 0, s->cluster_size - write_size=
);
>>> +        }
>> Should we assert that write_size <=3D s->cluster_size?
>=20
> Ok
>=20
> [...].
>=20
>>
>>> +        const char *name =3D bdrv_dirty_bitmap_name(bitmap);
>>> +        uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bitma=
p);
>>> +        Qcow2Bitmap *bm;
>>> +
>>> +        if (!bdrv_dirty_bitmap_get_persistance(bitmap)) {
>>> +            continue;
>>> +        }
>>> +
>>> +        if (++new_nb_bitmaps > QCOW2_MAX_BITMAPS) {
>>> +            error_setg(errp, "Too many persistent bitmaps");
>>> +            goto fail;
>>> +        }
>>> +
>>> +        new_dir_size +=3D calc_dir_entry_size(strlen(name), 0);
>>> +        if (new_dir_size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
>>> +            error_setg(errp, "Too large bitmap directory");
>>> +            goto fail;
>>> +        }
>> You only need to increment new_nb_bitmaps and increase new_dir_size if=

>> the bitmap does not already exist in the image (i.e. if
>> find_bitmap_by_name() below returns NULL).
>=20
> Why? No, I need to check the whole sum and the whole size.

If the bitmap already exists, you don't create a new directory entry but
reuse the existing one. Therefore, the number of bitmaps in the image
and the directory size will not grow then.

Max

>>> +
>>> +        if (check_constraints_on_bitmap(bs, name, granularity) < 0) =
{
>>> +            error_setg(errp, "Bitmap '%s' doesn't satisfy the constr=
aints",
>>> +                       name);
>>> +            goto fail;
>>> +        }
>>> +
>>> +        bm =3D find_bitmap_by_name(bm_list, name);
>>> +        if (bm =3D=3D NULL) {
>>> +            bm =3D g_new0(Qcow2Bitmap, 1);
>>> +            bm->name =3D g_strdup(name);
>>> +            QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
>>> +        } else {
>>> +            if (!(bm->flags & BME_FLAG_IN_USE) && can_write(bs)) {
>> Shouldn't we error out right at the beginning of this function if
>> can_write(bs) is false?
>=20
> Hmm, right.
>=20
> [...]
>=20
> --=20
> Best regards,
> Vladimir
>=20



--N7Bx7lpRJOW3O9cr9grhVWGEEaobN0g8v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhX+V8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ADIgIAJW61HY49ft8faJSXjUT5xp69H/QLjJH
lKCfFqK2FsEiFfQBgJ0FPkhu9KqGhhgs3K/FnwcwSU86uVxe6HcCNW9YrcAu5ukU
7ltaWDndeJgZSKWO4RMlvQCM2uqElDQI1rAGpz2ktyWe4AC4mgBrcA86Kop3aREj
I+llUM00q89VYBLus5JkFwZiKNhPZjIcrxCz+jEbVqWFG+pfAHbraT93OZ+3BNqr
Toc/JAz9XSKyxkt2dfJ422dOyz32XeVb8GUEJszMoYwb9u7AmC0+NlAgmW97qHlP
m1jy9A2VknUfG8eXoSxeZnkLuIaF0u7eYYpc0n0pBsvWa2v1fiANuPs=
=dRbu
-----END PGP SIGNATURE-----

--N7Bx7lpRJOW3O9cr9grhVWGEEaobN0g8v--
