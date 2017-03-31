Received: from eggs.gnu.org ([2001:4830:134:3::10]:58156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctzmw-00073Y-Hr
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctzmr-0000dQ-F0
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:52:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctzmr-0000bz-6M
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 12:52:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D870A81233
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 16:52:31 +0000 (UTC)
Date: Fri, 31 Mar 2017 17:52:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331165227.GP4514@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-31-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-31-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 30/51] ram: Move src_page_req* to RAMState
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
> This are the last postcopy fields still at MigrationState.  Once there
> Move MigrationSrcPageRequest to ram.c and remove MigrationState
> parameters where appropiate.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/migration/migration.h | 17 +-----------
>  migration/migration.c         |  5 +---
>  migration/ram.c               | 62 ++++++++++++++++++++++++++-----------------
>  3 files changed, 40 insertions(+), 44 deletions(-)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index e032fb0..8a6caa3 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -128,18 +128,6 @@ struct MigrationIncomingState {
>  MigrationIncomingState *migration_incoming_get_current(void);
>  void migration_incoming_state_destroy(void);
>  
> -/*
> - * An outstanding page request, on the source, having been received
> - * and queued
> - */
> -struct MigrationSrcPageRequest {
> -    RAMBlock *rb;
> -    hwaddr    offset;
> -    hwaddr    len;
> -
> -    QSIMPLEQ_ENTRY(MigrationSrcPageRequest) next_req;
> -};
> -
>  struct MigrationState
>  {
>      size_t bytes_xfer;
> @@ -186,9 +174,6 @@ struct MigrationState
>      /* Flag set once the migration thread called bdrv_inactivate_all */
>      bool block_inactive;
>  
> -    /* Queue of outstanding page requests from the destination */
> -    QemuMutex src_page_req_mutex;
> -    QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
>      /* The semaphore is used to notify COLO thread that failover is finished */
>      QemuSemaphore colo_exit_sem;
>  
> @@ -371,7 +356,7 @@ void savevm_skip_configuration(void);
>  int global_state_store(void);
>  void global_state_store_running(void);
>  
> -void flush_page_queue(MigrationState *ms);
> +void flush_page_queue(void);
>  int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>                           ram_addr_t start, ram_addr_t len);
>  uint64_t ram_pagesize_summary(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index b220941..58c1587 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -109,7 +109,6 @@ MigrationState *migrate_get_current(void)
>      };
>  
>      if (!once) {
> -        qemu_mutex_init(&current_migration.src_page_req_mutex);
>          current_migration.parameters.tls_creds = g_strdup("");
>          current_migration.parameters.tls_hostname = g_strdup("");
>          once = true;
> @@ -949,7 +948,7 @@ static void migrate_fd_cleanup(void *opaque)
>      qemu_bh_delete(s->cleanup_bh);
>      s->cleanup_bh = NULL;
>  
> -    flush_page_queue(s);
> +    flush_page_queue();
>  
>      if (s->to_dst_file) {
>          trace_migrate_fd_cleanup();
> @@ -1123,8 +1122,6 @@ MigrationState *migrate_init(const MigrationParams *params)
>  
>      migrate_set_state(&s->state, MIGRATION_STATUS_NONE, MIGRATION_STATUS_SETUP);
>  
> -    QSIMPLEQ_INIT(&s->src_page_requests);
> -
>      s->total_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      return s;
>  }
> diff --git a/migration/ram.c b/migration/ram.c
> index 325a0f3..601370c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -151,6 +151,18 @@ struct RAMBitmap {
>  };
>  typedef struct RAMBitmap RAMBitmap;
>  
> +/*
> + * An outstanding page request, on the source, having been received
> + * and queued
> + */
> +struct RAMSrcPageRequest {
> +    RAMBlock *rb;
> +    hwaddr    offset;
> +    hwaddr    len;
> +
> +    QSIMPLEQ_ENTRY(RAMSrcPageRequest) next_req;
> +};
> +
>  /* State of RAM for migration */
>  struct RAMState {
>      /* Last block that we have visited searching for dirty pages */
> @@ -205,6 +217,9 @@ struct RAMState {
>      RAMBitmap *ram_bitmap;
>      /* The RAMBlock used in the last src_page_request */
>      RAMBlock *last_req_rb;
> +    /* Queue of outstanding page requests from the destination */
> +    QemuMutex src_page_req_mutex;
> +    QSIMPLEQ_HEAD(src_page_requests, RAMSrcPageRequest) src_page_requests;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -1084,20 +1099,20 @@ static bool find_dirty_block(RAMState *rs, QEMUFile *f, PageSearchStatus *pss,
>   *
>   * Returns the block of the page (or NULL if none available)
>   *
> - * @ms: current migration state
> + * @rs: current RAM state
>   * @offset: used to return the offset within the RAMBlock
>   * @ram_addr_abs: pointer into which to store the address of the dirty page
>   *                within the global ram_addr space
>   */
> -static RAMBlock *unqueue_page(MigrationState *ms, ram_addr_t *offset,
> +static RAMBlock *unqueue_page(RAMState *rs, ram_addr_t *offset,
>                                ram_addr_t *ram_addr_abs)
>  {
>      RAMBlock *block = NULL;
>  
> -    qemu_mutex_lock(&ms->src_page_req_mutex);
> -    if (!QSIMPLEQ_EMPTY(&ms->src_page_requests)) {
> -        struct MigrationSrcPageRequest *entry =
> -                                QSIMPLEQ_FIRST(&ms->src_page_requests);
> +    qemu_mutex_lock(&rs->src_page_req_mutex);
> +    if (!QSIMPLEQ_EMPTY(&rs->src_page_requests)) {
> +        struct RAMSrcPageRequest *entry =
> +                                QSIMPLEQ_FIRST(&rs->src_page_requests);
>          block = entry->rb;
>          *offset = entry->offset;
>          *ram_addr_abs = (entry->offset + entry->rb->offset) &
> @@ -1108,11 +1123,11 @@ static RAMBlock *unqueue_page(MigrationState *ms, ram_addr_t *offset,
>              entry->offset += TARGET_PAGE_SIZE;
>          } else {
>              memory_region_unref(block->mr);
> -            QSIMPLEQ_REMOVE_HEAD(&ms->src_page_requests, next_req);
> +            QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
>              g_free(entry);
>          }
>      }
> -    qemu_mutex_unlock(&ms->src_page_req_mutex);
> +    qemu_mutex_unlock(&rs->src_page_req_mutex);
>  
>      return block;
>  }
> @@ -1125,13 +1140,11 @@ static RAMBlock *unqueue_page(MigrationState *ms, ram_addr_t *offset,
>   * Returns if a queued page is found
>   *
>   * @rs: current RAM state
> - * @ms: current migration state
>   * @pss: data about the state of the current dirty page scan
>   * @ram_addr_abs: pointer into which to store the address of the dirty page
>   *                within the global ram_addr space
>   */
> -static bool get_queued_page(RAMState *rs, MigrationState *ms,
> -                            PageSearchStatus *pss,
> +static bool get_queued_page(RAMState *rs, PageSearchStatus *pss,
>                              ram_addr_t *ram_addr_abs)
>  {
>      RAMBlock  *block;
> @@ -1139,7 +1152,7 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms,
>      bool dirty;
>  
>      do {
> -        block = unqueue_page(ms, &offset, ram_addr_abs);
> +        block = unqueue_page(rs, &offset, ram_addr_abs);
>          /*
>           * We're sending this page, and since it's postcopy nothing else
>           * will dirty it, and we must make sure it doesn't get sent again
> @@ -1191,19 +1204,18 @@ static bool get_queued_page(RAMState *rs, MigrationState *ms,
>   *
>   * It should be empty at the end anyway, but in error cases there may
>   * xbe some left.
> - *
> - * @ms: current migration state
>   */
> -void flush_page_queue(MigrationState *ms)
> +void flush_page_queue(void)

I'm not sure this is safe;  it's called from migrate_fd_cleanup right at
the end, if you do any finalisation/cleanup of the RAMState in ram_save_complete
then when is it safe to run this?

>  {
> -    struct MigrationSrcPageRequest *mspr, *next_mspr;
> +    struct RAMSrcPageRequest *mspr, *next_mspr;
> +    RAMState *rs = &ram_state;
>      /* This queue generally should be empty - but in the case of a failed
>       * migration might have some droppings in.
>       */
>      rcu_read_lock();
> -    QSIMPLEQ_FOREACH_SAFE(mspr, &ms->src_page_requests, next_req, next_mspr) {
> +    QSIMPLEQ_FOREACH_SAFE(mspr, &rs->src_page_requests, next_req, next_mspr) {
>          memory_region_unref(mspr->rb->mr);
> -        QSIMPLEQ_REMOVE_HEAD(&ms->src_page_requests, next_req);
> +        QSIMPLEQ_REMOVE_HEAD(&rs->src_page_requests, next_req);
>          g_free(mspr);
>      }
>      rcu_read_unlock();
> @@ -1260,16 +1272,16 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>          goto err;
>      }
>  
> -    struct MigrationSrcPageRequest *new_entry =
> -        g_malloc0(sizeof(struct MigrationSrcPageRequest));
> +    struct RAMSrcPageRequest *new_entry =
> +        g_malloc0(sizeof(struct RAMSrcPageRequest));
>      new_entry->rb = ramblock;
>      new_entry->offset = start;
>      new_entry->len = len;
>  
>      memory_region_ref(ramblock->mr);
> -    qemu_mutex_lock(&ms->src_page_req_mutex);
> -    QSIMPLEQ_INSERT_TAIL(&ms->src_page_requests, new_entry, next_req);
> -    qemu_mutex_unlock(&ms->src_page_req_mutex);
> +    qemu_mutex_lock(&rs->src_page_req_mutex);
> +    QSIMPLEQ_INSERT_TAIL(&rs->src_page_requests, new_entry, next_req);
> +    qemu_mutex_unlock(&rs->src_page_req_mutex);

Hmm ok where did it get it's rs from?
Anyway, the thing I needed to convince myself of was that there was any guarantee that
RAMState would exist by the time the first request came in, something that we now need
to be careful of.
I think we're mostly OK; we call qemu_savevm_state_begin() at the top
of migration_thread so the ram_save_setup should be done and allocate
the RAMState before we get into the main loop and thus before we ever
look at the 'start_postcopy' flag and thus before we ever ask the destination
to send us stuff.

>      rcu_read_unlock();
>  
>      return 0;
> @@ -1408,7 +1420,7 @@ static int ram_find_and_save_block(RAMState *rs, QEMUFile *f, bool last_stage)
>  
>      do {
>          again = true;
> -        found = get_queued_page(rs, ms, &pss, &dirty_ram_abs);
> +        found = get_queued_page(rs, &pss, &dirty_ram_abs);
>  
>          if (!found) {
>              /* priority queue empty, so just search for something dirty */
> @@ -1968,6 +1980,8 @@ static int ram_state_init(RAMState *rs)
>  
>      memset(rs, 0, sizeof(*rs));
>      qemu_mutex_init(&rs->bitmap_mutex);
> +    qemu_mutex_init(&rs->src_page_req_mutex);
> +    QSIMPLEQ_INIT(&rs->src_page_requests);

Similar question to above; that mutex is going to get reinit'd
on a new migration and it shouldn't be without it being destroyed.
Maybe make it a once.

Dave

>  
>      if (migrate_use_xbzrle()) {
>          XBZRLE_cache_lock();
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
