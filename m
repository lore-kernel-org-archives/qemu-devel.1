Received: from eggs.gnu.org ([2001:4830:134:3::10]:48158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1crDl5-0008Os-4d
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1crDl1-0005a6-Vx
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:11:15 -0400
Received: from [45.249.212.188] (port=2967 helo=dggrg02-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <yanghongyang@huawei.com>) id 1crDl1-0005Vm-7E
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:11:11 -0400
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-43-quintela@redhat.com>
From: Yang Hongyang <yanghongyang@huawei.com>
Message-ID: <8b10b0bc-909e-d6e8-da76-72b20fbf7e32@huawei.com>
Date: Fri, 24 Mar 2017 09:10:50 +0800
MIME-Version: 1.0
In-Reply-To: <20170323204544.12015-43-quintela@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 42/51] ram: Pass RAMBlock to bitmap_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com


On 2017/3/24 4:45, Juan Quintela wrote:
> We change the meaning of start to be the offset from the beggining of
> the block.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/exec/ram_addr.h | 2 ++
>  migration/ram.c         | 8 ++++----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index b05dc84..d50c970 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -354,11 +354,13 @@ static inline void cpu_physical_memory_clear_dirty_range(ram_addr_t start,
>  
>  static inline
>  uint64_t cpu_physical_memory_sync_dirty_bitmap(unsigned long *dest,
> +                                               RAMBlock *rb,
>                                                 ram_addr_t start,
>                                                 ram_addr_t length,
>                                                 int64_t *real_dirty_pages)
>  {
>      ram_addr_t addr;
> +    start = rb->offset + start;
>      unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>      uint64_t num_dirty = 0;
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 064b2c0..9772fd8 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -648,13 +648,13 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
>      return ret;
>  }
>  
> -static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
> -                                        ram_addr_t length)
> +static void migration_bitmap_sync_range(RAMState *rs, RAMBlock *rb,
> +                                        ram_addr_t start, ram_addr_t length)
>  {
>      unsigned long *bitmap;
>      bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
>      rs->migration_dirty_pages +=
> -        cpu_physical_memory_sync_dirty_bitmap(bitmap, start, length,
> +        cpu_physical_memory_sync_dirty_bitmap(bitmap, rb, start, length,
>                                                &rs->num_dirty_pages_period);
>  }
>  
> @@ -701,7 +701,7 @@ static void migration_bitmap_sync(RAMState *rs)
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> -        migration_bitmap_sync_range(rs, block->offset, block->used_length);
> +        migration_bitmap_sync_range(rs, block, 0, block->used_length);

Since RAMBlock been passed to bitmap_sync, could we remove
param 'block->used_length' either?

>      }
>      rcu_read_unlock();
>      qemu_mutex_unlock(&rs->bitmap_mutex);
> 

-- 
Thanks,
Yang
