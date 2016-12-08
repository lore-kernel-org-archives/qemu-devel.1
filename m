Received: from eggs.gnu.org ([2001:4830:134:3::10]:47073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEocw-0003q9-Hd
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:40:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEoct-0001xg-Es
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:40:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cEoct-0001xN-5n
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 21:40:03 -0500
Date: Thu, 8 Dec 2016 10:39:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161208023849.GF28693@pxdev.xzpeter.org>
References: <20161202065214.GF21601@pxdev.xzpeter.org>
	<088c2afd-575e-99af-1686-023c116352ab@intel.com>
	<20161206065155.GB4344@pxdev.xzpeter.org>
	<6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
	<20161206072228.GC4344@pxdev.xzpeter.org>
	<f9f9daab-519d-381b-c9e8-c6dcc139f1d3@intel.com>
	<20161206105914.GB3469@pxdev.xzpeter.org>
	<1b348745-3135-e28c-88f3-f45ed1855de3@intel.com>
	<20161207064322.GA28693@pxdev.xzpeter.org>
	<c1f4b99f-1bfd-9742-b8ca-360fa6fa609c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1f4b99f-1bfd-9742-b8ca-360fa6fa609c@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>

On Wed, Dec 07, 2016 at 10:04:57PM +0800, Lan Tianyu wrote:

[...]

> >Even if the context entry is cleared and invalidated, IMHO it does not
> >mean that we should be using GPA address space, nor do we need to put
> >it into guest physical address space. Instead, it simply means this
> >device cannot do any IO at that time. If IO comes, IOMMU should do
> >fault reporting to guest OS, which should be treated as error.
> 
> Yes, that looks right and there will be fault event reported by pIOMMU
> if context entry is no present for DMA untranslated request. This goes back
> to the first gap to report pIOMMU fault event to vIOMMU.

Right.

> 
> For disabling via clearing DMA translation via gcmd.TE bit, assigned
> device should work after clearing operation and it's still necessary to
> restore GPA->HPA mapping since we can't assume guest won't clear the bit
> after enabling DMA translation.
> 
> This maybe low priority gap since Linux IOMMU driver don't disable DMA
> translation frequently or dynamically. But we also should consider the
> situation.

I see. That's something I missed indeed. Yes we should support
disabling via gcmd.te. Also, looks like we still don't support
passthrough mode translation as well. That's something we need too
since that means we don't supporting iommu=pt.

I agree with you that we can postpone these tasks temporarily, just
like the error handling you mentioned.

> 
> >
> >So I think we are emulating the correct guest behavior here - we don't
> >need to do anything if a device is detached from an existing IOMMU
> >domain in guest. If we do (e.g., we replay the GPA address space on
> >that device when it is detached, so the shadow page table for that
> >device maps the whole guest memory), that is dangerous, because with
> >that the device can DMA to anywhere it wants to guest memory.
> 
> If guest want to disabling DMA translation, this is expected behavior
> and device model should follow guest configuration. This just likes most
> distributions don't enable VTD DMA translation by default and it's OS
> choice.

My previous comment only suites the case when a device is moved
outside an IOMMU domain. I agree with you on the rest.

Btw, do you have time to help review my RFC series for "vt-d replay"?
:) I'd like to receive any further review comments besides the issues
mentioned above since IMHO they can be seperated from current series,
I have noted them down in my pending list.

(I think I need to test iommu=pt a bit more to make sure it works
 asap)

Thanks,

-- peterx
