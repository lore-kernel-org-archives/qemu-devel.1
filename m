Received: from eggs.gnu.org ([2001:4830:134:3::10]:41284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGRHu-0000o1-2Y
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dGRHs-0006UF-R9
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 10:41:22 -0400
Date: Thu, 1 Jun 2017 16:41:06 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170601144106.GF4987@noname.redhat.com>
References: <20170531144331.30173-1-pbutsykin@virtuozzo.com>
	<20170531144331.30173-2-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531144331.30173-2-pbutsykin@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qcow2: add reduce image support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com

Am 31.05.2017 um 16:43 hat Pavel Butsykin geschrieben:
> This patch adds the reduction of the image file for qcow2. As a result, this
> allows us to reduce the virtual image size and free up space on the disk without
> copying the image. Image can be fragmented and reduction is done by punching
> holes in the image file.
> 
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  block/qcow2-cache.c    |  8 +++++
>  block/qcow2-cluster.c  | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  block/qcow2-refcount.c | 65 +++++++++++++++++++++++++++++++++++++++
>  block/qcow2.c          | 40 ++++++++++++++++++------
>  block/qcow2.h          |  4 +++
>  qapi/block-core.json   |  4 ++-
>  6 files changed, 193 insertions(+), 11 deletions(-)
> 
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index 1d25147392..da55118ca7 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
> @@ -411,3 +411,11 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
>      assert(c->entries[i].offset != 0);
>      c->entries[i].dirty = true;
>  }
> +
> +void qcow2_cache_entry_mark_clean(BlockDriverState *bs, Qcow2Cache *c,
> +     void *table)
> +{
> +    int i = qcow2_cache_get_table_idx(bs, c, table);
> +    assert(c->entries[i].offset != 0);
> +    c->entries[i].dirty = false;
> +}

This is an interesting function. We can use it whenever we're not
interested in the content of the table any more. However, we still keep
that data in the cache and may even evict other tables before this one.
The data in the cache also becomes inconsistent with the data in the
file, which should not be a problem in theory (because nobody should be
using it), but it surely could be confusing when debugging something in
the cache.

We can easily improve this a little: Make it qcow2_cache_discard(), a
function that gets a cluster offset, asserts that a table at this
offset isn't in use (not cached or ref == 0), and then just directly
drops it from the cache. This can be called from update_refcount()
whenever a refcount goes to 0, immediately before or after calling
update_refcount_discard() - those two are closely related. Then this
would automatically also be used for L2 tables.

Adding this mechanism could be a patch of its own.

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 347d94b0d2..47e04d7317 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -32,6 +32,89 @@
>  #include "qemu/bswap.h"
>  #include "trace.h"
>  
> +int qcow2_reduce_l1_table(BlockDriverState *bs, uint64_t max_size)

Let's call this shrink, it's easier to understand and consistent with
qcow2_reftable_shrink() that this patch adds, too.

> +{
> +    BDRVQcow2State *s = bs->opaque;
> +    int64_t new_l1_size_bytes, free_l1_clusters;
> +    uint64_t *new_l1_table;
> +    int new_l1_size, i, ret;
> +
> +    if (max_size >= s->l1_size) {
> +        return 0;
> +    }
> +
> +    new_l1_size = max_size;
> +
> +#ifdef DEBUG_ALLOC2
> +    fprintf(stderr, "reduce l1_table from %d to %" PRId64 "\n",
> +            s->l1_size, new_l1_size);
> +#endif
> +
> +    ret = qcow2_cache_flush(bs, s->l2_table_cache);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_FREE_L2_CLUSTERS);
> +    for (i = s->l1_size - 1; i > new_l1_size - 1; i--) {
> +        if ((s->l1_table[i] & L1E_OFFSET_MASK) == 0) {
> +            continue;
> +        }
> +        qcow2_free_clusters(bs, s->l1_table[i] & L1E_OFFSET_MASK,
> +                            s->l2_size * sizeof(uint64_t),
> +                            QCOW2_DISCARD_ALWAYS);
> +    }
> +
> +    new_l1_size_bytes = sizeof(uint64_t) * new_l1_size;

On 32 bit hosts, this does a 32 bit calculation and assigns it to a 64
bit value. I think this is still correct because new_l1_size_bytes is
limited by QCOW_MAX_L1_SIZE (0x2000000).

If this is the intention, maybe it would be more obvious to use a
normal int for new_l1_size_bytes, or to assert(new_l1_size <=
QCOW_MAX_L1_SIZE / sizeof(uint64_t)) before this line.

> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_WRITE_TABLE);
> +    ret = bdrv_pwrite_zeroes(bs->file, s->l1_table_offset + new_l1_size_bytes,
> +                             s->l1_size * sizeof(uint64_t) - new_l1_size_bytes,
> +                             0);

s->l1_table and the on-disk content are out of sync now. Error paths
must bring them back into sync from now on.

This is easier with the approach of qcow2_grow_l1_table(), which creates
a completely new L1 table and then atomically switches from old to new
with a header update.

> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    ret = bdrv_flush(bs->file->bs);
> +    if (ret < 0) {
> +        return ret;
> +    }

In both of these error cases, we don't know the actual state of the L1
table on disk.

> +    /* set new table size */
> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_ACTIVATE_TABLE);
> +    new_l1_size = cpu_to_be32(new_l1_size);
> +    ret = bdrv_pwrite_sync(bs->file, offsetof(QCowHeader, l1_size),
> +                           &new_l1_size, sizeof(new_l1_size));
> +    new_l1_size = be32_to_cpu(new_l1_size);
> +    if (ret < 0) {
> +        return ret;
> +    }

Maybe we can salvage the error handling if we move this first. If this
update fails, we simply have to keep using the old L1 table. If it
succeeds, we have successfully shrunk the L1 table and the contents of
the old entries doesn't strictly matter. We can zero it out just to be
nice, but correctness isn't affected by it.

> +    BLKDBG_EVENT(bs->file, BLKDBG_L1_REDUCE_FREE_L1_CLUSTERS);
> +    free_l1_clusters =
> +        DIV_ROUND_UP(s->l1_size * sizeof(uint64_t), s->cluster_size) -
> +        DIV_ROUND_UP(new_l1_size_bytes, s->cluster_size);
> +    if (free_l1_clusters) {
> +        qcow2_free_clusters(bs, s->l1_table_offset +
> +                                ROUND_UP(new_l1_size_bytes, s->cluster_size),
> +                            free_l1_clusters << s->cluster_bits,
> +                            QCOW2_DISCARD_ALWAYS);
> +    }
> +
> +    new_l1_table = qemu_try_blockalign(bs->file->bs,
> +                                       align_offset(new_l1_size_bytes, 512));
> +    if (new_l1_table == NULL) {
> +        return -ENOMEM;

Now the disk has a shortened L1 size, but our in-memory representation
still has the old size. This will cause corruption when the L1 table is
grown again.

> +    }
> +    memcpy(new_l1_table, s->l1_table, new_l1_size_bytes);
> +
> +    qemu_vfree(s->l1_table);
> +    s->l1_table = new_l1_table;
> +    s->l1_size = new_l1_size;
> +
> +    return 0;
> +}

Another thought: Is resizing the L1 table actually worth it given how
easy it is to get the error paths wrong?

With 64k clusters, you get another L1 table cluster every 4 TB. So
leaving 64k in the image file uselessly allocated for resizing an image
from 8 TB to 4 TB sounds like a waste that is totally acceptable if we
use it to get some more confidence that we won't corrupt images in error
cases.

We could just free the now unused L2 tables and overwrite their L1
entries with 0 without actually resizing the L1 table.

> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 7c06061aae..5481b623cd 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c

Skipping the review for refcount tables for now. The same argument
as for L1 tables applies, except that each cluster of the refcount table
covers 16 TB instead of 4 TB here.

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6b974b952f..dcd2d0241f 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2371,7 +2371,9 @@
>              'cluster_alloc_bytes', 'cluster_free', 'flush_to_os',
>              'flush_to_disk', 'pwritev_rmw_head', 'pwritev_rmw_after_head',
>              'pwritev_rmw_tail', 'pwritev_rmw_after_tail', 'pwritev',
> -            'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
> +            'pwritev_zero', 'pwritev_done', 'empty_image_prepare',
> +            'l1_reduce_write_table', 'l1_reduce_activate_table',
> +            'l1_reduce_free_l2_clusters', 'l1_reduce_free_l1_clusters' ] }

If you rename the function above, s/reduce/shrink/ here as well.

Kevin
