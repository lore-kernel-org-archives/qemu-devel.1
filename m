Received: from eggs.gnu.org ([2001:4830:134:3::10]:42247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEjC5-0001RX-Uz
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:52:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEjC3-0003tN-SG
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 15:52:02 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <2e03e805-9226-fdc7-7069-814c1346edd2@redhat.com>
Date: Wed, 7 Dec 2016 21:51:41 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="dLLa5CWPGhQgamIwC631bbmBdmxbI2wD0"
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
--dLLa5CWPGhQgamIwC631bbmBdmxbI2wD0
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <2e03e805-9226-fdc7-7069-814c1346edd2@redhat.com>
Subject: Re: [PATCH 09/21] qcow2: add .bdrv_load_autoloading_dirty_bitmaps
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-10-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Auto loading bitmaps are bitmaps in Qcow2, with the AUTO flag set. They=

> are loaded when the image is opened and become BdrvDirtyBitmaps for the=

> corresponding drive.
>=20
> Extra data in bitmaps is not supported for now.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/Makefile.objs  |   2 +-
>  block/qcow2-bitmap.c | 663 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   2 +
>  block/qcow2.h        |   3 +
>  4 files changed, 669 insertions(+), 1 deletion(-)
>  create mode 100644 block/qcow2-bitmap.c
>=20

[...]

> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> new file mode 100644
> index 0000000..0f797e6
> --- /dev/null
> +++ b/block/qcow2-bitmap.c
> @@ -0,0 +1,663 @@

[...]

> +/* Check table entry specification constraints. If cluster_size is 0, =
offset
> + * alignment is not checked. */
> +static int check_table_entry(uint64_t entry, int cluster_size)
> +{
> +    uint64_t offset;
> +
> +    if (entry & BME_TABLE_ENTRY_RESERVED_MASK) {
> +        return -EINVAL;
> +    }
> +
> +    offset =3D entry & BME_TABLE_ENTRY_OFFSET_MASK;
> +    if (offset !=3D 0) {
> +        /* if offset specified, bit 0 must is reserved */

-must

> +        if (entry & 1) {
> +            return -EINVAL;
> +        }
> +
> +        if ((cluster_size !=3D 0) && (entry % cluster_size !=3D 0)) {

Why would cluster_size be 0? Also, shouldn't it be offset instead of entr=
y?

> +            return -EINVAL;
> +        }
> +    }
> +
> +    return 0;
> +}

[...]

> +/* bitmap table entries must satisfy specification constraints */
> +static int load_bitmap_data(BlockDriverState *bs,
> +                            const uint64_t *bitmap_table,
> +                            uint32_t bitmap_table_size,
> +                            BdrvDirtyBitmap *bitmap)
> +{
> +    int ret =3D 0;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t sector, dsc;
> +    uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);
> +    uint8_t *buf =3D NULL;
> +    uint64_t i, tab_size =3D
> +            size_to_clusters(s,
> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_siz=
e));
> +
> +    if (tab_size !=3D bitmap_table_size ||
> +            tab_size > BME_MAX_TABLE_SIZE) {

This line should be aligned to the opening parenthesis.

[...]

> +static int check_dir_entry(BlockDriverState *bs, Qcow2BitmapDirEntry *=
entry)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t phys_bitmap_bytes =3D
> +            (uint64_t)entry->bitmap_table_size * s->cluster_size;
> +    uint64_t max_virtual_bits =3D
> +            (phys_bitmap_bytes * 8) << entry->granularity_bits;

I think this shift can overflow, even if bitmap_table_size, cluster_size
and granularity_bits are all within their respective limits.

> +    int64_t nb_sectors =3D bdrv_nb_sectors(bs);

Just using bdrv_getlength() would probably be simpler.

> +
> +    if (nb_sectors < 0) {
> +        return nb_sectors;
> +    }
> +
> +    int fail =3D

I'd prefer a boolean.

> +            (entry->bitmap_table_size =3D=3D 0) ||
> +            (entry->bitmap_table_offset =3D=3D 0) ||
> +            (entry->bitmap_table_offset % s->cluster_size) ||
> +            (entry->bitmap_table_size > BME_MAX_TABLE_SIZE) ||
> +            (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
> +            (entry->bitmap_table_offset !=3D 0 &&
> +                (nb_sectors << BDRV_SECTOR_BITS) > max_virtual_bits) |=
|
> +            (entry->granularity_bits > BME_MAX_GRANULARITY_BITS) ||
> +            (entry->granularity_bits < BME_MIN_GRANULARITY_BITS) ||
> +            (entry->flags & BME_RESERVED_FLAGS) ||
> +            (entry->name_size > BME_MAX_NAME_SIZE) ||
> +            (entry->type !=3D BT_DIRTY_TRACKING_BITMAP);
> +
> +    return fail ? -EINVAL : 0;
> +}

[...]

> +/* bitmap_list_load
> + * Get bitmap list from qcow2 image. Actually reads bitmap directory,
> + * checks it and convert to bitmap list.
> + */
> +static Qcow2BitmapList *bitmap_list_load(BlockDriverState *bs, uint64_=
t offset,
> +                                         uint64_t size, Error **errp)
> +{

[...]

> +    bm_list =3D bitmap_list_new();
> +    for (e =3D (Qcow2BitmapDirEntry *)dir;
> +             e < (Qcow2BitmapDirEntry *)dir_end; e =3D next_dir_entry(=
e)) {

This line should be aligned to the opening parenthesis.

[...]

> +
> +/* bitmap_list_store
> + * Store bitmap list to qcow2 image as a bitmap directory.
> + * Everything is checked.
> + */
> +static int bitmap_list_store(BlockDriverState *bs, Qcow2BitmapList *bm=
_list,
> +                             uint64_t *offset, uint64_t *size, bool in=
_place)
> +{

[...]

> +fail:
> +    g_free(dir);
> +
> +    if (dir_offset > 0) {
> +        qcow2_free_clusters(bs, dir_offset, dir_size, QCOW2_DISCARD_OT=
HER);

I think this should only be freed if in_place is false.

Max

> +    }
> +
> +    return ret;
> +}


--dLLa5CWPGhQgamIwC631bbmBdmxbI2wD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhIdl0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ARnEIAIQSrNtWaBcJdWpRlAQJQkVZmANWODCd
u1Hg9fHu4QRkdRgXOOpNoybpIhdO82Ug8ERetfay84Nr19UPA2XtXP59VwiJRz4k
+iiBaQUP78AeMbi3RiT3xr0V+C98CNkVstBH10a6ejDV7R+dqqdTMMc+Fx2/G+Us
zSqOAcGcsHfkofYH25woRy2FpNhi2RQ7JF4USRMMkJJvkXjrCokDcDRwxiBcea2z
vUm6lX38y49qFc/uhNacpaLo/lzNgefchZbv/FqWUFc3Gi9dJ6Nz0HExG66ost4a
70oWj6zdQeIWFs9GvtseKPG4Nng7wZDPRIao5SscBg+tMJLvh3aokXw=
=OECE
-----END PGP SIGNATURE-----

--dLLa5CWPGhQgamIwC631bbmBdmxbI2wD0--
