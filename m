Received: from eggs.gnu.org ([2001:4830:134:3::10]:50376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cEcqw-00081o-FN
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cEcqr-0005IJ-F8
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:05:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:15740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cEcqq-0005I6-Rv
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:05:41 -0500
From: Lan Tianyu <tianyu.lan@intel.com>
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<8188dd5e-2c71-dbd0-9a1a-9c8af6f74b96@intel.com>
	<20161202065214.GF21601@pxdev.xzpeter.org>
	<088c2afd-575e-99af-1686-023c116352ab@intel.com>
	<20161206065155.GB4344@pxdev.xzpeter.org>
	<6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
	<20161206072228.GC4344@pxdev.xzpeter.org>
	<f9f9daab-519d-381b-c9e8-c6dcc139f1d3@intel.com>
	<20161206105914.GB3469@pxdev.xzpeter.org>
	<1b348745-3135-e28c-88f3-f45ed1855de3@intel.com>
	<20161207064322.GA28693@pxdev.xzpeter.org>
Message-ID: <c1f4b99f-1bfd-9742-b8ca-360fa6fa609c@intel.com>
Date: Wed, 7 Dec 2016 22:04:57 +0800
MIME-Version: 1.0
In-Reply-To: <20161207064322.GA28693@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
To: Peter Xu <peterx@redhat.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>

On 2016年12月07日 14:43, Peter Xu wrote:
> On Wed, Dec 07, 2016 at 02:09:16PM +0800, Lan Tianyu wrote:
>> On 2016年12月06日 18:59, Peter Xu wrote:
>>> On Tue, Dec 06, 2016 at 04:27:39PM +0800, Lan Tianyu wrote:
>>>
>>> [...]
>>>
>>>>>
>>>>>> User space driver(E.G DPDK) also can enable/disable
>>>>>> IOVA for device dynamically.
>>>>>
>>>>> Could you provide more detailed (or any pointer) on how to do that? I
>>>>> did try to find it myself, I see an VFIO_IOMMU_ENABLE ioctl, but looks
>>>>> like it is for ppc only.
>>>>
>>>> No, I just give an example that user space may do that but no more
>>>> research. But since Qemu already can enable device's IOVA, other user
>>>> application also should can do that with the same VFIO interface, right?
>>>
>>> AFAIU we can't do that at least on x86. We can use vfio interface to
>>> bind group into container, but we should not be able to dynamically
>>> disable IOMMU protection. IIUC That needs to taint the kernel.
>>>
>>> The only way I know is that we probe vfio-pci with no-iommu mode, in
>>> that case, we disabled IOMMU, but we can never dynamically enable it
>>> as well.
>>>
>>> Please correct me if I am wrong.
>>
>>
>> Actually, disabling device's IOVA doesn't require to disable kernel
>> global DMA protect and just clear device's VTD context entry in the
>> context table. Go though IOMMU and VFIO code, find this will happen when
>> call VFIO_GROUP_UNSET_CONTAINER ioctl and it will be called when destroy
>> VM or unplug assigned device in Qemu. Please help to double check.
>>
>> Call trace:
>> __vfio_group_unset_container()
>> vfio_iommu_type1_detach_group()
>> iommu_detach_group()
>> dmar_remove_one_dev_info()
>> __dmar_remove_one_dev_info()
>> domain_context_clear()
>>
>>
>> The legacy KVM device assign code also will call iommu_detach_device()
>> when deassign a device.
>>
>> From device emulation view, we need to make sure correct register
>> emulation regardless of guest behavior.
>
> Even if the context entry is cleared and invalidated, IMHO it does not
> mean that we should be using GPA address space, nor do we need to put
> it into guest physical address space. Instead, it simply means this
> device cannot do any IO at that time. If IO comes, IOMMU should do
> fault reporting to guest OS, which should be treated as error.

Yes, that looks right and there will be fault event reported by pIOMMU
if context entry is no present for DMA untranslated request. This goes 
back to the first gap to report pIOMMU fault event to vIOMMU.

For disabling via clearing DMA translation via gcmd.TE bit, assigned
device should work after clearing operation and it's still necessary to
restore GPA->HPA mapping since we can't assume guest won't clear the bit
after enabling DMA translation.

This maybe low priority gap since Linux IOMMU driver don't disable DMA
translation frequently or dynamically. But we also should consider the
situation.

>
> So I think we are emulating the correct guest behavior here - we don't
> need to do anything if a device is detached from an existing IOMMU
> domain in guest. If we do (e.g., we replay the GPA address space on
> that device when it is detached, so the shadow page table for that
> device maps the whole guest memory), that is dangerous, because with
> that the device can DMA to anywhere it wants to guest memory.

If guest want to disabling DMA translation, this is expected behavior
and device model should follow guest configuration. This just likes most
distributions don't enable VTD DMA translation by default and it's OS
choice.

-- 
Best regards
Tianyu Lan
