Received: from eggs.gnu.org ([2001:4830:134:3::10]:45199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csSAu-0001pw-2p
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:47:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1csSAp-0006u8-UF
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:47:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1csSAp-0006tw-OY
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 06:46:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A62F081241
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 10:46:54 +0000 (UTC)
Date: Mon, 27 Mar 2017 18:46:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170327104650.GL11497@pxdev.xzpeter.org>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170323204544.12015-17-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/51] ram: Move iterations into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

On Thu, Mar 23, 2017 at 09:45:09PM +0100, Juan Quintela wrote:
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Another comment not directly related to this patch...

> ---
>  migration/ram.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 9fa3bd7..690ca8f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -170,6 +170,8 @@ struct RAMState {
>      uint64_t zero_pages;
>      /* number of normal transferred pages */
>      uint64_t norm_pages;
> +    /* Iterations since start */
> +    uint64_t iterations;
>  };
>  typedef struct RAMState RAMState;
>  
> @@ -177,7 +179,6 @@ static RAMState ram_state;
>  
>  /* accounting for migration statistics */
>  typedef struct AccountingInfo {
> -    uint64_t iterations;
>      uint64_t xbzrle_bytes;
>      uint64_t xbzrle_pages;
>      uint64_t xbzrle_cache_miss;
> @@ -693,13 +694,13 @@ static void migration_bitmap_sync(RAMState *rs)
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

Here we are calculating cache miss rate by xbzrle_cache_miss and
iterations. However looks like xbzrle_cache_miss is counted per guest
page (in save_xbzrle_page()) while the iteration count is per host
page (in ram_save_iterate()). Then, what if host page size not equals
to guest page size? E.g., when host uses 2M huge pages, host page size
is 2M, while guest page size can be 4K?

Thanks,

-- peterx
