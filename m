Received: from eggs.gnu.org ([2001:4830:134:3::10]:47563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dX7tH-0001sH-8H
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dX7tG-0000xo-78
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:24:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:58141 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dX7tG-0000wv-0G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:24:54 -0400
Date: Mon, 17 Jul 2017 17:24:48 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170717152448.GN12888@dhcp22.suse.cz>
References: <1499863221-16206-1-git-send-email-wei.w.wang@intel.com>
	<1499863221-16206-7-git-send-email-wei.w.wang@intel.com>
	<20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714181523-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v12 6/8] mm: support reporting free page
 blocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Fri 14-07-17 22:17:13, Michael S. Tsirkin wrote:
> On Fri, Jul 14, 2017 at 02:30:23PM +0200, Michal Hocko wrote:
> > On Wed 12-07-17 20:40:19, Wei Wang wrote:
> > > This patch adds support for reporting blocks of pages on the free list
> > > specified by the caller.
> > > 
> > > As pages can leave the free list during this call or immediately
> > > afterwards, they are not guaranteed to be free after the function
> > > returns. The only guarantee this makes is that the page was on the free
> > > list at some point in time after the function has been invoked.
> > > 
> > > Therefore, it is not safe for caller to use any pages on the returned
> > > block or to discard data that is put there after the function returns.
> > > However, it is safe for caller to discard data that was in one of these
> > > pages before the function was invoked.
> > 
> > I do not understand what is the point of such a function and how it is
> > used because the patch doesn't give us any user (I haven't checked other
> > patches yet).
> > 
> > But just from the semantic point of view this sounds like a horrible
> > idea. The only way to get a free block of pages is to call the page
> > allocator. I am tempted to give it Nack right on those grounds but I
> > would like to hear more about what you actually want to achieve.
> 
> Basically it's a performance hint to the hypervisor.
> For example, these pages would be good candidates to
> move around as they are not mapped into any running
> applications.
>
> As such, it's important not to slow down other parts of the system too
> much - otherwise we are speeding up one part of the system while we slow
> down other parts of it, which is why it's trying to drop the lock as
> soon a possible.

So why cannot you simply allocate those page and then do whatever you
need. You can tell the page allocator to do only a lightweight
allocation by the gfp_mask - e.g. GFP_NOWAIT or if you even do not want
to risk kswapd intervening then 0 mask.

> As long as hypervisor does not assume it can drop these pages, and as
> long it's correct in most cases.  we are OK even if the hint is slightly
> wrong because hypervisor notifications are racing with allocations.

But the page could have been reused anytime after the lock is dropped
and you cannot check for that except for elevating the reference count.
-- 
Michal Hocko
SUSE Labs
