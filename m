Received: from eggs.gnu.org ([2001:4830:134:3::10]:57472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dZz9r-0002QE-S0
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:41:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1dZz9n-00021M-Sx
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:41:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:33915 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1dZz9n-00020a-HN
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 08:41:47 -0400
Date: Tue, 25 Jul 2017 14:41:42 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170725124141.GF26723@dhcp22.suse.cz>
References: <20170714123023.GA2624@dhcp22.suse.cz>
	<20170714181523-mutt-send-email-mst@kernel.org>
	<20170717152448.GN12888@dhcp22.suse.cz>
	<596D6E7E.4070700@intel.com>
	<20170719081311.GC26779@dhcp22.suse.cz>
	<596F4A0E.4010507@intel.com>
	<20170724090042.GF25221@dhcp22.suse.cz>
	<59771010.6080108@intel.com>
	<20170725112513.GD26723@dhcp22.suse.cz>
	<597731E8.9040803@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597731E8.9040803@intel.com>
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
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, virtio-dev@lists.oasis-open.org, yang.zhang.wz@gmail.com, quan.xu@aliyun.com

On Tue 25-07-17 19:56:24, Wei Wang wrote:
> On 07/25/2017 07:25 PM, Michal Hocko wrote:
> >On Tue 25-07-17 17:32:00, Wei Wang wrote:
> >>On 07/24/2017 05:00 PM, Michal Hocko wrote:
> >>>On Wed 19-07-17 20:01:18, Wei Wang wrote:
> >>>>On 07/19/2017 04:13 PM, Michal Hocko wrote:
> >>>[...
> >>>>>All you should need is the check for the page reference count, no?  I
> >>>>>assume you do some sort of pfn walk and so you should be able to get an
> >>>>>access to the struct page.
> >>>>Not necessarily - the guest struct page is not seen by the hypervisor. The
> >>>>hypervisor only gets those guest pfns which are hinted as unused. From the
> >>>>hypervisor (host) point of view, a guest physical address corresponds to a
> >>>>virtual address of a host process. So, once the hypervisor knows a guest
> >>>>physical page is unsued, it knows that the corresponding virtual memory of
> >>>>the process doesn't need to be transferred in the 1st round.
> >>>I am sorry, but I do not understand. Why cannot _guest_ simply check the
> >>>struct page ref count and send them to the hypervisor?
> >>Were you suggesting the following?
> >>1) get a free page block from the page list using the API;
> >No. Use a pfn walk, check the reference count and skip those pages which
> >have 0 ref count.
> 
> 
> "pfn walk" - do you mean start from the first pfn, and scan all the pfns
> that the VM has?

yes

> >I suspected that you need to do some sort of the pfn
> >walk anyway because you somehow have to evaluate a memory to migrate,
> >right?
> 
> We don't need to do the pfn walk in the guest kernel. When the API
> reports, for example, a 2MB free page block, the API caller offers to
> the hypervisor the base address of the page block, and size=2MB, to
> the hypervisor.

So you want to skip pfn walks by regularly calling into the page
allocator to update your bitmap. If that is the case then would an API
that would allow you to update your bitmap via a callback be s
sufficient? Something like
	void walk_free_mem(int node, int min_order,
			void (*visit)(unsigned long pfn, unsigned long nr_pages))

The function will call the given callback for each free memory block on
the given node starting from the given min_order. The callback will be
strictly an atomic and very light context. You can update your bitmap
from there.

This would address my main concern that the allocator internals would
get outside of the allocator proper. A nasty callback which would be too
expensive could still stall other allocations and cause latencies but
the locking will be under mm core control at least.

Does that sound useful?
-- 
Michal Hocko
SUSE Labs
