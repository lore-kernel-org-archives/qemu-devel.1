Received: from eggs.gnu.org ([2001:4830:134:3::10]:45109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coUOU-0003Qh-9W
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coUOQ-0003vO-9m
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coUOQ-0003uk-1G
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:20:34 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AC863DBE7
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 12:20:34 +0000 (UTC)
Date: Thu, 16 Mar 2017 12:20:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316122026.GB2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-3-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-3-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/31] ram: Add dirty_rate_high_cnt to
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
Cc: qemu-devel@nongnu.org, amit.shah@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We need to add a parameter to several functions to make this work.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index c20a539..9120755 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -45,8 +45,6 @@
>  #include "qemu/rcu_queue.h"
>  #include "migration/colo.h"
>  
> -static int dirty_rate_high_cnt;
> -
>  static uint64_t bitmap_sync_count;
>  
>  /***********************************************************/
> @@ -148,6 +146,8 @@ struct RAMState {
>      uint32_t last_version;
>      /* We are in the first round */
>      bool ram_bulk_stage;
> +    /* How many times we have dirty too many pages */
> +    int dirty_rate_high_cnt;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -626,7 +626,7 @@ uint64_t ram_pagesize_summary(void)
>      return summary;
>  }
>  
> -static void migration_bitmap_sync(void)
> +static void migration_bitmap_sync(RAMState *rs)
>  {
>      RAMBlock *block;
>      uint64_t num_dirty_pages_init = migration_dirty_pages;
> @@ -673,9 +673,9 @@ static void migration_bitmap_sync(void)
>              if (s->dirty_pages_rate &&
>                 (num_dirty_pages_period * TARGET_PAGE_SIZE >
>                     (bytes_xfer_now - bytes_xfer_prev)/2) &&
> -               (dirty_rate_high_cnt++ >= 2)) {
> +               (rs->dirty_rate_high_cnt++ >= 2)) {
>                      trace_migration_throttle();
> -                    dirty_rate_high_cnt = 0;
> +                    rs->dirty_rate_high_cnt = 0;
>                      mig_throttle_guest_down();
>               }
>               bytes_xfer_prev = bytes_xfer_now;
> @@ -1859,7 +1859,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>      rcu_read_lock();
>  
>      /* This should be our last sync, the src is now paused */
> -    migration_bitmap_sync();
> +    migration_bitmap_sync(&ram_state);
>  
>      unsentmap = atomic_rcu_read(&migration_bitmap_rcu)->unsentmap;
>      if (!unsentmap) {
> @@ -1935,7 +1935,7 @@ static int ram_save_init_globals(RAMState *rs)
>  {
>      int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
>  
> -    dirty_rate_high_cnt = 0;
> +    rs->dirty_rate_high_cnt = 0;
>      bitmap_sync_count = 0;
>      migration_bitmap_sync_init();
>      qemu_mutex_init(&migration_bitmap_mutex);
> @@ -1999,7 +1999,7 @@ static int ram_save_init_globals(RAMState *rs)
>      migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
>  
>      memory_global_dirty_log_start();
> -    migration_bitmap_sync();
> +    migration_bitmap_sync(rs);
>      qemu_mutex_unlock_ramlist();
>      qemu_mutex_unlock_iothread();
>      rcu_read_unlock();
> @@ -2117,11 +2117,11 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  static int ram_save_complete(QEMUFile *f, void *opaque)
>  {
>      RAMState *rs = opaque;
> -    
> +

Is that undoing false spaces from the previous patch?

anyway,
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      rcu_read_lock();
>  
>      if (!migration_in_postcopy(migrate_get_current())) {
> -        migration_bitmap_sync();
> +        migration_bitmap_sync(rs);
>      }
>  
>      ram_control_before_iterate(f, RAM_CONTROL_FINISH);
> @@ -2154,6 +2154,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>                               uint64_t *non_postcopiable_pending,
>                               uint64_t *postcopiable_pending)
>  {
> +    RAMState *rs = opaque;
>      uint64_t remaining_size;
>  
>      remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
> @@ -2162,7 +2163,7 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>          remaining_size < max_size) {
>          qemu_mutex_lock_iothread();
>          rcu_read_lock();
> -        migration_bitmap_sync();
> +        migration_bitmap_sync(rs);
>          rcu_read_unlock();
>          qemu_mutex_unlock_iothread();
>          remaining_size = ram_save_remaining() * TARGET_PAGE_SIZE;
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
