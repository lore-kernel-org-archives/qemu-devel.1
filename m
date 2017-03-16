Received: from eggs.gnu.org ([2001:4830:134:3::10]:46361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coUSm-0006eJ-Cg
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:25:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1coUSi-0005fH-Df
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:25:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1coUSi-0005fC-7V
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 08:25:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44FEE7E9D3
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 12:25:00 +0000 (UTC)
Date: Thu, 16 Mar 2017 12:24:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316122455.GG2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-8-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/31] ram: Move xbzrle_cache_miss_prev
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
> ---
>  migration/ram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index b13d2d5..ae077c5 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -155,6 +155,8 @@ struct RAMState {
>      int64_t bytes_xfer_prev;
>      /* number of dirty pages since start_time */
>      int64_t num_dirty_pages_period;
> +    /* xbzrle misses since the beggining of the period */
                                    ^--- extra g

Other than that,
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> +    uint64_t xbzrle_cache_miss_prev;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -601,7 +603,6 @@ static void migration_bitmap_sync_range(ram_addr_t start, ram_addr_t length)
>  }
>  
>  /* Fix me: there are too many global variables used in migration process. */
> -static uint64_t xbzrle_cache_miss_prev;
>  static uint64_t iterations_prev;
>  
>  static void migration_bitmap_sync_init(RAMState *rs)
> @@ -609,7 +610,7 @@ static void migration_bitmap_sync_init(RAMState *rs)
>      rs->start_time = 0;
>      rs->bytes_xfer_prev = 0;
>      rs->num_dirty_pages_period = 0;
> -    xbzrle_cache_miss_prev = 0;
> +    rs->xbzrle_cache_miss_prev = 0;
>      iterations_prev = 0;
>  }
>  
> @@ -689,11 +690,11 @@ static void migration_bitmap_sync(RAMState *rs)
>              if (iterations_prev != acct_info.iterations) {
>                  acct_info.xbzrle_cache_miss_rate =
>                     (double)(acct_info.xbzrle_cache_miss -
> -                            xbzrle_cache_miss_prev) /
> +                            rs->xbzrle_cache_miss_prev) /
>                     (acct_info.iterations - iterations_prev);
>              }
>              iterations_prev = acct_info.iterations;
> -            xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
> +            rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
>          }
>          s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
>              / (end_time - rs->start_time);
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
