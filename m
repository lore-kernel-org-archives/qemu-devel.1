Received: from eggs.gnu.org ([2001:4830:134:3::10]:54373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctvZj-0005ly-Ap
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:22:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctvZe-0008K0-Ci
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:22:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctvZe-0008JU-38
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:22:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F3C0E7F0A3
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 12:22:36 +0000 (UTC)
Date: Fri, 31 Mar 2017 13:22:33 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331122232.GE4514@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-46-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-46-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 45/51] ram: Use page number instead of an
 address for the bitmap operations
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
> We use an unsigned long for the page number.  Notice that our bitmaps
> already got that for the index, so we have that limit.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 76 ++++++++++++++++++++++++++-------------------------------
>  1 file changed, 34 insertions(+), 42 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 6cd77b5..b1a031e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -611,13 +611,12 @@ static int save_xbzrle_page(RAMState *rs, uint8_t **current_data,
>   * @rs: current RAM state
>   * @rb: RAMBlock where to search for dirty pages
>   * @start: starting address (typically so we can continue from previous page)
> - * @ram_addr_abs: pointer into which to store the address of the dirty page
> - *                within the global ram_addr space
> + * @page: pointer into where to store the dirty page

I'd prefer if you could call it 'page_abs' - it often gets tricky to know
whether we're talking about a page offset within a RAMBlock or an offset within
the whole bitmap.
(I wish we had different index types)

>   */
>  static inline
>  ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>                                         ram_addr_t start,
> -                                       ram_addr_t *ram_addr_abs)
> +                                       unsigned long *page)
>  {
>      unsigned long base = rb->offset >> TARGET_PAGE_BITS;
>      unsigned long nr = base + (start >> TARGET_PAGE_BITS);
> @@ -634,17 +633,17 @@ ram_addr_t migration_bitmap_find_dirty(RAMState *rs, RAMBlock *rb,
>          next = find_next_bit(bitmap, size, nr);
>      }
>  
> -    *ram_addr_abs = next << TARGET_PAGE_BITS;
> +    *page = next;
>      return (next - base) << TARGET_PAGE_BITS;
>  }
>  
> -static inline bool migration_bitmap_clear_dirty(RAMState *rs, ram_addr_t addr)
> +static inline bool migration_bitmap_clear_dirty(RAMState *rs,
> +                                                unsigned long page)
>  {
>      bool ret;
> -    int nr = addr >> TARGET_PAGE_BITS;
>      unsigned long *bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
>  
> -    ret = test_and_clear_bit(nr, bitmap);
> +    ret = test_and_clear_bit(page, bitmap);
>  
>      if (ret) {
>          rs->migration_dirty_pages--;
> @@ -1056,14 +1055,13 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>   * @rs: current RAM state
>   * @pss: data about the state of the current dirty page scan
>   * @again: set to false if the search has scanned the whole of RAM
> - * @ram_addr_abs: pointer into which to store the address of the dirty page
> - *                within the global ram_addr space
> + * @page: pointer into where to store the dirty page
>   */
>  static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
> -                             bool *again, ram_addr_t *ram_addr_abs)
> +                             bool *again, unsigned long *page)
>  {
>      pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
> -                                              ram_addr_abs);
> +                                              page);
>      if (pss->complete_round && pss->block == rs->last_seen_block &&
>          pss->offset >= rs->last_offset) {
>          /*
> @@ -1111,11 +1109,10 @@ static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
>   *
>   * @rs: current RAM state
>   * @offset: used to return the offset within the RAMBlock
> - * @ram_addr_abs: pointer into which to store the address of the dirty page
> - *                within the global ram_addr space
> + * @page: pointer into where to store the dirty page
>   */
>  static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
> -                              ram_addr_t *ram_addr_abs)
> +                              unsigned long *page)
>  {
>      RAMBlock *block = NULL;
>  
> @@ -1125,8 +1122,7 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
>                                  QSIMPLEQ_FIRST(&rs->src_page_requests);
>          block = entry->rb;
>          *offset = entry->offset;
> -        *ram_addr_abs = (entry->offset + entry->rb->offset) &
> -                        TARGET_PAGE_MASK;
> +        *page = (entry->offset + entry->rb->offset) >> TARGET_PAGE_BITS;
>  
>          if (entry->len > TARGET_PAGE_SIZE) {
>              entry->len -= TARGET_PAGE_SIZE;
> @@ -1151,18 +1147,17 @@ static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
>   *
>   * @rs: current RAM state
>   * @pss: data about the state of the current dirty page scan
> - * @ram_addr_abs: pointer into which to store the address of the dirty page
> - *                within the global ram_addr space
> + * @page: pointer into where to store the dirty page
>   */
>  static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
> -                            ram_addr_t *ram_addr_abs)
> +                            unsigned long *page)
>  {
>      RAMBlock  *block;
>      ram_addr_t offset;
>      bool dirty;
>  
>      do {
> -        block = unqueue_page(rs, &offset, ram_addr_abs);
> +        block = unqueue_page(rs, &offset, page);
>          /*
>           * We're sending this page, and since it's postcopy nothing else
>           * will dirty it, and we must make sure it doesn't get sent again
> @@ -1172,17 +1167,15 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
>          if (block) {
>              unsigned long *bitmap;
>              bitmap = atomic_rcu_read(&rs->ram_bitmap)->bmap;
> -            dirty = test_bit(*ram_addr_abs >> TARGET_PAGE_BITS, bitmap);
> +            dirty = test_bit(*page, bitmap);
>              if (!dirty) {
> -                trace_get_queued_page_not_dirty(
> -                    block->idstr, (uint64_t)offset,
> -                    (uint64_t)*ram_addr_abs,
> -                    test_bit(*ram_addr_abs >> TARGET_PAGE_BITS,
> -                         atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
> +                trace_get_queued_page_not_dirty(block->idstr, (uint64_t)offset,
> +                    *page,
> +                    test_bit(*page,
> +                             atomic_rcu_read(&rs->ram_bitmap)->unsentmap));
>              } else {
> -                trace_get_queued_page(block->idstr,
> -                                      (uint64_t)offset,
> -                                      (uint64_t)*ram_addr_abs);
> +                trace_get_queued_page(block->idstr, (uint64_t)offset,
> +                                     *page);

I think you need to fix the trace_ definitions for get_queued_page
and get_queued_page_not_dirty they're currently taking uint64_t's for
ram_addr and they now need to be long's (with the format changes).


Dave

>              }
>          }
>  
> @@ -1308,15 +1301,15 @@ err:
>   * @ms: current migration state
>   * @pss: data about the page we want to send
>   * @last_stage: if we are at the completion stage
> - * @dirty_ram_abs: address of the start of the dirty page in ram_addr_t space
> + * @page: page number of the dirty page
>   */
>  static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
> -                                bool last_stage, ram_addr_t dirty_ram_abs)
> +                                bool last_stage, unsigned long page)
>  {
>      int res = 0;
>  
>      /* Check the pages is dirty and if it is send it */
> -    if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
> +    if (migration_bitmap_clear_dirty(rs, page)) {
>          unsigned long *unsentmap;
>          if (!rs->preffer_xbzrle && migrate_use_compression()) {
>              res = ram_save_compressed_page(rs, pss, last_stage);
> @@ -1329,7 +1322,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          }
>          unsentmap = atomic_rcu_read(&rs->ram_bitmap)->unsentmap;
>          if (unsentmap) {
> -            clear_bit(dirty_ram_abs >> TARGET_PAGE_BITS, unsentmap);
> +            clear_bit(page, unsentmap);
>          }
>      }
>  
> @@ -1351,24 +1344,24 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>   * @ms: current migration state
>   * @pss: data about the page we want to send
>   * @last_stage: if we are at the completion stage
> - * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
> + * @page: Page number of the dirty page
>   */
>  static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
>                                bool last_stage,
> -                              ram_addr_t dirty_ram_abs)
> +                              unsigned long page)
>  {
>      int tmppages, pages = 0;
>      size_t pagesize = qemu_ram_pagesize(pss->block);
>  
>      do {
> -        tmppages = ram_save_target_page(rs, pss, last_stage, dirty_ram_abs);
> +        tmppages = ram_save_target_page(rs, pss, last_stage, page);
>          if (tmppages < 0) {
>              return tmppages;
>          }
>  
>          pages += tmppages;
>          pss->offset += TARGET_PAGE_SIZE;
> -        dirty_ram_abs += TARGET_PAGE_SIZE;
> +        page++;
>      } while (pss->offset & (pagesize - 1));
>  
>      /* The offset we leave with is the last one we looked at */
> @@ -1395,8 +1388,7 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>      PageSearchStatus pss;
>      int pages = 0;
>      bool again, found;
> -    ram_addr_t dirty_ram_abs; /* Address of the start of the dirty page in
> -                                 ram_addr_t space */
> +    unsigned long page; /* Page number of the dirty page */
>  
>      /* No dirty page as there is zero RAM */
>      if (!ram_bytes_total()) {
> @@ -1413,15 +1405,15 @@ static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>  
>      do {
>          again = true;
> -        found = get_queued_page(rs, &pss, &dirty_ram_abs);
> +        found = get_queued_page(rs, &pss, &page);
>  
>          if (!found) {
>              /* priority queue empty, so just search for something dirty */
> -            found = find_dirty_block(rs, &pss, &again, &dirty_ram_abs);
> +            found = find_dirty_block(rs, &pss, &again, &page);
>          }
>  
>          if (found) {
> -            pages = ram_save_host_page(rs, &pss, last_stage, dirty_ram_abs);
> +            pages = ram_save_host_page(rs, &pss, last_stage, page);
>          }
>      } while (!pages && again);
>  
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
