Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC19C282CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:06:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E3C2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 10:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7E3C2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33520 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEt4g-00023G-QO
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 06:06:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt2l-0000fl-Fp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1hEt2j-0003SP-Ki
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 06:04:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63017)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1hEt2f-0003OM-4m; Fri, 12 Apr 2019 06:04:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AA27104D78;
	Fri, 12 Apr 2019 10:04:14 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-161.ams2.redhat.com [10.36.117.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C4E9619C65;
	Fri, 12 Apr 2019 10:03:58 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
	qemu-arm@nongnu.org, peter.maydell@linaro.org
Date: Fri, 12 Apr 2019 12:03:27 +0200
Message-Id: <20190412100354.6409-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 12 Apr 2019 10:04:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC v3 00/27] vSMMUv3/pSMMUv3 2 stage VFIO integration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: yi.l.liu@intel.com, mst@redhat.com, jean-philippe.brucker@arm.com,
	peterx@redhat.com, alex.williamson@redhat.com, vincent.stehle@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412100327.d7chkQyHeyLpFlnzxh4oozATLygY5QC7tHYDQqwZrFQ@z>

Up to now vSMMUv3 has not been integrated with VFIO. VFIO
integration requires to program the physical IOMMU consistently
with the guest mappings. However, as opposed to VTD, SMMUv3 has
no "Caching Mode" which allows easy trapping of guest mappings.
This means the vSMMUV3 cannot use the same VFIO integration as VTD.

However SMMUv3 has 2 translation stages. This was devised with
virtualization use case in mind where stage 1 is "owned" by the
guest whereas the host uses stage 2 for VM isolation.

This series sets up this nested translation stage. It only works
if there is one physical SMMUv3 used along with QEMU vSMMUv3 (in
other words, it does not work if there is a physical SMMUv2).

The series uses a new kernel user API [1], still under definition.

- We force the host to use stage 2 instead of stage 1, when we
  detect a vSMMUV3 is behind a VFIO device. For a VFIO device
  without any virtual IOMMU, we still use stage 1 as many existing
  SMMUs expect this behavior.
- We introduce new IOTLB "config" notifiers, requested to notify
  changes in the config of a given iommu memory region. So now
  we have notifiers for IOTLB changes and config changes.
- vSMMUv3 calls config notifiers when STE (Stream Table Entries)
  are updated by the guest.
- We implement a specific UNMAP notifier that conveys guest
  IOTLB invalidations to the host
- We implement a new MAP notifiers only used for MSI IOVAs so
  that the host can build a nested stage translation for MSI IOVAs
- As the legacy MAP notifier is not called anymore, we must make
  sure stage 2 mappings are set. This is achieved through another
  memory listener.
- Physical SMMUs faults are reported to the guest via en eventfd
  mechanism and reinjected into this latter.

Note: The 2 first patches were sent separately.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.0.0-rc2-2stage-rfcv3

Compatible with kernel series:
[PATCH v7 00/23] SMMUv3 Nested Stage Setup
https://github.com/eauger/linux/tree/v5.1-rc3-2stage-v7

History:
v2 -> v3:
- rework fault handling
- MSI binding registration done in vfio-pci. MSI binding tear down called
  on container cleanup path
- leaf parameter propagated

v1 -> v2:
- Fixed dual assignment (asid now correctly propagated on TLB invalidatio=
ns)
- Integrated fault reporting

Next Steps:
- Mature the user API with people involved in SVA work (KVM forum may be =
a
  good opportunity to meet)
- Submit the IOMMU cfg notifier changes and some VFIO changes separately,=
 to
  progress independently on the kernel dependency


Eric Auger (27):
  hw/arm/smmuv3: Remove SMMUNotifierNode
  vfio/common: Introduce vfio_set_irq_signaling helper
  update-linux-headers: Import iommu.h
  header update against 5.1-rc3 and IOMMU/VFIO nested stage APIs
  memory: add IOMMU_ATTR_VFIO_NESTED IOMMU memory region attribute
  memory: add IOMMU_ATTR_MSI_TRANSLATE IOMMU memory region attribute
  hw/arm/smmuv3: Advertise VFIO_NESTED and MSI_TRANSLATE attributes
  hw/vfio/common: Force nested if iommu requires it
  memory: Prepare for different kinds of IOMMU MR notifiers
  memory: Add IOMMUConfigNotifier
  memory: Add arch_id and leaf fields in IOTLBEntry
  hw/arm/smmuv3: Store the PASID table GPA in the translation config
  hw/arm/smmuv3: Implement dummy replay
  hw/arm/smmuv3: Fill the IOTLBEntry arch_id on NH_VA invalidation
  hw/arm/smmuv3: Fill the IOTLBEntry leaf field on NH_VA invalidation
  hw/arm/smmuv3: Notify on config changes
  hw/vfio/common: Introduce vfio_alloc_guest_iommu helper
  hw/vfio/common: Introduce hostwin_from_range helper
  hw/vfio/common: Introduce helpers to DMA map/unap a RAM section
  hw/vfio/common: Setup nested stage mappings
  hw/vfio/common: Register a MAP notifier for MSI binding
  vfio-pci: Expose MSI stage 1 bindings to the host
  memory: Introduce IOMMU Memory Region inject_faults API
  hw/arm/smmuv3: Implement fault injection
  vfio-pci: register handler for iommu fault
  vfio-pci: Set up fault regions
  vfio-pci: Implement the DMA fault handler

 exec.c                                        |  12 +-
 hw/arm/smmu-common.c                          |  16 +-
 hw/arm/smmuv3.c                               | 212 +++++--
 hw/arm/trace-events                           |   3 +-
 hw/i386/amd_iommu.c                           |   2 +-
 hw/i386/intel_iommu.c                         |  25 +-
 hw/misc/tz-mpc.c                              |   8 +-
 hw/ppc/spapr_iommu.c                          |   2 +-
 hw/s390x/s390-pci-inst.c                      |   4 +-
 hw/vfio/common.c                              | 548 ++++++++++++++----
 hw/vfio/pci.c                                 | 469 +++++++++------
 hw/vfio/pci.h                                 |   4 +
 hw/vfio/platform.c                            |  55 +-
 hw/vfio/trace-events                          |   6 +-
 hw/virtio/vhost.c                             |  14 +-
 include/exec/memory.h                         | 159 ++++-
 include/hw/arm/smmu-common.h                  |   9 +-
 include/hw/vfio/vfio-common.h                 |  10 +
 .../infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h |  15 +-
 include/standard-headers/drm/drm_fourcc.h     |  63 ++
 include/standard-headers/linux/ethtool.h      |  33 +-
 .../linux/input-event-codes.h                 |   2 +
 include/standard-headers/linux/input.h        |   6 +-
 include/standard-headers/linux/pci_regs.h     |   2 +
 .../standard-headers/linux/virtio_config.h    |   6 +
 include/standard-headers/linux/virtio_ring.h  |  10 -
 .../standard-headers/rdma/vmw_pvrdma-abi.h    |   1 +
 linux-headers/asm-arm/unistd-common.h         |  22 +
 linux-headers/asm-arm64/unistd.h              |   2 +
 linux-headers/asm-generic/unistd.h            | 158 +++--
 linux-headers/asm-mips/unistd_n32.h           |  20 +
 linux-headers/asm-mips/unistd_o32.h           |  30 +
 linux-headers/asm-powerpc/kvm.h               |   2 +
 linux-headers/asm-powerpc/unistd_32.h         |  30 +
 linux-headers/asm-powerpc/unistd_64.h         |  11 +
 linux-headers/asm-s390/unistd_32.h            |  33 ++
 linux-headers/asm-s390/unistd_64.h            |  14 +
 linux-headers/asm-x86/unistd_32.h             |  34 ++
 linux-headers/asm-x86/unistd_64.h             |   4 +
 linux-headers/asm-x86/unistd_x32.h            |   4 +
 linux-headers/linux/iommu.h                   | 240 ++++++++
 linux-headers/linux/vfio.h                    | 107 ++++
 memory.c                                      |  69 ++-
 scripts/update-linux-headers.sh               |   2 +-
 44 files changed, 1965 insertions(+), 513 deletions(-)
 create mode 100644 linux-headers/linux/iommu.h

--=20
2.20.1


