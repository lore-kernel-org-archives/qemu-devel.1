Received: from eggs.gnu.org ([2001:4830:134:3::10]:51706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ7QY-0003zQ-Ir
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dQ7QU-0005Va-JX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:30:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58244)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dQ7QU-0005VH-AO
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 03:30:14 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170628024358.29956-1-haozhong.zhang@intel.com> (Haozhong
	Zhang's message of "Wed, 28 Jun 2017 10:43:58 +0800")
References: <20170628024358.29956-1-haozhong.zhang@intel.com>
Reply-To: quintela@redhat.com
Date: Wed, 28 Jun 2017 09:30:01 +0200
Message-ID: <87zics7eo6.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] exec: fix access to ram_list.dirty_memory
 when sync dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Xiao Guangrong <xiaoguangrong@tencent.com>

Haozhong Zhang <haozhong.zhang@intel.com> wrote:
> In cpu_physical_memory_sync_dirty_bitmap(rb, start, ...), the 2nd
> argument 'start' is relative to the start of the ramblock 'rb'. When
> it's used to access the dirty memory bitmap of ram_list (i.e.
> ram_list.dirty_memory[DIRTY_MEMORY_MIGRATION]->blocks[]), an offset to
> the start of all RAM (i.e. rb->offset) should be added to it, which has
> however been missed since c/s 6b6712efcc. For a ramblock of host memory
> backend whose offset is not zero, cpu_physical_memory_sync_dirty_bitmap()
> synchronizes the incorrect part of the dirty memory bitmap of ram_list
> to the per ramblock dirty bitmap. As a result, a guest with host
> memory backend may crash after migration.
>
> Fix it by adding the offset of ramblock when accessing the dirty memory
> bitmap of ram_list in cpu_physical_memory_sync_dirty_bitmap().
>
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

As this function is only used on migration, should I integrate it on my
next push, or do you want to pull it, Paolo?

Later, Juan.


> ---
>  include/exec/ram_addr.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index 73d1bea8b6..cbc797ed05 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -377,6 +377,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>                                                 uint64_t *real_dirty_pages)
>  {
>      ram_addr_t addr;
> +    ram_addr_t offset = rb->offset;
>      unsigned long page = BIT_WORD(start >> TARGET_PAGE_BITS);
>      uint64_t num_dirty = 0;
>      unsigned long *dest = rb->bmap;
> @@ -386,8 +387,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>          int k;
>          int nr = BITS_TO_LONGS(length >> TARGET_PAGE_BITS);
>          unsigned long * const *src;
> -        unsigned long idx = (page * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
> -        unsigned long offset = BIT_WORD((page * BITS_PER_LONG) %
> +        unsigned long word = BIT_WORD((start + offset) >> TARGET_PAGE_BITS);
> +        unsigned long idx = (word * BITS_PER_LONG) / DIRTY_MEMORY_BLOCK_SIZE;
> +        unsigned long offset = BIT_WORD((word * BITS_PER_LONG) %
>                                          DIRTY_MEMORY_BLOCK_SIZE);
>  
>          rcu_read_lock();
> @@ -416,7 +418,7 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>      } else {
>          for (addr = 0; addr < length; addr += TARGET_PAGE_SIZE) {
>              if (cpu_physical_memory_test_and_clear_dirty(
> -                        start + addr,
> +                        start + addr + offset,
>                          TARGET_PAGE_SIZE,
>                          DIRTY_MEMORY_MIGRATION)) {
>                  *real_dirty_pages += 1;
