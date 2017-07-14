Received: from eggs.gnu.org ([2001:4830:134:3::10]:60885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dW58K-000051-Iy
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1dW58F-00037o-Ji
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:16:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1dW58F-00036F-9h
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 14:16:03 -0400
Date: Fri, 14 Jul 2017 12:15:55 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170714121555.7e64d849@w520.home>
In-Reply-To: <A2975661238FB949B60364EF0F2C2574390A7C4F@shsmsx102.ccr.corp.intel.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
	<1d63c1ae-ca10-0f9d-91de-0d9c9823c104@arm.com>
	<20170705112816.56554f65@w520.home>
	<A2975661238FB949B60364EF0F2C2574390A7C4F@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, "Lan,
	Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, Joerg Roedel <joro@8bytes.org>

On Fri, 14 Jul 2017 08:58:02 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Hi Alex,
> 
> Against to the opaque open, I'd like to propose the following definition
> based on the existing comments. Pls note that I've merged the pasid
> table binding and iommu tlb invalidation into a single IOCTL and make
> different flags to indicate the iommu operations. Per Kevin's comments,
> there may be iommu invalidation for guest IOVA tlb, so I renamed the
> IOCTL and data structure to be non-svm specific. Pls kindly have a review,
> so that we can make the opaque open closed and move forward. Surely,
> comments and ideas are welcomed. And for the scope and flags definition
> in struct iommu_tlb_invalidate, it's also welcomed to give your ideas on it.
> 
> 1. Add a VFIO IOCTL for iommu operations from user-space
> 
> #define VFIO_IOMMU_OP_IOCTL _IO(VFIO_TYPE, VFIO_BASE + 24)
> 
> Corresponding data structure:
> struct vfio_iommu_operation_info {
> 	__u32	argsz;
> #define VFIO_IOMMU_BIND_PASIDTBL	(1 << 0) /* Bind PASID Table */
> #define VFIO_IOMMU_BIND_PASID	(1 << 1) /* Bind PASID from userspace driver*/
> #define VFIO_IOMMU_BIND_PGTABLE	(1 << 2) /* Bind guest mmu page table */
> #define VFIO_IOMMU_INVAL_IOTLB	(1 << 3) /* Invalidate iommu tlb */
> 	__u32	flag;
> 	__u32	length; // length of the data[] part in byte
> 	__u8	data[]; // stores the data for iommu op indicated by flag field
> };

If we're doing a generic "Ops" ioctl, then we should have an "op" field
which is defined by an enum.  It doesn't make sense to use flags for
this, for example can we set multiple flag bits?  If not then it's not
a good use for a bit field.  I'm also not sure I understand the value
of the "length" field, can't it always be calculated from argsz?

> For iommu tlb invalidation from userspace, the "__u8 data[]" stores
> data which would be parsed by the "struct iommu_tlb_invalidate" defined
> below.
> 
> 2. Definitions in include/uapi/linux/iommu.h(newly added header file)
> 
> /* IOMMU model definition for iommu operations from userspace */
> enum iommu_model {
> 	INTLE_IOMMU,
> 	ARM_SMMU,
> 	AMD_IOMMU,
> 	SPAPR_IOMMU,
> 	S390_IOMMU,
> };
> 
> struct iommu_tlb_invalidate {
> 	__u32	scope;
> /* pasid-selective invalidation described by @pasid */
> #define IOMMU_INVALIDATE_PASID	(1 << 0)
> /* address-selevtive invalidation described by (@vaddr, @size) */
> #define IOMMU_INVALIDATE_VADDR	(1 << 1)

Again, is a bit field appropriate here, can a user set both bits?

> 	__u32	flags;
> /*  targets non-pasid mappings, @pasid is not valid */
> #define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
> /* indicating that the pIOMMU doesn't need to invalidate
> 	all intermediate tables cached as part of the PTE for
> 	vaddr, only the last-level entry (pte). This is a hint. */
> #define IOMMU_INVALIDATE_VADDR_LEAF	(1 << 1)

Are we venturing into vendor specific attributes here?

> 	__u32	pasid;
> 	__u64	vaddr;
> 	__u64	size;
> 	enum iommu_model model;

How does a user learn which model(s) are supported by the interface?
How do they learn which ops are supported?  Perhaps a good use for one
of those flag bits in the outer data structure is "probe".

> 	/*
> 	 Vendor may have different HW version and thus the
> 	 data part of this structure differs, use sub_version
> 	 to indicate such difference.
> 	 */
> 	__u322 sub_version;

Not sure I see the value of this vs creating an INTEL_IOMMUv2 entry in
the model enum.

> 	__u64 length; // length of the data[] part in byte

Questionably useful vs calculating from argsz again , but it certainly
doesn't need to be a qword :-o

> 	__u8	data[];
> };
> 
> For Intel, the data structue is:
> struct intel_iommu_invalidate_data {
> 	__u64 low;
> 	__u64 high;
> }

high/low what?  This is a pretty weak uapi definition.  Thanks,

Alex
