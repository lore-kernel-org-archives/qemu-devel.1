Received: from eggs.gnu.org ([2001:4830:134:3::10]:32966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQ4BJ-0002lI-89
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 23:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQ4BG-0003lI-62
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 23:34:37 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:21758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQ4BF-0002IP-NH
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 23:34:34 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <5A31F445.6070504@intel.com>
	<201712150129.BFC35949.FFtFOLSOJOQHVM@I-love.SAKURA.ne.jp>
	<20171214181219.GA26124@bombadil.infradead.org>
	<201712160121.BEJ26052.HOFFOOQFMLtSVJ@I-love.SAKURA.ne.jp>
	<20171215202238-mutt-send-email-mst@kernel.org>
In-Reply-To: <20171215202238-mutt-send-email-mst@kernel.org>
Message-Id: <201712161331.ABI26579.OtOMFSOLHVFFQJ@I-love.SAKURA.ne.jp>
Date: Sat, 16 Dec 2017 13:31:24 +0900
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
To: mst@redhat.com
Cc: willy@infradead.org, wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com, nilal@redhat.com, riel@redhat.com

Michael S. Tsirkin wrote:
> On Sat, Dec 16, 2017 at 01:21:52AM +0900, Tetsuo Handa wrote:
> > My understanding is that virtio-balloon wants to handle sparsely spreaded
> > unsigned long values (which is PATCH 4/7) and wants to find all chunks of
> > consecutive "1" bits efficiently. Therefore, I guess that holding the values
> > in ascending order at store time is faster than sorting the values at read
> > time.
> 
> Are you asking why is a bitmap used here, as opposed to a tree?

No. I'm OK with "segments using trees" + "offsets using bitmaps".

>                                                                  It's
> not just store versus read. There's also the issue that memory can get
> highly fragmented, if it is, the number of 1s is potentially very high.
> A bitmap can use as little as 1 bit per value, it is hard to beat in
> this respect.
> 

I'm asking whether we really need to invent a new library module (i.e.
PATCH 1/7 + PATCH 2/7 + PATCH 3/7) for virtio-balloon compared to mine.

What virtio-balloon needs is ability to

  (1) record any integer value in [0, ULONG_MAX] range

  (2) fetch all recorded values, with consecutive values combined in
      min,max (or start,count) form for efficiently

and I wonder whether we need to invent complete API set which
Matthew Wilcox and Wei Wang are planning for generic purpose.
