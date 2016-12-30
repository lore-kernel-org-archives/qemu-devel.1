Received: from eggs.gnu.org ([2001:4830:134:3::10]:44743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMo6l-00046y-RG
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 22:43:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cMo6i-0007ke-Ol
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 22:43:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cMo6i-0007kB-G5
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 22:43:52 -0500
Date: Fri, 30 Dec 2016 11:43:43 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161230034343.GC4195@pxdev.xzpeter.org>
References: <A2975661238FB949B60364EF0F2C257438FEF883@shsmsx102.ccr.corp.intel.com>
	<20161229095533.GA4195@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C257438FEF97F@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257438FEF97F@shsmsx102.ccr.corp.intel.com>
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

On Thu, Dec 29, 2016 at 10:23:21AM +0000, Liu, Yi L wrote:

[...]

> > >
> > > Hereby, I have a minor concern on this part.
> > > The replay would be performed in vfio_listener_region_add() when device is
> > > assigned. Since guest is just started, so there will be no valid context entry for the
> > > assigned device. So there will be no vtd_page_walk. Thus no change to SL page
> > > table in host. The SL page table would still be a IOVA->HPA mapping. It's true
> > > that the gIOVA->HPA mapping can be built by page map/unmap when guest
> > > trying to issue dma. So it is just ok without relpay in the beginning. Hot plug should
> > > be all the same. I guess it is the design here?
> > 
> > I am not sure whether I get your point here - I think it's by design.
> > We don't really need replay if we are sure that the IOMMU address
> > space has totally no mapping (i.e., when the guest init). Replay is
> > only useful when there are existing mappings in the IOMMU address
> > space.
> yes, if we are sure no existing mapping, it is ok. There is another case which may
> complain it. If a device is hotplug in, then there should be existing mapping. Just
> looked code again. If corresponding context entry is not present, the
> vtd_page_walk should be bypassed.

Yes, if the context entry is not present, the replay will be bypassed.
And if it exists, then the replay will work (along with the page walk
process). Shouldn't that the behavior we want?

Please clarify if I misunderstood your question.

[...]

> > >
> > > However, it may be incompatible with a future work in which we expose an
> > > vIOMMU to guest but guest disable IOVA usage. In this scenario, the SL page
> > > table in host would be a GPA->HPA instead of a gIOVA->HPA mapping. It would
> > > rely on memory_replay to build a GPA->HPA mapping. If I'm correct, I think it
> > > would be expected to have a replay in the time device is assigned.
> > 
> > If you need a GPA -> HPA mapping (AFAICT you mean virtualized SVM and
> > the so-called first level translation), IMHO the default mapping
> > behavior of vfio_listener_region_add() suites here (when
> > memory_region_is_iommu(section->mr) == false), which maps the whole
> > guest physical address space, just like the case when we use vfio
> > devices without vIOMMU.
> Yes, I mean SVM virtualizaion. To virtualize SVM, an vIOMMU would be exposed to
> guest. So memory_region_is_iommu(section->mr) would be true. Then, the original
> mapping the whole guest physical address space would not run. Thus no GPA->HPA
> mapping would be built. This is what I really concern here.

What I meant above was, we might be able to leverage existing
no-viommu logic to build the SLPT for virtualized SVM. For example, we
can switch the if block from:

  if (memory_region_is_iommu(section->mr))

into something similiar like:

  if (memory_region_is_iommu(section->mr) &&
      !FIRST_LEVEL_TRANSLATION_ENABLED(section->mr))

Just a quick thought, not sure whether that would be an applicable
idea. Thanks,

-- peterx
