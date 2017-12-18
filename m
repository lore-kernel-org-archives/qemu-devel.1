Received: from eggs.gnu.org ([2001:4830:134:3::10]:36058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eQleX-0000BL-NO
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eQleT-0001wj-7G
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:59:41 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:37401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eQleS-0001w6-VR
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 21:59:37 -0500
Date: Sun, 17 Dec 2017 18:59:27 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171218025927.GB6683@bombadil.infradead.org>
References: <201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215184915.GB27160@bombadil.infradead.org>
	<20171215192203.GC27160@bombadil.infradead.org>
	<286AC319A985734F985F78AFA26841F739387C1D@shsmsx102.ccr.corp.intel.com>
	<20171217221842.GA6683@bombadil.infradead.org>
	<5A3728DC.3060509@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A3728DC.3060509@intel.com>
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mst@redhat.com" <mst@redhat.com>, "mhocko@kernel.org" <mhocko@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mawilcox@microsoft.com" <mawilcox@microsoft.com>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>, "nilal@redhat.com" <nilal@redhat.com>, "riel@redhat.com" <riel@redhat.com>

On Mon, Dec 18, 2017 at 10:33:00AM +0800, Wei Wang wrote:
> > My only qualm is that I've been considering optimising the memory
> > consumption when an entire 1024-bit chunk is full; instead of keeping a
> > pointer to a 128-byte entry full of ones, store a special value in the
> > radix tree which means "every bit is set".
> > 
> > The downside is that we then have to pass GFP flags to xbit_clear() and
> > xbit_zero(), and they can fail.  It's not clear to me whether that's a
> > good tradeoff.
> 
> Yes, this will sacrifice performance. In many usages, users may set bits one
> by one, and each time when a bit is set, it needs to scan the whole
> ida_bitmap to see if all other bits are set, if so, it can free the
> ida_bitmap. I think this extra scanning of the ida_bitmap would add a lot
> overhead.

Not a huge amount of overhead.  An ida_bitmap is only two cachelines,
and the loop is simply 'check each word against ~0ul', so up to 16
load/test/loop instructions.  Plus we have to do that anyway to maintain
the free tag for IDAs.

> > But I need to get the XArray (which replaces the radix tree) finished first.
> 
> OK. It seems the new implementation wouldn't be done shortly.
> Other parts of this patch series are close to the end of review, and we hope
> to make some progress soon. Would it be acceptable that we continue with the
> basic xb_ implementation (e.g. as xbitmap 1.0) for this patch series? and
> xbit_ implementation can come as xbitmap 2.0 in the future?

Yes, absolutely, I don't want to hold you up behind the XArray.
