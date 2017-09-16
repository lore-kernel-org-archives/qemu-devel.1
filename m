Received: from eggs.gnu.org ([2001:4830:134:3::10]:33961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtF2C-0004PN-CY
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 11:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dtF2B-0001lD-0W
	for qemu-devel@nongnu.org; Sat, 16 Sep 2017 11:29:32 -0400
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
	<20170817091542.9403-4-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9205db19-e16e-55d7-a6bd-0dd7d6e7eae5@redhat.com>
Date: Sat, 16 Sep 2017 17:29:17 +0200
MIME-Version: 1.0
In-Reply-To: <20170817091542.9403-4-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="chxvhgFOsPrhScLXLFTL4W9wPiGnViWAW"
Subject: Re: [Qemu-devel] [PATCH v7 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--chxvhgFOsPrhScLXLFTL4W9wPiGnViWAW
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com,
 den@openvz.org
Message-ID: <9205db19-e16e-55d7-a6bd-0dd7d6e7eae5@redhat.com>
Subject: Re: [PATCH v7 3/4] qcow2: add shrink image support
References: <20170817091542.9403-1-pbutsykin@virtuozzo.com>
 <20170817091542.9403-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170817091542.9403-4-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-08-17 11:15, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cluster.c  |  50 +++++++++++++++++++++
>  block/qcow2-refcount.c | 120 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c          |  43 ++++++++++++++----
>  block/qcow2.h          |  14 ++++++
>  qapi/block-core.json   |   3 +-
>  5 files changed, 220 insertions(+), 10 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index f06c08f64c..0c7a9a920c 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -32,6 +32,56 @@
>  #include "qemu/bswap.h"
>  #include "trace.h"
> =20
> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t exact_size)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int new_l1_size, i, ret;
> +
> +    if (exact_size >=3D s->l1_size) {
> +        return 0;
> +    }
> +
> +    new_l1_size =3D exact_size;
> +
> +#ifdef DEBUG_ALLOC2
> +    fprintf(stderr, "shrink l1_table from %d to %d\n", s->l1_size, new=
_l1_size);
> +#endif
> +
> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
> +    ret =3D bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
> +                                       new_l1_size * sizeof(uint64_t),=

> +                             (s->l1_size - new_l1_size) * sizeof(uint6=
4_t), 0);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    ret =3D bdrv_flush(bs->file->bs);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
> +    for (i =3D s->l1_size - 1; i > new_l1_size - 1; i--) {
> +        if ((s->l1_table[i] & L1E_OFFSET_MASK) =3D=3D 0) {
> +            continue;
> +        }
> +        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
> +                            s->cluster_size, QCOW2_DISCARD_ALWAYS);
> +        s->l1_table[i] =3D 0;
> +    }
> +    return 0;
> +
> +fail:
> +    /*
> +     * If the write in the l1_table failed the image may contain parti=
ally
> +     * overwritten the l1_table. In this case would be better to clear=
 the

e.g. *"may contain a partially overwritten l1_table"
*"In this case it would be better"

> +     * l1_table in memory to avoid possible image corruption.
> +     */
> +    memset(s->l1_table + exact_size, 0,

Though it doesn't make a functional difference, I'd prefer "new_l1_size"
instead of "exact_size", because you're using new_l1_size everywhere
else (including the line below).

> +           (s->l1_size - new_l1_size) * sizeof(uint64_t));
> +    return ret;
> +}
> +
>  int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>                          bool exact_size)
>  {
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 8c17c0e3aa..15af9a795f 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -29,6 +29,7 @@
>  #include "block/qcow2.h"
>  #include "qemu/range.h"
>  #include "qemu/bswap.h"
> +#include "qemu/cutils.h"
> =20
>  static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t siz=
e);
>  static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *b=
s,
> @@ -3061,3 +3062,122 @@ done:
>      qemu_vfree(new_refblock);
>      return ret;
>  }
> +
> +static int qcow2_discard_refcount_block(BlockDriverState *bs,
> +                                        uint64_t discard_block_offs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t refblock_offs =3D get_refblock_offset(s, discard_block_of=
fs);
> +    uint64_t cluster_index =3D discard_block_offs >> s->cluster_bits;
> +    uint32_t block_index =3D cluster_index & (s->refcount_block_size -=
 1);
> +    void *refblock;
> +    int ret;
> +
> +    assert(discard_block_offs !=3D 0);
> +
> +    ret =3D qcow2_cache_get(bs, s->refcount_block_cache, refblock_offs=
,
> +                          &refblock);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    if (s->get_refcount(refblock, block_index) !=3D 1) {
> +        qcow2_signal_corruption(bs, true, -1, -1, "Invalid refcount:"
> +                                " refblock offset %#" PRIx64
> +                                ", reftable index %u"
> +                                ", block offset %#" PRIx64
> +                                ", refcount %#" PRIx64,
> +                                refblock_offs,
> +                                offset_to_reftable_index(s, discard_bl=
ock_offs),
> +                                discard_block_offs,
> +                                s->get_refcount(refblock, block_index)=
);
> +        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
> +        return -EINVAL;
> +    }
> +    s->set_refcount(refblock, block_index, 0);
> +
> +    qcow2_cache_entry_mark_dirty(bs, s->refcount_block_cache, refblock=
);
> +
> +    qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
> +
> +    if (cluster_index < s->free_cluster_index) {
> +        s->free_cluster_index =3D cluster_index;
> +    }
> +
> +    refblock =3D qcow2_cache_is_table_offset(bs, s->refcount_block_cac=
he,
> +                                           discard_block_offs);
> +    if (refblock) {
> +        /* discard refblock from the cache if refblock is cached */
> +        qcow2_cache_discard(bs, s->refcount_block_cache, refblock);
> +    }
> +    update_refcount_discard(bs, discard_block_offs, s->cluster_size);
> +
> +    return 0;
> +}
> +
> +int qcow2_shrink_reftable(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t *reftable_tmp =3D
> +        g_malloc(s->refcount_table_size * sizeof(uint64_t));
> +    int i, ret;
> +
> +    for (i =3D 0; i < s->refcount_table_size; i++) {
> +        int64_t refblock_offs =3D s->refcount_table[i] & REFT_OFFSET_M=
ASK;
> +        void *refblock;
> +        bool unused_block;
> +
> +        if (refblock_offs =3D=3D 0) {
> +            reftable_tmp[i] =3D 0;
> +            continue;
> +        }
> +        ret =3D qcow2_cache_get(bs, s->refcount_block_cache, refblock_=
offs,
> +                              &refblock);
> +        if (ret < 0) {
> +            goto out;
> +        }
> +
> +        /* the refblock has own reference */
> +        if (i =3D=3D offset_to_reftable_index(s, refblock_offs)) {
> +            uint64_t block_index =3D (refblock_offs >> s->cluster_bits=
) &
> +                                   (s->refcount_block_size - 1);
> +            uint64_t refcount =3D s->get_refcount(refblock, block_inde=
x);
> +
> +            s->set_refcount(refblock, block_index, 0);
> +
> +            unused_block =3D buffer_is_zero(refblock, s->cluster_size)=
;
> +
> +            s->set_refcount(refblock, block_index, refcount);
> +        } else {
> +            unused_block =3D buffer_is_zero(refblock, s->cluster_size)=
;
> +        }
> +        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
> +
> +        reftable_tmp[i] =3D unused_block ? 0 : cpu_to_be64(s->refcount=
_table[i]);
> +    }
> +
> +    ret =3D bdrv_pwrite_sync(bs->file, s->refcount_table_offset, refta=
ble_tmp,
> +                           s->refcount_table_size * sizeof(uint64_t));=

> +    /*
> +     * If the write in the reftable failed the image may contain parti=
ally
> +     * overwritten the reftable. In this case would be better to clear=
 the

*"may contain a partially overwritten reftable"
*"In this case it would be better"

With these changes:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +     * reftable in memory to avoid possible image corruption.
> +     */
> +    for (i =3D 0; i < s->refcount_table_size; i++) {
> +        if (s->refcount_table[i] && !reftable_tmp[i]) {
> +            if (ret =3D=3D 0) {
> +                ret =3D qcow2_discard_refcount_block(bs, s->refcount_t=
able[i] &
> +                                                       REFT_OFFSET_MAS=
K);
> +            }
> +            s->refcount_table[i] =3D 0;
> +        }
> +    }
> +
> +    if (!s->cache_discards) {
> +        qcow2_process_discards(bs, ret);
> +    }
> +
> +out:
> +    g_free(reftable_tmp);
> +    return ret;
> +}


--chxvhgFOsPrhScLXLFTL4W9wPiGnViWAW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlm9Q00SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5NkH/2hQ/HLV9cC5vth2N8IincylkTwA7tzs
lHV5DI4dNLXLdFMkavzbIe9wUAYlZnAGyq7hwPT6rCY6ey3guxgpHfdA4DpeMkQL
FrSMs6J5VsI6f99JKXhogEP0fBLM17iqRUP0U77o6GmeMNE0+M4OVei6zDhUrEMp
4Yj2qhvqPAySbODM8U6ug9+w5to4hTMcYdGqx63pM7v2n2cQuQwfsHoD3pWz7eXB
hl8FFEz7fGv5ySnRkszXgvtCl2neATvWDfKjD1zPDhnhJhQLAsqZeZ5XjP1RA+iz
nXz/pG63/M6GV/9uy7QWkRsdlrtuwW6LRnu7XaKOPQxRjHGQyLro7PM=
=698n
-----END PGP SIGNATURE-----

--chxvhgFOsPrhScLXLFTL4W9wPiGnViWAW--
