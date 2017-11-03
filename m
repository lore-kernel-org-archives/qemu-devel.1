Received: from eggs.gnu.org ([2001:4830:134:3::10]:52431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eAZiL-0007iy-7g
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eAZiF-0005I9-Pr
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:00:41 -0400
Received: from www262.sakura.ne.jp ([2001:e42:101:1:202:181:97:72]:11385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <penguin-kernel@I-love.SAKURA.ne.jp>)
	id 1eAZiF-0005Hk-BZ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 07:00:35 -0400
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <1509696786-1597-1-git-send-email-wei.w.wang@intel.com>
	<1509696786-1597-4-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1509696786-1597-4-git-send-email-wei.w.wang@intel.com>
Message-Id: <201711031959.CCC21876.tQFLHOOFVMJSFO@I-love.SAKURA.ne.jp>
Date: Fri, 3 Nov 2017 19:59:38 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Qemu-devel] [PATCH v17 3/6] mm/balloon_compaction.c: split
 balloon page allocation and enqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com
Cc: david@redhat.com, cornelia.huck@de.ibm.com, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, willy@infradead.org, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

Wei Wang wrote:
> Here's a detailed analysis of the deadlock by Tetsuo Handa:
> 
> In leak_balloon(), mutex_lock(&vb->balloon_lock) is called in order to
> serialize against fill_balloon(). But in fill_balloon(),
> alloc_page(GFP_HIGHUSER[_MOVABLE] | __GFP_NOMEMALLOC | __GFP_NORETRY) is
> called with vb->balloon_lock mutex held. Since GFP_HIGHUSER[_MOVABLE]
> implies __GFP_DIRECT_RECLAIM | __GFP_IO | __GFP_FS, despite __GFP_NORETRY
> is specified, this allocation attempt might indirectly depend on somebody
> else's __GFP_DIRECT_RECLAIM memory allocation. And such indirect
> __GFP_DIRECT_RECLAIM memory allocation might call leak_balloon() via
> virtballoon_oom_notify() via blocking_notifier_call_chain() callback via
> out_of_memory() when it reached __alloc_pages_may_oom() and held oom_lock
> mutex. Since vb->balloon_lock mutex is already held by fill_balloon(), it
> will cause OOM lockup. Thus, do not wait for vb->balloon_lock mutex if
> leak_balloon() is called from out_of_memory().

Please drop "Thus, do not wait for vb->balloon_lock mutex if leak_balloon()
is called from out_of_memory()." part. This is not what this patch will do.

> 
> Thread1                                Thread2
> fill_balloon()
>  takes a balloon_lock
>   balloon_page_enqueue()
>    alloc_page(GFP_HIGHUSER_MOVABLE)
>     direct reclaim (__GFP_FS context)  takes a fs lock
>      waits for that fs lock             alloc_page(GFP_NOFS)
>                                          __alloc_pages_may_oom()
>                                           takes the oom_lock
>                                            out_of_memory()
>                                             blocking_notifier_call_chain()
>                                              leak_balloon()
>                                                tries to take that
> 					       balloon_lock and deadlocks
