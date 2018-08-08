Received: from eggs.gnu.org ([2001:4830:134:3::10]:46453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnGG5-0003LP-Ri
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:39:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnGG1-0002cn-Vk
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:39:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33682 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fnGG1-0002b8-Qj
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:39:37 -0400
Date: Wed, 8 Aug 2018 12:39:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180808043926.GE24415@xz-mi>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-6-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807091209.13531-6-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3 05/10] migration: move handle of zero
 page to the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Tue, Aug 07, 2018 at 05:12:04PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Detecting zero page is not a light work, moving it to the thread to
> speed the main thread up, btw, handling ram_release_pages() for the
> zero page is moved to the thread as well
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---

[...]

> @@ -2239,17 +2290,10 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>      }
>  
>      /*
> -     * Make sure the first page is sent out before other pages.
> -     *
> -     * we post it as normal page as compression will take much
> -     * CPU resource.
> +     * do not use multifd for compression as the first page in the new
> +     * block should be posted out before sending the compressed page
>       */
> -    if (block == rs->last_sent_block && save_page_use_compression(rs)) {
> -        res = compress_page_with_multi_thread(rs, block, offset);
> -        if (res > 0) {
> -            return res;
> -        }
> -    } else if (migrate_use_multifd()) {
> +    if (!save_page_use_compression(rs) && migrate_use_multifd()) {

Not related to this patch: I think we should just disallow user to
specify both compression and multifd together.  I vaguely remembered
that I left a comment somewhere in the multifd series but it must have
fallen throw the cracks...  Anyway it's not related to this patch:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

>          return ram_save_multifd_page(rs, block, offset);
>      }
>  
> -- 
> 2.14.4
> 

-- 
Peter Xu
