Received: from eggs.gnu.org ([2001:4830:134:3::10]:34203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8niv-0006kP-07
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1d8nir-0004JJ-Ug
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:01:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1d8nir-0004Io-Nk
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:01:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8538B3D965
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 13:01:36 +0000 (UTC)
Date: Thu, 11 May 2017 14:01:30 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170511130129.GF2078@work-vm>
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
	<1494505358-15287-2-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1494505358-15287-2-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 1/4] ramblock: add RAMBLOCK_FOREACH()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

* Peter Xu (peterx@redhat.com) wrote:
> So that it can simplifies the iterators.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  exec.c                 | 22 +++++++++++-----------
>  include/exec/ramlist.h |  5 +++++
>  migration/ram.c        | 13 +++++++------
>  3 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index eac6085..50519ae 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -978,7 +978,7 @@ static RAMBlock *qemu_get_ram_block(ram_addr_t addr)
>      if (block && addr - block->offset < block->max_length) {
>          return block;
>      }
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          if (addr - block->offset < block->max_length) {
>              goto found;
>          }
> @@ -1578,12 +1578,12 @@ static ram_addr_t find_ram_offset(ram_addr_t size)
>          return 0;
>      }
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          ram_addr_t end, next = RAM_ADDR_MAX;
>  
>          end = block->offset + block->max_length;
>  
> -        QLIST_FOREACH_RCU(next_block, &ram_list.blocks, next) {
> +        RAMBLOCK_FOREACH(next_block) {
>              if (next_block->offset >= end) {
>                  next = MIN(next, next_block->offset);
>              }
> @@ -1609,7 +1609,7 @@ unsigned long last_ram_page(void)
>      ram_addr_t last = 0;
>  
>      rcu_read_lock();
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          last = MAX(last, block->offset + block->max_length);
>      }
>      rcu_read_unlock();
> @@ -1659,7 +1659,7 @@ void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceState *dev)
>      pstrcat(new_block->idstr, sizeof(new_block->idstr), name);
>  
>      rcu_read_lock();
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          if (block != new_block &&
>              !strcmp(block->idstr, new_block->idstr)) {
>              fprintf(stderr, "RAMBlock \"%s\" already registered, abort!\n",
> @@ -1693,7 +1693,7 @@ size_t qemu_ram_pagesize_largest(void)
>      RAMBlock *block;
>      size_t largest = 0;
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          largest = MAX(largest, qemu_ram_pagesize(block));
>      }
>  
> @@ -1839,7 +1839,7 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>       * QLIST (which has an RCU-friendly variant) does not have insertion at
>       * tail, so save the last element in last_block.
>       */
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          last_block = block;
>          if (block->max_length < new_block->max_length) {
>              break;
> @@ -2021,7 +2021,7 @@ void qemu_ram_remap(ram_addr_t addr, ram_addr_t length)
>      int flags;
>      void *area, *vaddr;
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          offset = addr - block->offset;
>          if (offset < block->max_length) {
>              vaddr = ramblock_ptr(block, offset);
> @@ -2167,7 +2167,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>          goto found;
>      }
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          /* This case append when the block is not mapped. */
>          if (block->host == NULL) {
>              continue;
> @@ -2200,7 +2200,7 @@ RAMBlock *qemu_ram_block_by_name(const char *name)
>  {
>      RAMBlock *block;
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          if (!strcmp(name, block->idstr)) {
>              return block;
>          }
> @@ -3424,7 +3424,7 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque)
>      int ret = 0;
>  
>      rcu_read_lock();
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          ret = func(block->idstr, block->host, block->offset,
>                     block->used_length, opaque);
>          if (ret) {
> diff --git a/include/exec/ramlist.h b/include/exec/ramlist.h
> index c59880d..f1c6b45 100644
> --- a/include/exec/ramlist.h
> +++ b/include/exec/ramlist.h
> @@ -4,6 +4,7 @@
>  #include "qemu/queue.h"
>  #include "qemu/thread.h"
>  #include "qemu/rcu.h"
> +#include "qemu/rcu_queue.h"
>  
>  typedef struct RAMBlockNotifier RAMBlockNotifier;
>  
> @@ -54,6 +55,10 @@ typedef struct RAMList {
>  } RAMList;
>  extern RAMList ram_list;
>  
> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define  RAMBLOCK_FOREACH(block)  \
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next)
> +
>  void qemu_mutex_lock_ramlist(void);
>  void qemu_mutex_unlock_ramlist(void);
>  
> diff --git a/migration/ram.c b/migration/ram.c
> index 293d27c..d88afea 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -648,7 +648,7 @@ uint64_t ram_pagesize_summary(void)
>      RAMBlock *block;
>      uint64_t summary = 0;
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          summary |= block->page_size;
>      }
>  
> @@ -676,7 +676,7 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          migration_bitmap_sync_range(rs, block, 0, block->used_length);
>      }
>      rcu_read_unlock();
> @@ -1408,8 +1408,9 @@ uint64_t ram_bytes_total(void)
>      uint64_t total = 0;
>  
>      rcu_read_lock();
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next)
> +    RAMBLOCK_FOREACH(block) {
>          total += block->used_length;
> +    }
>      rcu_read_unlock();
>      return total;
>  }
> @@ -1500,7 +1501,7 @@ void ram_postcopy_migrated_memory_release(MigrationState *ms)
>  {
>      struct RAMBlock *block;
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          unsigned long *bitmap = block->bmap;
>          unsigned long range = block->used_length >> TARGET_PAGE_BITS;
>          unsigned long run_start = find_next_zero_bit(bitmap, range, 0);
> @@ -1578,7 +1579,7 @@ static int postcopy_each_ram_send_discard(MigrationState *ms)
>      struct RAMBlock *block;
>      int ret;
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          PostcopyDiscardState *pds =
>              postcopy_discard_send_init(ms, block->idstr);
>  
> @@ -1961,7 +1962,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>  
>      qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
>  
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH(block) {
>          qemu_put_byte(f, strlen(block->idstr));
>          qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
>          qemu_put_be64(f, block->used_length);
> -- 
> 2.7.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
