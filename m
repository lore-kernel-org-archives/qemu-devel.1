Received: from eggs.gnu.org ([2001:4830:134:3::10]:55566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQoSA-0005m4-GV
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 23:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cQoS7-0002EZ-FY
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 23:54:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cQoS7-0002EL-6e
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 23:54:31 -0500
Date: Tue, 10 Jan 2017 06:54:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170110065350-mutt-send-email-mst@kernel.org>
References: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1483092559-24488-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4 00/10] vhost device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peterx@redhat.com, cornelia.huck@de.ibm.com, wexu@redhat.com, vkaplans@redhat.com

On Fri, Dec 30, 2016 at 06:09:09PM +0800, Jason Wang wrote:
> Hi all:
> 
> As the userspace vitio driver became popular, more and more request
> were received for secure DMA environemt (DMAR). So this series tries
> to make DMAR works for virtio/vhost. The idea is let virtio/vhost
> co-work with userspace iommu implememtation. This is done through:
> 
> - for virtio, when platform supports IOMMU (VIRTIO_F_IOMMU_PLATFORM),
>   virtio will not assume address_space_memory, instead a transport
>   specific method were introduced for querying the dma address space
>   and dma helpers were used in device emulation codes.
> - for vhost, implement a device IOTLB by using device IOTLB API
>   supported by recent kernel. With this API, vhost kernel can query
>   IOTLB entry for a specified iova from qemu, qemu can invalidate an
>   arbitrary range of iova in vhost kernel.
> 
> The device IOTLB API is totaly architecture independent, an example
> implementation was done with intel iommu by:
> 
> - implement basic ATS (Address Translation Service) for virtio-pci,
>   this will make device IOTLB visible for iommu driver in guest.
> - implement device IOTLB descriptor processing in intel iommu (enabled
>   through device-iotlb=on), and trigger the device IOTLB invalidation
>   in vhost through iommu notifier.
> 
> It could be easily ported to other IOMMU or architecture even if it
> doesn't support device IOTLB. (e.g just invalidate the vhost IOTLB
> during IOMMU IOTLB invalidation). But this will be slow since several
> devics were contending userspace IOTLB entries.
> 
> AMD IOMMU suppot for device IOTLB is ready, but it depends on other
> fixes to work correctly.
> 
> Test was done by:
> 
> - intel_iommu=on/strict in guest.
> - vfio l2fwd in guest.
> 
> This main use case is the programs that use fixed mapping in guest
> (e.g dpdk). If 1G hugepage were used in guest, thanks to the SLLPS
> support, we can get 100% TLB hit rate for l2fwd in guest.
> 
> For the normal kernel driver which uses lots of dynamic mapping and
> unmapping, we may see performance penalty, this could be optimized in
> the future.

This causes make check failure with Broken pipe message.
Probably an unexpected interaction with vhost-user.

> TODO:
> - more platforms and IOMMU support (done but block by other bugs of
>   AMD IOMMU)
> - performance optimizations (e.g merging adjacent mappings)
> - non ATS support (userspace IOTLB snooping)
> - using ATSCtl to disable Device IOTLB
> 
> Changes from V3:
> - rebase to HEAD
> - fill all entry of IOMMUTLBEntry before notify
> 
> Changes from V2:
> - rebase to HEAD
> - avoid querying dma_as each time by using vdev->dma_as directly
> - fix and improve address_space_get_iotlb_entry()
> - drop patch 1 (which has been posted as an independent fix)
> - fix ECAP when device-iotlb=off
> - fix centos6 build
> 
> Changes from V1:
> - rebase to HEAD
> - avoid calling transport specific dma as fetching method each time by
>   caching it in vdev
> - convert to use new IOMMU notifier API
> - silent checkpatch warnings and fix 32bit build
> - use "device-iotlb" instead of "device_iotlb"
> - rename virtio_memory_map() to vhost_memory_map() and move it to vhost.c
> - use memory_region_is_iommu() instead of inventing new one
> 
> Changes from RFC:
> - rebase to HEAD
> - switch to use new vhost device IOTLB API
> - use the new feature bit VIRITO_F_IOMMU_PLATFORM
> - finalize basic ATS implementation
> - add ATSR for Root port ATS transaction
> - fix the iommu notifier handling during unregistering
> - use snprintf() in patch 3
> - correc the loop in address_space_get_iotlb_entry()
> - small tweak on the address calculation during device iotlb
>   descriptor processing.
> 
> Jason Wang (10):
>   virtio: convert to use DMA api
>   intel_iommu: name vtd address space with devfn
>   intel_iommu: allocate new key when creating new address space
>   exec: introduce address_space_get_iotlb_entry()
>   intel_iommu: support device iotlb descriptor
>   virtio-pci: address space translation service (ATS) support
>   acpi: add ATSR for q35
>   memory: handle alias for iommu notifier
>   memory: handle alias in memory_region_is_iommu()
>   vhost_net: device IOTLB support
> 
>  exec.c                                    |  33 ++++++
>  hw/block/virtio-blk.c                     |   2 +-
>  hw/char/virtio-serial-bus.c               |   3 +-
>  hw/i386/acpi-build.c                      |   9 ++
>  hw/i386/intel_iommu.c                     |  92 +++++++++++++--
>  hw/i386/intel_iommu_internal.h            |  13 ++-
>  hw/i386/x86-iommu.c                       |  17 +++
>  hw/pci/pcie.c                             |  16 +++
>  hw/scsi/virtio-scsi.c                     |   4 +-
>  hw/virtio/vhost-backend.c                 |  99 +++++++++++++++++
>  hw/virtio/vhost.c                         | 178 ++++++++++++++++++++++++++----
>  hw/virtio/virtio-bus.c                    |   8 ++
>  hw/virtio/virtio-pci.c                    |  21 ++++
>  hw/virtio/virtio-pci.h                    |   4 +
>  hw/virtio/virtio.c                        |  57 ++++++----
>  include/exec/memory.h                     |   8 ++
>  include/hw/acpi/acpi-defs.h               |  12 ++
>  include/hw/i386/x86-iommu.h               |   1 +
>  include/hw/pci/pcie.h                     |   4 +
>  include/hw/virtio/vhost-backend.h         |  13 +++
>  include/hw/virtio/vhost.h                 |   4 +
>  include/hw/virtio/virtio-access.h         |  31 ++++--
>  include/hw/virtio/virtio-bus.h            |   1 +
>  include/hw/virtio/virtio.h                |   9 +-
>  include/standard-headers/linux/pci_regs.h |   1 +
>  memory.c                                  |   9 ++
>  net/tap.c                                 |   1 +
>  27 files changed, 582 insertions(+), 68 deletions(-)
> 
> -- 
> 2.7.4
