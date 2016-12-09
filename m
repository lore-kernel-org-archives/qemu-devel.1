Received: from eggs.gnu.org ([2001:4830:134:3::10]:59730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFOcA-00085C-1n
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cFOc7-00020M-Ir
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:05:41 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
Date: Fri, 9 Dec 2016 18:05:27 +0100
MIME-Version: 1.0
In-Reply-To: <1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pGrouQeSVOC3C0fINrNc48lsKm7CAEO0d"
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
--pGrouQeSVOC3C0fINrNc48lsKm7CAEO0d
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
Subject: Re: [PATCH 13/21] qcow2: add .bdrv_store_persistent_dirty_bitmaps()
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
 <1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
> Realize block bitmap storing interface, to allow qcow2 images store
> persistent bitmaps.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-bitmap.c | 451 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   1 +
>  block/qcow2.h        |   1 +
>  3 files changed, 453 insertions(+)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 81be1ca..a975388 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -28,6 +28,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "exec/log.h"
> +#include "qemu/cutils.h"
> =20
>  #include "block/block_int.h"
>  #include "block/qcow2.h"
> @@ -43,6 +44,10 @@
>  #define BME_MIN_GRANULARITY_BITS 9
>  #define BME_MAX_NAME_SIZE 1023
> =20
> +#if BME_MAX_TABLE_SIZE * 8ULL > INT_MAX
> +#error In the code bitmap table physical size assumed to fit into int
> +#endif
> +
>  /* Bitmap directory entry flags */
>  #define BME_RESERVED_FLAGS 0xfffffffcU
>  #define BME_FLAG_IN_USE 1
> @@ -74,6 +79,8 @@ typedef struct Qcow2Bitmap {
>      uint8_t granularity_bits;
>      char *name;
> =20
> +    BdrvDirtyBitmap *dirty_bitmap;

(I'm not quite happy with the asymmetry of this field (it isn't set by
load_bitmap(), but it is required by store_bitmap()), but making it
symmetric either by making load_bitmap() set it or by store_bitmap() not
reading it (but getting the value through an explicit parameter) makes
the code needlessly more complicated, so I guess I'll have to stay
not-quite-happy.)

> +
>      QSIMPLEQ_ENTRY(Qcow2Bitmap) entry;
>  } Qcow2Bitmap;
>  typedef QSIMPLEQ_HEAD(Qcow2BitmapList, Qcow2Bitmap) Qcow2BitmapList;
> @@ -87,6 +94,27 @@ static inline bool can_write(BlockDriverState *bs)
>      return !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INA=
CTIVE);
>  }
> =20
> +static int update_header_sync(BlockDriverState *bs)
> +{
> +    int ret;
> +
> +    ret =3D qcow2_update_header(bs);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* We doesn't return  bdrv_flush error code. Even if it fails, wri=
te was

s/doesn't/don't/

(Also, there's a double space after return.)

> +     * successful and it is more logical to consider that header is in=
 the new
> +     * state than in the old.
> +     */
> +    ret =3D bdrv_flush(bs);
> +    if (ret < 0) {
> +        fprintf(stderr, "Failed to flush qcow2 header");
> +    }
> +
> +    return 0;
> +}
> +
>  static inline void bitmap_table_to_cpu(uint64_t *bitmap_table, size_t =
size)
>  {
>      size_t i;
> @@ -96,6 +124,15 @@ static inline void bitmap_table_to_cpu(uint64_t *bi=
tmap_table, size_t size)
>      }
>  }
> =20
> +static inline void bitmap_table_to_be(uint64_t *bitmap_table, size_t s=
ize)
> +{
> +    size_t i;
> +
> +    for (i =3D 0; i < size; ++i) {
> +        cpu_to_be64s(&bitmap_table[i]);
> +    }
> +}
> +
>  /* Check table entry specification constraints. If cluster_size is 0, =
offset
>   * alignment is not checked. */
>  static int check_table_entry(uint64_t entry, int cluster_size)
> @@ -121,6 +158,51 @@ static int check_table_entry(uint64_t entry, int c=
luster_size)
>      return 0;
>  }
> =20
> +static int check_constraints_on_bitmap(BlockDriverState *bs,
> +                                       const char *name,
> +                                       uint32_t granularity)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int granularity_bits =3D ctz32(granularity);
> +
> +    int64_t nb_sectors =3D bdrv_nb_sectors(bs);
> +
> +    if (nb_sectors < 0) {
> +        return nb_sectors;
> +    }
> +
> +    uint64_t phys_bitmap_bytes =3D (nb_sectors << BDRV_SECTOR_BITS) >>=


Using bdrv_getlength() would be simpler.

> +                                 granularity_bits;
> +    uint64_t bitmap_table_size =3D phys_bitmap_bytes / s->cluster_size=
;

Should be a DIV_ROUND_UP().

> +    size_t name_size =3D strlen(name);
> +
> +    int fail =3D

I'd personally like a bool more.

> +            (bitmap_table_size > BME_MAX_TABLE_SIZE) ||
> +            (phys_bitmap_bytes > BME_MAX_PHYS_SIZE) ||
> +            (granularity_bits > BME_MAX_GRANULARITY_BITS) ||
> +            (granularity_bits < BME_MIN_GRANULARITY_BITS) ||
> +            (name_size > BME_MAX_NAME_SIZE);
> +
> +    return fail ? -EINVAL : 0;
> +}
> +
> +static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_=
table,
> +                               uint32_t bitmap_table_size)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int i;
> +
> +    for (i =3D 0; i < bitmap_table_size; ++i) {
> +        uint64_t addr =3D bitmap_table[i] & BME_TABLE_ENTRY_OFFSET_MAS=
K;
> +        if (!addr) {
> +            continue;
> +        }
> +
> +        qcow2_free_clusters(bs, addr, s->cluster_size, QCOW2_DISCARD_O=
THER);
> +        bitmap_table[i] =3D 0;
> +    }
> +}
> +
>  static int bitmap_table_load(BlockDriverState *bs, Qcow2Bitmap *bm,
>                               uint64_t **bitmap_table)
>  {
> @@ -159,6 +241,28 @@ fail:
>      return ret;
>  }
> =20
> +static int free_bitmap_clusters(BlockDriverState *bs, Qcow2Bitmap *bm)=

> +{
> +    int ret;
> +    uint64_t *bitmap_table;
> +
> +    ret =3D bitmap_table_load(bs, bm, &bitmap_table);
> +    if (ret < 0) {
> +        assert(bitmap_table =3D=3D NULL);
> +        return ret;
> +    }
> +
> +    clear_bitmap_table(bs, bitmap_table, bm->table_size);
> +    qcow2_free_clusters(bs, bm->table_offset, bm->table_size * sizeof(=
uint64_t),
> +                        QCOW2_DISCARD_OTHER);
> +    g_free(bitmap_table);
> +
> +    bm->table_offset =3D 0;
> +    bm->table_size =3D 0;
> +
> +    return 0;
> +}
> +
>  /* This function returns the number of disk sectors covered by a singl=
e cluster
>   * of bitmap data. */
>  static uint64_t disk_sectors_in_bitmap_cluster(const BDRVQcow2State *s=
,
> @@ -603,6 +707,72 @@ fail:
>   * Bitmap List end
>   */
> =20
> +static int update_ext_header_and_dir(BlockDriverState *bs,
> +                                     Qcow2BitmapList *bm_list)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int ret;
> +    Qcow2Bitmap *bm;
> +    uint64_t new_offset =3D 0;
> +    uint64_t new_size =3D 0;
> +    uint32_t new_nb_bitmaps =3D 0;
> +    uint64_t old_offset =3D s->bitmap_directory_offset;
> +    uint64_t old_size =3D s->bitmap_directory_size;
> +    uint32_t old_nb_bitmaps =3D s->nb_bitmaps;
> +    uint64_t old_autocl =3D s->autoclear_features;
> +
> +    if (bm_list !=3D NULL && !QSIMPLEQ_EMPTY(bm_list)) {
> +        QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +            new_nb_bitmaps++;
> +        }
> +
> +        if (new_nb_bitmaps > QCOW2_MAX_BITMAPS) {
> +            return -EINVAL;
> +        }
> +
> +        ret =3D bitmap_list_store(bs, bm_list, &new_offset, &new_size,=
 false);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        ret =3D bdrv_flush(bs);
> +        if (ret < 0) {
> +            goto fail;
> +        }

I think this only needs to flush bs->file, not bs itself. Alternatively,
bitmap_list_store() could just use bdrv_pwrite_sync().

> +
> +        s->autoclear_features |=3D QCOW2_AUTOCLEAR_BITMAPS;
> +    } else {
> +        s->autoclear_features &=3D ~(uint64_t)QCOW2_AUTOCLEAR_BITMAPS;=

> +    }
> +
> +    s->bitmap_directory_offset =3D new_offset;
> +    s->bitmap_directory_size =3D new_size;
> +    s->nb_bitmaps =3D new_nb_bitmaps;
> +
> +    ret =3D update_header_sync(bs);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    if (old_size > 0) {
> +        qcow2_free_clusters(bs, old_offset, old_size, QCOW2_DISCARD_OT=
HER);
> +    }
> +
> +    return 0;
> +
> +fail:
> +    if (new_offset > 0) {
> +        qcow2_free_clusters(bs, new_offset, new_size, QCOW2_DISCARD_OT=
HER);
> +    }
> +
> +    s->bitmap_directory_offset =3D old_offset;
> +    s->bitmap_directory_size =3D old_size;
> +    s->nb_bitmaps =3D old_nb_bitmaps;
> +    s->autoclear_features =3D old_autocl;
> +
> +    return ret;
> +}
> +
>  /* for g_slist_foreach for GSList of BdrvDirtyBitmap* elements */
>  static void release_dirty_bitmap_helper(gpointer bitmap,
>                                          gpointer bs)
> @@ -664,3 +834,284 @@ fail:
>      g_slist_free(created_dirty_bitmaps);
>      bitmap_list_free(bm_list);
>  }
> +
> +/* store_bitmap_data()
> + * Store bitmap to image, filling bitmap table accordingly.
> + */
> +static uint64_t *store_bitmap_data(BlockDriverState *bs,
> +                                   BdrvDirtyBitmap *bitmap,
> +                                   uint32_t *bitmap_table_size, Error =
**errp)
> +{
> +    int ret;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int64_t sector;
> +    uint64_t dsc;
> +    uint64_t bm_size =3D bdrv_dirty_bitmap_size(bitmap);
> +    const char *bm_name =3D bdrv_dirty_bitmap_name(bitmap);
> +    uint8_t *buf =3D NULL;
> +    BdrvDirtyBitmapIter *dbi;
> +    uint64_t *tb;
> +    uint64_t tb_size =3D
> +            size_to_clusters(s,
> +                bdrv_dirty_bitmap_serialization_size(bitmap, 0, bm_siz=
e));
> +
> +    if (tb_size > BME_MAX_TABLE_SIZE ||
> +            tb_size * s->cluster_size > BME_MAX_PHYS_SIZE) {

Alignment to the opening parenthesis, please.

> +        error_setg(errp, "Bitmap '%s' is too big", bm_name);
> +        return NULL;
> +    }
> +
> +    tb =3D g_try_new0(uint64_t, tb_size);
> +    if (tb =3D=3D NULL) {
> +        error_setg(errp, "No memory");
> +        return NULL;
> +    }
> +
> +    dbi =3D bdrv_dirty_iter_new(bitmap, 0);
> +    buf =3D g_malloc(s->cluster_size);
> +    dsc =3D disk_sectors_in_bitmap_cluster(s, bitmap);
> +
> +    while ((sector =3D bdrv_dirty_iter_next(dbi)) !=3D -1) {
> +        uint64_t cluster =3D sector / dsc;
> +        uint64_t end, write_size;
> +        int64_t off;
> +
> +        sector =3D cluster * dsc;
> +        end =3D MIN(bm_size, sector + dsc);
> +        write_size =3D
> +            bdrv_dirty_bitmap_serialization_size(bitmap, sector, end -=
 sector);
> +
> +        off =3D qcow2_alloc_clusters(bs, s->cluster_size);
> +        if (off < 0) {
> +            error_setg_errno(errp, -off,
> +                             "Failed to allocate clusters for bitmap '=
%s'",
> +                             bm_name);
> +            goto fail;
> +        }
> +        tb[cluster] =3D off;

Somehow I would feel better with either an assert(cluster < tb_size);
here or an assert(bdrv_nb_sectors(bs) / dsc =3D=3D tb_size); (plus the er=
ror
handling for bdrv_nb_sectors()) above the loop.

> +
> +        bdrv_dirty_bitmap_serialize_part(bitmap, buf, sector, end - se=
ctor);
> +        if (write_size < s->cluster_size) {
> +            memset(buf + write_size, 0, s->cluster_size - write_size);=

> +        }

Should we assert that write_size <=3D s->cluster_size?

> +
> +        ret =3D qcow2_pre_write_overlap_check(bs, 0, off, s->cluster_s=
ize);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Qcow2 overlap check failed")=
;
> +            goto fail;
> +        }
> +
> +        ret =3D bdrv_pwrite(bs->file, off, buf, s->cluster_size);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to write bitmap '%s' =
to file",
> +                             bm_name);
> +            goto fail;
> +        }
> +
> +        if (end >=3D bm_size) {
> +            break;
> +        }
> +
> +        bdrv_set_dirty_iter(dbi, end);
> +    }
> +
> +    *bitmap_table_size =3D tb_size;
> +    g_free(buf);
> +    bdrv_dirty_iter_free(dbi);
> +
> +    return tb;
> +
> +fail:
> +    clear_bitmap_table(bs, tb, tb_size);
> +    g_free(buf);
> +    bdrv_dirty_iter_free(dbi);
> +    g_free(tb);
> +
> +    return NULL;
> +}
> +
> +/* store_bitmap()
> + * Store bm->dirty_bitmap to qcow2.
> + * Set bm->table_offset and bm->table_size accordingly.
> + */
> +static int store_bitmap(BlockDriverState *bs, Qcow2Bitmap *bm, Error *=
*errp)
> +{
> +    int ret;
> +    uint64_t *tb;
> +    int64_t tb_offset;
> +    uint32_t tb_size;
> +    BdrvDirtyBitmap *bitmap =3D bm->dirty_bitmap;
> +    const char *bm_name;
> +
> +    assert(bitmap !=3D NULL);
> +
> +    bm_name =3D bdrv_dirty_bitmap_name(bitmap);
> +
> +    tb =3D store_bitmap_data(bs, bitmap, &tb_size, errp);
> +    if (tb =3D=3D NULL) {
> +        g_free(tb);
> +        return -EINVAL;
> +    }
> +
> +    assert(tb_size <=3D BME_MAX_TABLE_SIZE);
> +    tb_offset =3D qcow2_alloc_clusters(bs, tb_size * sizeof(tb[0]));
> +    if (tb_offset < 0) {
> +        error_setg_errno(errp, -tb_offset,
> +                         "Failed to allocate clusters for bitmap '%s'"=
,
> +                         bm_name);
> +        goto fail;
> +    }
> +
> +    ret =3D qcow2_pre_write_overlap_check(bs, 0, tb_offset,
> +                                        tb_size * sizeof(tb[0]));
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Qcow2 overlap check failed");
> +        goto fail;
> +    }
> +
> +    bitmap_table_to_be(tb, tb_size);
> +    ret =3D bdrv_pwrite(bs->file, tb_offset, tb, tb_size * sizeof(tb[0=
]));
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to write bitmap '%s' to f=
ile",
> +                         bm_name);
> +        goto fail;
> +    }
> +
> +    g_free(tb);
> +
> +    bm->table_offset =3D tb_offset;
> +    bm->table_size =3D tb_size;
> +
> +    return 0;
> +
> +fail:
> +    clear_bitmap_table(bs, tb, tb_size);
> +
> +    if (tb_offset > 0) {
> +        qcow2_free_clusters(bs, tb_offset, tb_size, QCOW2_DISCARD_OTHE=
R);

tb_size should be tb_size * sizeof(uint64_t) (or sizeof(tb[0])).

> +    }
> +
> +    g_free(tb);
> +
> +    return ret;
> +}
> +
> +static Qcow2Bitmap *find_bitmap_by_name(Qcow2BitmapList *bm_list,
> +                                        const char *name)
> +{
> +    Qcow2Bitmap *bm;
> +
> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +        if (strcmp(name, bm->name) =3D=3D 0) {
> +            return bm;
> +        }
> +    }
> +
> +    return NULL;
> +}
> +
> +void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error =
**errp)
> +{
> +    BdrvDirtyBitmap *bitmap;
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint32_t new_nb_bitmaps =3D s->nb_bitmaps;
> +    uint64_t new_dir_size =3D s->bitmap_directory_size;
> +    int ret;
> +    Qcow2BitmapList *bm_list;
> +    Qcow2Bitmap *bm;
> +
> +    if (!bdrv_has_persistent_bitmaps(bs)) {
> +        /* nothing to do */
> +        return;

Maybe there is something to do. See [1].

> +    }
> +
> +    if (s->nb_bitmaps =3D=3D 0) {
> +        bm_list =3D bitmap_list_new();
> +    } else {
> +        bm_list =3D bitmap_list_load(bs, s->bitmap_directory_offset,
> +                                   s->bitmap_directory_size, errp);
> +        if (bm_list =3D=3D NULL) {
> +            /* errp is already set */
> +            return;
> +        }
> +    }
> +
> +    /* check constraints and names */
> +    for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap !=3D NULL=
;
> +            bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap)) {

Alignment to the opening parenthesis, please.

> +        const char *name =3D bdrv_dirty_bitmap_name(bitmap);
> +        uint32_t granularity =3D bdrv_dirty_bitmap_granularity(bitmap)=
;
> +        Qcow2Bitmap *bm;
> +
> +        if (!bdrv_dirty_bitmap_get_persistance(bitmap)) {
> +            continue;
> +        }
> +
> +        if (++new_nb_bitmaps > QCOW2_MAX_BITMAPS) {
> +            error_setg(errp, "Too many persistent bitmaps");
> +            goto fail;
> +        }
> +
> +        new_dir_size +=3D calc_dir_entry_size(strlen(name), 0);
> +        if (new_dir_size > QCOW2_MAX_BITMAP_DIRECTORY_SIZE) {
> +            error_setg(errp, "Too large bitmap directory");
> +            goto fail;
> +        }

You only need to increment new_nb_bitmaps and increase new_dir_size if
the bitmap does not already exist in the image (i.e. if
find_bitmap_by_name() below returns NULL).

> +
> +        if (check_constraints_on_bitmap(bs, name, granularity) < 0) {
> +            error_setg(errp, "Bitmap '%s' doesn't satisfy the constrai=
nts",
> +                       name);
> +            goto fail;
> +        }
> +
> +        bm =3D find_bitmap_by_name(bm_list, name);
> +        if (bm =3D=3D NULL) {
> +            bm =3D g_new0(Qcow2Bitmap, 1);
> +            bm->name =3D g_strdup(name);
> +            QSIMPLEQ_INSERT_TAIL(bm_list, bm, entry);
> +        } else {
> +            if (!(bm->flags & BME_FLAG_IN_USE) && can_write(bs)) {

Shouldn't we error out right at the beginning of this function if
can_write(bs) is false?

> +                error_setg(errp, "Bitmap '%s' is already exists in the=
 image",
> +                           name);
> +                goto fail;
> +            }
> +            free_bitmap_clusters(bs, bm);

These clusters should not be freed until the new data has been written
successfully.

> +            /* TODO it is better to reuse these clusters */
> +        }
> +        bm->flags =3D bdrv_dirty_bitmap_get_autoload(bitmap) ? BME_FLA=
G_AUTO : 0;
> +        bm->granularity_bits =3D ctz32(bdrv_dirty_bitmap_granularity(b=
itmap));
> +        bm->dirty_bitmap =3D bitmap;
> +    }

[1] What about bitmaps that have BME_FLAG_IN_USE set but do not have a
corresponding BDS bitmap?

If such a bitmap does not have BME_FLAG_AUTO set, we didn't set the
flag, so we should keep it unchanged. That's what this function is
currently doing.

However, if such a bitmap does have BME_FLAG_AUTO set, it was definitely
us who set the IN_USE flag (because otherwise we would have aborted
loading the bitmaps, and thus also aborted bdrv_open_common()).
Therefore, the only explanation is that the bitmap was deleted in the
meantime, and that means we should also delete it in the qcow2 file.

Max

> +
> +    /* allocate clusters and store bitmaps */
> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +        if (bm->dirty_bitmap =3D=3D NULL) {
> +            continue;
> +        }
> +
> +        ret =3D store_bitmap(bs, bm, errp);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +    }
> +
> +    ret =3D update_ext_header_and_dir(bs, bm_list);
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret, "Failed to update bitmap extensio=
n");
> +        goto fail;
> +    }
> +
> +    bitmap_list_free(bm_list);
> +    return;
> +
> +fail:
> +    QSIMPLEQ_FOREACH(bm, bm_list, entry) {
> +        if (bm->dirty_bitmap =3D=3D NULL || bm->table_offset =3D=3D 0)=
 {
> +            continue;
> +        }
> +
> +        free_bitmap_clusters(bs, bm);
> +    }
> +
> +    bitmap_list_free(bm_list);
> +}
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 443be0e..66c7f74 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -3515,6 +3515,7 @@ BlockDriver bdrv_qcow2 =3D {
>      .bdrv_attach_aio_context  =3D qcow2_attach_aio_context,
> =20
>      .bdrv_load_autoloading_dirty_bitmaps =3D qcow2_load_autoloading_di=
rty_bitmaps,
> +    .bdrv_store_persistent_dirty_bitmaps =3D qcow2_store_persistent_di=
rty_bitmaps,
>  };
> =20
>  static void bdrv_qcow2_init(void)
> diff --git a/block/qcow2.h b/block/qcow2.h
> index bcedf5b..d9a7643 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -615,5 +615,6 @@ void qcow2_cache_put(BlockDriverState *bs, Qcow2Cac=
he *c, void **table);
> =20
>  /* qcow2-bitmap.c functions */
>  void qcow2_load_autoloading_dirty_bitmaps(BlockDriverState *bs, Error =
**errp);
> +void qcow2_store_persistent_dirty_bitmaps(BlockDriverState *bs, Error =
**errp);
> =20
>  #endif
>=20



--pGrouQeSVOC3C0fINrNc48lsKm7CAEO0d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhK5FcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Ao+kH/0Bcztb9FWtrLgyWvnURqimDTf8jSOe3
BVZq2B06Gd58SWMvK+0I2ERHCdpohKecZ0okXEq15/QKTys5bl4N0o4lcQHYS3HR
k45PHgBIqac/y6MLV4UbSEvW/ZenHkdn0nSAgrVcZAgpu4Q4e0dxxQ4FX/9RYILI
HO7XcFPbutka1XcB3aueh7SBhHtPgbKHLFtaHv/tW17f+9CrXQyWbXvRDDYJO2AL
MkT2vU3WS+6KO6A/iFxEAL1JAgLQQF6gRQSdqhvvvs7kq6UqJqboBJoAfTOXmazn
Td0QkgIUNu9DnH92n8a02tNPmdKsPIoVzGhOQOcGQ9Go59l4jqkRVsw=
=vnlo
-----END PGP SIGNATURE-----

--pGrouQeSVOC3C0fINrNc48lsKm7CAEO0d--
