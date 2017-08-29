Received: from eggs.gnu.org ([2001:4830:134:3::10]:37996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dmmPs-0003C4-2n
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 15:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dmmPq-0007q4-Pl
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 15:43:16 -0400
References: <1503312534-6642-1-git-send-email-Bharat.Bhushan@nxp.com>
	<20170829170630.GA2622@virtx40>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <1698021f-3b2b-84aa-01de-ba042097a9ee@redhat.com>
Date: Tue, 29 Aug 2017 21:42:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170829170630.GA2622@virtx40>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v3 0/2] virtio-iommu: VFIO
 integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Linu Cherian <linuc.decode@gmail.com>, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Cc: peter.maydell@linaro.org, kevin.tian@intel.com, drjones@redhat.com, mst@redhat.com, marc.zyngier@arm.com, tn@semihalf.com, will.deacon@arm.com, qemu-devel@nongnu.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, linu.cherian@cavium.com, robin.murphy@arm.com, christoffer.dall@linaro.org, eric.auger.pro@gmail.com

Hi Linu,

On 29/08/2017 19:06, Linu Cherian wrote:
> Hi,
> 
> On Mon Aug 21, 2017 at 04:18:52PM +0530, Bharat Bhushan wrote:
>> This V3 version is mainly about rebasing on v3 version on Virtio-iommu device
>> framework from Eric Augur and addresing review comments.
>>
>> This patch series allows PCI pass-through using virtio-iommu.
>>   
>> This series is based on:
>>  - virtio-iommu specification written by Jean-Philippe Brucker
>>    [RFC 0/3] virtio-iommu: a paravirtualized IOMMU,
>>  
>>  - virtio-iommu driver by Jean-Philippe Brucker
>>    [RFC PATCH linux] iommu: Add virtio-iommu driver
>>  
>>  - virtio-iommu device emulation by Eric Augur.
>>    [RFC v3 0/8] VIRTIO-IOMMU device
>>
>> PCI device pass-through and virtio-net-pci is tested with these changes using dma-ops
>>
> 
> Facing issues while trying to test with VFIO.
> 
> vfio_dma_map fails as below, 
> qemu-system-aarch64: vfio_dma_map(0x1ff0da0, 0xfdfc7000, 0x1000, 0xffff79acc000) = -22 (Invalid argument)
> Very likely this seem to be an issue with map size. Kernel PAGE_SIZE 
> is 64k on my host and hence the map size for the physical SMMU also will
> start with 64k.
Most probably. I currently use 4KB on both host/guest.  Also the devices
I assign have BARs smaller than 64kB and this causes issue with DPDK.

> 
> Qemu source: https://github.com/eauger/qemu.git + this patch series
>              on branch v2.10.0-rc0-virtio-iommu-rfcv3
> Linux source: git://linux-arm.org/linux-jpb.git
>              on branch virtio-iommu/v0.1
> Any pointers ?
Looks good.
> 
> The other related questions i had,
> 1.  In, virtio_iommu_device_realize in qemu,
>    s->config.page_sizes = TARGET_PAGE_MASK;
> 
>   Same is being taken as pgsize_bitmap in virtio_iommu guest kernel driver.
>   In, viommu_probe 
>   virtio_cread(vdev, struct virtio_iommu_config, page_sizes,
>                      &viommu->pgsize_bitmap);
> 
>   Should s->config.page_sizes be initialized with page bitmap instead
>   of page mask ?
We currently support all page size bits greater or equal than the guest
page size
define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)

We evoked the problem you seem to face in
https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg05308.html

and the temporary solution was to use TARGET_PAGE_MASK
> 
> 2. Should we not populate the supported page sizes based on  
>    host kernel size and SMMU hardware capability rather than 
>    based on the machine emulated on qemu? Atleast that makes
>    sense for VFIO case.

I think Jean's proposal to address this issue is to enhance the PROBE
API. The driver would fetch for each device an accurate page_size_mask
that would characterize either the virtual iommu or the underlying
physical iommu. This would override the global page_size_mask. I think
the plan was to issue that for v0.5

Thanks

Eric
> 
>> This patch series does not implement RESV_MEM changes proposal by Jean-Philippe "https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg01796.html"
>>
>> v2->v3:
>>  - This series is based on "[RFC v3 0/8] VIRTIO-IOMMU device"
>>    Which is based on top of v2.10-rc0 that 
>>  - Fixed issue with two PCI devices
>>  - Addressed review comments
>>
>> v1->v2:
>>   - Added trace events
>>   - removed vSMMU3 link in patch description
>>
>> Bharat Bhushan (2):
>>   target/arm/kvm: Translate the MSI doorbell in kvm_arch_fixup_msi_route
>>   virtio-iommu: vfio integration with virtio-iommu
>>
>>  hw/virtio/trace-events           |   5 ++
>>  hw/virtio/virtio-iommu.c         | 163 +++++++++++++++++++++++++++++++++++++++
>>  include/hw/virtio/virtio-iommu.h |   6 ++
>>  target/arm/kvm.c                 |  27 +++++++
>>  target/arm/trace-events          |   3 +
>>  5 files changed, 204 insertions(+)
>>
>> -- 
>> 1.9.3
>>
>>
> 
