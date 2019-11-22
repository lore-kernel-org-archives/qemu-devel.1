Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B3CC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4EC2068F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 18:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iH9QJHsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4EC2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDig-0000eh-A8
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 13:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1iYDh4-0007Yw-Bf
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1iYDh1-0007zS-64
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52766
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1iYDh1-0007yv-2H
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 13:30:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574447406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5hE4YyL9JE+UetpQS9qrlJo5Nenw9bcwxRibUWjNDzk=;
 b=iH9QJHsYjkZZb6R6y6BQaEEmMPFeEOA3wLBMBdqzj94yqXS9TZTHbNtbpmkHbp7tx95sk5
 9Znh4dhssq1Uc6QWtNPIopQEyijndudIg9KEcJN3r39/aSNopjbipCZ/ctca/aBfasXF8Q
 aWA4bR+PkRmPYwD9kqxK7QrLxSWuN8E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-ufPVXPRiOGmHvbGv174bIQ-1; Fri, 22 Nov 2019 13:30:02 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C222B9FA58;
 Fri, 22 Nov 2019 18:30:00 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9F6099F47;
 Fri, 22 Nov 2019 18:29:49 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, mst@redhat.com,
 armbru@redhat.com, jean-philippe.brucker@arm.com, bharatb.linux@gmail.com,
 yang.zhong@intel.com, dgilbert@redhat.com, quintela@redhat.com
Subject: [PATCH for-5.0 v11 00/20] VIRTIO-IOMMU device
Date: Fri, 22 Nov 2019 19:29:23 +0100
Message-Id: <20191122182943.4656-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ufPVXPRiOGmHvbGv174bIQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: kevin.tian@intel.com, peterx@redhat.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series implements the QEMU virtio-iommu device.

This matches the v0.12 spec and the corresponding virtio-iommu
driver upstreamed in 5.3.

The pci proxy for the virtio-iommu device is instantiated using
"-device virtio-iommu-pci". This series still relies on ACPI IORT/DT
integration. Note the ACPI IORT integration is not yet upstreamed
and testing needs to be based on Jean-Philippe's additional
kernel patches [1].

Work is ongoing to remove IORT adherence and allow the
bindings between the IOMMU and the root complex to be defined
and written into the PCI device configuration space. The outcome
of this work is uncertain at this stage though. See [2].

So only patches 1-11 fully rely on upstreamed kernel code. Others
should be considered as RFC.

This respin allows people to test on ARM and x86. It also
brings migration support (tested on ARM) and various cleanups.
Reserved regions are now passed through an array of properties.
A libqos test also is introduced to test the virtio-iommu API.

Note integration with vhost devices and vfio devices is not part
of this series. Please follow Bharat's respins [3].

The 1st Patch ("migration: Support QLIST migration") was sent
separately [4].

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2-rc2-virtio-iommu-v11

[1] kernel branch to be used for guest
    https://github.com/eauger/linux/tree/v5.4-rc8-virtio-iommu-iort
[2] [RFC 00/13] virtio-iommu on non-devicetree platforms
[3] VFIO/VHOST integration is not part of this series. Please follow
    [PATCH RFC v5 0/5] virtio-iommu: VFIO integration respins
[4] [PATCH v6] migration: Support QLIST migration

Testing:
- tested with guest using virtio-net-pci
  (,vhost=3Doff,iommu_platform,disable-modern=3Doff,disable-legacy=3Don)
  and virtio-blk-pci
- migration on ARM
- on x86 PC machine I get some AHCI non translated transactions,
  very early. This does not prevent the guest from boot and behaving
  properly. Warnings look like:
qemu-system-x86_64: virtio_iommu_translate sid=3D250 is not known!!
qemu-system-x86_64: no buffer available in event queue to report event
qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS
receive buffer address

History:

v10 -> v11:
- introduce virtio_iommu_handle_req macro
- migration support
- introduce DEFINE_PROP_INTERVAL and pass reserved regions
  through an array of those
- domain gtree simplification

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
- fix redefinition of viommu_as typedef



Eric Auger (20):
  migration: Support QLIST migration
  virtio-iommu: Add skeleton
  virtio-iommu: Decode the command payload
  virtio-iommu: Add the iommu regions
  virtio-iommu: Endpoint and domains structs and helpers
  virtio-iommu: Implement attach/detach command
  virtio-iommu: Implement map/unmap
  virtio-iommu: Implement translate
  virtio-iommu: Implement fault reporting
  virtio-iommu-pci: Add virtio iommu pci support
  hw/arm/virt: Add the virtio-iommu device tree mappings
  qapi: Introduce DEFINE_PROP_INTERVAL
  virtio-iommu: Implement probe request
  virtio-iommu: Handle reserved regions in the translation process
  virtio-iommu-pci: Add array of Interval properties
  hw/arm/virt-acpi-build: Introduce fill_iort_idmap helper
  hw/arm/virt-acpi-build: Add virtio-iommu node in IORT table
  virtio-iommu: Support migration
  pc: Add support for virtio-iommu-pci
  tests: Add virtio-iommu test

 hw/arm/virt-acpi-build.c         |  91 ++-
 hw/arm/virt.c                    |  53 +-
 hw/core/qdev-properties.c        |  90 +++
 hw/i386/acpi-build.c             |  72 +++
 hw/i386/pc.c                     |  15 +-
 hw/virtio/Kconfig                |   5 +
 hw/virtio/Makefile.objs          |   2 +
 hw/virtio/trace-events           |  22 +
 hw/virtio/virtio-iommu-pci.c     |  91 +++
 hw/virtio/virtio-iommu.c         | 952 +++++++++++++++++++++++++++++++
 include/exec/memory.h            |   6 +
 include/hw/acpi/acpi-defs.h      |  21 +-
 include/hw/arm/virt.h            |   2 +
 include/hw/i386/pc.h             |   2 +
 include/hw/pci/pci.h             |   1 +
 include/hw/qdev-properties.h     |   3 +
 include/hw/virtio/virtio-iommu.h |  67 +++
 include/migration/vmstate.h      |  21 +
 include/qemu/queue.h             |  39 ++
 include/qemu/typedefs.h          |   1 +
 migration/trace-events           |   5 +
 migration/vmstate-types.c        |  70 +++
 qdev-monitor.c                   |   1 +
 tests/Makefile.include           |   2 +
 tests/libqos/virtio-iommu.c      | 177 ++++++
 tests/libqos/virtio-iommu.h      |  45 ++
 tests/test-vmstate.c             | 170 ++++++
 tests/virtio-iommu-test.c        | 261 +++++++++
 28 files changed, 2253 insertions(+), 34 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu-pci.c
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 tests/libqos/virtio-iommu.c
 create mode 100644 tests/libqos/virtio-iommu.h
 create mode 100644 tests/virtio-iommu-test.c

--=20
2.20.1


