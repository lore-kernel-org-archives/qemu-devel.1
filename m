Received: from eggs.gnu.org ([2001:4830:134:3::10]:50271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctW30-00080x-Pw
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:07:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctW2w-0003c1-NY
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctW2w-0003bG-EP
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 05:07:10 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C69280F8E
	for <qemu-devel@nongnu.org>; Thu, 30 Mar 2017 09:07:09 +0000 (UTC)
Date: Thu, 30 Mar 2017 10:07:06 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170330090705.GC2800@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-43-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-43-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 42/51] ram: Pass RAMBlock to bitmap_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> We change the meaning of start to be the offset from the beggining of
> the block.

s/beggining/beginning/

Why do this?
We have:
   migration_bitmap_sync (all blocks)
   migration_bitmap_sync_range - called per block
   cpu_physical_memory_sync_dirty_bitmap

Why keep migration_bitmap_sync_range having start/length as well as the block
if you could just rename it to migration_bitmap_sync_block and just give it the rb?
And since cpu_physical_memory_clear_dirty_range is lower level, why give it
the rb?

Dave


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
>      }
>      rcu_read_unlock();
>      qemu_mutex_unlock(&rs->bitmap_mutex);
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
