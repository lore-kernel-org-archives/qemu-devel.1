Received: from eggs.gnu.org ([2001:4830:134:3::10]:51821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1crME5-0004Az-Qz
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1crME0-000392-T3
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1crME0-00038u-NU
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 06:13:40 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D038B2E6040
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 10:13:40 +0000 (UTC)
Date: Fri, 24 Mar 2017 10:13:36 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170324101336.GD2901@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-19-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-19-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 18/51] ram: Move xbzrle_pages into RAMState
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
>  migration/ram.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 721fd66..b4e647a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -174,6 +174,8 @@ struct RAMState {
>      uint64_t iterations;
>      /* xbzrle transmitted bytes */
>      uint64_t xbzrle_bytes;
> +    /* xbzrle transmmited pages */
> +    uint64_t xbzrle_pages;

Yes, it might be useful to comment that the bytes are compressed bytes
while the pages are raw so it's not just a ratio.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>  };
>  typedef struct RAMState RAMState;
>  
> @@ -181,7 +183,6 @@ static RAMState ram_state;
>  
>  /* accounting for migration statistics */
>  typedef struct AccountingInfo {
> -    uint64_t xbzrle_pages;
>      uint64_t xbzrle_cache_miss;
>      double xbzrle_cache_miss_rate;
>      uint64_t xbzrle_overflows;
> @@ -211,7 +212,7 @@ uint64_t xbzrle_mig_bytes_transferred(void)
>  
>  uint64_t xbzrle_mig_pages_transferred(void)
>  {
> -    return acct_info.xbzrle_pages;
> +    return ram_state.xbzrle_pages;
>  }
>  
>  uint64_t xbzrle_mig_pages_cache_miss(void)
> @@ -544,7 +545,7 @@ static int save_xbzrle_page(RAMState *rs, QEMUFile *f, uint8_t **current_data,
>      qemu_put_be16(f, encoded_len);
>      qemu_put_buffer(f, XBZRLE.encoded_buf, encoded_len);
>      bytes_xbzrle += encoded_len + 1 + 2;
> -    acct_info.xbzrle_pages++;
> +    rs->xbzrle_pages++;
>      rs->xbzrle_bytes += bytes_xbzrle;
>      *bytes_transferred += bytes_xbzrle;
>  
> @@ -1997,6 +1998,7 @@ static int ram_save_init_globals(RAMState *rs)
>      rs->norm_pages = 0;
>      rs->iterations = 0;
>      rs->xbzrle_bytes = 0;
> +    rs->xbzrle_pages = 0;
>      migration_bitmap_sync_init(rs);
>      qemu_mutex_init(&migration_bitmap_mutex);
>  
> -- 
> 2.9.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
