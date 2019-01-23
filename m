Received: from eggs.gnu.org ([209.51.188.92]:45670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmHuZ-0007EI-6B
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gmHkF-0004Gr-2h
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:35:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35428)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gmHkE-0004Ff-Qy
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:35:03 -0500
Date: Wed, 23 Jan 2019 12:34:50 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190123123449.GC2193@work-vm>
References: <20190111063732.10484-1-xiaoguangrong@tencent.com>
	<20190111063732.10484-2-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111063732.10484-2-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] migration: introduce
 pages-per-second
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> It introduces a new statistic, pages-per-second, as bandwidth or mbps is
> not enough to measure the performance of posting pages out as we have
> compression, xbzrle, which can significantly reduce the amount of the
> data size, instead, pages-per-second is the one we want
> 

This makes sense to me.

(With the typos fixed):
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  hmp.c                 |  2 ++
>  migration/migration.c | 11 ++++++++++-
>  migration/migration.h |  8 ++++++++
>  migration/ram.c       |  6 ++++++
>  qapi/migration.json   |  5 ++++-
>  5 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 80aa5ab504..944e3e072d 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -236,6 +236,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->ram->page_size >> 10);
>          monitor_printf(mon, "multifd bytes: %" PRIu64 " kbytes\n",
>                         info->ram->multifd_bytes >> 10);
> +        monitor_printf(mon, "pages-per-second: %" PRIu64 "\n",
> +                       info->ram->pages_per_second);
>  
>          if (info->ram->dirty_pages_rate) {
>              monitor_printf(mon, "dirty pages rate: %" PRIu64 " pages\n",
> diff --git a/migration/migration.c b/migration/migration.c
> index ffc4d9e556..a82d594f29 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -777,6 +777,7 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>      info->ram->postcopy_requests = ram_counters.postcopy_requests;
>      info->ram->page_size = qemu_target_page_size();
>      info->ram->multifd_bytes = ram_counters.multifd_bytes;
> +    info->ram->pages_per_second = s->pages_per_second;
>  
>      if (migrate_use_xbzrle()) {
>          info->has_xbzrle_cache = true;
> @@ -1563,6 +1564,7 @@ void migrate_init(MigrationState *s)
>      s->rp_state.from_dst_file = NULL;
>      s->rp_state.error = false;
>      s->mbps = 0.0;
> +    s->pages_per_second = 0.0;
>      s->downtime = 0;
>      s->expected_downtime = 0;
>      s->setup_time = 0;
> @@ -2881,7 +2883,7 @@ static void migration_calculate_complete(MigrationState *s)
>  static void migration_update_counters(MigrationState *s,
>                                        int64_t current_time)
>  {
> -    uint64_t transferred, time_spent;
> +    uint64_t transferred, transferred_pages, time_spent;
>      uint64_t current_bytes; /* bytes transferred since the beginning */
>      double bandwidth;
>  
> @@ -2898,6 +2900,11 @@ static void migration_update_counters(MigrationState *s,
>      s->mbps = (((double) transferred * 8.0) /
>                 ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
>  
> +    transferred_pages = ram_get_total_transferred_pages() -
> +                            s->iteration_initial_pages;
> +    s->pages_per_second = (double) transferred_pages /
> +                             (((double) time_spent / 1000.0));
> +
>      /*
>       * if we haven't sent anything, we don't want to
>       * recalculate. 10000 is a small enough number for our purposes
> @@ -2910,6 +2917,7 @@ static void migration_update_counters(MigrationState *s,
>  
>      s->iteration_start_time = current_time;
>      s->iteration_initial_bytes = current_bytes;
> +    s->iteration_initial_pages = ram_get_total_transferred_pages();
>  
>      trace_migrate_transferred(transferred, time_spent,
>                                bandwidth, s->threshold_size);
> @@ -3314,6 +3322,7 @@ static void migration_instance_init(Object *obj)
>  
>      ms->state = MIGRATION_STATUS_NONE;
>      ms->mbps = -1;
> +    ms->pages_per_second = -1;
>      qemu_sem_init(&ms->pause_sem, 0);
>      qemu_mutex_init(&ms->error_mutex);
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index e413d4d8b6..810effc384 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -126,6 +126,12 @@ struct MigrationState
>       */
>      QemuSemaphore rate_limit_sem;
>  
> +    /* pages already send at the beggining of current interation */
> +    uint64_t iteration_initial_pages;
> +
> +    /* pages transferred per second */
> +    double pages_per_second;
> +
>      /* bytes already send at the beggining of current interation */
>      uint64_t iteration_initial_bytes;
>      /* time at the start of current iteration */
> @@ -271,6 +277,8 @@ bool migrate_use_block_incremental(void);
>  int migrate_max_cpu_throttle(void);
>  bool migrate_use_return_path(void);
>  
> +uint64_t ram_get_total_transferred_pages(void);
> +
>  bool migrate_use_compression(void);
>  int migrate_compress_level(void);
>  int migrate_compress_threads(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 7e7deec4d8..7e429b0502 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1593,6 +1593,12 @@ uint64_t ram_pagesize_summary(void)
>      return summary;
>  }
>  
> +uint64_t ram_get_total_transferred_pages(void)
> +{
> +    return  ram_counters.normal + ram_counters.duplicate +
> +                compression_counters.pages + xbzrle_counters.pages;
> +}
> +
>  static void migration_update_rates(RAMState *rs, int64_t end_time)
>  {
>      uint64_t page_count = rs->target_page_count - rs->target_page_count_prev;
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 31b589ec26..c5babd03b0 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -41,6 +41,9 @@
>  #
>  # @multifd-bytes: The number of bytes sent through multifd (since 3.0)
>  #
> +# @pages-per-second: the number of memory pages transferred per second
> +#        (Since 3.2)
> +#
>  # Since: 0.14.0
>  ##
>  { 'struct': 'MigrationStats',
> @@ -49,7 +52,7 @@
>             'normal-bytes': 'int', 'dirty-pages-rate' : 'int',
>             'mbps' : 'number', 'dirty-sync-count' : 'int',
>             'postcopy-requests' : 'int', 'page-size' : 'int',
> -           'multifd-bytes' : 'uint64' } }
> +           'multifd-bytes' : 'uint64', 'pages-per-second' : 'uint64' } }
>  
>  ##
>  # @XBZRLECacheStats:
> -- 
> 2.14.5
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
