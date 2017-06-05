Received: from eggs.gnu.org ([2001:4830:134:3::10]:50106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dHtUZ-0006ox-Gd
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dHtUU-0005Jj-Hk
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:00:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dHtUU-0005Il-8E
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 11:00:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 69432811AC
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 15:00:20 +0000 (UTC)
Date: Mon, 5 Jun 2017 16:00:10 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170605150009.GL2109@work-vm>
References: <20170601220813.30535-1-quintela@redhat.com>
	<20170601220813.30535-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170601220813.30535-6-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] ram: Make RAMState dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> We create the variable while we are at migration and we remove it
> after migration.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 52 ++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 6c48219..1164f14 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -199,7 +199,7 @@ struct RAMState {
>  };
>  typedef struct RAMState RAMState;
>  
> -static RAMState ram_state;
> +static RAMState *ram_state;
>  
>  MigrationStats ram_counters;
>  
> @@ -783,7 +783,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>  static int do_compress_ram_page(QEMUFile *f, RAMBlock *block,
>                                  ram_addr_t offset)
>  {
> -    RAMState *rs = &ram_state;
> +    RAMState *rs = ram_state;
>      int bytes_sent, blen;
>      uint8_t *p = block->host + (offset & TARGET_PAGE_MASK);
>  
> @@ -1130,7 +1130,7 @@ static void migration_page_queue_free(RAMState *rs)
>  int ram_save_queue_pages(const char *rbname, ram_addr_t start, ram_addr_t len)
>  {
>      RAMBlock *ramblock;
> -    RAMState *rs = &ram_state;
> +    RAMState *rs = ram_state;
>  
>      ram_counters.postcopy_requests++;
>      rcu_read_lock();
> @@ -1351,7 +1351,7 @@ void free_xbzrle_decoded_buf(void)
>  
>  static void ram_migration_cleanup(void *opaque)
>  {
> -    RAMState *rs = opaque;
> +    RAMState **rsp = opaque;
>      RAMBlock *block;
>  
>      /* caller have hold iothread lock or is in a bh, so there is
> @@ -1378,7 +1378,9 @@ static void ram_migration_cleanup(void *opaque)
>          XBZRLE.zero_target_page = NULL;
>      }
>      XBZRLE_cache_unlock();
> -    migration_page_queue_free(rs);
> +    migration_page_queue_free(*rsp);
> +    g_free(*rsp);
> +    *rsp = NULL;

Yes, I think that's a safe place to free it.

>  }
>  
>  static void ram_state_reset(RAMState *rs)
> @@ -1703,7 +1705,7 @@ static int postcopy_chunk_hostpages(MigrationState *ms, RAMBlock *block)
>   */
>  int ram_postcopy_send_discard_bitmap(MigrationState *ms)
>  {
> -    RAMState *rs = &ram_state;
> +    RAMState *rs = ram_state;
>      RAMBlock *block;
>      int ret;
>  
> @@ -1786,12 +1788,13 @@ err:
>      return ret;
>  }
>  
> -static int ram_state_init(RAMState *rs)
> +static int ram_state_init(RAMState **rsp)
>  {
> -    memset(rs, 0, sizeof(*rs));
> -    qemu_mutex_init(&rs->bitmap_mutex);
> -    qemu_mutex_init(&rs->src_page_req_mutex);
> -    QSIMPLEQ_INIT(&rs->src_page_requests);
> +    *rsp = g_new0(RAMState, 1);
> +
> +    qemu_mutex_init(&(*rsp)->bitmap_mutex);
> +    qemu_mutex_init(&(*rsp)->src_page_req_mutex);
> +    QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
>  
>      if (migrate_use_xbzrle()) {
>          XBZRLE_cache_lock();
> @@ -1802,6 +1805,8 @@ static int ram_state_init(RAMState *rs)
>          if (!XBZRLE.cache) {
>              XBZRLE_cache_unlock();
>              error_report("Error creating cache");
> +            g_free(*rsp);
> +            *rsp = NULL;
>              return -1;
>          }
>          XBZRLE_cache_unlock();
> @@ -1810,6 +1815,8 @@ static int ram_state_init(RAMState *rs)
>          XBZRLE.encoded_buf = g_try_malloc0(TARGET_PAGE_SIZE);
>          if (!XBZRLE.encoded_buf) {
>              error_report("Error allocating encoded_buf");
> +            g_free(*rsp);
> +            *rsp = NULL;
>              return -1;
>          }
>  
> @@ -1818,6 +1825,8 @@ static int ram_state_init(RAMState *rs)
>              error_report("Error allocating current_buf");
>              g_free(XBZRLE.encoded_buf);
>              XBZRLE.encoded_buf = NULL;
> +            g_free(*rsp);
> +            *rsp = NULL;
>              return -1;
>          }
>      }
> @@ -1827,7 +1836,7 @@ static int ram_state_init(RAMState *rs)
>  
>      qemu_mutex_lock_ramlist();
>      rcu_read_lock();
> -    ram_state_reset(rs);
> +    ram_state_reset(*rsp);
>  
>      /* Skip setting bitmap if there is no RAM */
>      if (ram_bytes_total()) {
> @@ -1852,7 +1861,7 @@ static int ram_state_init(RAMState *rs)
>      ram_counters.remaining_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
>  
>      memory_global_dirty_log_start();
> -    migration_bitmap_sync(rs);
> +    migration_bitmap_sync(*rsp);
>      qemu_mutex_unlock_ramlist();
>      qemu_mutex_unlock_iothread();
>      rcu_read_unlock();
> @@ -1877,16 +1886,16 @@ static int ram_state_init(RAMState *rs)
>   */
>  static int ram_save_setup(QEMUFile *f, void *opaque)
>  {
> -    RAMState *rs = opaque;
> +    RAMState **rsp = opaque;
>      RAMBlock *block;
>  
>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
> -        if (ram_state_init(rs) < 0) {
> +        if (ram_state_init(rsp) != 0) {
>              return -1;
> -         }
> +        }
>      }
> -    rs->f = f;
> +    (*rsp)->f = f;
>  
>      rcu_read_lock();
>  
> @@ -1921,7 +1930,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>   */
>  static int ram_save_iterate(QEMUFile *f, void *opaque)
>  {
> -    RAMState *rs = opaque;
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;

OK, to be honest my preference would be
   RAMState *rs = *(RAMState **)opaque;
that I think works; but that's jus ttaste if you had to redo it.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>      int ret;
>      int i;
>      int64_t t0;
> @@ -1996,7 +2006,8 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>   */
>  static int ram_save_complete(QEMUFile *f, void *opaque)
>  {
> -    RAMState *rs = opaque;
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
>  
>      rcu_read_lock();
>  
> @@ -2033,7 +2044,8 @@ static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
>                               uint64_t *non_postcopiable_pending,
>                               uint64_t *postcopiable_pending)
>  {
> -    RAMState *rs = opaque;
> +    RAMState **temp = opaque;
> +    RAMState *rs = *temp;
>      uint64_t remaining_size;
>  
>      remaining_size = ram_counters.remaining_pages * TARGET_PAGE_SIZE;
> -- 
> 2.9.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
