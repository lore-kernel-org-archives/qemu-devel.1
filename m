Received: from eggs.gnu.org ([2001:4830:134:3::10]:37249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNoX7-0006J6-V1
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:55:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dNoX6-0005Ii-8i
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 18:55:34 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-4-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
Date: Thu, 22 Jun 2017 00:55:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170613121639.17853-4-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aRn8wCFvSW9XjSfkvvBg4f6N5TRFieadu"
Subject: Re: [Qemu-devel] [PATCH v2 3/4] qcow2: add shrink image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aRn8wCFvSW9XjSfkvvBg4f6N5TRFieadu
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <aed64e0e-61ed-12c9-8676-ad55795b6e62@redhat.com>
Subject: Re: [PATCH v2 3/4] qcow2: add shrink image support
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
 <20170613121639.17853-4-pbutsykin@virtuozzo.com>
In-Reply-To: <20170613121639.17853-4-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 14:16, Pavel Butsykin wrote:
> This patch add shrinking of the image file for qcow2. As a result, this=
 allows
> us to reduce the virtual image size and free up space on the disk witho=
ut
> copying the image. Image can be fragmented and shrink is done by punchi=
ng holes
> in the image file.
>=20
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2-cluster.c  | 42 ++++++++++++++++++++++++++++++++
>  block/qcow2-refcount.c | 65 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c          | 40 +++++++++++++++++++++++--------
>  block/qcow2.h          |  2 ++
>  qapi/block-core.json   |  3 ++-
>  5 files changed, 141 insertions(+), 11 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index d779ea19cf..a84b7e607e 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -32,6 +32,48 @@
>  #include "qemu/bswap.h"
>  #include "trace.h"
> =20
> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size)

It's not really a max_size but always an exact size. You don't want it
to be any smaller than this.

> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int new_l1_size, i, ret;
> +
> +    if (max_size >=3D s->l1_size) {
> +        return 0;
> +    }
> +
> +    new_l1_size =3D max_size;
> +
> +#ifdef DEBUG_ALLOC2
> +    fprintf(stderr, "shrink l1_table from %d to %" PRId64 "\n",
> +            s->l1_size, new_l1_size);

new_l1_size is of type int, not int64_t.

> +#endif
> +
> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_WRITE_TABLE);
> +    ret =3D bdrv_pwrite_zeroes(bs->file, s->l1_table_offset +
> +                                       sizeof(uint64_t) * new_l1_size,=

> +                             (s->l1_size - new_l1_size) * sizeof(uint6=
4_t), 0);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret =3D bdrv_flush(bs->file->bs);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_SHRINK_FREE_L2_CLUSTERS);
> +    for (i =3D s->l1_size - 1; i > new_l1_size - 1; i--) {
> +        if ((s->l1_table[i] & L1E_OFFSET_MASK) =3D=3D 0) {
> +            continue;
> +        }
> +        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
> +                            s->l2_size * sizeof(uint64_t),

I'm more of a fan of s->cluster_size instead of s->l2_size *
sizeof(uint64_t) but it's not like it matters...

> +                            QCOW2_DISCARD_ALWAYS);
> +        s->l1_table[i] =3D 0;

I'd probably clear the overhanging s->l1_table entries before
bdrv_flush() (before you shouldn't really use them after
bdrv_pwrite_zeroes() has returned, even if bdrv_flush() has failed), but
it's not absolutely necessary. As long as they still have a refcount of
at least one, writing to them will just be useless but not destroy any da=
ta.

> +    }
> +    return 0;
> +}
> +
>  int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>                          bool exact_size)
>  {
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 576ab551d6..e98306acd8 100644
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
> @@ -2936,3 +2937,67 @@ done:
>      qemu_vfree(new_refblock);
>      return ret;
>  }
> +
> +int qcow2_shrink_reftable(BlockDriverState *bs)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    uint64_t *reftable_tmp =3D
> +        g_try_malloc(sizeof(uint64_t) * s->refcount_table_size);
> +    int i, ret;
> +
> +    if (s->refcount_table_size && reftable_tmp =3D=3D NULL) {
> +        return -ENOMEM;
> +    }
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
> +        if (i =3D=3D refblock_offs >> (s->refcount_block_bits + s->clu=
ster_bits)) {
> +            uint64_t blk_index =3D (refblock_offs >> s->cluster_bits) =
&
> +                                 (s->refcount_block_size - 1);
> +            uint64_t refcount =3D s->get_refcount(refblock, blk_index)=
;
> +
> +            s->set_refcount(refblock, blk_index, 0);
> +
> +            unused_block =3D buffer_is_zero(refblock, s->refcount_bloc=
k_size);

s/refcount_block_size/cluster_size/

> +
> +            s->set_refcount(refblock, blk_index, refcount);
> +        } else {
> +            unused_block =3D buffer_is_zero(refblock, s->refcount_bloc=
k_size);

Same here.

> +        }
> +        qcow2_cache_put(bs, s->refcount_block_cache, &refblock);
> +
> +        reftable_tmp[i] =3D unused_block ? 0 : cpu_to_be64(s->refcount=
_table[i]);
> +    }
> +
> +    ret =3D bdrv_pwrite_sync(bs->file, s->refcount_table_offset, refta=
ble_tmp,
> +                           sizeof(uint64_t) * s->refcount_table_size);=

> +    if (ret < 0) {
> +        goto out;
> +    }
> +
> +    for (i =3D 0; i < s->refcount_table_size; i++) {
> +        if (s->refcount_table[i] && !reftable_tmp[i]) {
> +            qcow2_free_clusters(bs, s->refcount_table[i] & REFT_OFFSET=
_MASK,
> +                                s->cluster_size, QCOW2_DISCARD_ALWAYS)=
;

This doesn't feel like a very good idea. The bdrv_pwrite_sync() before
has brought the on-disk refcount structures into a different state than
what we have cached.

OTOH, the bdrv_pwrite_sync() has accessed only the reftable and this
should only access refblocks. So I cannot think of any way this might
actually do something bad. But I guess it'll be better for to revisit
this when it's not in the middle of the night (so on Friday).

> +            s->refcount_table[i] =3D 0;
> +        }
> +    }
> +
> +out:
> +    g_free(reftable_tmp);
> +    return ret;
> +}
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b3ba5daa93..0ad46d2776 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2545,6 +2545,7 @@ static int qcow2_truncate(BlockDriverState *bs, i=
nt64_t offset, Error **errp)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      int64_t new_l1_size;
> +    uint64_t total_size;
>      int ret;
> =20
>      if (offset & 511) {
> @@ -2558,17 +2559,36 @@ static int qcow2_truncate(BlockDriverState *bs,=
 int64_t offset, Error **errp)
>          return -ENOTSUP;
>      }
> =20
> -    /* shrinking is currently not supported */
> -    if (offset < bs->total_sectors * 512) {
> -        error_setg(errp, "qcow2 doesn't support shrinking images yet")=
;
> -        return -ENOTSUP;
> -    }
> -
>      new_l1_size =3D size_to_l1(s, offset);
> -    ret =3D qcow2_grow_l1_table(bs, new_l1_size, true);
> -    if (ret < 0) {
> -        error_setg_errno(errp, -ret, "Failed to grow the L1 table");
> -        return ret;
> +    total_size =3D bs->total_sectors << BDRV_SECTOR_BITS;
> +
> +    if (offset < total_size) {
> +        ret =3D qcow2_cluster_discard(bs, ROUND_UP(offset, s->cluster_=
size),
> +                                    total_size - ROUND_UP(offset,
> +                                                          s->cluster_s=
ize),
> +                                    QCOW2_DISCARD_ALWAYS, true);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to discard reduced cl=
asters");

s/clasters/clusters/

And maybe "truncated", "stripped", or "cropped" instead of "reduced"?

> +            return ret;
> +        }
> +
> +        ret =3D qcow2_shrink_l1_table(bs, new_l1_size);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to reduce the L1 tabl=
e");

s/reduce/shrink/ (or "truncate"; or "reduce the L1 table size")

Also, to be fair, you're actually reducing the number of L2 tables, not
the size of the L1 table. (But that's a nit pick)

> +            return ret;
> +        }
> +
> +        ret =3D qcow2_shrink_reftable(bs);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to shrink the refcoun=
t table");

And this is not really shrinking the reftable but instead discarding
some refblocks (potentially). (This is a nit pick, too)

Max

> +            return ret;
> +        }
> +    } else {
> +        ret =3D qcow2_grow_l1_table(bs, new_l1_size, true);
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret, "Failed to grow the L1 table"=
);
> +            return ret;
> +        }
>      }
> =20
>      /* write updated header.size */
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 07faa6dc78..600463bf8e 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -531,10 +531,12 @@ int qcow2_pre_write_overlap_check(BlockDriverStat=
e *bs, int ign, int64_t offset,
>  int qcow2_change_refcount_order(BlockDriverState *bs, int refcount_ord=
er,
>                                  BlockDriverAmendStatusCB *status_cb,
>                                  void *cb_opaque, Error **errp);
> +int qcow2_shrink_reftable(BlockDriverState *bs);
> =20
>  /* qcow2-cluster.c functions */
>  int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t min_size,
>                          bool exact_size);
> +int qcow2_shrink_l1_table(BlockDriverState *bs, uint64_t max_size);
>  int qcow2_write_l1_entry(BlockDriverState *bs, int l1_index);
>  int qcow2_decompress_cluster(BlockDriverState *bs, uint64_t cluster_of=
fset);
>  int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f85c2235c7..bcbffa3339 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2372,7 +2372,8 @@
>              'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>              'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_he=
ad',
>              'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
> +            'l1_shrink_write_table', 'l1_shrink_free_l2_clusters' ] }
> =20
>  ##
>  # @BlkdebugInjectErrorOptions:
>=20



--aRn8wCFvSW9XjSfkvvBg4f6N5TRFieadu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZSvlXEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMqK
B/9QXXpx9gjq7siAdLpQtb/cWC9RhCsQS1srFi0rcqVKoqPn2fAlQgk0lBwQpvGw
0pNXI7+aHMoL6gAjSq18fREC3NeykI19nrsvLkzbZubXRnhHgNpNGDgSzeQQD/jh
3gilPvNAdMEUYMFItdf2hveu6LZW9hbqp+MWYMf34Cy3LnCqvKsKLfaTrpAFRON0
SAuWpCffNtt+ElXFCfqOJvHvzKOiwHei83J/7kWhIBVefwr6o42dfwUWrh4YhJhu
dQc8+jIt7hk7COTj2picI0bK0fceG3QTekt8ixmzQNdI9q7I15if+/2TujAZOTMo
RmG+JsgisPiJwa0kgPV8BVcg
=5a/k
-----END PGP SIGNATURE-----

--aRn8wCFvSW9XjSfkvvBg4f6N5TRFieadu--
