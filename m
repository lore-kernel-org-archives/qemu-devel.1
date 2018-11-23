Received: from eggs.gnu.org ([2001:4830:134:3::10]:52452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1gQEJz-0002fd-Fo
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:28:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shameerali.kolothum.thodi@huawei.com>)
	id 1gQEJv-0006Hk-He
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:28:45 -0500
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Date: Fri, 23 Nov 2018 16:28:13 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA8387E9A0C@FRAEML521-MBX.china.huawei.com>
References: <20180921081819.9203-1-eric.auger@redhat.com>
In-Reply-To: <20180921081819.9203-1-eric.auger@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v2 00/28] vSMMUv3/pSMMUv3 2 stage VFIO
 integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Cc: "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "cdall@kernel.org" <cdall@kernel.org>, "mst@redhat.com" <mst@redhat.com>, "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "peterx@redhat.com" <peterx@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, Linuxarm <linuxarm@huawei.com>, "xuwei (O)" <xuwei5@huawei.com>



> -----Original Message-----
> From: Qemu-devel [mailto:qemu-devel-
> bounces+shameerali.kolothum.thodi=3Dhuawei.com@nongnu.org] On Behalf Of
> Eric Auger
> Sent: 21 September 2018 09:18
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; peter.maydell@linaro.org
> Cc: yi.l.liu@intel.com; cdall@kernel.org; mst@redhat.com; jean-
> philippe.brucker@arm.com; peterx@redhat.com; alex.williamson@redhat.com
> Subject: [Qemu-devel] [RFC v2 00/28] vSMMUv3/pSMMUv3 2 stage VFIO
> integration
>=20

[...]

> This series can be found at:
> https://github.com/eauger/qemu/tree/v3.0.0_2stage-rfc-v2
>=20
> Testing:
> - For testing use my kernel branch
>   https://github.com/eauger/linux/tree/v4.19-rc4-2stage-rfc-v2 [1]
> - Tested on Qualcomm HW with 1/2 assigned e1000e NICs. Hotplug
>   was also tested OK.
> - Known limitation:
>   - currently sending an NH_ASID command instead of NH_VA
>     upon guest NH_VA. This may cause important perf downgrade.
>     Propagating NH_VA does not work at the moment.

Hi Eric,

I had a  go with this RFC on one of our platform and noted that when the Gu=
est=20
boots with ACPI , the ping doesn't work with the assigned ixgbevf NIC thoug=
h=20
the network device gets detected and added to the iommu group.=20

It's all fine when I boot the Guest with DT. Have you tested this with ACPI=
 yet or
am I missing anything obvious here?

Please let me know.

Thanks,
Shameer
=20
> References:
> - [1] [RFC v2 00/20] SMMUv3 Nested Stage Setup
>   (https://lkml.org/lkml/2018/9/18/1087)
>   The User API still is unstable and under discussion.
>=20
> History:
> v1 -> v2:
> - Fixed dual assignment (asid now correctly propagated on TLB invalidatio=
ns)
> - Integrated fault reporting
>=20
> Next Steps:
> - Mature the user API with people involved in SVA work (KVM forum may be =
a
>   good opportunity to meet)
> - Submit the IOMMU cfg notifier changes and some VFIO changes separately,
> to
>   progress independently on the kernel dependency
>=20
> Eric Auger (28):
>   hw/arm/smmu-common: Fix the name of the iommu memory regions
>   hw/arm/smmuv3: fix eventq recording and IRQ triggerring
>   update-linux-headers: Import iommu.h
>   linux-headers: Partial header update
>   memory: add IOMMU_ATTR_VFIO_NESTED IOMMU memory region attribute
>   hw/arm/smmuv3: Implement get_attr API to report
> IOMMU_ATTR_VFIO_NESTED
>   hw/vfio/common: Refactor container initialization
>   hw/vfio/common: Force nested if iommu requires it
>   memory: Introduce IOMMUIOLTBNotifier
>   memory: rename memory_region notify_iommu, notify_one
>   memory: Add IOMMUConfigNotifier
>   memory: Add arch_id in IOTLBEntry
>   hw/arm/smmuv3: Store s1ctrptr in translation config data
>   hw/arm/smmuv3: Implement dummy replay
>   hw/arm/smmuv3: Notify on config changes
>   hw/arm/smmuv3: Fill the IOTLBEntry arch_id on NH_VA invalidation
>   hw/vfio/common: Introduce vfio_alloc_guest_iommu helper
>   hw/vfio/common: Introduce vfio_dma_(un)map_ram_section helpers
>   hw/vfio/common: Register specific nested mode notifiers and
>     memory_listener
>   hw/vfio/common: Register MAP notifier for MSI binding
>   target/arm/kvm: Notifies IOMMU on MSI stage 1 binding
>   vfio/pci: Always set up MSI route before enabling vectors
>   hw/arm/smmuv3: Remove warning about unsupported MAP notifiers
>   memory: Introduce IOMMU_NOTIFIER_INIT_CFG IOMMU Config Notifier
>   memory: Introduce IOMMU Memory Region inject_faults API
>   hw/vfio/common: Handle fault_handler
>   hw/arm/smmuv3: Init fault handling
>   hw/arm/smmuv3: Implement fault injection
>=20
>  exec.c                          |  12 +-
>  hw/arm/smmu-common.c            |  12 +-
>  hw/arm/smmuv3-internal.h        |  26 +-
>  hw/arm/smmuv3.c                 | 189 +++++++--
>  hw/i386/intel_iommu.c           |  16 +-
>  hw/misc/tz-mpc.c                |   8 +-
>  hw/ppc/spapr_iommu.c            |   2 +-
>  hw/s390x/s390-pci-inst.c        |   4 +-
>  hw/vfio/common.c                | 666 ++++++++++++++++++++++++--------
>  hw/vfio/pci.c                   |   1 +
>  hw/vfio/trace-events            |   4 +-
>  hw/virtio/vhost.c               |  12 +-
>  include/exec/memory.h           | 140 +++++--
>  include/hw/arm/smmu-common.h    |   1 +
>  include/hw/vfio/vfio-common.h   |   1 +
>  linux-headers/linux/iommu.h     | 237 ++++++++++++
>  linux-headers/linux/vfio.h      |  48 +++
>  memory.c                        |  66 +++-
>  scripts/update-linux-headers.sh |   2 +-
>  target/arm/kvm.c                |  46 +--
>  20 files changed, 1206 insertions(+), 287 deletions(-)
>  create mode 100644 linux-headers/linux/iommu.h
>=20
> --
> 2.17.1
>=20
