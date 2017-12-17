Received: from eggs.gnu.org ([2001:4830:134:3::10]:33592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQW7X-0000IX-TQ
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 05:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQW7U-00044S-Oq
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 05:24:35 -0500
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:39738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eQW7U-0002lJ-9X
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 05:24:32 -0500
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1513079759-14169-4-git-send-email-wei.w.wang@intel.com>
	<20171215184256.GA27160@bombadil.infradead.org>
	<5A34F193.5040700@intel.com>
	<201712162028.FEB87079.FOJFMQHVOSLtFO@I-love.SAKURA.ne.jp>
	<5A35FF89.8040500@intel.com>
In-Reply-To: <5A35FF89.8040500@intel.com>
Message-Id: <201712171921.IBB30790.VOOOFMQHFSLFJt@I-love.SAKURA.ne.jp>
Date: Sun, 17 Dec 2017 19:21:35 +0900
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
> > But passing GFP_NOWAIT means that we can handle allocation failure. There is
> > no need to use preload approach when we can handle allocation failure.
> 
> I think the reason we need xb_preload is because radix tree insertion 
> needs the memory being preallocated already (it couldn't suffer from 
> memory failure during the process of inserting, probably because 
> handling the failure there isn't easy, Matthew may know the backstory of 
> this)

According to https://lwn.net/Articles/175432/ , I think that preloading is needed
only when failure to insert an item into a radix tree is a significant problem.
That is, when failure to insert an item into a radix tree is not a problem,
I think that we don't need to use preloading.

> 
> So, I think we can handle the memory failure with xb_preload, which 
> stops going into the radix tree APIs, but shouldn't call radix tree APIs 
> without the related memory preallocated.

It seems to me that virtio-ballon case has no problem without using preloading.
