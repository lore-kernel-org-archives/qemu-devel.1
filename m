Received: from eggs.gnu.org ([2001:4830:134:3::10]:52390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT8aF-00030o-1T
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:25:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT8aA-0004eN-7I
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:25:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54966 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fT8a9-0004c3-Kl
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:25:14 -0400
Date: Wed, 13 Jun 2018 17:25:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180613162508.GM2676@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-6-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-6-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 05/12] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Then the uses can adjust the parameters based on this info
> 
> Currently, it includes:
> pages: amount of pages compressed and transferred to the target VM
> busy: amount of count that no free thread to compress data
> busy-rate: rate of thread busy
> reduced-size: amount of bytes reduced by compression
> compression-rate: rate of compressed size
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  hmp.c                 | 13 +++++++++++++
>  migration/migration.c | 11 +++++++++++
>  migration/ram.c       | 37 +++++++++++++++++++++++++++++++++++++
>  migration/ram.h       |  1 +
>  qapi/migration.json   | 25 ++++++++++++++++++++++++-
>  5 files changed, 86 insertions(+), 1 deletion(-)
> 
> diff --git a/hmp.c b/hmp.c
> index ef93f4878b..5c2d3bd318 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -269,6 +269,19 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
>                         info->xbzrle_cache->overflow);
>      }
>  
> +    if (info->has_compression) {
> +        monitor_printf(mon, "compression pages: %" PRIu64 " pages\n",
> +                       info->compression->pages);
> +        monitor_printf(mon, "compression busy: %" PRIu64 "\n",
> +                       info->compression->busy);
> +        monitor_printf(mon, "compression busy rate: %0.2f\n",
> +                       info->compression->busy_rate);
> +        monitor_printf(mon, "compression reduced size: %" PRIu64 "\n",
> +                       info->compression->reduced_size);
> +        monitor_printf(mon, "compression rate: %0.2f\n",
> +                       info->compression->compression_rate);
> +    }
> +
>      if (info->has_cpu_throttle_percentage) {
>          monitor_printf(mon, "cpu throttle percentage: %" PRIu64 "\n",
>                         info->cpu_throttle_percentage);
> diff --git a/migration/migration.c b/migration/migration.c
> index 05aec2c905..bf7c63a5a2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -693,6 +693,17 @@ static void populate_ram_info(MigrationInfo *info, MigrationState *s)
>          info->xbzrle_cache->overflow = xbzrle_counters.overflow;
>      }
>  
> +    if (migrate_use_compression()) {
> +        info->has_compression = true;
> +        info->compression = g_malloc0(sizeof(*info->compression));
> +        info->compression->pages = compression_counters.pages;
> +        info->compression->busy = compression_counters.busy;
> +        info->compression->busy_rate = compression_counters.busy_rate;
> +        info->compression->reduced_size = compression_counters.reduced_size;
> +        info->compression->compression_rate =
> +                                    compression_counters.compression_rate;
> +    }
> +
>      if (cpu_throttle_active()) {
>          info->has_cpu_throttle_percentage = true;
>          info->cpu_throttle_percentage = cpu_throttle_get_percentage();
> diff --git a/migration/ram.c b/migration/ram.c
> index ee03b28435..80914b747e 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -292,6 +292,15 @@ struct RAMState {
>      uint64_t num_dirty_pages_period;
>      /* xbzrle misses since the beginning of the period */
>      uint64_t xbzrle_cache_miss_prev;
> +
> +    /* compression statistics since the beginning of the period */
> +    /* amount of count that no free thread to compress data */
> +    uint64_t compress_thread_busy_prev;
> +    /* amount bytes reduced by compression */
> +    uint64_t compress_reduced_size_prev;
> +    /* amount of compressed pages */
> +    uint64_t compress_pages_prev;
> +
>      /* number of iterations at the beginning of period */
>      uint64_t iterations_prev;
>      /* Iterations since start */
> @@ -329,6 +338,8 @@ struct PageSearchStatus {
>  };
>  typedef struct PageSearchStatus PageSearchStatus;
>  
> +CompressionStats compression_counters;
> +
>  struct CompressParam {
>      bool done;
>      bool quit;
> @@ -1147,6 +1158,24 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
>              rs->xbzrle_cache_miss_prev) / iter_count;
>          rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
>      }
> +
> +    if (migrate_use_compression()) {
> +        uint64_t comp_pages;
> +
> +        compression_counters.busy_rate = (double)(compression_counters.busy -
> +            rs->compress_thread_busy_prev) / iter_count;
> +        rs->compress_thread_busy_prev = compression_counters.busy;
> +
> +        comp_pages = compression_counters.pages - rs->compress_pages_prev;
> +        if (comp_pages) {
> +            compression_counters.compression_rate =
> +                (double)(compression_counters.reduced_size -
> +                rs->compress_reduced_size_prev) /
> +                (comp_pages * TARGET_PAGE_SIZE);
> +            rs->compress_pages_prev = compression_counters.pages;
> +            rs->compress_reduced_size_prev = compression_counters.reduced_size;
> +        }
> +    }
>  }
>  
>  static void migration_bitmap_sync(RAMState *rs)
> @@ -1412,6 +1441,9 @@ static void flush_compressed_data(RAMState *rs)
>          qemu_mutex_lock(&comp_param[idx].mutex);
>          if (!comp_param[idx].quit) {
>              len = qemu_put_qemu_file(rs->f, comp_param[idx].file);
> +            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> +            compression_counters.reduced_size += TARGET_PAGE_SIZE - len + 8;

I think I'd rather save just len+8 rather than than the subtraction.

I think other than that, and Eric's comments, it's OK.

Dave

> +            compression_counters.pages++;
>              ram_counters.transferred += len;
>          }
>          qemu_mutex_unlock(&comp_param[idx].mutex);
> @@ -1441,6 +1473,10 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>              qemu_cond_signal(&comp_param[idx].cond);
>              qemu_mutex_unlock(&comp_param[idx].mutex);
>              pages = 1;
> +            /* 8 means a header with RAM_SAVE_FLAG_CONTINUE. */
> +            compression_counters.reduced_size += TARGET_PAGE_SIZE -
> +                                                 bytes_xmit + 8;
> +            compression_counters.pages++;
>              ram_counters.transferred += bytes_xmit;
>              break;
>          }
> @@ -1760,6 +1796,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>          if (res > 0) {
>              return res;
>          }
> +        compression_counters.busy++;
>      }
>  
>      return ram_save_page(rs, pss, last_stage);
> diff --git a/migration/ram.h b/migration/ram.h
> index d386f4d641..7b009b23e5 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -36,6 +36,7 @@
>  
>  extern MigrationStats ram_counters;
>  extern XBZRLECacheStats xbzrle_counters;
> +extern CompressionStats compression_counters;
>  
>  int xbzrle_cache_resize(int64_t new_size, Error **errp);
>  uint64_t ram_bytes_remaining(void);
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 3ec418dabf..a11987cdc4 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -72,6 +72,26 @@
>             'cache-miss': 'int', 'cache-miss-rate': 'number',
>             'overflow': 'int' } }
>  
> +##
> +# @CompressionStats:
> +#
> +# Detailed compression migration statistics
> +#
> +# @pages: amount of pages compressed and transferred to the target VM
> +#
> +# @busy: amount of count that no free thread to compress data
> +#
> +# @busy-rate: rate of thread busy
> +#
> +# @reduced-size: amount of bytes reduced by compression
> +#
> +# @compression-rate: rate of compressed size
> +#
> +##
> +{ 'struct': 'CompressionStats',
> +  'data': {'pages': 'int', 'busy': 'int', 'busy-rate': 'number',
> +	   'reduced-size': 'int', 'compression-rate': 'number' } }
> +
>  ##
>  # @MigrationStatus:
>  #
> @@ -169,6 +189,8 @@
>  #           only present when the postcopy-blocktime migration capability
>  #           is enabled. (Since 2.13)
>  #
> +# @compression: compression migration statistics, only returned if compression
> +#           feature is on and status is 'active' or 'completed' (Since 2.14)
>  #
>  # Since: 0.14.0
>  ##
> @@ -183,7 +205,8 @@
>             '*cpu-throttle-percentage': 'int',
>             '*error-desc': 'str',
>             '*postcopy-blocktime' : 'uint32',
> -           '*postcopy-vcpu-blocktime': ['uint32']} }
> +           '*postcopy-vcpu-blocktime': ['uint32'],
> +           '*compression': 'CompressionStats'} }
>  
>  ##
>  # @query-migrate:
> -- 
> 2.14.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
