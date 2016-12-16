Received: from eggs.gnu.org ([2001:4830:134:3::10]:43210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cHtdc-00012d-IW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cHtdY-0000BA-En
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 09:37:32 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
	<2e03e805-9226-fdc7-7069-814c1346edd2@redhat.com>
	<81adfcb0-77cf-2370-6aca-0b9bcfe5ca0a@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3e6a1526-d0ea-8d15-505b-07101e777da0@redhat.com>
Date: Fri, 16 Dec 2016 15:37:12 +0100
MIME-Version: 1.0
In-Reply-To: <81adfcb0-77cf-2370-6aca-0b9bcfe5ca0a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="C9Exlg8NC7w09JxOGkE5SsHn3IQLQ0bVc"
Subject: Re: [Qemu-devel] [PATCH 09/21] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
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
--C9Exlg8NC7w09JxOGkE5SsHn3IQLQ0bVc
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <3e6a1526-d0ea-8d15-505b-07101e777da0@redhat.com>
Subject: Re: [PATCH 09/21] qcow2: add .bdrv_load_autoloading_dirty_bitmaps
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
 <2e03e805-9226-fdc7-7069-814c1346edd2@redhat.com>
 <81adfcb0-77cf-2370-6aca-0b9bcfe5ca0a@virtuozzo.com>
In-Reply-To: <81adfcb0-77cf-2370-6aca-0b9bcfe5ca0a@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 14.12.2016 16:54, Vladimir Sementsov-Ogievskiy wrote:
> 07.12.2016 23:51, Max Reitz wrote:
>> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>>> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. Th=
ey
>>> are loaded when the image is opened and become BdrvDirtyBitmaps for t=
he
>>> corresponding drive.
>>>
>>> Extra data in bitmaps is not supported for now.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>>   block/Makefile.objs  |   2 +-
>>>   block/qcow2-bitmap.c | 663
>>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>   block/qcow2.c        |   2 +
>>>   block/qcow2.h        |   3 +
>>>   4 files changed, 669 insertions(+), 1 deletion(-)
>>>   create mode 100644 block/qcow2-bitmap.c
>>>
>> [...]
>>
>>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>>> new file mode 100644
>>> index 0000000..0f797e6
>>> --- /dev/null
>>> +++ b/block/qcow2-bitmap.c
>>> @@ -0,0 +1,663 @@
>> [...]
>>
>>> +/* Check table entry specification constraints. If cluster_size is
>>> 0, offset
>>> + * alignment is not checked. */
>>> +static int check_table_entry(uint64_t entry, int cluster_size)
>>> +{
>>> +    uint64_t offset;
>>> +
>>> +    if (entry & BME_TABLE_ENTRY_RESERVED_MASK) {
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    offset =3D entry & BME_TABLE_ENTRY_OFFSET_MASK;
>>> +    if (offset !=3D 0) {
>>> +        /* if offset specified, bit 0 must is reserved */
>> -must
>>
>>> +        if (entry & 1) {
>>> +            return -EINVAL;
>>> +        }
>>> +
>>> +        if ((cluster_size !=3D 0) && (entry % cluster_size !=3D 0)) =
{
>> Why would cluster_size be 0? Also, shouldn't it be offset instead of
>> entry?
>=20
> the comment says: "If cluster_size is 0, offset alignment is not checke=
d"

Oops, right. Is there any place where this function is called with
cluster_size being 0, though?

> yes, should be offset.
>=20
>>
>>> +            return -EINVAL;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>> [...]
>>
>>> +/* bitmap table entries must satisfy specification constraints */
>>> +static int load_bitmap_data(BlockDriverState *bs,
>>> +                            const uint64_t *bitmap_table,
>>> +                            uint32_t bitmap_table_size,
>>> +                            BdrvDirtyBitmap *bitmap)
>>> +{
>>> +    int ret =3D 0;
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    uint64_t sector, dsc;
>>> +    uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);
>>> +    uint8_t *buf =3D NULL;
>>> +    uint64_t i, tab_size =3D
>>> +            size_to_clusters(s,
>>> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0,
>>> bm_size));
>>> +
>>> +    if (tab_size !=3D bitmap_table_size ||
>>> +            tab_size > BME_MAX_TABLE_SIZE) {
>> This line should be aligned to the opening parenthesis.
>>
>> [...]
>>
>>> +static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry=

>>> *entry)
>>> +{
>>> +    BDRVQcow2State *s =3D bs->opaque;
>>> +    uint64_t phys_bitmap_bytes =3D
>>> +            (uint64_t)entry->bitmap_table_size * s->cluster_size;
>>> +    uint64_t max_virtual_bits =3D
>>> +            (phys_bitmap_bytes * 8) << entry->granularity_bits;
>> I think this shift can overflow, even if bitmap_table_size, cluster_si=
ze
>> and granularity_bits are all within their respective limits.
>=20
> Hmm. But it can't, if phys_bitmap_bytes <=3D MAX_PHYS_SIZE. I can just
> move this calculation down.

Yes, you're right, I missed the check on phys_bitmap_bytes. It's all
good then.

>>> +    int64_t nb_sectors =3D bdrv_nb_sectors(bs);
>> Just using bdrv_getlength() would probably be simpler.
>>
>>> +
>>> +    if (nb_sectors < 0) {
>>> +        return nb_sectors;
>>> +    }
>>> +
>>> +    int fail =3D
>> I'd prefer a boolean.
>=20
> and mixed definition/code)

=2E..now that you mention it... :-)

>>> +            (entry->bitmap_table_size =3D=3D 0) ||
>>> +            (entry->bitmap_table_offset =3D=3D 0) ||
>>> +            (entry->bitmap_table_offset % s->cluster_size) ||
>>> +            (entry->bitmap_table_size > BME_MAX_TABLE_SIZE) ||
>>> +            (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
>>> +            (entry->bitmap_table_offset !=3D 0 &&
>=20
> hmm, can be dropped, as checked above
>=20
>>> +                (nb_sectors << BDRV_SECTOR_BITS) > max_virtual_bits)=
 ||
>>> +            (entry->granularity_bits > BME_MAX_GRANULARITY_BITS) ||
>>> +            (entry->granularity_bits < BME_MIN_GRANULARITY_BITS) ||
>>> +            (entry->flags & BME_RESERVED_FLAGS) ||
>>> +            (entry->name_size > BME_MAX_NAME_SIZE) ||
>>> +            (entry->type !=3D BT_DIRTY_TRACKING_BITMAP);
>>> +
>>> +    return fail ? -EINVAL : 0;
>>> +}
>> [...]
>>
>>> +/* bitmap_list_load
>>> + * Get bitmap list from qcow2 image. Actually reads bitmap directory=
,
>>> + * checks it and convert to bitmap list.
>>> + */
>>> +static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs,
>>> uint64_t offset,
>>> +                                         uint64_t size, Error **errp=
)
>>> +{
>> [...]
>>
>>> +    bm_list =3D bitmap_list_new();
>>> +    for (e =3D (Qcow2BitmapDirEntry *)dir;
>>> +             e < (Qcow2BitmapDirEntry *)dir_end; e =3D
>>> next_dir_entry(e)) {
>> This line should be aligned to the opening parenthesis.
>>
>> [...]
>>
>>> +
>>> +/* bitmap_list_store
>>> + * Store bitmap list to qcow2 image as a bitmap directory.
>>> + * Everything is checked.
>>> + */
>>> +static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList
>>> *bm_list,
>>> +                             uint64_t *offset, uint64_t *size, bool
>>> in_place)
>>> +{
>> [...]
>>
>>> +fail:
>>> +    g_free(dir);
>>> +
>>> +    if (dir_offset > 0) {
>>> +        qcow2_free_clusters(bs, dir_offset, dir_size,
>>> QCOW2_DISCARD_OTHER);
>> I think this should only be freed if in_place is false.
>=20
> Reasonable.. And this also leads me to the think that we should clear
> autoclear bit in the header before inplace updating of bitmap directory=

> and set it after successful update.

Not a bad idea, actually. I don't think it's absolutely necessary but it
would indeed be nice.

Max


--C9Exlg8NC7w09JxOGkE5SsHn3IQLQ0bVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhT/BgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A+KQH/0+XyUuKOW0LJw++9X0qFEvyD7lVtkh8
8G3DXWtxDgTe7VQXJoIfIZIE/zwuVz5MFO84w6BqXVkepJbdaBOheqmxcm+ZC6qj
71sOWHqVho5AHbhR8ob38VPEGWvQHtzXyrdMOJQRQsjSF5CuZI5kZZbjSgzOd4b1
azlX2JbachmpNL7qvFQ6/MEeUVHbM8RlPZ0JfDqkzbik9W7y1hROKI7E/njhm1RW
aYltxqnS+KIoid0upRTxLLhOe7XWA+NDW0Zo3jx6VVgHElNcApo7EZ78o4OeC4v5
jKrLcOZIfLK8Ffnz6z60Vs7s/lAXImERSI31arZn9EYgohdMPnVUBpo=
=ju2y
-----END PGP SIGNATURE-----

--C9Exlg8NC7w09JxOGkE5SsHn3IQLQ0bVc--
