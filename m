Received: from eggs.gnu.org ([2001:4830:134:3::10]:60457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctxQU-0001DJ-UP
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctxQR-0004MY-HQ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:21:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctxQR-0004Ln-7D
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:21:15 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C6A1C0528B6
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 14:21:14 +0000 (UTC)
Date: Fri, 31 Mar 2017 15:21:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331142109.GG4514@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-37-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-37-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 36/51] ram: Move QEMUFile into RAMState
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
> We receive the file from save_live operations and we don't use it
> until 3 or 4 levels of calls down.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 84 +++++++++++++++++++++++++--------------------------------
>  1 file changed, 37 insertions(+), 47 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 7667e73..6a39704 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -756,21 +756,20 @@ static void migration_bitmap_sync(RAMState *rs)
>   * Returns the number of pages written.
>   *
>   * @rs: current RAM state
> - * @f: QEMUFile where to send the data
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @p: pointer to the page
>   */
> -static int save_zero_page(RAMState *rs, QEMUFile *f, RAMBlock *block,
> -                          ram_addr_t offset, uint8_t *p)
> +static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
> +                          uint8_t *p)
>  {
>      int pages = -1;
>  
>      if (is_zero_range(p, TARGET_PAGE_SIZE)) {
>          rs->zero_pages++;
>          rs->bytes_transferred +=
> -            save_page_header(f, block, offset | RAM_SAVE_FLAG_COMPRESS);
> -        qemu_put_byte(f, 0);
> +            save_page_header(rs->f, block, offset | RAM_SAVE_FLAG_COMPRESS);
> +        qemu_put_byte(rs->f, 0);
>          rs->bytes_transferred += 1;
>          pages = 1;
>      }
> @@ -798,12 +797,11 @@ static void ram_release_pages(MigrationState *ms, const char *rbname,
>   *
>   * @rs: current RAM state
>   * @ms: current migration state
> - * @f: QEMUFile where to send the data
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @last_stage: if we are at the completion stage
>   */
> -static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
> +static int ram_save_page(RAMState *rs, MigrationState *ms,
>                           PageSearchStatus *pss, bool last_stage)
>  {
>      int pages = -1;
> @@ -819,7 +817,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>  
>      /* In doubt sent page as normal */
>      bytes_xmit = 0;
> -    ret = ram_control_save_page(f, block->offset,
> +    ret = ram_control_save_page(rs->f, block->offset,
>                             offset, TARGET_PAGE_SIZE, &bytes_xmit);
>      if (bytes_xmit) {
>          rs->bytes_transferred += bytes_xmit;
> @@ -842,7 +840,7 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>              }
>          }
>      } else {
> -        pages = save_zero_page(rs, f, block, offset, p);
> +        pages = save_zero_page(rs, block, offset, p);
>          if (pages > 0) {
>              /* Must let xbzrle know, otherwise a previous (now 0'd) cached
>               * page would be stale
> @@ -864,14 +862,14 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>  
>      /* XBZRLE overflow or normal page */
>      if (pages == -1) {
> -        rs->bytes_transferred += save_page_header(f, block,
> +        rs->bytes_transferred += save_page_header(rs->f, block,
>                                                 offset | RAM_SAVE_FLAG_PAGE);
>          if (send_async) {
> -            qemu_put_buffer_async(f, p, TARGET_PAGE_SIZE,
> +            qemu_put_buffer_async(rs->f, p, TARGET_PAGE_SIZE,
>                                    migrate_release_ram() &
>                                    migration_in_postcopy(ms));
>          } else {
> -            qemu_put_buffer(f, p, TARGET_PAGE_SIZE);
> +            qemu_put_buffer(rs->f, p, TARGET_PAGE_SIZE);
>          }
>          rs->bytes_transferred += TARGET_PAGE_SIZE;
>          pages = 1;
> @@ -906,7 +904,7 @@ static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>      return bytes_sent;
>  }
>  
> -static void flush_compressed_data(RAMState *rs, QEMUFile *f)
> +static void flush_compressed_data(RAMState *rs)
>  {
>      int idx, len, thread_count;
>  
> @@ -926,7 +924,7 @@ static void flush_compressed_data(RAMState *rs, QEMUFile *f)
>      for (idx = 0; idx < thread_count; idx++) {
>          qemu_mutex_lock(&comp_param[idx].mutex);
>          if (!comp_param[idx].quit) {
> -            len = qemu_put_qemu_file(f, comp_param[idx].file);
> +            len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
>              rs->bytes_transferred += len;
>          }
>          qemu_mutex_unlock(&comp_param[idx].mutex);
> @@ -940,8 +938,8 @@ static inline void set_compress_params(CompressParam *param, RAMBlock *block,
>      param->offset = offset;
>  }
>  
> -static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
> -                                           RAMBlock *block, ram_addr_t offset)
> +static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
> +                                           ram_addr_t offset)
>  {
>      int idx, thread_count, bytes_xmit = -1, pages = -1;
>  
> @@ -951,7 +949,7 @@ static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
>          for (idx = 0; idx < thread_count; idx++) {
>              if (comp_param[idx].done) {
>                  comp_param[idx].done = false;
> -                bytes_xmit = qemu_put_qemu_file(f, comp_param[idx].file);
> +                bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
>                  qemu_mutex_lock(&comp_param[idx].mutex);
>                  set_compress_params(&comp_param[idx], block, offset);
>                  qemu_cond_signal(&comp_param[idx].cond);
> @@ -980,13 +978,11 @@ static int compress_page_with_multi_thread(RAMState *rs, QEMUFile *f,
>   *
>   * @rs: current RAM state
>   * @ms: current migration state
> - * @f: QEMUFile where to send the data
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
>   * @last_stage: if we are at the completion stage
>   */
>  static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
> -                                    QEMUFile *f,
>                                      PageSearchStatus *pss, bool last_stage)
>  {
>      int pages = -1;
> @@ -998,7 +994,7 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>  
>      p = block->host + offset;
>  
> -    ret = ram_control_save_page(f, block->offset,
> +    ret = ram_control_save_page(rs->f, block->offset,
>                                  offset, TARGET_PAGE_SIZE, &bytes_xmit);
>      if (bytes_xmit) {
>          rs->bytes_transferred += bytes_xmit;
> @@ -1020,20 +1016,20 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>           * is used to avoid resending the block name.
>           */
>          if (block != rs->last_sent_block) {
> -            flush_compressed_data(rs, f);
> -            pages = save_zero_page(rs, f, block, offset, p);
> +            flush_compressed_data(rs);
> +            pages = save_zero_page(rs, block, offset, p);
>              if (pages == -1) {
>                  /* Make sure the first page is sent out before other pages */
> -                bytes_xmit = save_page_header(f, block, offset |
> +                bytes_xmit = save_page_header(rs->f, block, offset |
>                                                RAM_SAVE_FLAG_COMPRESS_PAGE);
> -                blen = qemu_put_compression_data(f, p, TARGET_PAGE_SIZE,
> +                blen = qemu_put_compression_data(rs->f, p, TARGET_PAGE_SIZE,
>                                                   migrate_compress_level());
>                  if (blen > 0) {
>                      rs->bytes_transferred += bytes_xmit + blen;
>                      rs->norm_pages++;
>                      pages = 1;
>                  } else {
> -                    qemu_file_set_error(f, blen);
> +                    qemu_file_set_error(rs->f, blen);
>                      error_report("compressed data failed!");
>                  }
>              }
> @@ -1042,9 +1038,9 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>              }
>          } else {
>              offset |= RAM_SAVE_FLAG_CONTINUE;
> -            pages = save_zero_page(rs, f, block, offset, p);
> +            pages = save_zero_page(rs, block, offset, p);
>              if (pages == -1) {
> -                pages = compress_page_with_multi_thread(rs, f, block, offset);
> +                pages = compress_page_with_multi_thread(rs, block, offset);
>              } else {
>                  ram_release_pages(ms, block->idstr, pss->offset, pages);
>              }
> @@ -1061,13 +1057,12 @@ static int ram_save_compressed_page(RAMState *rs, MigrationState *ms,
>   * Returns if a page is found
>   *
>   * @rs: current RAM state
> - * @f: QEMUFile where to send the data
>   * @pss: data about the state of the current dirty page scan
>   * @again: set to false if the search has scanned the whole of RAM
>   * @ram_addr_abs: pointer into which to store the address of the dirty page
>   *                within the global ram_addr space
>   */
> -static bool find_dirty_block(RAMState *rs, QEMUFile *f, PageSearchStatus *pss,
> +static bool find_dirty_block(RAMState *rs, PageSearchStatus *pss,
>                               bool *again, ram_addr_t *ram_addr_abs)
>  {
>      pss->offset = migration_bitmap_find_dirty(rs, pss->block, pss->offset,
> @@ -1095,7 +1090,7 @@ static bool find_dirty_block(RAMState *rs, QEMUFile *f, PageSearchStatus *pss,
>                  /* If xbzrle is on, stop using the data compression at this
>                   * point. In theory, xbzrle can do better than compression.
>                   */
> -                flush_compressed_data(rs, f);
> +                flush_compressed_data(rs);
>                  compression_switch = false;
>              }
>          }
> @@ -1314,12 +1309,11 @@ err:
>   *
>   * @rs: current RAM state
>   * @ms: current migration state
> - * @f: QEMUFile where to send the data
>   * @pss: data about the page we want to send
>   * @last_stage: if we are at the completion stage
>   * @dirty_ram_abs: address of the start of the dirty page in ram_addr_t space
>   */
> -static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
> +static int ram_save_target_page(RAMState *rs, MigrationState *ms,
>                                  PageSearchStatus *pss,
>                                  bool last_stage,
>                                  ram_addr_t dirty_ram_abs)
> @@ -1330,9 +1324,9 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>      if (migration_bitmap_clear_dirty(rs, dirty_ram_abs)) {
>          unsigned long *unsentmap;
>          if (compression_switch && migrate_use_compression()) {
> -            res = ram_save_compressed_page(rs, ms, f, pss, last_stage);
> +            res = ram_save_compressed_page(rs, ms, pss, last_stage);
>          } else {
> -            res = ram_save_page(rs, ms, f, pss, last_stage);
> +            res = ram_save_page(rs, ms, pss, last_stage);
>          }
>  
>          if (res < 0) {
> @@ -1367,12 +1361,11 @@ static int ram_save_target_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>   *
>   * @rs: current RAM state
>   * @ms: current migration state
> - * @f: QEMUFile where to send the data
>   * @pss: data about the page we want to send
>   * @last_stage: if we are at the completion stage
>   * @dirty_ram_abs: Address of the start of the dirty page in ram_addr_t space
>   */
> -static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
> +static int ram_save_host_page(RAMState *rs, MigrationState *ms,
>                                PageSearchStatus *pss,
>                                bool last_stage,
>                                ram_addr_t dirty_ram_abs)
> @@ -1381,8 +1374,7 @@ static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>      size_t pagesize = qemu_ram_pagesize(pss->block);
>  
>      do {
> -        tmppages = ram_save_target_page(rs, ms, f, pss, last_stage,
> -                                        dirty_ram_abs);
> +        tmppages = ram_save_target_page(rs, ms, pss, last_stage, dirty_ram_abs);
>          if (tmppages < 0) {
>              return tmppages;
>          }
> @@ -1405,14 +1397,13 @@ static int ram_save_host_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
>   * Returns the number of pages written where zero means no dirty pages
>   *
>   * @rs: current RAM state
> - * @f: QEMUFile where to send the data
>   * @last_stage: if we are at the completion stage
>   *
>   * On systems where host-page-size > target-page-size it will send all the
>   * pages in a host page that are dirty.
>   */
>  
> -static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage)
> +static int ram_find_and_save_block(RAMState *rs, bool last_stage)
>  {
>      PageSearchStatus pss;
>      MigrationState *ms = migrate_get_current();
> @@ -1440,12 +1431,11 @@ static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage)
>  
>          if (!found) {
>              /* priority queue empty, so just search for something dirty */
> -            found = find_dirty_block(rs, f, &pss, &again, &dirty_ram_abs);
> +            found = find_dirty_block(rs, &pss, &again, &dirty_ram_abs);
>          }
>  
>          if (found) {
> -            pages = ram_save_host_page(rs, ms, f, &pss, last_stage,
> -                                       dirty_ram_abs);
> +            pages = ram_save_host_page(rs, ms, &pss, last_stage, dirty_ram_abs);
>          }
>      } while (!pages && again);
>  
> @@ -2145,7 +2135,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>      while ((ret = qemu_file_rate_limit(f)) == 0) {
>          int pages;
>  
> -        pages = ram_find_and_save_block(rs, f, false);
> +        pages = ram_find_and_save_block(rs, false);
>          /* no more pages to sent */
>          if (pages == 0) {
>              done = 1;
> @@ -2167,7 +2157,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>          }
>          i++;
>      }
> -    flush_compressed_data(rs, f);
> +    flush_compressed_data(rs);
>      rcu_read_unlock();
>  
>      /*
> @@ -2215,14 +2205,14 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      while (true) {
>          int pages;
>  
> -        pages = ram_find_and_save_block(rs, f, !migration_in_colo_state());
> +        pages = ram_find_and_save_block(rs, !migration_in_colo_state());
>          /* no more blocks to sent */
>          if (pages == 0) {
>              break;
>          }
>      }
>  
> -    flush_compressed_data(rs, f);
> +    flush_compressed_data(rs);
>      ram_control_after_iterate(f, RAM_CONTROL_FINISH);
>  
>      rcu_read_unlock();
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
