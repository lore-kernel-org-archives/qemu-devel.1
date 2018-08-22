Received: from eggs.gnu.org ([2001:4830:134:3::10]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsLEV-0000Pa-CW
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsLER-0004mu-NY
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:59:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fsLER-0004lb-30
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:58:59 -0400
Date: Wed, 22 Aug 2018 12:58:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180822045849.GF3324@xz-x1>
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
	<20180821081029.26121-9-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821081029.26121-9-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v4 08/10] migration: fix calculating
 xbzrle_counters.cache_miss_rate
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

On Tue, Aug 21, 2018 at 04:10:27PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> As Peter pointed out:
> | - xbzrle_counters.cache_miss is done in save_xbzrle_page(), so it's
> |   per-guest-page granularity
> |
> | - RAMState.iterations is done for each ram_find_and_save_block(), so
> |   it's per-host-page granularity
> |
> | An example is that when we migrate a 2M huge page in the guest, we
> | will only increase the RAMState.iterations by 1 (since
> | ram_find_and_save_block() will be called once), but we might increase
> | xbzrle_counters.cache_miss for 2M/4K=512 times (we'll call
> | save_xbzrle_page() that many times) if all the pages got cache miss.
> | Then IMHO the cache miss rate will be 512/1=51200% (while it should
> | actually be just 100% cache miss).
> 
> And he also suggested as xbzrle_counters.cache_miss_rate is the only
> user of rs->iterations we can adapt it to count target guest page
> numbers
> 
> After that, rename 'iterations' to 'target_page_count' to better reflect
> its meaning
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
