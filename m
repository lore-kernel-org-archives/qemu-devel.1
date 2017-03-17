Received: from eggs.gnu.org ([2001:4830:134:3::10]:52481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coodt-0003Nd-SP
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coodp-0007BW-UV
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:57:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coodp-0007BS-LF
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 05:57:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7C5BF8047E
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 09:57:49 +0000 (UTC)
Date: Fri, 17 Mar 2017 09:57:43 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170317095743.GB2396@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-26-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-26-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 25/31] ram: Use the RAMState
 bytes_transferred parameter
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
> Somewhere it was passed by reference, just use it from RAMState.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 77 ++++++++++++++++++++-------------------------------------
>  1 file changed, 27 insertions(+), 50 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f9933b2..9c9533d 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -477,12 +477,10 @@ static void xbzrle_cache_zero_page(RAMState *rs, ram_addr_t current_addr)
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @last_stage: if we are at the completion stage
> - * @bytes_transferred: increase it with the number of transferred bytes
>   */
>  static int save_xbzrle_page(QEMUFile *f, RAMState *rs, uint8_t **current_data,
>                              ram_addr_t current_addr, RAMBlock *block,
> -                            ram_addr_t offset, bool last_stage,
> -                            uint64_t *bytes_transferred)
> +                            ram_addr_t offset, bool last_stage)
>  {
>      int encoded_len = 0, bytes_xbzrle;
>      uint8_t *prev_cached_page;
> @@ -538,7 +536,7 @@ static int save_xbzrle_page(QEMUFile *f, RAMState *rs, uint8_t **current_data,
>      bytes_xbzrle += encoded_len + 1 + 2;
>      rs->xbzrle_pages++;
>      rs->xbzrle_bytes += bytes_xbzrle;
> -    *bytes_transferred += bytes_xbzrle;
> +    rs->bytes_transferred += bytes_xbzrle;
>  
>      return 1;
>  }
> @@ -701,20 +699,18 @@ static void migration_bitmap_sync(RAMState *rs)
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @p: pointer to the page
> - * @bytes_transferred: increase it with the number of transferred bytes
>   */
>  static int save_zero_page(RAMState *rs, QEMUFile *f, RAMBlock *block,
> -                          ram_addr_t offset,
> -                          uint8_t *p, uint64_t *bytes_transferred)
> +                          ram_addr_t offset, uint8_t *p)
>  {
>      int pages = -1;
>  
>      if (is_zero_range(p, TARGET_PAGE_SIZE)) {
>          rs->zero_pages++;
> -        *bytes_transferred += save_page_header(f, block,
> -                                               offset | RAM_SAVE_FLAG_COMPRESS);
> +        rs->bytes_transferred += save_page_header(f, block,
> +                                                  offset | RAM_SAVE_FLAG_COMPRESS);
>          qemu_put_byte(f, 0);
> -        *bytes_transferred += 1;
> +        rs->bytes_transferred += 1;
>          pages = 1;
>      }
>  
> @@ -745,11 +741,9 @@ static void ram_release_pages(MigrationState *ms, const char *block_name,
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @last_stage: if we are at the completion stage
> - * @bytes_transferred: increase it with the number of transferred bytes
>   */
>  static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
> -                         PageSearchStatus *pss, bool last_stage,
> -                         uint64_t *bytes_transferred)
> +                         PageSearchStatus *pss, bool last_stage)
>  {
>      int pages = -1;
>      uint64_t bytes_xmit;
> @@ -767,7 +761,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>      ret = ram_control_save_page(f, block->offset,
>                             offset, TARGET_PAGE_SIZE, &bytes_xmit);
>      if (bytes_xmit) {
> -        *bytes_transferred += bytes_xmit;
> +        rs->bytes_transferred += bytes_xmit;
>          pages = 1;
>      }
>  
> @@ -787,7 +781,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>              }
>          }
>      } else {
> -        pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
> +        pages = save_zero_page(rs, f, block, offset, p);
>          if (pages > 0) {
>              /* Must let xbzrle know, otherwise a previous (now 0'd) cached
>               * page would be stale
> @@ -797,7 +791,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>          } else if (!rs->ram_bulk_stage &&
>                     !migration_in_postcopy(ms) && migrate_use_xbzrle()) {
>              pages = save_xbzrle_page(f, rs, &p, current_addr, block,
> -                                     offset, last_stage, bytes_transferred);
> +                                     offset, last_stage);
>              if (!last_stage) {
>                  /* Can't send this cached data async, since the cache page
>                   * might get updated before it gets to the wire
> @@ -809,7 +803,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>  
>      /* XBZRLE overflow or normal page */
>      if (pages == -1) {
> -        *bytes_transferred += save_page_header(f, block,
> +        rs->bytes_transferred += save_page_header(f, block,
>                                                 offset | RAM_SAVE_FLAG_PAGE);
>          if (send_async) {
>              qemu_put_buffer_async(f, p, TARGET_PAGE_SIZE,
> @@ -818,7 +812,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>          } else {
>              qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
>          }
> -        *bytes_transferred += TARGET_PAGE_SIZE;
> +        rs->bytes_transferred += TARGET_PAGE_SIZE;
>          pages = 1;
>          rs->norm_pages++;
>      }
> @@ -886,8 +880,7 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
>  }
>  
>  static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
> -                                           RAMBlock *block, ram_addr_t offset,
> -                                           uint64_t *bytes_transferred)
> +                                           RAMBlock *block, ram_addr_t offset)
>  {
>      int idx, thread_count, bytes_xmit = -1, pages = -1;
>  
> @@ -904,7 +897,7 @@ static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
>                  qemu_mutex_unlock(&comp_param[idx].mutex);
>                  pages = 1;
>                  rs->norm_pages++;
> -                *bytes_transferred += bytes_xmit;
> +                rs->bytes_transferred += bytes_xmit;
>                  break;
>              }
>          }
> @@ -930,12 +923,10 @@ static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @last_stage: if we are at the completion stage
> - * @bytes_transferred: increase it with the number of transferred bytes
>   */
>  static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>                                      QEMUFile *f,
> -                                    PageSearchStatus *pss, bool last_stage,
> -                                    uint64_t *bytes_transferred)
> +                                    PageSearchStatus *pss, bool last_stage)
>  {
>      int pages = -1;
>      uint64_t bytes_xmit = 0;
> @@ -949,7 +940,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>      ret = ram_control_save_page(f, block->offset,
>                                  offset, TARGET_PAGE_SIZE, &bytes_xmit);
>      if (bytes_xmit) {
> -        *bytes_transferred += bytes_xmit;
> +        rs->bytes_transferred += bytes_xmit;
>          pages = 1;
>      }
>      if (ret != RAM_SAVE_CONTROL_NOT_SUPP) {
> @@ -969,7 +960,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>           */
>          if (block != rs->last_sent_block) {
>              flush_compressed_data(rs, f);
> -            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
> +            pages = save_zero_page(rs, f, block, offset, p);
>              if (pages == -1) {
>                  /* Make sure the first page is sent out before other pages */
>                  bytes_xmit = save_page_header(f, block, offset |
> @@ -977,7 +968,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>                  blen = qemu_put_compression_data(f, p, TARGET_PAGE_SIZE,
>                                                   migrate_compress_level());
>                  if (blen > 0) {
> -                    *bytes_transferred += bytes_xmit + blen;
> +                    rs->bytes_transferred += bytes_xmit + blen;
>                      rs->norm_pages++;
>                      pages = 1;
>                  } else {
> @@ -990,10 +981,9 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>              }
>          } else {
>              offset |= RAM_SAVE_FLAG_CONTINUE;
> -            pages = save_zero_page(rs, f, block, offset, p, bytes_transferred);
> +            pages = save_zero_page(rs, f, block, offset, p);
>              if (pages == -1) {
> -                pages = compress_page_with_multi_thread(rs, f, block, offset,
> -                                                        bytes_transferred);
> +                pages = compress_page_with_multi_thread(rs, f, block, offset);
>              } else {
>                  ram_release_pages(ms, block->idstr, pss->offset, pages);
>              }
> @@ -1256,7 +1246,6 @@ err:
>   * @block: pointer to block that contains the page we want to send
>   * @offset: offset inside the block for the page;
>   * @last_stage: if we are at the completion stage
> - * @bytes_transferred: increase it with the number of transferred bytes
>   * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
>   *
>   * Returns: Number of pages written.
> @@ -1264,7 +1253,6 @@ err:
>  static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>                                  PageSearchStatus *pss,
>                                  bool last_stage,
> -                                uint64_t *bytes_transferred,
>                                  ram_addr_t dirty_ram_abs)
>  {
>      int res = 0;
> @@ -1273,12 +1261,9 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>      if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
>          unsigned long *unsentmap;
>          if (compression_switch && migrate_use_compression()) {
> -            res = ram_save_compressed_page(rs, ms, f, pss,
> -                                           last_stage,
> -                                           bytes_transferred);
> +            res = ram_save_compressed_page(rs, ms, f, pss, last_stage);
>          } else {
> -            res = ram_save_page(rs, ms, f, pss, last_stage,
> -                                bytes_transferred);
> +            res = ram_save_page(rs, ms, f, pss, last_stage);
>          }
>  
>          if (res < 0) {
> @@ -1317,21 +1302,18 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>   * @offset: offset inside the block for the page; updated to last target page
>   *          sent
>   * @last_stage: if we are at the completion stage
> - * @bytes_transferred: increase it with the number of transferred bytes
>   * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
>   */
>  static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>                                PageSearchStatus *pss,
>                                bool last_stage,
> -                              uint64_t *bytes_transferred,
>                                ram_addr_t dirty_ram_abs)
>  {
>      int tmppages, pages = 0;
>      size_t pagesize = qemu_ram_pagesize(pss->block);
>  
>      do {
> -        tmppages = ram_save_target_page(rs, ms, f, pss, last_stage,
> -                                        bytes_transferred, dirty_ram_abs);
> +        tmppages = ram_save_target_page(rs, ms, f, pss, last_stage, dirty_ram_abs);
>          if (tmppages < 0) {
>              return tmppages;
>          }
> @@ -1357,14 +1339,12 @@ static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>   * @rs: The RAM state
>   * @f: QEMUFile where to send the data
>   * @last_stage: if we are at the completion stage
> - * @bytes_transferred: increase it with the number of transferred bytes
>   *
>   * On systems where host-page-size > target-page-size it will send all the
>   * pages in a host page that are dirty.
>   */
>  
> -static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage,
> -                                   uint64_t *bytes_transferred)
> +static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage)
>  {
>      PageSearchStatus pss;
>      MigrationState *ms = migrate_get_current();
> @@ -1396,9 +1376,7 @@ static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage,
>          }
>  
>          if (found) {
> -            pages = ram_save_host_page(rs, ms, f, &pss,
> -                                       last_stage, bytes_transferred,
> -                                       dirty_ram_abs);
> +            pages = ram_save_host_page(rs, ms, f, &pss, last_stage, dirty_ram_abs);
>          }
>      } while (!pages && again);
>  
> @@ -2046,7 +2024,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>      while ((ret = qemu_file_rate_limit(f)) == 0) {
>          int pages;
>  
> -        pages = ram_find_and_save_block(rs, f, false, &rs->bytes_transferred);
> +        pages = ram_find_and_save_block(rs, f, false);
>          /* no more pages to sent */
>          if (pages == 0) {
>              done = 1;
> @@ -2107,8 +2085,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      while (true) {
>          int pages;
>  
> -        pages = ram_find_and_save_block(rs, f, !migration_in_colo_state(),
> -                                        &rs->bytes_transferred);
> +        pages = ram_find_and_save_block(rs, f, !migration_in_colo_state());
>          /* no more blocks to sent */
>          if (pages == 0) {
>              break;
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
