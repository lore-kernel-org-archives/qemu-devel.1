Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dSjad-0004rs-Ll
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dSjaY-0004sP-Pb
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:39:31 -0400
Received: from foss.arm.com ([217.140.101.70]:34922)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jean-philippe.brucker@arm.com>) id 1dSjaY-0004rr-Gm
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 08:39:26 -0400
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-8-git-send-email-yi.l.liu@intel.com>
	<cc330a8f-e087-9b6f-2a40-38b58688d300@arm.com>
	<20170702100659.GA22053@gmail.com>
	<0e4f2dd4-d553-b1b7-7bec-fe0ff5242c54@arm.com>
	<20170703103115.GB22053@gmail.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <1d63c1ae-ca10-0f9d-91de-0d9c9823c104@arm.com>
Date: Wed, 5 Jul 2017 13:42:03 +0100
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190D25919@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: "Lan, Tianyu" <tianyu.lan@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Will Deacon <Will.Deacon@arm.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>

On 05/07/17 07:45, Tian, Kevin wrote:
>> From: Liu, Yi L
>> Sent: Monday, July 3, 2017 6:31 PM
>>
>> Hi Jean,
>>
>>
>>>
>>>> 2. Define a structure in include/uapi/linux/iommu.h(newly added header
>> file)
>>>>
>>>> struct iommu_tlb_invalidate {
>>>> 	__u32	scope;
>>>> /* pasid-selective invalidation described by @pasid */
>>>> #define IOMMU_INVALIDATE_PASID	(1 << 0)
>>>> /* address-selevtive invalidation described by (@vaddr, @size) */
>>>> #define IOMMU_INVALIDATE_VADDR	(1 << 1)
> 
> For VT-d above two flags are related. There is no method of flushing
> (@vaddr, @size) for all pasids, which doesn't make sense. address-
> selective invalidation is valid only for a given pasid. So it's not appropriate
> to put them in same level of scope definition at least for VT-d.

For ARM SMMU the "flush all by VA" operation is valid. Although it's
unclear at this point if we will ever allow that, it should probably stay
in the common format, if there is one.

>>>> 	__u32	flags;
>>>> /*  targets non-pasid mappings, @pasid is not valid */
>>>> #define IOMMU_INVALIDATE_NO_PASID	(1 << 0)
>>>
>>> Although it was my proposal, I don't like this flag. In ARM SMMU, we're
>>> using a special mode where PASID 0 is reserved and any traffic without
>>> PASID uses entry 0 of the PASID table. So I proposed the "NO_PASID" flag
>>> to invalidate that special context explicitly. But this means that
>>> invalidation packet targeted at that context will have "scope = PASID" and
>>> "flags = NO_PASID", which is utterly confusing.
>>>
>>> I now think that we should get rid of the IOMMU_INVALIDATE_NO_PASID
>> flag
>>> and just use PASID 0 to invalidate this context on ARM. I don't think
>>> other architectures would use the NO_PASID flag anyway, but might be
>> mistaken.
>>
>> I may suggest to keep it so far. On VT-d, we may pass some data in opaque,
>> so
>> we may work without it. But if other vendor want to issue non-PASID tagged
>> cache, then may encounter problem.
> 
> I'm worried about what's the criteria which attribute should be abstracted
> in common structure and which can be left to opaque. It doesn't make
> much sense to do such abstraction purely because different vendor formats
> have some common fields. Usually we do such abstraction because 
> vendor-agnostic code need to do some common handling before going to
> vendor specific code. However in this case VFIO is not expected to do anything
> with those IOMMU specific attributes. Then the structure is directly forwarded
> to IOMMU driver, which simply translates the structure into vendor specific
> opaque data again. Then why bothering to do double translations in Qemu
> and IOMMU driver side?>
> Take VT-d for example. Below is a summary of all possible selections around
> invalidation of 1st level structure for svm:
> 
> Scope: All PASIDs, single PASID
> for each PASID:
> 	all mappings, or page-selective mappings (addr, size)
> invalidation target:
> 	IOTLB entries (leaf)
> 	paging structure cache (non-leaf)

I'm curious, can you invalidate all intermediate paging structures for a
given PASID without invalidating the leaves?

> 	PASID cache (pasid->cr3)
I guess any implementations that gives the whole PASID table to userspace
will need the PASID cache invalidation. This was missing from my proposal
since it was from virtio-iommu.

> invalidation hint:
> 	whether global pages are included
> 	drain reads/writes>
> Above are pretty architectural attributes if just looking at functional
> purpose. Then if we really consider defining a common structure, it
> might be more natural to define a superset of all vendors' capabilities
> and remove the opaque field at all. But as said earlier the purpose of
> doing such abstraction is not clear if there is no vendor-agnostic
> user actually digesting those fields. Then should we reconsider the
> full opaque approach?
> 
> Welcome comments since I may overlook something here. :-)

I guess on x86 the invalidation packet formats are stable, but for ARM I'm
reluctant to deal with vendor-specific formats at the API level, because
they tend to be volatile. If a virtual IOMMU version is different from the
physical one, then the page table format will be the same but invalidation
format will not.

So it would be good to define common fields that have the same effects
regardless on the underlying pIOMMU. And the fields that differ between
ARM and x86 seem to only be hints.

In addition on ARM SMMU, the guest cannot build an invalidation command
that the host could simply copy into the hardware command queue. The
pIOMMU driver needs to craft an invalidation command with a Virtual
Machine ID, that the guest is never aware of, and a separate ATS
invalidation command. It might also need to retrieve an Address Space ID
associated with the given PASID if it chose to hide it from the guest.

So for us the invalidation structure would always be different from the
hardware one. That's why I do not have any reason the prefer an opaque
structure in the first place, and defining generic fields looks much
neater :) Then again, I don't have any strong technical objection to it.

Thanks,
Jean
