Received: from eggs.gnu.org ([2001:4830:134:3::10]:36935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1copNw-0000X9-Nz
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:45:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1copNs-0008TE-O9
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:45:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40820)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1copNs-0008Su-FL
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:45:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2BFD84DD7E
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 10:45:24 +0000 (UTC)
Date: Fri, 17 Mar 2017 10:45:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170317104519.GE2396@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-31-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-31-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 30/31] ram: move dirty_pages_rate to
 RAMState
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
> Treat it like the rest of ram stats counters.  Export its value the
> same way.  As an added bonus, no more MigrationState used in
> migration_bitmap_sync();
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h |  2 +-
>  migration/migration.c         |  7 +++----
>  migration/ram.c               | 12 +++++++++---
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 42b9edf..43bdf86 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -166,7 +166,6 @@ struct MigrationState
>      int64_t total_time;
>      int64_t downtime;
>      int64_t expected_downtime;
> -    int64_t dirty_pages_rate;
>      bool enabled_capabilities[MIGRATION_CAPABILITY__MAX];
>      int64_t xbzrle_cache_size;
>      int64_t setup_time;
> @@ -269,6 +268,7 @@ uint64_t ram_bytes_remaining(void);
>  uint64_t ram_bytes_transferred(void);
>  uint64_t ram_bytes_total(void);
>  uint64_t ram_dirty_sync_count(void);
> +uint64_t ram_dirty_pages_rate(void);
>  void free_xbzrle_decoded_buf(void);
>  
>  void acct_update_position(QEMUFile *f, size_t size, bool zero);
> diff --git a/migration/migration.c b/migration/migration.c
> index 2f8c440..0a70d55 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -650,7 +650,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>  
>      if (s->state != MIGRATION_STATUS_COMPLETED) {
>          info->ram->remaining = ram_bytes_remaining();
> -        info->ram->dirty_pages_rate = s->dirty_pages_rate;
> +        info->ram->dirty_pages_rate = ram_dirty_pages_rate();
>      }
>  }
>  
> @@ -1106,7 +1106,6 @@ MigrationState *migrate_init(const MigrationParams *params)
>      s->mbps = 0.0;
>      s->downtime = 0;
>      s->expected_downtime = 0;
> -    s->dirty_pages_rate = 0;
>      s->setup_time = 0;
>      s->start_postcopy = false;
>      s->postcopy_after_devices = false;
> @@ -1998,8 +1997,8 @@ static void *migration_thread(void *opaque)
>                                        bandwidth, max_size);
>              /* if we haven't sent anything, we don't want to recalculate
>                 10000 is a small enough number for our purposes */
> -            if (s->dirty_pages_rate && transferred_bytes > 10000) {
> -                s->expected_downtime = s->dirty_pages_rate * (1ul << qemu_target_page_bits())/ bandwidth;
> +            if (ram_dirty_pages_rate() && transferred_bytes > 10000) {
> +                s->expected_downtime = ram_dirty_pages_rate() * (1ul << qemu_target_page_bits())/ bandwidth;
>              }
>  
>              qemu_file_reset_rate_limit(s->to_dst_file);
> diff --git a/migration/ram.c b/migration/ram.c
> index 1006e60..b85f58f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -193,6 +193,8 @@ struct RAMState {
>      uint64_t migration_dirty_pages;
>      /* total number of bytes transferred */
>      uint64_t bytes_transferred;
> +    /* number of dirtied pages in the last second */
> +    uint64_t dirty_pages_rate;
>      /* protects modification of the bitmap */
>      QemuMutex bitmap_mutex;
>      /* Ram Bitmap protected by RCU */
> @@ -254,6 +256,11 @@ uint64_t ram_dirty_sync_count(void)
>      return ram_state.bitmap_sync_count;
>  }
>  
> +uint64_t ram_dirty_pages_rate(void)
> +{
> +    return ram_state.dirty_pages_rate;
> +}
> +
>  /* used by the search for pages to send */
>  struct PageSearchStatus {
>      /* Current block being searched */
> @@ -624,7 +631,6 @@ static void migration_bitmap_sync(RAMState *rs)
>  {
>      RAMBlock *block;
>      uint64_t num_dirty_pages_init = rs->migration_dirty_pages;
> -    MigrationState *s = migrate_get_current();
>      int64_t end_time;
>      int64_t bytes_xfer_now;
>  
> @@ -664,7 +670,7 @@ static void migration_bitmap_sync(RAMState *rs)
>                 throttling */
>              bytes_xfer_now = ram_bytes_transferred();
>  
> -            if (s->dirty_pages_rate &&
> +            if (rs->dirty_pages_rate &&
>                 (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>                     (bytes_xfer_now - rs->bytes_xfer_prev)/2) &&
>                 (rs->dirty_rate_high_cnt++ >= 2)) {
> @@ -685,7 +691,7 @@ static void migration_bitmap_sync(RAMState *rs)
>              rs->iterations_prev = rs->iterations;
>              rs->xbzrle_cache_miss_prev = rs->xbzrle_cache_miss;
>          }
> -        s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
> +        rs->dirty_pages_rate = rs->num_dirty_pages_period * 1000
>              / (end_time - rs->start_time);
>          rs->start_time = end_time;
>          rs->num_dirty_pages_period = 0;
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
