Received: from eggs.gnu.org ([2001:4830:134:3::10]:43624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1daJV6-0005X3-07
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mhocko@kernel.org>) id 1daJV2-0002Pt-OQ
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:25:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:57629 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mhocko@kernel.org>) id 1daJV2-0002Ov-Dx
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:25:04 -0400
Date: Wed, 26 Jul 2017 12:24:58 +0200
From: Michal Hocko <mhocko@kernel.org>
Message-ID: <20170726102458.GH2981@dhcp22.suse.cz>
References: <20170719081311.GC26779@dhcp22.suse.cz>
	<596F4A0E.4010507@intel.com>
	<20170724090042.GF25221@dhcp22.suse.cz>
	<59771010.6080108@intel.com>
	<20170725112513.GD26723@dhcp22.suse.cz>
	<597731E8.9040803@intel.com>
	<20170725124141.GF26723@dhcp22.suse.cz>
	<286AC319A985734F985F78AFA26841F739283F62@shsmsx102.ccr.corp.intel.com>
	<20170725145333.GK26723@dhcp22.suse.cz>
	<5977FCDF.7040606@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5977FCDF.7040606@intel.com>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "david@redhat.com" <david@redhat.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "aarcange@redhat.com" <aarcange@redhat.com>, "amit.shah@redhat.com" <amit.shah@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu@aliyun.com" <quan.xu@aliyun.com>

On Wed 26-07-17 10:22:23, Wei Wang wrote:
> On 07/25/2017 10:53 PM, Michal Hocko wrote:
> >On Tue 25-07-17 14:47:16, Wang, Wei W wrote:
> >>On Tuesday, July 25, 2017 8:42 PM, hal Hocko wrote:
> >>>On Tue 25-07-17 19:56:24, Wei Wang wrote:
> >>>>On 07/25/2017 07:25 PM, Michal Hocko wrote:
> >>>>>On Tue 25-07-17 17:32:00, Wei Wang wrote:
> >>>>>>On 07/24/2017 05:00 PM, Michal Hocko wrote:
> >>>>>>>On Wed 19-07-17 20:01:18, Wei Wang wrote:
> >>>>>>>>On 07/19/2017 04:13 PM, Michal Hocko wrote:
> >>>>>>>[...
> >>>>We don't need to do the pfn walk in the guest kernel. When the API
> >>>>reports, for example, a 2MB free page block, the API caller offers to
> >>>>the hypervisor the base address of the page block, and size=2MB, to
> >>>>the hypervisor.
> >>>So you want to skip pfn walks by regularly calling into the page allocator to
> >>>update your bitmap. If that is the case then would an API that would allow you
> >>>to update your bitmap via a callback be s sufficient? Something like
> >>>	void walk_free_mem(int node, int min_order,
> >>>			void (*visit)(unsigned long pfn, unsigned long nr_pages))
> >>>
> >>>The function will call the given callback for each free memory block on the given
> >>>node starting from the given min_order. The callback will be strictly an atomic
> >>>and very light context. You can update your bitmap from there.
> >>I would need to introduce more about the background here:
> >>The hypervisor and the guest live in their own address space. The hypervisor's bitmap
> >>isn't seen by the guest. I think we also wouldn't be able to give a callback function
> >>from the hypervisor to the guest in this case.
> >How did you plan to use your original API which export struct page array
> >then?
> 
> 
> That's where the virtio-balloon driver comes in. It uses a shared ring
> mechanism to
> send the guest memory info to the hypervisor.
> 
> We didn't expose the struct page array from the guest to the hypervisor. For
> example, when
> a 2MB free page block is reported from the free page list, the info put on
> the ring is just
> (base address of the 2MB continuous memory, size=2M).

So what exactly prevents virtio-balloon from using the above proposed
callback mechanism and export what is needed to the hypervisor?
 
> >>>This would address my main concern that the allocator internals would get
> >>>outside of the allocator proper.
> >>What issue would it have to expose the internal, for_each_zone()?
> >zone is a MM internal concept. No code outside of the MM proper should
> >really care about zones.
> 
> I think this is also what Andrew suggested in the previous discussion:
> https://lkml.org/lkml/2017/3/16/951
> 
> Move the code to virtio-balloon and a little layering violation seems
> acceptable.

Andrew didn't suggest to expose zones to modules. If I read his words
properly he said that a functionality which "provides a snapshot of the
present system unused pages" is just too specific for virtio usecase
to be a generic function and as such it should be in virtio. I tend
to agree. Even the proposed callback API is a layer violation. We
should just make sure that the API is not inherently dangerous. That
is why I have chosen to give only pfn and nr_pages to the caller. Sure
somebody could argue that the caller could do pfn_to_page and do nasty
things. That would be a fair argument but nothing really prevents
anybody to do th pfn walk already so there shouldn't inherently more
risk. We can document what we expect from the API user and that would be
much easier to describe than struct page API IMHO.
-- 
Michal Hocko
SUSE Labs
