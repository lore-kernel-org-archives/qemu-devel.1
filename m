Received: from eggs.gnu.org ([2001:4830:134:3::10]:46349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cE9K3-00023x-EO
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cE9K0-0006pY-Ch
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:33:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:43016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cE9K0-0006p8-3C
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 01:33:48 -0500
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<8188dd5e-2c71-dbd0-9a1a-9c8af6f74b96@intel.com>
	<20161202065214.GF21601@pxdev.xzpeter.org>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <088c2afd-575e-99af-1686-023c116352ab@intel.com>
Date: Tue, 6 Dec 2016 14:30:24 +0800
MIME-Version: 1.0
In-Reply-To: <20161202065214.GF21601@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
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

On 2016年12月02日 14:52, Peter Xu wrote:
> On Thu, Dec 01, 2016 at 02:44:14PM +0800, Lan Tianyu wrote:
> 
> [...]
> 
>> Hi:
>> I think there are still other gaps to enable passthough device with
>> vIOMMU's DMA translation support.
>>
>> 1. Since this patchset is to shadow guest IO page table to
>> pIOMMU(physical IOMMU) vfio_dma_map/umap(), there will be some fault
>> events from pIOMMU if guest os does misconfigurations. We should report
>> these fault events to guest. This means we need to pass the fault event
>> from pIOMMU driver to vIOMMU in Qemu. I suppose a channel in VFIO should
>> be added to connect pIOMMU and vIOMMU.
> 
> Thanks for raising this up - IMHO this is a good question.
> 
>>
>> The task should be divided into three parts
>> 1) pIOMMU driver reports fault events for vIOMMU via new VFIO interface
> 
> Here you mean "how host kernel capture the DMAR fault", right?

Yes, VFIO kernel driver should know the fault event when it's triggered.

> 
> IMHO We can have something like notifier/notifiee as well in DMAR
> fault reporting - people (like vfio driver in kernel) can register to
> fault reports related to specific device. When DMAR receives faults
> for those devices, it triggers the notification list, then vfio can be
> notified.

Yes, something likes this.


> 
>> 2) Add new channel in VFIO subsystem to connect pIOMMU driver and
>> vIOMMU in Qemu
>> 3) vIOMMU in Qemu get fault event from VFIO subsystem in Qemu and inject
>> virtual fault event to guest.
>>
>> Such VFIO channel is also required by device's PRS(Page Request
>> Services) support. This is also a part of SVM(Shared virtual memory)
>> support in VM. Here is SVM design doc link.
>> http://marc.info/?l=kvm&m=148049586514120&w=2
>>
>> 2. How to restore GPA->HPA mapping when IOVA is disabled by guest.
>> When guest enables IOVA for device, vIOMMU will invalidate all previous
>> GPA->HPA mapping and update IOVA->HPA mapping to pIOMMU via iommu
>> notifier. But if IOVA is disabled, I think we should restore GPA->HPA
>> mapping for the device otherwise the device won't work again in the VM.
> 
> If we can have a workable replay mechanism, this problem will be
> solved IMHO.

Basic idea is to replay related memory regions to restore GPA->HPA
mapping when guest disables IOVA.


-- 
Best regards
Tianyu Lan
