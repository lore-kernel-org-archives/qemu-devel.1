Received: from eggs.gnu.org ([2001:4830:134:3::10]:57097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctHAm-0001kw-HE
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:14:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ctHAi-0002xA-Dh
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:14:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ctHAi-0002x0-84
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 13:14:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 53C2CC208095
	for <qemu-devel@nongnu.org>; Wed, 29 Mar 2017 17:14:11 +0000 (UTC)
Date: Wed, 29 Mar 2017 18:14:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170329171407.GE2501@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-24-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-24-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 23/51] ram: Everything was init to zero,
 so use memset
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
> And then init only things that are not zero by default.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index c6ba92c..a890179 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -611,15 +611,6 @@ static void migration_bitmap_sync_range(RAMState *rs, ram_addr_t start,
>                                                &rs->num_dirty_pages_period);
>  }
>  
> -static void migration_bitmap_sync_init(RAMState *rs)
> -{
> -    rs->start_time = 0;
> -    rs->bytes_xfer_prev = 0;
> -    rs->num_dirty_pages_period = 0;
> -    rs->xbzrle_cache_miss_prev = 0;
> -    rs->iterations_prev = 0;
> -}
> -
>  /**
>   * ram_pagesize_summary: calculate all the pagesizes of a VM
>   *
> @@ -1984,21 +1975,11 @@ err:
>      return ret;
>  }
>  
> -static int ram_save_init_globals(RAMState *rs)
> +static int ram_state_init(RAMState *rs)
>  {
>      int64_t ram_bitmap_pages; /* Size of bitmap in pages, including gaps */
>  
> -    rs->dirty_rate_high_cnt = 0;
> -    rs->bitmap_sync_count = 0;
> -    rs->zero_pages = 0;
> -    rs->norm_pages = 0;
> -    rs->iterations = 0;
> -    rs->xbzrle_bytes = 0;
> -    rs->xbzrle_pages = 0;
> -    rs->xbzrle_cache_miss = 0;
> -    rs->xbzrle_cache_miss_rate = 0;
> -    rs->xbzrle_overflows = 0;
> -    migration_bitmap_sync_init(rs);
> +    memset(rs, 0, sizeof(*rs));
>      qemu_mutex_init(&migration_bitmap_mutex);
>  
>      if (migrate_use_xbzrle()) {
> @@ -2088,7 +2069,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>  
>      /* migration has already setup the bitmap, reuse it. */
>      if (!migration_in_colo_state()) {
> -        if (ram_save_init_globals(rs) < 0) {
> +        if (ram_state_init(rs) < 0) {
>              return -1;
>           }
>      }
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
