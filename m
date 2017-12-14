Received: from eggs.gnu.org ([2001:4830:134:3::10]:38906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePXzf-0000Yf-Tg
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePXzc-000063-Hb
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:12:27 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:37532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1ePXzc-00005E-8V
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 13:12:24 -0500
Date: Thu, 14 Dec 2017 10:12:19 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171214181219.GA26124@bombadil.infradead.org>
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
	<5A311C5E.7000304@intel.com>
	<201712132316.EJJ57332.MFOSJHOFFVLtQO@I-love.SAKURA.ne.jp>
	<5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
Subject: Re: [Qemu-devel] [PATCH v19 3/7] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Fri, Dec 15, 2017 at 01:29:45AM +0900, Tetsuo Handa wrote:
> > > Also, one more thing you need to check. Have you checked how long does
> > > xb_find_next_set_bit(xb, 0, ULONG_MAX) on an empty xbitmap takes?
> > > If it causes soft lockup warning, should we add cond_resched() ?
> > > If yes, you have to document that this API might sleep. If no, you
> > > have to document that the caller of this API is responsible for
> > > not to pass such a large value range.
> > 
> > Yes, that will take too long time. Probably we can document some 
> > comments as a reminder for the callers.
> 
> Then, I feel that API is poorly implemented. There is no need to brute-force
> when scanning [0, ULONG_MAX] range. If you eliminate exception path and
> redesign the data structure, xbitmap will become as simple as a sample
> implementation shown below. Not tested yet, but I think that this will be
> sufficient for what virtio-baloon wants to do; i.e. find consecutive "1" bits
> quickly. I didn't test whether finding "struct ulong_list_data" using radix
> tree can improve performance.

find_next_set_bit() is just badly implemented.  There is no need to
redesign the data structure.  It should be a simple matter of:

 - look at ->head, see it is NULL, return false.

If bit 100 is set and you call find_next_set_bit(101, ULONG_MAX), it
should look at block 0, see there is a pointer to it, scan the block,
see there are no bits set above 100, then realise we're at the end of
the tree and stop.

If bit 2000 is set, and you call find_next_set_bit(2001, ULONG_MAX)
tit should look at block 1, see there's no bit set after bit 2001, then
look at the other blocks in the node, see that all the pointers are NULL
and stop.

This isn't rocket science, we already do something like this in the radix
tree and it'll be even easier to do in the XArray.  Which I'm going back
to working on now.
