Received: from eggs.gnu.org ([2001:4830:134:3::10]:51295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Tomasz.Nowicki@cavium.com>) id 1dxABn-0005fL-Ep
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:07:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Tomasz.Nowicki@cavium.com>) id 1dxABm-0008Az-7R
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 07:07:39 -0400
References: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
From: Tomasz Nowicki <tnowicki@caviumnetworks.com>
Message-ID: <0062ede1-54d4-7e13-2986-374ec62c0a2a@caviumnetworks.com>
Date: Wed, 27 Sep 2017 13:07:20 +0200
MIME-Version: 1.0
In-Reply-To: <1505807208-9063-1-git-send-email-eric.auger@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v4 00/16] VIRTIO-IOMMU device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com, peter.maydell@linaro.org, alex.williamson@redhat.com, mst@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, jean-philippe.brucker@arm.com
Cc: will.deacon@arm.com, kevin.tian@intel.com, marc.zyngier@arm.com, christoffer.dall@linaro.org, drjones@redhat.com, wei@redhat.com, bharat.bhushan@nxp.com, peterx@redhat.com, linuc.decode@gmail.com

Hi Eric,

Out of curiosity, I compared your SMMUv3 full emulation against 
virtio-iommu. For virtio-net device behind the virtio-iommu I get 50% 
performance of what I can get for SMMUv3 emulation.

Do you have similar observations? Since there is no need to emulate HW 
behaviour in QEMU I expected virtio-iommu to be faster. I will run some 
more benchmarks.

Thanks,
Tomasz

On 19.09.2017 09:46, Eric Auger wrote:
> This series implements the virtio-iommu device.
> 
> This v4 is an upgrade to v0.4 spec [1] and applies on QEMU v2.10.0.
> - probe request support although no reserved region is returned at
>    the moment
> - unmap semantics less strict, as specified in v0.4
> - device registration, attach/detach revisited
> - split into smaller patches to ease review
> - propose a way to inform the IOMMU mr about the page_size_mask
>    of underlying HW IOMMU, if any
> - remove warning associated with the translation of the MSI doorbell
> 
> The device gets instantiated using the "-device virtio-iommu-device"
> option. It currently works with ARM virt machine only, as the machine
> must handle the dt binding between the virtio-mmio "iommu" node and
> the PCI host bridge node.
> 
> The associated VHOST/VFIO adaptation is available on the branch
> below but is not officially delivered as part of this series.
> 
> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/v2.10.0-virtio-iommu-v4
> 
> References:
> [1] [RFC] virtio-iommu version 0.4
>      git://linux-arm.org/virtio-iommu.git branch viommu/v0.4
> 
> Testing:
> - guest kernel with v0.4 virtio-iommu driver (4kB page)
> - tested with guest using virtio-pci-net and vhost-net
>    (,vhost=on/off,iommu_platform,disable-modern=off,disable-legacy=on  )
> - tested with VFIO and guest assigned with 2 VFs
> - tested with DPDK on guest with 2 assigned VFs
> 
> Not tested:
> - hot-plug/hot-unplug of EP: not implemented
> 
> History:
> v2-> v4:
> - see above
> 
> v2 -> v3:
> - rebase on top of 2.10-rc0 and especially
>    [PATCH qemu v9 0/2] memory/iommu: QOM'fy IOMMU MemoryRegion
> - add mutex init
> - fix as->mappings deletion using g_tree_ref/unref
> - when a dev is attached whereas it is already attached to
>    another address space, first detach it
> - fix some error values
> - page_sizes = TARGET_PAGE_MASK;
> - I haven't changed the unmap() semantics yet, waiting for the
>    next virtio-iommu spec revision.
> 
> v1 -> v2:
> - fix redifinition of viommu_as typedef
> 
> Eric Auger (16):
>    update-linux-headers: import virtio_iommu.h
>    linux-headers: Update for virtio-iommu
>    virtio-iommu: add skeleton
>    virtio-iommu: Decode the command payload
>    virtio-iommu: Add the iommu regions
>    virtio-iommu: Register attached devices
>    virtio-iommu: Implement attach/detach command
>    virtio-iommu: Implement map/unmap
>    virtio-iommu: Implement translate
>    virtio-iommu: Implement probe request
>    hw/arm/virt: Add 2.11 machine type
>    hw/arm/virt: Add virtio-iommu to the virt board
>    memory.h: Add set_page_size_mask IOMMUMemoryRegion callback
>    hw/vfio/common: Set the IOMMUMemoryRegion supported page sizes
>    virtio-iommu: Implement set_page_size_mask
>    hw/vfio/common: Do not print error when viommu translates into an mmio
>      region
> 
>   hw/arm/virt.c                                 | 115 +++-
>   hw/vfio/common.c                              |   7 +-
>   hw/virtio/Makefile.objs                       |   1 +
>   hw/virtio/trace-events                        |  24 +
>   hw/virtio/virtio-iommu.c                      | 923 ++++++++++++++++++++++++++
>   include/exec/memory.h                         |   4 +
>   include/hw/arm/virt.h                         |   5 +
>   include/hw/vfio/vfio-common.h                 |   1 +
>   include/hw/virtio/virtio-iommu.h              |  61 ++
>   include/standard-headers/linux/virtio_ids.h   |   1 +
>   include/standard-headers/linux/virtio_iommu.h | 177 +++++
>   linux-headers/linux/virtio_iommu.h            |   1 +
>   scripts/update-linux-headers.sh               |   3 +
>   13 files changed, 1312 insertions(+), 11 deletions(-)
>   create mode 100644 hw/virtio/virtio-iommu.c
>   create mode 100644 include/hw/virtio/virtio-iommu.h
>   create mode 100644 include/standard-headers/linux/virtio_iommu.h
>   create mode 100644 linux-headers/linux/virtio_iommu.h
> 
