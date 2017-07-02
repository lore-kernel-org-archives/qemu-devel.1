Received: from eggs.gnu.org ([2001:4830:134:3::10]:60524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dRyTa-0007iy-37
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1dRyTV-0006CP-Bc
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:21:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:51021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1dRyTU-00069B-VO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:21:01 -0400
Date: Sun, 2 Jul 2017 18:06:59 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20170702100659.GA22053@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 7/8] VFIO: Add new IOCTL for IOMMU TLB
 invalidate propagation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, ashok.raj@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org, jacob.jun.pan@intel.com

On Fri, May 12, 2017 at 01:11:02PM +0100, Jean-Philippe Brucker wrote:

Hi Jean,

As we've got a few discussions on it. I'd like to have a conclusion and
make it as a reference for future discussion.

Currently, we are inclined to have a hybrid format for the iommu tlb
invalidation from userspace(vIOMMU or userspace driver).

Based on the previous discussion, may the below work?

1. Add a IOCTL for iommu tlb invalidation.

VFIO_IOMMU_TLB_INVALIDATE

struct vfio_iommu_tlb_invalidate {
   __u32   argsz;
   __u32   length;
   __u8    data[];
};

comments from Alex William: is it more suitable to add a new flag bit on
vfio_device_svm(a structure defined in patch 5 of this patchset), the data
structure is so similar.

Personally, I'm ok with it. Pls let me know your thoughts. However, the
precondition is we accept the whole definition in this email. If not, the
vfio_iommu_tlb_invalidate would be defined differently.

2. Define a structure in include/uapi/linux/iommu.h(newly added header file)

struct iommu_tlb_invalidate {
	__u32	scope;
/* pasid-selective invalidation described by @pasid */
#define IOMMU_INVALIDATE_PASID	(1 << 0)
/* address-selevtive invalidation described by (@vaddr, @size) */
#define IOMMU_INVALIDATE_VADDR	(1 << 1)
	__u32	flags;
/*  targets non-pasid mappings, @pasid is not valid */
#define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
/* indicating that the pIOMMU doesn't need to invalidate
   all intermediate tables cached as part of the PTE for
   vaddr, only the last-level entry (pte). This is a hint. */
#define IOMMU_INVALIDATE_VADDR_LEAF	(1 << 1)
	__u32	pasid;
	__u64	vaddr;
	__u64	size;
	__u8	data[];
};

For this part, the scope and flags are basically aligned with your previous
email. I renamed the prefix to be "IOMMU_". In my opinion, the scope and flags
would be filled by vIOMMU emulator and be parsed by underlying iommu driver,
it is much more suitable to be defined in a uapi header file.

Besides the reason above, I don't want VFIO engae too much on the data parsing.
If we move the scope,flags,pasid,vaddr,size fields to vfio_iommu_tlb_invalidate,
then both kernel space vfio and user space vfio needs to do much parsing. So I
may prefer the way above.

If you've got any other idea, pls feel free to post it. It's welcomed.

Thanks,
Yi L

> Hi Yi,
> 
> On 26/04/17 11:12, Liu, Yi L wrote:
> > From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> > 
> > This patch adds VFIO_IOMMU_TLB_INVALIDATE to propagate IOMMU TLB
> > invalidate request from guest to host.
> > 
> > In the case of SVM virtualization on VT-d, host IOMMU driver has
> > no knowledge of caching structure updates unless the guest
> > invalidation activities are passed down to the host. So a new
> > IOCTL is needed to propagate the guest cache invalidation through
> > VFIO.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  include/uapi/linux/vfio.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 6b97987..50c51f8 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -564,6 +564,15 @@ struct vfio_device_svm {
> >  
> >  #define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
> >  
> > +/* For IOMMU TLB Invalidation Propagation */
> > +struct vfio_iommu_tlb_invalidate {
> > +	__u32	argsz;
> > +	__u32	length;
> > +	__u8	data[];
> > +};
> 
> We initially discussed something a little more generic than this, with
> most info explicitly described and only pIOMMU-specific quirks and hints
> in an opaque structure. Out of curiosity, why the change? I'm not against
> a fully opaque structure, but there seem to be a large overlap between TLB
> invalidations across architectures.
> 
> 
> For what it's worth, when prototyping the paravirtualized IOMMU I came up
> with the following.
> 
> (From the paravirtualized POV, the SMMU also has to swizzle endianess
> after unpacking an opaque structure, since userspace doesn't know what's
> in it and guest might use a different endianess. So we need to force all
> opaque data to be e.g. little-endian.)
> 
> struct vfio_iommu_tlb_invalidate {
> 	__u32	argsz;
> 	__u32	scope;
> 	__u32	flags;
> 	__u32	pasid;
> 	__u64	vaddr;
> 	__u64	size;
> 	__u8	data[];
> };
> 
> Scope is a bitfields restricting the invalidation scope. By default
> invalidate the whole container (all PASIDs and all VAs). @pasid, @vaddr
> and @size are unused.
> 
> Adding VFIO_IOMMU_INVALIDATE_PASID (1 << 0) restricts the invalidation
> scope to the pasid described by @pasid.
> Adding VFIO_IOMMU_INVALIDATE_VADDR (1 << 1) restricts the invalidation
> scope to the address range described by (@vaddr, @size).
> 
> So setting scope = VFIO_IOMMU_INVALIDATE_VADDR would invalidate the VA
> range for *all* pasids (as well as no_pasid). Setting scope =
> (VFIO_IOMMU_INVALIDATE_VADDR|VFIO_IOMMU_INVALIDATE_PASID) would invalidate
> the VA range only for @pasid.
> 
> Flags depend on the selected scope:
> 
> VFIO_IOMMU_INVALIDATE_NO_PASID, indicating that invalidation (either
> without scope or with INVALIDATE_VADDR) targets non-pasid mappings
> exclusively (some architectures, e.g. SMMU, allow this)
> 
> VFIO_IOMMU_INVALIDATE_VADDR_LEAF, indicating that the pIOMMU doesn't need
> to invalidate all intermediate tables cached as part of the PTW for vaddr,
> only the last-level entry (pte). This is a hint.
> 
> I guess what's missing for Intel IOMMU and would go in @data is the
> "global" hint (which we don't have in SMMU invalidations). Do you see
> anything else, that the pIOMMU cannot deduce from this structure?
> 
> Thanks,
> Jean
> 
> 
> > +#define VFIO_IOMMU_TLB_INVALIDATE	_IO(VFIO_TYPE, VFIO_BASE + 23)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> >  
> >  /*
> > 
> 
> 
