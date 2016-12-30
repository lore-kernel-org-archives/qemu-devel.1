Received: from eggs.gnu.org ([2001:4830:134:3::10]:39448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMtL5-0001d1-5B
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 04:19:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMtL1-0007HC-VJ
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 04:19:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37788)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMtL1-0007GJ-Lk
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 04:18:59 -0500
Date: Fri, 30 Dec 2016 17:18:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161230091300.GD4195@pxdev.xzpeter.org>
References: <A2975661238FB949B60364EF0F2C257438FEF883@shsmsx102.ccr.corp.intel.com>
	<20161229095533.GA4195@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257438FEF97F@shsmsx102.ccr.corp.intel.com>
	<20161230034343.GC4195@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257438FEFB52@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257438FEFB52@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 11/13] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'bd.aviv@gmail.com'" <bd.aviv@gmail.com>

On Fri, Dec 30, 2016 at 04:39:49AM +0000, Liu, Yi L wrote:
> > -----Original Message-----
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, December 30, 2016 11:44 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Cc: Tian, Kevin <kevin.tian@intel.com>; Lan, Tianyu <tianyu.lan@intel.com>; 'qemu-
> > devel@nongnu.org' <qemu-devel@nongnu.org>; 'bd.aviv@gmail.com'
> > <bd.aviv@gmail.com>
> > Subject: Re: [Qemu-devel] [RFC PATCH 11/13] intel_iommu: provide its own replay()
> > callback
> > 
> > On Thu, Dec 29, 2016 at 10:23:21AM +0000, Liu, Yi L wrote:
> > 
> > [...]
> > 
> > > > >
> > > > > Hereby, I have a minor concern on this part.
> > > > > The replay would be performed in vfio_listener_region_add() when device is
> > > > > assigned. Since guest is just started, so there will be no valid context entry for
> > the
> > > > > assigned device. So there will be no vtd_page_walk. Thus no change to SL page
> > > > > table in host. The SL page table would still be a IOVA->HPA mapping. It's true
> > > > > that the gIOVA->HPA mapping can be built by page map/unmap when guest
> > > > > trying to issue dma. So it is just ok without relpay in the beginning. Hot plug
> > should
> > > > > be all the same. I guess it is the design here?
> > > >
> > > > I am not sure whether I get your point here - I think it's by design.
> > > > We don't really need replay if we are sure that the IOMMU address
> > > > space has totally no mapping (i.e., when the guest init). Replay is
> > > > only useful when there are existing mappings in the IOMMU address
> > > > space.
> > > yes, if we are sure no existing mapping, it is ok. There is another case which may
> > > complain it. If a device is hotplug in, then there should be existing mapping. Just
> > > looked code again. If corresponding context entry is not present, the
> > > vtd_page_walk should be bypassed.
> > 
> > Yes, if the context entry is not present, the replay will be bypassed.
> > And if it exists, then the replay will work (along with the page walk
> > process). Shouldn't that the behavior we want?
> > 
> > Please clarify if I misunderstood your question.
> I was just assuming a replay should be performed when a new device is plug in.
> However, according to your statements, it is not required. Is this the conclusion in
> the previous discussion?

Hmm, I mean whether the replay is needed for the hotplugged device
should depend on which iommu domain it joins when it is plugged. I
think it should belong to nowhere when plugged but I am not quite
sure... IIUC that'll depend on whether the context entry of that
plugged device is valid - and I think it should be an invalid one.

> 
> > [...]
> > 
> > > > >
> > > > > However, it may be incompatible with a future work in which we expose an
> > > > > vIOMMU to guest but guest disable IOVA usage. In this scenario, the SL page
> > > > > table in host would be a GPA->HPA instead of a gIOVA->HPA mapping. It would
> > > > > rely on memory_replay to build a GPA->HPA mapping. If I'm correct, I think it
> > > > > would be expected to have a replay in the time device is assigned.
> > > >
> > > > If you need a GPA -> HPA mapping (AFAICT you mean virtualized SVM and
> > > > the so-called first level translation), IMHO the default mapping
> > > > behavior of vfio_listener_region_add() suites here (when
> > > > memory_region_is_iommu(section->mr) == false), which maps the whole
> > > > guest physical address space, just like the case when we use vfio
> > > > devices without vIOMMU.
> > > Yes, I mean SVM virtualizaion. To virtualize SVM, an vIOMMU would be exposed to
> > > guest. So memory_region_is_iommu(section->mr) would be true. Then, the
> > original
> > > mapping the whole guest physical address space would not run. Thus no GPA->HPA
> > > mapping would be built. This is what I really concern here.
> > 
> > What I meant above was, we might be able to leverage existing
> > no-viommu logic to build the SLPT for virtualized SVM. For example, we
> > can switch the if block from:
> > 
> >   if (memory_region_is_iommu(section->mr))
> > 
> > into something similiar like:
> > 
> >   if (memory_region_is_iommu(section->mr) &&
> >       !FIRST_LEVEL_TRANSLATION_ENABLED(section->mr))
> > 
> > Just a quick thought, not sure whether that would be an applicable
> > idea. Thanks,
> If I remember correctly, with vIOMMU exposed, section->mr here should
> not be a ram, the logic would fail in the following code. I agree with you
> that map the whole guest physical address space should work with SVM
> virtualization. May need to think more on how to make it happen.
> 
> hw/i386/common.c, a snippet:
>     /* Here we assume that memory_region_is_ram(section->mr)==true */
> 
>     vaddr = memory_region_get_ram_ptr(section->mr) +
>             section->offset_within_region +
>             (iova - section->offset_within_address_space);

Right. That code won't work if only with a change in the if() clause -
I wasn't showing any workable codes (even it's not pesudo), only to
show what I meant. :)

-- peterx
