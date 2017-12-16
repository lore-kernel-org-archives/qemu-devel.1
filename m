Received: from eggs.gnu.org ([2001:4830:134:3::10]:54909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQAgF-0003U8-7D
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 06:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQAgC-0005CD-KQ
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 06:30:59 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:13847)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQAgC-0002hi-5O
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 06:30:56 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<20171215184256.GA27160@bombadil.infradead.org>
	<5A34F193.5040700@intel.com>
In-Reply-To: <5A34F193.5040700@intel.com>
Message-Id: <201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>
Date: Sat, 16 Dec 2017 20:28:04 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, willy@infradead.org
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Wei Wang wrote:
> On 12/16/2017 02:42 AM, Matthew Wilcox wrote:
> > On Tue, Dec 12, 2017 at 07:55:55PM +0800, Wei Wang wrote:
> >> +int xb_preload_and_set_bit(struct xb *xb, unsigned long bit, gfp_t gfp);
> > I'm struggling to understand when one would use this.  The xb_ API
> > requires you to handle your own locking.  But specifying GFP flags
> > here implies you can sleep.  So ... um ... there's no locking?
> 
> In the regular use cases, people would do xb_preload() before taking the 
> lock, and the xb_set/clear within the lock.
> 
> In the virtio-balloon usage, we have a large number of bits to set with 
> the balloon_lock being held (we're not unlocking for each bit), so we 
> used the above wrapper to do preload and set within the balloon_lock, 
> and passed in GFP_NOWAIT to avoid sleeping. Probably we can change to 
> put this wrapper implementation to virtio-balloon, since it would not be 
> useful for the regular cases.

GFP_NOWAIT is chosen in order not to try to OOM-kill something, isn't it?
But passing GFP_NOWAIT means that we can handle allocation failure. There is
no need to use preload approach when we can handle allocation failure.
