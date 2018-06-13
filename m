Received: from eggs.gnu.org ([2001:4830:134:3::10]:42864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT841-0005wZ-NL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT83x-0003Sv-Ao
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:52:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53050 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fT83x-0003S2-6C
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:51:57 -0400
Date: Wed, 13 Jun 2018 16:51:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180613155147.GJ2676@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-3-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-3-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 02/12] migration: fix counting normal page
 for compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> The compressed page is not normal page

Is this the right reason?
I think we always increment some counter for a page - so
what gets incremented for a compressed page?
Is the real answer that we do:

  ram_save_target_page
     control_save_page
     compress_page_with_multi_thread

and control_save_page already increments the counter?

Dave

> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 0caf32ab0a..dbf24d8c87 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1432,7 +1432,6 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>              qemu_cond_signal(&comp_param[idx].cond);
>              qemu_mutex_unlock(&comp_param[idx].mutex);
>              pages = 1;
> -            ram_counters.normal++;

>              ram_counters.transferred += bytes_xmit;
>              break;
>          }
> -- 
> 2.14.4
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
