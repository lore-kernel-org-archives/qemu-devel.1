Received: from eggs.gnu.org ([2001:4830:134:3::10]:51698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ea4V1-0006rM-Tj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:56:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ea4Uy-0002rl-2F
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:56:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ea4Ux-0002qv-RL
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 13:56:15 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5CD3A49E9
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 18:56:14 +0000 (UTC)
Date: Fri, 12 Jan 2018 18:56:05 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180112185604.GD2309@work-vm>
References: <20180110124723.11879-1-quintela@redhat.com>
	<20180110124723.11879-4-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180110124723.11879-4-quintela@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 03/14] migration: Drop current address
 parameter from save_zero_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

* Juan Quintela (quintela@redhat.com) wrote:
> It already has RAMBlock and offset, it can calculate it itself.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index cb1950f3eb..5a109efeda 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -907,11 +907,10 @@ static void migration_bitmap_sync(RAMState *rs)
>   * @rs: current RAM state
>   * @block: block that contains the page we want to send
>   * @offset: offset inside the block for the page
> - * @p: pointer to the page
>   */
> -static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset,
> -                          uint8_t *p)
> +static int save_zero_page(RAMState *rs, RAMBlock *block, ram_addr_t offset)
>  {
> +    uint8_t *p = block->host + offset;
>      int pages = -1;
>  
>      if (is_zero_range(p, TARGET_PAGE_SIZE)) {
> @@ -984,7 +983,7 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>              }
>          }
>      } else {
> -        pages = save_zero_page(rs, block, offset, p);
> +        pages = save_zero_page(rs, block, offset);
>          if (pages > 0) {
>              /* Must let xbzrle know, otherwise a previous (now 0'd) cached
>               * page would be stale
> @@ -1160,7 +1159,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>           */
>          if (block != rs->last_sent_block) {
>              flush_compressed_data(rs);
> -            pages = save_zero_page(rs, block, offset, p);
> +            pages = save_zero_page(rs, block, offset);
>              if (pages == -1) {
>                  /* Make sure the first page is sent out before other pages */
>                  bytes_xmit = save_page_header(rs, rs->f, block, offset |
> @@ -1180,7 +1179,7 @@ static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
>                  ram_release_pages(block->idstr, offset, pages);
>              }
>          } else {
> -            pages = save_zero_page(rs, block, offset, p);
> +            pages = save_zero_page(rs, block, offset);
>              if (pages == -1) {
>                  pages = compress_page_with_multi_thread(rs, block, offset);
>              } else {
> -- 
> 2.14.3
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
