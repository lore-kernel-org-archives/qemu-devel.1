Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C74DC4332D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C735420724
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9b6OcbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C735420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFL09-0003TM-Rw
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1jFKzI-0002R5-WE
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1jFKzH-0003pw-3e
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:59:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25841)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1jFKzG-0003pA-PJ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 12:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584723550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FEDfEuVxkMtr1RXUfx7aDAWkicAcG614Y6zaNEL5rAA=;
 b=P9b6OcbR9+yi2jCTRxgKCrMXKZ/CyAJMRoW+/IE2qhBupx3nGjl5CPb1U8g4BO0bNgTJyR
 MhoK0PbJOwGq5zU4EvaQT15eGwYkxRIteHD/kPnf3KWYT3pwI891qoBG3FUVi6fYF2Wd1O
 5as+H+6d+Wl46wp6GXplRVifSs51lX0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-5H2nNXgPN3-F8t_XXGQjlQ-1; Fri, 20 Mar 2020 12:59:08 -0400
X-MC-Unique: 5H2nNXgPN3-F8t_XXGQjlQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7C4A18C8C00;
 Fri, 20 Mar 2020 16:59:05 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4141E19757;
 Fri, 20 Mar 2020 16:58:47 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 alex.williamson@redhat.com, jacob.jun.pan@linux.intel.com,
 yi.l.liu@intel.com
Subject: [RFC v6 00/24] vSMMUv3/pSMMUv3 2 stage VFIO integration
Date: Fri, 20 Mar 2020 17:58:16 +0100
Message-Id: <20200320165840.30057-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jean-philippe@linaro.org, tnowicki@marvell.com, maz@kernel.org,
 zhangfei.gao@foxmail.com, peterx@redhat.com,
 shameerali.kolothum.thodi@huawei.com, zhangfei.gao@linaro.org,
 bbhushan2@marvell.com, will@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

- We force the host to use stage 2 instead of stage 1, when we
  detect a vSMMUV3 is behind a VFIO device. For a VFIO device
  without any virtual IOMMU, we still use stage 1 as many existing
  SMMUs expect this behavior.
- We use PCIPASIDOps to propage guest stage1 config changes on
  STE (Stream Table Entry) changes.
- We implement a specific UNMAP notifier that conveys guest
  IOTLB invalidations to the host
- We register MSI IOVA/GPA bindings to the host so that this latter
  can build a nested stage translation
- As the legacy MAP notifier is not called anymore, we must make
  sure stage 2 mappings are set. This is achieved through another
  prereg memory listener.
- Physical SMMU stage 1 related faults are reported to the guest
  via en eventfd mechanism and exposed trhough a dedicated VFIO-PCI
  region. Then they are reinjected into the guest.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2.0-2stage-rfcv6

Kernel Dependencies:
[1] [PATCH v10 00/11] SMMUv3 Nested Stage Setup (VFIO part)
[2] [PATCH v10 00/13] SMMUv3 Nested Stage Setup (IOMMU part)
branch at: https://github.com/eauger/linux/tree/will-arm-smmu-updates-2stag=
e-v10

History:

v5 -> v6:
- just rebase work

v4 -> v5:
- Use PCIPASIDOps for config update notifications
- removal of notification for MSI binding which is not needed
  anymore
- Use a single fault region
- use the specific interrupt index

v3 -> v4:
- adapt to changes in uapi (asid cache invalidation)
- check VFIO_PCI_DMA_FAULT_IRQ_INDEX is supported at kernel level
  before attempting to set signaling for it.
- sync on 5.2-rc1 kernel headers + Drew's patch that imports sve_context.h
- fix MSI binding for MSI (not MSIX)
- fix mingw compilation

v2 -> v3:
- rework fault handling
- MSI binding registration done in vfio-pci. MSI binding tear down called
  on container cleanup path
- leaf parameter propagated

v1 -> v2:
- Fixed dual assignment (asid now correctly propagated on TLB invalidations=
)
- Integrated fault reporting


Eric Auger (23):
  update-linux-headers: Import iommu.h
  header update against 5.6.0-rc3 and IOMMU/VFIO nested stage APIs
  memory: Add IOMMU_ATTR_VFIO_NESTED IOMMU memory region attribute
  memory: Add IOMMU_ATTR_MSI_TRANSLATE IOMMU memory region attribute
  memory: Introduce IOMMU Memory Region inject_faults API
  memory: Add arch_id and leaf fields in IOTLBEntry
  iommu: Introduce generic header
  vfio: Force nested if iommu requires it
  vfio: Introduce hostwin_from_range helper
  vfio: Introduce helpers to DMA map/unmap a RAM section
  vfio: Set up nested stage mappings
  vfio: Pass stage 1 MSI bindings to the host
  vfio: Helper to get IRQ info including capabilities
  vfio/pci: Register handler for iommu fault
  vfio/pci: Set up the DMA FAULT region
  vfio/pci: Implement the DMA fault handler
  hw/arm/smmuv3: Advertise MSI_TRANSLATE attribute
  hw/arm/smmuv3: Store the PASID table GPA in the translation config
  hw/arm/smmuv3: Fill the IOTLBEntry arch_id on NH_VA invalidation
  hw/arm/smmuv3: Fill the IOTLBEntry leaf field on NH_VA invalidation
  hw/arm/smmuv3: Pass stage 1 configurations to the host
  hw/arm/smmuv3: Implement fault injection
  hw/arm/smmuv3: Allow MAP notifiers

Liu Yi L (1):
  pci: introduce PCIPASIDOps to PCIDevice

 hw/arm/smmuv3.c                 | 189 ++++++++++--
 hw/arm/trace-events             |   3 +-
 hw/pci/pci.c                    |  34 +++
 hw/vfio/common.c                | 506 +++++++++++++++++++++++++-------
 hw/vfio/pci.c                   | 267 ++++++++++++++++-
 hw/vfio/pci.h                   |   9 +
 hw/vfio/trace-events            |   9 +-
 include/exec/memory.h           |  49 +++-
 include/hw/arm/smmu-common.h    |   1 +
 include/hw/iommu/iommu.h        |  28 ++
 include/hw/pci/pci.h            |  11 +
 include/hw/vfio/vfio-common.h   |  16 +
 linux-headers/COPYING           |   2 +
 linux-headers/asm-x86/kvm.h     |   1 +
 linux-headers/linux/iommu.h     | 375 +++++++++++++++++++++++
 linux-headers/linux/vfio.h      | 109 ++++++-
 memory.c                        |  10 +
 scripts/update-linux-headers.sh |   2 +-
 18 files changed, 1478 insertions(+), 143 deletions(-)
 create mode 100644 include/hw/iommu/iommu.h
 create mode 100644 linux-headers/linux/iommu.h

--=20
2.20.1


