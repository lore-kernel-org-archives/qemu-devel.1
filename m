Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewS3i-0006Qw-E5
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ewS3f-0002bb-9V
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:32:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52278 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ewS3f-0002b7-48
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 08:32:35 -0400
Date: Thu, 15 Mar 2018 12:32:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180315123228.GH3062@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-9-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-9-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 8/8] migration: remove
 ram_save_compressed_page()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, quintela@redhat.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Now, we can reuse the path in ram_save_page() to post the page out
> as normal, then the only thing remained in ram_save_compressed_page()
> is compression that we can move it out to the caller
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Thanks, that does simplify stuff a lot in the end!

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/ram.c | 45 ++++++++-------------------------------------
>  1 file changed, 8 insertions(+), 37 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index f778627992..8f4f8aca86 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1162,41 +1162,6 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>      return pages;
>  }
>  
> -/**
> - * ram_save_compressed_page: compress the given page and send it to the stream
> - *
> - * Returns the number of pages written.
> - *
> - * @rs: current RAM state
> - * @block: block that contains the page we want to send
> - * @offset: offset inside the block for the page
> - * @last_stage: if we are at the completion stage
> - */
> -static int ram_save_compressed_page(RAMState *rs, PageSearchStatus *pss,
> -                                    bool last_stage)
> -{
> -    int pages = -1;
> -    uint8_t *p;
> -    RAMBlock *block = pss->block;
> -    ram_addr_t offset = pss->page << TARGET_PAGE_BITS;
> -
> -    p = block->host + offset;
> -
> -    if (block != rs->last_sent_block) {
> -        /*
> -         * Make sure the first page is sent out before other pages.
> -         *
> -         * we post it as normal page as compression will take much
> -         * CPU resource.
> -         */
> -        pages = save_normal_page(rs, block, offset, p, true);
> -    } else {
> -        pages = compress_page_with_multi_thread(rs, block, offset);
> -    }
> -
> -    return pages;
> -}
> -
>  /**
>   * find_dirty_block: find the next dirty page and update any state
>   * associated with the search process.
> @@ -1501,8 +1466,14 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>              goto page_saved;
>          }
>  
> -        if (save_page_use_compression(rs)) {
> -            res = ram_save_compressed_page(rs, pss, last_stage);
> +        /*
> +         * Make sure the first page is sent out before other pages.
> +         *
> +         * we post it as normal page as compression will take much
> +         * CPU resource.
> +         */
> +        if (block == rs->last_sent_block && save_page_use_compression(rs)) {
> +            res = compress_page_with_multi_thread(rs, block, offset);
>          } else {
>              res = ram_save_page(rs, pss, last_stage);
>          }
> -- 
> 2.14.3
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
