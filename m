Received: from eggs.gnu.org ([2001:4830:134:3::10]:46713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cobgr-0007Ow-6V
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cobgm-0005WM-2t
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:08:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cobgl-0005WI-QK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 16:07:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E195B1E5E
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 20:07:59 +0000 (UTC)
Date: Thu, 16 Mar 2017 20:07:55 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170316200755.GQ2567@work-vm>
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-20-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315135021.6978-20-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 19/31] ram: move xbzrle_overflows into
 RAMState
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
> Once there, remove the now unused AccountingInfo struct and var.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 23a7317..75ad17f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -174,23 +174,13 @@ struct RAMState {
>      uint64_t xbzrle_cache_miss;
>      /* xbzrle miss rate */
>      double xbzrle_cache_miss_rate;
> +    /* xbzrle number of overflows */
> +    uint64_t xbzrle_overflows;
>  };
>  typedef struct RAMState RAMState;
>  
>  static RAMState ram_state;
>  
> -/* accounting for migration statistics */
> -typedef struct AccountingInfo {
> -    uint64_t xbzrle_overflows;
> -} AccountingInfo;
> -
> -static AccountingInfo acct_info;
> -
> -static void acct_clear(void)
> -{
> -    memset(&acct_info, 0, sizeof(acct_info));
> -}
> -
>  uint64_t dup_mig_pages_transferred(void)
>  {
>      return ram_state.zero_pages;
> @@ -223,7 +213,7 @@ double xbzrle_mig_cache_miss_rate(void)
>  
>  uint64_t xbzrle_mig_pages_overflow(void)
>  {
> -    return acct_info.xbzrle_overflows;
> +    return ram_state.xbzrle_overflows;
>  }

That's a bit naughty isn't it - I thought you were trying to get rid of all
the global accesses?

Dave

>  static QemuMutex migration_bitmap_mutex;
> @@ -510,7 +500,7 @@ static int save_xbzrle_page(QEMUFile *f, RAMState *rs, uint8_t **current_data,
>          return 0;
>      } else if (encoded_len == -1) {
>          trace_save_xbzrle_page_overflow();
> -        acct_info.xbzrle_overflows++;
> +        rs->xbzrle_overflows++;
>          /* update data in the cache */
>          if (!last_stage) {
>              memcpy(prev_cached_page, *current_data, TARGET_PAGE_SIZE);
> @@ -1936,6 +1926,7 @@ static int ram_save_init_globals(RAMState *rs)
>      rs->xbzrle_pages = 0;
>      rs->xbzrle_cache_miss = 0;
>      rs->xbzrle_cache_miss_rate = 0;
> +    rs->xbzrle_overflows = 0;
>      migration_bitmap_sync_init(rs);
>      qemu_mutex_init(&migration_bitmap_mutex);
>  
> @@ -1966,8 +1957,6 @@ static int ram_save_init_globals(RAMState *rs)
>              XBZRLE.encoded_buf = NULL;
>              return -1;
>          }
> -
> -        acct_clear();
>      }
>  
>      /* For memory_global_dirty_log_start below.  */
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
