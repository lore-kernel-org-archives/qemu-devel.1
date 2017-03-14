Received: from eggs.gnu.org ([2001:4830:134:3::10]:41810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1cnbT5-0004K1-Mx
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1cnbT2-0001WR-Im
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:41:43 -0400
Received: from [59.151.112.132] (port=11636 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1cnbT1-0001VX-PQ
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 21:41:40 -0400
References: <20170314012646.30560-1-fanc.fnst@cn.fujitsu.com>
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <d6638a87-2513-29c5-95ef-dfca00b6167d@cn.fujitsu.com>
Date: Tue, 14 Mar 2017 09:41:30 +0800
MIME-Version: 1.0
In-Reply-To: <20170314012646.30560-1-fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Change the method to calculate
 dirty-pages-rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, pbonzini@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com



On 03/14/2017 09:26 AM, Chao Fan wrote:
> In function cpu_physical_memory_sync_dirty_bitmap, file
> include/exec/ram_addr.h:
>
> if (src[idx][offset]) {
>     unsigned long bits = atomic_xchg(&src[idx][offset], 0);
>     unsigned long new_dirty;
>     new_dirty = ~dest[k];
>     dest[k] |= bits;
>     new_dirty &= bits;
>     num_dirty += ctpopl(new_dirty);
> }
>
> After these codes executed, only the pages not dirtied in bitmap(dest),
> but dirtied in dirty_memory[DIRTY_MEMORY_MIGRATION] will be calculated.
> For example:
> When ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION] = 0b00001111,
> and atomic_rcu_read(&migration_bitmap_rcu)->bmap = 0b00000011,
> the new_dirty will be 0b00001100, and this function will return 2 but not
> 4 which is expected.
> the dirty pages in dirty_memory[DIRTY_MEMORY_MIGRATION] are all new,
> so these should be calculated also.
>
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  include/exec/ram_addr.h | 5 ++++-
>  migration/ram.c         | 7 +++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index cd432e7..b05dc84 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -355,7 +355,8 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
>  static inline
>  uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
>                                                 ram_addr_t start,
> -                                               ram_addr_t length)
> +                                               ram_addr_t length,
> +                                               int64_t *real_dirty_pages)
>  {
>      ram_addr_t addr;
>      unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
> @@ -379,6 +380,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
>              if (src[idx][offset]) {
>                  unsigned long bits = atomic_xchg(&src[idx][offset], 0);
>                  unsigned long new_dirty;
> +                *real_dirty_pages += ctpopl(bits);
>                  new_dirty = ~dest[k];
>                  dest[k] |= bits;
>                  new_dirty &= bits;
> @@ -398,6 +400,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
>                          start + addr,
>                          TARGET_PAGE_SIZE,
>                          DIRTY_MEMORY_MIGRATION)) {
> +                *real_dirty_pages += 1;
>                  long k = (start + addr) >> TARGET_PAGE_BITS;
>                  if (!test_and_set_bit(k, dest)) {
>                      num_dirty++;
> diff --git a/migration/ram.c b/migration/ram.c
> index 719425b..fdf9a85 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -576,18 +576,18 @@ static inline bool migration_bitmap_clear_dirty(ram_addr_t addr)
>      return ret;
>  }
>
> +static int64_t num_dirty_pages_period;
>  static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
>  {
>      unsigned long *bitmap;
>      bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> -    migration_dirty_pages +=
> -        cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length);
> +    migration_dirty_pages += cpu_physical_memory_sync_dirty_bitmap(bitmap,
> +                             start, length, &num_dirty_pages_period);
>  }
>
>  /* Fix me: there are too many global variables used in migration process. */
>  static int64_t start_time;
>  static int64_t bytes_xfer_prev;
> -static int64_t num_dirty_pages_period;
>  static uint64_t xbzrle_cache_miss_prev;
>  static uint64_t iterations_prev;
>
> @@ -648,7 +648,6 @@ static void migration_bitmap_sync(void)
>
>      trace_migration_bitmap_sync_end(migration_dirty_pages
>                                      - num_dirty_pages_init);
> -    num_dirty_pages_period += migration_dirty_pages - num_dirty_pages_init;

it seems num_dirty_pages_init should be removed also and update trace_migration_bitmap_sync_end()'s parameter.


Thanks
Zhijian

>      end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>
>      /* more than 1 second = 1000 millisecons */
>
