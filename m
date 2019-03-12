Received: from eggs.gnu.org ([209.51.188.92]:57126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3Y8t-0001GG-OT
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1h3Y8s-0003iE-9y
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:31:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1h3Y8s-0003fp-2Q
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 23:31:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC94810C6E
	for <qemu-devel@nongnu.org>; Tue, 12 Mar 2019 03:23:47 +0000 (UTC)
Date: Tue, 12 Mar 2019 11:23:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190312032342.GC14108@xz-x1>
References: <871s3dg3si.fsf@redhat.com>
	<3fd4f68a-9ce4-7e54-a763-ccdcf844890e@redhat.com>
	<87zhq1ed33.fsf@redhat.com>
	<21d96d05-b600-b115-3649-8d488aeec82b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21d96d05-b600-b115-3649-8d488aeec82b@redhat.com>
Subject: Re: [Qemu-devel] Flatview rendering scalability issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 11, 2019 at 03:07:43PM +0100, Paolo Bonzini wrote:
> On 11/03/19 14:48, Sergio Lopez wrote:
> >> The initialization is O(n^2) because the guest initializes one device at
> >> a time, so you rebuild the FlatView first with 0 devices, then 1, then
> >> 2, etc.  This is very hard to fix, if at all possible.
> >>
> >> However, each FlatView creation should be O(n) where n is the number of
> >> devices currently configured.  Please check with "info mtree -f" that
> >> you only have a fixed number of FlatViews.  Old versions had one per device.
> > I'm seeing 9 FVs with 1 PCI, and 119 with 100 PCIs.
> 
> With
> 
> $ eval qemu-system-x86_64 -M q35 \
>     -device\ e1000,id=n{1,2,3,4,5,6,7,8}{1,2,3}
> 
> I only see 4 flat views ("system", "io", "memory", "(none)").
> 
> Probably you are using intel-iommu?  Peter, it should be possible to
> reorganize the VT-d memory regions like this:
> 
>     intel_iommu_ir (MMIO, not added to any container)
> 
>     vtd_root_dmar (container)
>       intel_iommu_dmar (IOMMU), priority 0
>       alias to intel_iommu_ir, priority 1
> 
>     vtd_root_nodmar
>       alias to get_system_memory(), priority 0
>       alias to intel_iommu_ir, priority 1
> 
>     vtd_root_0 memory region (container)
>         vtd_root_dmar             # only one of these is enabled
>         vtd_root_nodmar
> 
> where the vtd_root_dmar and vtd_root_nodmar memory regions are created
> in vtd_init once and for all.  Because all vtd_root_* memory regions
> have only one child, memory.c will recognize that they represent the
> same memory, and create at most two FlatViews (one for vtd_root_dmar,
> one for vtd_root_nodmar).

Yes this sounds good.  The only thing I'm still uncertain is about the
IOMMU notifiers, which should be per-device (for real).  That's
embedded in IOMMUMemoryRegion so far and it includes the real MR
object:

struct IOMMUMemoryRegion {
    MemoryRegion parent_obj;
    QLIST_HEAD(, IOMMUNotifier) iommu_notify;
    IOMMUNotifierFlag iommu_notify_flags;
};

Maybe I should also make parent_obj a pointer to the created MRs
mentioned above, so IOMMUMemoryRegion only contains notification
information rather than real MRs (otherwise we won't have a chance to
share memory regions between devices)?

(But if so then TYPE_INTEL_IOMMU_MEMORY_REGION might not be able to
 inherit TYPE_IOMMU_MEMORY_REGION directly, and I've not thought about
 the details of that, yet)

Regards,

-- 
Peter Xu
