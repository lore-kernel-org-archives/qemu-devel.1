Received: from eggs.gnu.org ([2001:4830:134:3::10]:34582)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwsVl-0005pJ-1M
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fwsVh-0007ZH-T2
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:19:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37984 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fwsVh-0007Yv-MM
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 13:19:33 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180903092644.25812-3-xiaoguangrong@tencent.com> (guangrong
	xiao's message of "Mon, 3 Sep 2018 17:26:42 +0800")
References: <20180903092644.25812-1-xiaoguangrong@tencent.com>
	<20180903092644.25812-3-xiaoguangrong@tencent.com>
Reply-To: quintela@redhat.com
Date: Mon, 03 Sep 2018 19:19:25 +0200
Message-ID: <87a7oy33du.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 2/4] migration: fix calculating
 xbzrle_counters.cache_miss_rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>
> As Peter pointed out:
> | - xbzrle_counters.cache_miss is done in save_xbzrle_page(), so it's
> |   per-guest-page granularity
> |
> | - RAMState.iterations is done for each ram_find_and_save_block(), so
> |   it's per-host-page granularity
> |
> | An example is that when we migrate a 2M huge page in the guest, we
> | will only increase the RAMState.iterations by 1 (since
> | ram_find_and_save_block() will be called once), but we might increase
> | xbzrle_counters.cache_miss for 2M/4K=512 times (we'll call
> | save_xbzrle_page() that many times) if all the pages got cache miss.
> | Then IMHO the cache miss rate will be 512/1=51200% (while it should
> | actually be just 100% cache miss).
>
> And he also suggested as xbzrle_counters.cache_miss_rate is the only
> user of rs->iterations we can adapt it to count target guest page
> numbers
>
> After that, rename 'iterations' to 'target_page_count' to better reflect
> its meaning
>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Because I don't mind the name change.  But the example is wrong, this is
not about huge pages, it is about architectures with different page size
(arm is king here, second place for ppc as far as I know).  You can have
a guest with 4kb pages on a host with 64kb pages.  Then we do "magic"
and when we synchronize the dirty bitmap, we update it on guest page
sizes.

>From cpu_physical_memory_set_dirty_lebitmap()

    unsigned long hpratio = getpagesize() / TARGET_PAGE_SIZE;

    [...]
        /*
         * bitmap-traveling is faster than memory-traveling (for addr...)
         * especially when most of the memory is not dirty.
         */
        for (i = 0; i < len; i++) {
            if (bitmap[i] != 0) {
                c = leul_to_cpu(bitmap[i]);
                do {
                    j = ctzl(c);
                    c &= ~(1ul << j);
                    page_number = (i * HOST_LONG_BITS + j) * hpratio;
                    addr = page_number * TARGET_PAGE_SIZE;
                    ram_addr = start + addr;
                    cpu_physical_memory_set_dirty_range(ram_addr,
                                       TARGET_PAGE_SIZE * hpratio, clients);
                } while (c != 0);
            }
        }

This is where the hpratio is used, as you can see, if getpagesize() is
smaller than TARGET_PAGE_SIZE, things start to get really rually funny.

Later, Juan.

> ---
>  migration/ram.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 2ad07b5e15..25af797c0a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -301,10 +301,10 @@ struct RAMState {
>      uint64_t num_dirty_pages_period;
>      /* xbzrle misses since the beginning of the period */
>      uint64_t xbzrle_cache_miss_prev;
> -    /* number of iterations at the beginning of period */
> -    uint64_t iterations_prev;
> -    /* Iterations since start */
> -    uint64_t iterations;
> +    /* total handled target pages at the beginning of period */
> +    uint64_t target_page_count_prev;
> +    /* total handled target pages since start */
> +    uint64_t target_page_count;
>      /* number of dirty bits in the bitmap */
>      uint64_t migration_dirty_pages;
>      /* last dirty_sync_count we have seen */
> @@ -1594,19 +1594,19 @@ uint64_t ram_pagesize_summary(void)
>  
>  static void migration_update_rates(RAMState *rs, int64_t end_time)
>  {
> -    uint64_t iter_count = rs->iterations - rs->iterations_prev;
> +    uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
>  
>      /* calculate period counters */
>      ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
>                  / (end_time - rs->time_last_bitmap_sync);
>  
> -    if (!iter_count) {
> +    if (!page_count) {
>          return;
>      }
>  
>      if (migrate_use_xbzrle()) {
>          xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
> -            rs->xbzrle_cache_miss_prev) / iter_count;
> +            rs->xbzrle_cache_miss_prev) / page_count;
>          rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
>      }
>  }
> @@ -1664,7 +1664,7 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>          migration_update_rates(rs, end_time);
>  
> -        rs->iterations_prev = rs->iterations;
> +        rs->target_page_count_prev = rs->target_page_count;
>  
>          /* reset period counters */
>          rs->time_last_bitmap_sync = end_time;
> @@ -3209,7 +3209,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>              done = 1;
>              break;
>          }
> -        rs->iterations++;
> +        rs->target_page_count += pages;
>  
>          /* we want to check in the 1st loop, just in case it was the 1st time
>             and we had to sync the dirty bitmap.
