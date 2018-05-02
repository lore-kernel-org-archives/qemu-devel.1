Received: from eggs.gnu.org ([2001:4830:134:3::10]:57664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDhnZ-0007WZ-HM
	for qemu-devel@nongnu.org; Tue, 01 May 2018 22:47:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDhnW-000494-EE
	for qemu-devel@nongnu.org; Tue, 01 May 2018 22:47:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51584 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDhnW-00046r-8G
	for qemu-devel@nongnu.org; Tue, 01 May 2018 22:47:14 -0400
Date: Wed, 2 May 2018 10:46:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180502024653.GB25938@xz-mi>
References: <20180428081045.8878-1-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180428081045.8878-1-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH] migration: fix saving normal page even if
 it's been compressed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Sat, Apr 28, 2018 at 04:10:45PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Fix the bug introduced by da3f56cb2e767016 (migration: remove
> ram_save_compressed_page()), It should be 'return' rather than
> 'res'
> 
> Sorry for this stupid mistake :(
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

So is that only a performance degradation without this fix (since
AFAIU the compressing pages will be sent twice)?  Thanks,

> ---
>  migration/ram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 01cc815410..699546cc43 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1490,7 +1490,7 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss,
>       * CPU resource.
>       */
>      if (block == rs->last_sent_block && save_page_use_compression(rs)) {
> -        res = compress_page_with_multi_thread(rs, block, offset);
> +        return compress_page_with_multi_thread(rs, block, offset);
>      }
>  
>      return ram_save_page(rs, pss, last_stage);
> -- 
> 2.14.3
> 

-- 
Peter Xu
