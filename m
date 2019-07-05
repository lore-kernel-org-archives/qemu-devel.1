Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FE2C468AD
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F2B21670
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 11:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F2B21670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjill-0004t4-P5
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 07:22:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52323)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiid-0002p8-Jk
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yi.l.liu@intel.com>) id 1hjiic-0005qN-76
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:03 -0400
Received: from mga14.intel.com ([192.55.52.115]:2961)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yi.l.liu@intel.com>) id 1hjiib-0005e0-Ui
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 07:19:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Jul 2019 04:18:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,458,1557212400"; d="scan'208";a="363354897"
Received: from yiliu-dev.bj.intel.com ([10.238.156.139])
 by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2019 04:18:49 -0700
From: Liu Yi L <yi.l.liu@intel.com>
To: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 alex.williamson@redhat.com, peterx@redhat.com
Date: Fri,  5 Jul 2019 19:01:33 +0800
Message-Id: <1562324511-2910-1-git-send-email-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
Subject: [Qemu-devel] [RFC v1 00/18] intel_iommu: expose Shared Virtual
 Addressing to VM
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
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, eric.auger@redhat.com,
 yi.y.sun@intel.com, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Shared virtual address (SVA), a.k.a, Shared virtual memory (SVM) on Intel
platforms allow address space sharing between device DMA and applications.
SVA can reduce programming complexity and enhance security.
This series is intended to expose SVA capability to VMs. i.e. shared guest
application address space with passthru devices. The whole SVA virtualization
requires QEMU/VFIO/IOMMU changes. This series includes the QEMU changes, for
VFIO and IOMMU changes, they are in separate series (listed in the "Related
series").

The high-level architecture for SVA virtualization is as below:

    .-------------.  .---------------------------.
    |   vIOMMU    |  | Guest process CR3, FL only|
    |             |  '---------------------------'
    .----------------/
    | PASID Entry |--- PASID cache flush -
    '-------------'                       |
    |             |                       V
    |             |                CR3 in GPA
    '-------------'
Guest
------| Shadow |--------------------------|--------
      v        v                          v
Host
    .-------------.  .----------------------.
    |   pIOMMU    |  | Bind FL for GVA-GPA  |
    |             |  '----------------------'
    .----------------/  |
    | PASID Entry |     V (Nested xlate)
    '----------------\.------------------------------.
    |             |   |SL for GPA-HPA, default domain|
    |             |   '------------------------------'
    '-------------'
Where:
 - FL = First level/stage one page tables
 - SL = Second level/stage two page tables

There are roughly four parts:
1. Introduce PCIPASIDOps to PCIDevice to support PASID related operations
2. Passdown PASID allocation and free to host
3. Passdown guest PASID binding to host
4. Passdown guest IOMMU cache invalidation to host

Related series:
[1] [PATCH v4 00/22]  Shared virtual address IOMMU and VT-d support:
https://lwn.net/Articles/790820/
<My series is based on this kernel series from Jacob Pan>

[2] [RFC PATCH 0/4] vfio: support Shared Virtual Addressing from Yi Liu

This work is based on collaboration with other developers on the IOMMU
mailing list. Notably,
[1] [RFC PATCH 00/20] Qemu: Extend intel_iommu emulator to support
Shared Virtual Memory from Yi Liu
https://www.spinics.net/lists/kvm/msg148798.html

[2] [RFC PATCH 0/8] Shared Virtual Memory virtualization for VT-d from Yi Liu
https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021475.html

[3] [PATCH v3 00/12] Introduce new iommu notifier framework for virt-SVA
by Yi Liu
https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg00078.html

[4] [PATCH v6 00/22] SMMUv3 Nested Stage Setup by Eric Auger
https://lkml.org/lkml/2019/3/17/124

[5] [RFC v4 00/27] vSMMUv3/pSMMUv3 2 stage VFIO integration by Eric Auger
https://lists.sr.ht/~philmd/qemu/%3C20190527114203.2762-1-eric.auger%40redhat.com%3E

[6] [RFC PATCH 2/6] drivers core: Add I/O ASID allocator by Jean-Philippe
Brucker
https://www.spinics.net/lists/iommu/msg30639.html

Liu Yi L (18):
  linux-headers: import iommu.h from kernel
  linux-headers: import vfio.h from kernel
  hw/pci: introduce PCIPASIDOps to PCIDevice
  intel_iommu: add "sm_model" option
  vfio/pci: add pasid alloc/free implementation
  intel_iommu: support virtual command emulation and pasid request
  hw/pci: add pci_device_bind/unbind_gpasid
  vfio/pci: add vfio bind/unbind_gpasid implementation
  intel_iommu: process pasid cache invalidation
  intel_iommu: tag VTDAddressSpace instance with PASID
  intel_iommu: create VTDAddressSpace per BDF+PASID
  intel_iommu: bind/unbind guest page table to host
  intel_iommu: flush pasid cache after a DSI context cache flush
  hw/pci: add flush_pasid_iotlb() in PCIPASIDOps
  vfio/pci: adds support for PASID-based iotlb flush
  intel_iommu: add PASID-based iotlb invalidation support
  intel_iommu: propagate PASID-based iotlb flush to host
  intel_iommu: do not passdown pasid bind for PASID #0

 hw/i386/intel_iommu.c          | 811 ++++++++++++++++++++++++++++++++++++++++-
 hw/i386/intel_iommu_internal.h |  97 +++++
 hw/i386/trace-events           |   7 +
 hw/pci/pci.c                   |  95 +++++
 hw/vfio/pci.c                  | 138 +++++++
 include/hw/i386/intel_iommu.h  |  22 +-
 include/hw/pci/pci.h           |  27 ++
 linux-headers/linux/iommu.h    | 338 +++++++++++++++++
 linux-headers/linux/vfio.h     | 116 ++++++
 9 files changed, 1644 insertions(+), 7 deletions(-)
 create mode 100644 linux-headers/linux/iommu.h

-- 
2.7.4


