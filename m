Received: from eggs.gnu.org ([2001:4830:134:3::10]:35674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cTUJ2-0001AQ-MM
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:00:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cTUIx-0000WO-IJ
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:00:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cTUIx-0000UO-A3
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 09:00:07 -0500
Date: Tue, 17 Jan 2017 22:00:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170117140000.GN30108@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-14-git-send-email-peterx@redhat.com>
	<20170116125357.31b7ef82@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170116125357.31b7ef82@t450s.home>
Subject: Re: [Qemu-devel] [PATCH RFC v3 13/14] intel_iommu: allow dynamic
 switch of IOMMU region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, bd.aviv@gmail.com

On Mon, Jan 16, 2017 at 12:53:57PM -0700, Alex Williamson wrote:
> On Fri, 13 Jan 2017 11:06:39 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > This is preparation work to finally enabled dynamic switching ON/OFF for
> > VT-d protection. The old VT-d codes is using static IOMMU address space,
> > and that won't satisfy vfio-pci device listeners.
> > 
> > Let me explain.
> > 
> > vfio-pci devices depend on the memory region listener and IOMMU replay
> > mechanism to make sure the device mapping is coherent with the guest
> > even if there are domain switches. And there are two kinds of domain
> > switches:
> > 
> >   (1) switch from domain A -> B
> >   (2) switch from domain A -> no domain (e.g., turn DMAR off)
> > 
> > Case (1) is handled by the context entry invalidation handling by the
> > VT-d replay logic. What the replay function should do here is to replay
> > the existing page mappings in domain B.
> 
> There's really 2 steps here, right?  Invalidate A, replay B.  I think
> the code handles this, but I want to make sure.  We don't want to end
> up with a superset of both A & B.

First of all, this discussion should be beyond this patch's scope,
since this patch is currently only handling the case when guest
disables DMAR in general.

Then, my understanding for above question: when we do A -> B domain
switch, guest will not send specific context entry invalidations for
A, but will for sure send one when context entry is ready for B. In
that sense, IMO we don't have a clear "two steps", only one, which is
the latter "replay B". We do correct unmap based on the PSIs
(page-selective invalidations) of A when guest unmaps the pages in A.

So, for the use case of nested device assignment (which is the goal of
this series for now):

- L1 guest put device D1,D2,... of L2 guest into domain A
- L1 guest map the L2 memory into L1 address space (L2GPA -> L1GPA)
- ... (L2 guest runs, until it stops running)
- L1 guest unmap all the pages in domain A
- L1 guest move device D1,D2,... of L2 guest outside domain A

This series should work for above, since before any device leaves its
domain, the domain will be clean and without unmapped pages.

However, if we have the following scenario (which I don't know whether
this's achievable):

- guest iommu domain A has device D1, D2
- guest iommu domain B has device D3
- move device D2 from domain A into B

Here when D2 move from A to B, IIUC our current Linux IOMMU driver
code will not send any PSI (page-selected invalidations) for D2 or
domain A because domain A still has device in it, guest should only
send a context entry invalidation for device D2, telling that D2 has
switched to domain B. In that case, I am not sure whether current
series can work properly, and IMHO we may need to have the domain
knowledge in VT-d emulation code (while we don't have it yet) in the
future to further support this kind of domain switches.

> 
> On the invalidation, a future optimization when disabling an entire
> memory region might also be to invalidate the entire range at once
> rather than each individual mapping within the range, which I think is
> what happens now, right?

Right. IIUC this can be an enhancement to current page walk logic - we
can coalesce continuous IOTLB with same property and notify only once
for these coalesced entries.

Noted in my todo list.

> 
> > However for case (2), we don't want to replay any domain mappings - we
> > just need the default GPA->HPA mappings (the address_space_memory
> > mapping). And this patch helps on case (2) to build up the mapping
> > automatically by leveraging the vfio-pci memory listeners.
> 
> Have you thought about using this address space switching to emulate
> ecap.PT?  ie. advertise hardware based passthrough so that the guest
> doesn't need to waste pagetable entries for a direct mapped, static
> identity domain.

Kind of. Currently we still don't have iommu=pt for the emulated code.
We can achieve that by leveraging this patch.

> 
> Otherwise the series looks pretty good to me.  Thanks,

Your review comment is really important to me. Thanks!

I'll see whether we can get to a consensus on above issue, then repost
with existing fixes.

Thanks,

-- peterx
