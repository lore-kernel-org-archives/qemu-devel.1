Received: from eggs.gnu.org ([2001:4830:134:3::10]:46103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coURX-0005gS-U2
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coURW-0005Tj-Tp
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:23:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coURW-0005SQ-LI
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:23:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A4EB83F3F
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 12:23:46 +0000 (UTC)
Date: Thu, 16 Mar 2017 12:23:41 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316122340.GF2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-7-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/31] ram: Move num_dirty_pages_period
 into RAMState
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
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

(This series could be fewer patches...)

> ---
>  migration/ram.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 2d288cc..b13d2d5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -153,6 +153,8 @@ struct RAMState {
>      int64_t start_time;
>      /* bytes transferred at start_time */
>      int64_t bytes_xfer_prev;
> +    /* number of dirty pages since start_time */
> +    int64_t num_dirty_pages_period;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -599,7 +601,6 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
>  }
>  
>  /* Fix me: there are too many global variables used in migration process. */
> -static int64_t num_dirty_pages_period;
>  static uint64_t xbzrle_cache_miss_prev;
>  static uint64_t iterations_prev;
>  
> @@ -607,7 +608,7 @@ static void migration_bitmap_sync_init(RAMState *rs)
>  {
>      rs->start_time = 0;
>      rs->bytes_xfer_prev = 0;
> -    num_dirty_pages_period = 0;
> +    rs->num_dirty_pages_period = 0;
>      xbzrle_cache_miss_prev = 0;
>      iterations_prev = 0;
>  }
> @@ -660,7 +661,7 @@ static void migration_bitmap_sync(RAMState *rs)
>  
>      trace_migration_bitmap_sync_end(migration_dirty_pages
>                                      - num_dirty_pages_init);
> -    num_dirty_pages_period += migration_dirty_pages - num_dirty_pages_init;
> +    rs->num_dirty_pages_period += migration_dirty_pages - num_dirty_pages_init;
>      end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>  
>      /* more than 1 second = 1000 millisecons */
> @@ -674,7 +675,7 @@ static void migration_bitmap_sync(RAMState *rs)
>              bytes_xfer_now = ram_bytes_transferred();
>  
>              if (s->dirty_pages_rate &&
> -               (num_dirty_pages_period * TARGET_PAGE_SIZE >
> +               (rs->num_dirty_pages_period * TARGET_PAGE_SIZE >
>                     (bytes_xfer_now - rs->bytes_xfer_prev)/2) &&
>                 (rs->dirty_rate_high_cnt++ >= 2)) {
>                      trace_migration_throttle();
> @@ -694,11 +695,11 @@ static void migration_bitmap_sync(RAMState *rs)
>              iterations_prev = acct_info.iterations;
>              xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
>          }
> -        s->dirty_pages_rate = num_dirty_pages_period * 1000
> +        s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
>              / (end_time - rs->start_time);
>          s->dirty_bytes_rate = s->dirty_pages_rate * TARGET_PAGE_SIZE;
>          rs->start_time = end_time;
> -        num_dirty_pages_period = 0;
> +        rs->num_dirty_pages_period = 0;
>      }
>      s->dirty_sync_count = rs->bitmap_sync_count;
>      if (migrate_use_events()) {
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
