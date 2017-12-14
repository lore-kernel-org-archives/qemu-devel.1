Received: from eggs.gnu.org ([2001:4830:134:3::10]:59015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePSla-0002ht-EC
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1ePSlX-0004V9-9G
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:37:34 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:40364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1ePSlX-0004Ds-05
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:37:31 -0500
Date: Thu, 14 Dec 2017 04:37:01 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20171214123701.GA30288@bombadil.infradead.org>
References: <1513079759-14169-1-git-send-email-wei.w.wang@intel.com>
	<1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<201712122220.IFH05261.LtJOFFSFHVMQOO@I-love.SAKURA.ne.jp>
	<5A311C5E.7000304@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A311C5E.7000304@intel.com>
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
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

On Wed, Dec 13, 2017 at 08:26:06PM +0800, Wei Wang wrote:
> On 12/12/2017 09:20 PM, Tetsuo Handa wrote:
> > Can you eliminate exception path and fold all xbitmap patches into one, and
> > post only one xbitmap patch without virtio-baloon changes? If exception path
> > is valuable, you can add exception path after minimum version is merged.
> > This series is too difficult for me to close corner cases.
> 
> That exception path is claimed to save memory, and I don't have a strong
> reason to remove that part.
> Matthew, could we get your feedback on this?

Sure.  This code is derived from the IDA code in lib/idr.c.  Eventually,
I intend to reunite them.  For IDA, it clearly makes sense; the first 62
entries result in allocating no memory at all, which is going to be 99%
of users.  After that, we allocate 128 bytes which will serve the first
1024 users.

The xbitmap, as used by Wei's patches here is going to be used somewhat
differently from that.  I understand why Tetsuo wants the exceptional
path removed; I'm not sure the gains will be as important.  But if we're
going to rebuild the IDA on top of the xbitmap, we need to keep them.

I really want to pay more attention to this, but I need to focus on
getting the XArray finished.
