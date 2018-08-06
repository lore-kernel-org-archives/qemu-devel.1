Received: from eggs.gnu.org ([2001:4830:134:3::10]:44730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fmh4x-00084c-LE
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fmh4w-0005Tf-Hg
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 11:05:51 -0400
Date: Mon, 6 Aug 2018 17:05:41 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180806150541.GE4631@localhost.localdomain>
References: <20180806141322.14427-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806141322.14427-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Release dirty entries with
 cache-clean-interval
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 06.08.2018 um 16:13 hat Alberto Garcia geschrieben:
> The cache-clean-interval option is used to periodically release unused
> entries from the L2 and refcount caches. Dirty cache entries are left
> untouched, even if they are otherwise valid candidates for removal.
> 
> This patch allows releasing those entries by flushing them to disk
> first.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-cache.c | 21 +++++++++++++++------
>  block/qcow2.c       |  4 ++--
>  block/qcow2.h       |  2 +-
>  3 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/block/qcow2-cache.c b/block/qcow2-cache.c
> index d9dafa31e5..0812164e46 100644
> --- a/block/qcow2-cache.c
> +++ b/block/qcow2-cache.c
> @@ -46,6 +46,8 @@ struct Qcow2Cache {
>      uint64_t                cache_clean_lru_counter;
>  };
>  
> +static int qcow2_cache_entry_flush(BlockDriverState *bs, Qcow2Cache *c, int i);
> +
>  static inline void *qcow2_cache_get_table_addr(Qcow2Cache *c, int table)
>  {
>      return (uint8_t *) c->table_array + (size_t) table * c->table_size;
> @@ -86,26 +88,33 @@ static void qcow2_cache_table_release(Qcow2Cache *c, int i, int num_tables)
>  #endif
>  }
>  
> -static inline bool can_clean_entry(Qcow2Cache *c, int i)
> +static inline bool can_clean_entry(BlockDriverState *bs, Qcow2Cache *c, int i)
>  {
>      Qcow2CachedTable *t = &c->entries[i];
> -    return t->ref == 0 && !t->dirty && t->offset != 0 &&
> -        t->lru_counter <= c->cache_clean_lru_counter;
> +    if (t->ref || !t->offset || t->lru_counter > c->cache_clean_lru_counter) {
> +        return false;
> +    }
> +
> +    if (qcow2_cache_entry_flush(bs, c, i) < 0) {
> +        return false;
> +    }

We're not in coroutine context here, so qcow2_cache_entry_flush() will
be blocking. I don't think that's acceptable in a timer callback.

On the other hand, if we made it non-blocking by moving it into a
coroutine that could yield, we would have to consider races with other
parts of the code and at least take s->lock and implement
.bdrv_co_drain_begin/end callbacks.

Kevin
