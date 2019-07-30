Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63049C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C7B320693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 17:22:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C7B320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsVpW-0007sd-DX
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 13:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60628)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hsVp4-0007PD-Ca
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hsVp2-0000Gq-PD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 13:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hsVoz-0000Dn-HI; Tue, 30 Jul 2019 13:21:57 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 59E79C049E1A;
 Tue, 30 Jul 2019 17:21:55 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-49.ams2.redhat.com [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CBB960BEC;
 Tue, 30 Jul 2019 17:21:40 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, mst@redhat.com, peter.maydell@linaro.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, kevin.tian@intel.com
Date: Tue, 30 Jul 2019 19:21:22 +0200
Message-Id: <20190730172137.23114-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Tue, 30 Jul 2019 17:21:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-4.2 v10 00/15] VIRTIO-IOMMU device
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
Cc: tn@semihalf.com, bharat.bhushan@nxp.com, peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series rebases the virtio-iommu device on qemu 4.1.0-rc2
and implements the v0.12 virtio-iommu spec. The driver has just been
upstreamed in 5.3 so kernel dependencies are now resolved.

The pci proxy for the virtio-iommu device is now available and needs
to be instantiated from the command line using "-device virtio-iommu-pci"=
.

At the moment the virtio-iommu-device only works in the ARM virt
machine with DT boot. Indeed, besides the device instantiation,
links between the PCIe root complex and the IOMMU must be described.
ACPI description is not yet supported at kernel level.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.1.0-rc2-virtio-iommu-v10
virtio-iommu kernel driver is available from 5.3-rc3 onwards

Testing:
- tested with guest using virtio-net-pci
  (,vhost=3Doff,iommu_platform,disable-modern=3Doff,disable-legacy=3Don)
  and virtio-blk-pci
- VFIO/VHOST integration is not part of this series. Please follow
  [PATCH RFC v5 0/5] virtio-iommu: VFIO integration respins

History:

v9 -> v10:
- rebase on 4.1.0-rc2, compliance with 0.12 spec
- removed ACPI part
- cleanup (see individual change logs)
- moved to a PATCH series

v8 -> v9:
- virtio-iommu-pci device needs to be instantiated from the command
  line (RID is not imposed anymore).
- tail structure properly initialized

v7 -> v8:
- virtio-iommu-pci added
- virt instantiation modified
- DT and ACPI modified to exclude the iommu RID from the mapping
- VIRTIO_IOMMU_F_BYPASS, VIRTIO_F_VERSION_1 features exposed

v6 -> v7:
- rebase on qemu 3.0.0-rc3
- minor update against v0.7
- fix issue with EP not on pci.0 and ACPI probing
- change the instantiation method

v5 -> v6:
- minor update against v0.6 spec
- fix g_hash_table_lookup in virtio_iommu_find_add_as
- replace some error_reports by qemu_log_mask(LOG_GUEST_ERROR, ...)

v4 -> v5:
- event queue and fault reporting
- we now return the IOAPIC MSI region if the virtio-iommu is instantiated
  in a PC machine.
- we bypass transactions on MSI HW region and fault on reserved ones.
- We support ACPI boot with mach-virt (based on IORT proposal)
- We moved to the new driver naming conventions
- simplified mach-virt instantiation
- worked around the disappearing of pci_find_primary_bus
- in virtio_iommu_translate, check the dev->as is not NULL
- initialize as->device_list in virtio_iommu_get_as
- initialize bufstate.error to false in virtio_iommu_probe

v3 -> v4:
- probe request support although no reserved region is returned at
  the moment
- unmap semantics less strict, as specified in v0.4
- device registration, attach/detach revisited
- split into smaller patches to ease review
- propose a way to inform the IOMMU mr about the page_size_mask
  of underlying HW IOMMU, if any
- remove warning associated with the translation of the MSI doorbell

v2 -> v3:
- rebase on top of 2.10-rc0 and especially
  [PATCH qemu v9 0/2] memory/iommu: QOM'fy IOMMU MemoryRegion
- add mutex init
- fix as->mappings deletion using g_tree_ref/unref
- when a dev is attached whereas it is already attached to
  another address space, first detach it
- fix some error values
- page_sizes =3D TARGET_PAGE_MASK;
- I haven't changed the unmap() semantics yet, waiting for the
  next virtio-iommu spec revision.

v1 -> v2:
- fix redifinition of viommu_as typedef


Eric Auger (15):
  update-linux-headers: Import virtio_iommu.h
  linux-headers: update against 5.3-rc2
  virtio-iommu: Add skeleton
  virtio-iommu: Decode the command payload
  virtio-iommu: Add the iommu regions
  virtio-iommu: Endpoint and domains structs and helpers
  virtio-iommu: Implement attach/detach command
  virtio-iommu: Implement map/unmap
  virtio-iommu: Implement translate
  virtio-iommu: Implement probe request
  virtio-iommu: Expose the IOAPIC MSI reserved region when relevant
  virtio-iommu: Implement fault reporting
  virtio_iommu: Handle reserved regions in translation process
  virtio-iommu-pci: Add virtio iommu pci support
  hw/arm/virt: Add the virtio-iommu device tree mappings

 hw/arm/virt.c                                 |   54 +-
 hw/virtio/Kconfig                             |    5 +
 hw/virtio/Makefile.objs                       |    2 +
 hw/virtio/trace-events                        |   25 +
 hw/virtio/virtio-iommu-pci.c                  |   88 ++
 hw/virtio/virtio-iommu.c                      | 1004 +++++++++++++++++
 include/hw/arm/virt.h                         |    2 +
 include/hw/pci/pci.h                          |    1 +
 include/hw/virtio/virtio-iommu.h              |   66 ++
 include/standard-headers/asm-x86/bootparam.h  |    2 +
 include/standard-headers/asm-x86/kvm_para.h   |    3 +
 include/standard-headers/linux/ethtool.h      |    2 +
 include/standard-headers/linux/pci_regs.h     |    4 +
 include/standard-headers/linux/virtio_ids.h   |    1 +
 include/standard-headers/linux/virtio_iommu.h |  165 +++
 include/standard-headers/linux/virtio_pmem.h  |    6 +-
 linux-headers/asm-arm/kvm.h                   |   12 +
 linux-headers/asm-arm/unistd-common.h         |    2 +
 linux-headers/asm-arm64/kvm.h                 |   17 +
 linux-headers/asm-generic/mman-common.h       |   15 +-
 linux-headers/asm-generic/mman.h              |   10 +-
 linux-headers/asm-generic/unistd.h            |    8 +-
 linux-headers/asm-mips/unistd_n32.h           |    1 +
 linux-headers/asm-mips/unistd_n64.h           |    1 +
 linux-headers/asm-mips/unistd_o32.h           |    1 +
 linux-headers/asm-powerpc/mman.h              |    6 +-
 linux-headers/asm-powerpc/unistd_32.h         |    1 +
 linux-headers/asm-powerpc/unistd_64.h         |    1 +
 linux-headers/asm-s390/unistd_32.h            |    2 +
 linux-headers/asm-s390/unistd_64.h            |    2 +
 linux-headers/asm-x86/kvm.h                   |   28 +-
 linux-headers/asm-x86/unistd_32.h             |    2 +
 linux-headers/asm-x86/unistd_64.h             |    2 +
 linux-headers/asm-x86/unistd_x32.h            |    2 +
 linux-headers/linux/kvm.h                     |   11 +-
 linux-headers/linux/psp-sev.h                 |    5 +-
 linux-headers/linux/virtio_iommu.h            |    1 +
 qdev-monitor.c                                |    1 +
 scripts/update-linux-headers.sh               |    3 +
 39 files changed, 1522 insertions(+), 42 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu-pci.c
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 include/standard-headers/linux/virtio_iommu.h
 create mode 100644 linux-headers/linux/virtio_iommu.h

--=20
2.20.1


