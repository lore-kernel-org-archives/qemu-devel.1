Received: from eggs.gnu.org ([2001:4830:134:3::10]:35660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVItX-0007eS-4k
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dVItT-0000Cm-2G
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 10:45:39 -0400
Date: Wed, 12 Jul 2017 16:45:19 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170712144519.GD4917@noname.str.redhat.com>
References: <20170712114700.20008-1-pbutsykin@virtuozzo.com>
	<20170712114700.20008-3-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712114700.20008-3-pbutsykin@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v5 2/4] qcow2: add qcow2_cache_discard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

Am 12.07.2017 um 13:46 hat Pavel Butsykin geschrieben:
> Whenever l2/refcount table clusters are discarded from the file we can
> automatically drop unnecessary content of the cache tables. This reduces
> the chance of eviction useful cache data and eliminates inconsistent data
> in the cache with the data in the file.
> 
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/qcow2-cache.c    | 26 ++++++++++++++++++++++++++
>  block/qcow2-refcount.c | 14 ++++++++++++++
>  block/qcow2.h          |  3 +++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index 1d25147392..75746a7f43 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
> @@ -411,3 +411,29 @@ void qcow2_cache_entry_mark_dirty(BlockDriverState *bs, Qcow2Cache *c,
>      assert(c->entries[i].offset != 0);
>      c->entries[i].dirty = true;
>  }
> +
> +void *qcow2_cache_is_table_offset(BlockDriverState *bs, Qcow2Cache *c,
> +                                  uint64_t offset)
> +{
> +    int i;
> +
> +    for (i = 0; i < c->size; i++) {
> +        if (c->entries[i].offset == offset) {
> +            return qcow2_cache_get_table_addr(bs, c, i);
> +        }
> +    }
> +    return NULL;
> +}
> +
> +void qcow2_cache_discard(BlockDriverState *bs, Qcow2Cache *c, void *table)
> +{
> +    int i = qcow2_cache_get_table_idx(bs, c, table);
> +
> +    assert(c->entries[i].ref == 0);
> +
> +    c->entries[i].offset = 0;
> +    c->entries[i].lru_counter = 0;
> +    c->entries[i].dirty = false;
> +
> +    qcow2_cache_table_release(bs, c, i, 1);
> +}
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index c9b0dcb4f3..8050db4544 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -862,6 +862,20 @@ static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *bs,
>          s->set_refcount(refcount_block, block_index, refcount);
>  
>          if (refcount == 0 && s->discard_passthrough[type]) {
> +            void *table;
> +
> +            table = qcow2_cache_is_table_offset(bs, s->refcount_block_cache,
> +                                                offset);
> +            if (table != NULL) {
> +                qcow2_cache_put(bs, s->refcount_block_cache, &refcount_block);
> +                qcow2_cache_discard(bs, s->refcount_block_cache, table);
> +            }
> +
> +            table = qcow2_cache_is_table_offset(bs, s->l2_table_cache, offset);
> +            if (table != NULL) {
> +                qcow2_cache_discard(bs, s->l2_table_cache, table);
> +            }
> +
>              update_refcount_discard(bs, cluster_offset, s->cluster_size);
>          }
>      }

This is not wrong, but wouldn't actually even refcount == 0 be enough as
a condition to evict the cluster from the cache? I don't think it really
matters whether we actually send a discard request or not for the image
file.

Kevin
