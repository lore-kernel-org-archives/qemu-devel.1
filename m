Received: from eggs.gnu.org ([2001:4830:134:3::10]:50303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT8Sn-0006DU-0A
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT8Sj-0002A5-BR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:17:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59842 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fT8Sj-00028Q-5r
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 12:17:33 -0400
Date: Wed, 13 Jun 2018 17:17:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180613161723.GL2676@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-5-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-5-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 04/12] migration: introduce
 migration_update_rates
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
> It is used to slightly clean the code up, no logic is changed

Actually, there is a slight change; iterations_prev is always updated
when previously it was only updated with xbzrle on; still the change
makes more sense.


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index dd1283dd45..ee03b28435 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1130,6 +1130,25 @@ uint64_t ram_pagesize_summary(void)
>      return summary;
>  }
>  
> +static void migration_update_rates(RAMState *rs, int64_t end_time)
> +{
> +    uint64_t iter_count = rs->iterations - rs->iterations_prev;
> +
> +    /* calculate period counters */
> +    ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
> +                / (end_time - rs->time_last_bitmap_sync);
> +
> +    if (!iter_count) {
> +        return;
> +    }
> +
> +    if (migrate_use_xbzrle()) {
> +        xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
> +            rs->xbzrle_cache_miss_prev) / iter_count;
> +        rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
> +    }
> +}
> +
>  static void migration_bitmap_sync(RAMState *rs)
>  {
>      RAMBlock *block;
> @@ -1159,9 +1178,6 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>      /* more than 1 second = 1000 millisecons */
>      if (end_time > rs->time_last_bitmap_sync + 1000) {
> -        /* calculate period counters */
> -        ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
> -            / (end_time - rs->time_last_bitmap_sync);
>          bytes_xfer_now = ram_counters.transferred;
>  
>          /* During block migration the auto-converge logic incorrectly detects
> @@ -1183,16 +1199,9 @@ static void migration_bitmap_sync(RAMState *rs)
>              }
>          }
>  
> -        if (migrate_use_xbzrle()) {
> -            if (rs->iterations_prev != rs->iterations) {
> -                xbzrle_counters.cache_miss_rate =
> -                   (double)(xbzrle_counters.cache_miss -
> -                            rs->xbzrle_cache_miss_prev) /
> -                   (rs->iterations - rs->iterations_prev);
> -                rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
> -            }
> -            rs->iterations_prev = rs->iterations;
> -        }
> +        migration_update_rates(rs, end_time);
> +
> +        rs->iterations_prev = rs->iterations;
>  
>          /* reset period counters */
>          rs->time_last_bitmap_sync = end_time;
> -- 
> 2.14.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
