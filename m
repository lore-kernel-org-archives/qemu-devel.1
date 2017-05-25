Received: from eggs.gnu.org ([2001:4830:134:3::10]:55322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDgpB-00064L-Hu
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:40:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dDgp8-0004Fm-Cq
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:40:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dDgp8-0004FQ-3v
	for qemu-devel@nongnu.org; Wed, 24 May 2017 20:40:18 -0400
Date: Thu, 25 May 2017 08:40:07 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170525004007.GP3873@pxdev.xzpeter.org>
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-3-git-send-email-felipe@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1495642203-12702-3-git-send-email-felipe@nutanix.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: set dirty_pages_rate before
 autoconverge logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Juan Quintela <quintela@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, May 24, 2017 at 05:10:01PM +0100, Felipe Franciosi wrote:
> Currently, a "period" in the RAM migration logic is at least a second
> long and accounts for what happened since the last period (or the
> beginning of the migration). The dirty_pages_rate counter is calculated
> at the end this logic.
> 
> If the auto convergence capability is enabled from the start of the
> migration, it won't be able to use this counter the first time around.
> This calculates dirty_pages_rate as soon as a period is deemed over,
> which allows for it to be used immediately.
> 
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

You fixed the indents as well, but imho it's okay.

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/ram.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 36bf720..495ecbe 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -694,6 +694,10 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>      /* more than 1 second = 1000 millisecons */
>      if (end_time > rs->time_last_bitmap_sync + 1000) {
> +        /* calculate period counters */
> +        rs->dirty_pages_rate = rs->num_dirty_pages_period * 1000
> +            / (end_time - rs->time_last_bitmap_sync);
> +
>          if (migrate_auto_converge()) {
>              /* The following detection logic can be refined later. For now:
>                 Check to see if the dirtied bytes is 50% more than the approx.
> @@ -702,15 +706,14 @@ static void migration_bitmap_sync(RAMState *rs)
>                 throttling */
>              bytes_xfer_now = ram_bytes_transferred();
>  
> -            if (rs->dirty_pages_rate &&
> -               (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
> +            if ((rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>                     (bytes_xfer_now - rs->bytes_xfer_prev) / 2) &&
> -               (rs->dirty_rate_high_cnt++ >= 2)) {
> +                (rs->dirty_rate_high_cnt++ >= 2)) {
>                      trace_migration_throttle();
>                      rs->dirty_rate_high_cnt = 0;
>                      mig_throttle_guest_down();
> -             }
> -             rs->bytes_xfer_prev = bytes_xfer_now;
> +            }
> +            rs->bytes_xfer_prev = bytes_xfer_now;
>          }
>  
>          if (migrate_use_xbzrle()) {
> @@ -723,8 +726,8 @@ static void migration_bitmap_sync(RAMState *rs)
>              rs->iterations_prev = rs->iterations;
>              rs->xbzrle_cache_miss_prev = rs->xbzrle_cache_miss;
>          }
> -        rs->dirty_pages_rate = rs->num_dirty_pages_period * 1000
> -            / (end_time - rs->time_last_bitmap_sync);
> +
> +        /* reset period counters */
>          rs->time_last_bitmap_sync = end_time;
>          rs->num_dirty_pages_period = 0;
>      }
> -- 
> 1.9.5
> 

-- 
Peter Xu
