Received: from eggs.gnu.org ([2001:4830:134:3::10]:45762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cobds-0004Vd-UV
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cobdn-0004DP-W1
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:05:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44614)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cobdn-0004DC-O4
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:04:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97D4A342C7C
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 20:04:55 +0000 (UTC)
Date: Thu, 16 Mar 2017 20:04:51 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316200450.GP2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-15-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-15-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/31] ram: Move iterations into RAMState
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
>  migration/ram.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 8caeb4f..234bdba 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -164,6 +164,8 @@ struct RAMState {
>      uint64_t zero_pages;
>      /* number of normal transferred pages */
>      uint64_t norm_pages;
> +    /* Iterations since start */
> +    uint64_t iterations;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -171,7 +173,6 @@ static RAMState ram_state;
>  
>  /* accounting for migration statistics */
>  typedef struct AccountingInfo {
> -    uint64_t iterations;
>      uint64_t xbzrle_bytes;
>      uint64_t xbzrle_pages;
>      uint64_t xbzrle_cache_miss;
> @@ -668,13 +669,13 @@ static void migration_bitmap_sync(RAMState *rs)
>          }
>  
>          if (migrate_use_xbzrle()) {
> -            if (rs->iterations_prev != acct_info.iterations) {
> +            if (rs->iterations_prev != rs->iterations) {
>                  acct_info.xbzrle_cache_miss_rate =
>                     (double)(acct_info.xbzrle_cache_miss -
>                              rs->xbzrle_cache_miss_prev) /
> -                   (acct_info.iterations - rs->iterations_prev);
> +                   (rs->iterations - rs->iterations_prev);
>              }
> -            rs->iterations_prev = acct_info.iterations;
> +            rs->iterations_prev = rs->iterations;
>              rs->xbzrle_cache_miss_prev = acct_info.xbzrle_cache_miss;
>          }
>          s->dirty_pages_rate = rs->num_dirty_pages_period * 1000
> @@ -1926,6 +1927,7 @@ static int ram_save_init_globals(RAMState *rs)
>      rs->bitmap_sync_count = 0;
>      rs->zero_pages = 0;
>      rs->norm_pages = 0;
> +    rs->iterations = 0;
>      migration_bitmap_sync_init(rs);
>      qemu_mutex_init(&migration_bitmap_mutex);
>  
> @@ -2066,7 +2068,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>              done = 1;
>              break;
>          }
> -        acct_info.iterations++;
> +        rs->iterations++;
>  
>          /* we want to check in the 1st loop, just in case it was the 1st time
>             and we had to sync the dirty bitmap.
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
