Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CCDC282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:45:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2196C20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 14:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1vIJQtR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2196C20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipZ3X-00083m-PQ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 09:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eric.auger@redhat.com>) id 1ipZ2F-0006ds-CJ
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1ipZ2C-0004y8-JM
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:43:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1ipZ2C-0004rN-FN
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 09:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578581019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tAS0JQmIS6a/1f824K0abzAAukj4cbd0pTHJ+0RvriQ=;
 b=I1vIJQtRmhaaHM2ROK5EPyI2QYOFr/f+7/2ZQdztKffQkq5Agxr73hmo+cSTc9eEXrT3/B
 yNjcMrA/Z5AY2IKjtY5u3BT6iuNQcfOpZlgVpKGjRUpht9F51qZoD8fP1S984nxJc1TV5I
 PA20/KEe34NNdjI76If0vFGEbXkz60c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-2gsxiXGiOtecPnPaOLiwvQ-1; Thu, 09 Jan 2020 09:43:38 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6A59FDB61;
 Thu,  9 Jan 2020 14:43:36 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA9A161069;
 Thu,  9 Jan 2020 14:43:25 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, jean-philippe@linaro.org,
 dgilbert@redhat.com, quintela@redhat.com, mst@redhat.com, peterx@redhat.com
Subject: [PATCH v12 00/13] VIRTIO-IOMMU device
Date: Thu,  9 Jan 2020 15:43:06 +0100
Message-Id: <20200109144319.15912-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2gsxiXGiOtecPnPaOLiwvQ-1
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
Cc: kevin.tian@intel.com, bharatb.linux@gmail.com, tnowicki@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This series implements the QEMU virtio-iommu device.

This matches the v0.12 spec (voted) and the corresponding
virtio-iommu driver upstreamed in 5.3. All kernel dependencies
are resolved for DT integration. The virtio-iommu can be
instantiated in ARM virt using "-device virtio-iommu-pci".
Non DT mode is not yet supported.

This feature targets 5.0.

For non DT integration, guest kernel dependencies are not resolved
yet. Historically, an approach based on the ACPI IORT was used.
However this is not considered as the best approach anymore.
Alternative approaches are under discussion in [2] but they are
still in RFC state. So considering the time needed to get this
stabilized and the spec updated, I hope the DT integration for ARM
can be merged first.

Integration with vhost devices and vfio devices is not part
of this series. Please follow Bharat's respins [3].

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v4.2-virtio-iommu-v12
This branch also supports ACPI/IORT integration for both ARM
and x86.

References:
[1] kernel branch to be used for guest for testing on ARM or
    x86 with ACPI/IORT integration:
    https://github.com/eauger/linux/tree/v5.4-rc8-virtio-iommu-iort
    for testing the DT boot on ARM, upstream kernel can be used.
[2] [RFC 00/13] virtio-iommu on non-devicetree platforms
[3] VFIO/VHOST integration is not part of this series. Please follow
    [PATCH RFC v5 0/5] virtio-iommu: VFIO integration respins

Testing:
- tested with guest using virtio-net-pci
  (,vhost=3Doff,iommu_platform,disable-modern=3Doff,disable-legacy=3Don)
  and virtio-blk-pci
- migration on ARM and x86
- on x86 PC machine AHCI unmapped transactions are observed at early
  boot stage. This does not prevent the guest from booting and behaving
  properly. Warnings look like:
qemu-system-x86_64: virtio_iommu_translate sid=3D250 is not known!!
qemu-system-x86_64: no buffer available in event queue to report event
qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS
receive buffer address
This is due to the fact that by default the virtio-iommu device blocks
unmapped transations. This is likely to change in the future.

History:

v11 -> v12:
- took into account Peter and Jean's comments
  - use guest features
  - restore as_by_bus_num and when attaching devices, check they are
    actually protected by the IOMMU. Updated the tests accordingly.
  - fix the mapping ref counting and make sure mappings are properly
    cleaned.
  - Use CamelCase for data types
  - simplify postload callback as suggested by Peter
  - add R-bs
- fix mingw compilation issue
- add IOMMU migration priority
- qlist migration load simplified following Juan's suggestion

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


Eric Auger (13):
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
  virtio-iommu: Support migration
  tests: Add virtio-iommu test

 hw/arm/virt.c                    |  54 +-
 hw/virtio/Kconfig                |   5 +
 hw/virtio/Makefile.objs          |   2 +
 hw/virtio/trace-events           |  20 +
 hw/virtio/virtio-iommu-pci.c     |  88 +++
 hw/virtio/virtio-iommu.c         | 902 +++++++++++++++++++++++++++++++
 include/hw/arm/virt.h            |   2 +
 include/hw/pci/pci.h             |   1 +
 include/hw/virtio/virtio-iommu.h |  64 +++
 include/migration/vmstate.h      |  21 +
 include/qemu/queue.h             |  32 ++
 migration/trace-events           |   5 +
 migration/vmstate-types.c        |  74 +++
 qdev-monitor.c                   |   1 +
 tests/Makefile.include           |   2 +
 tests/libqos/virtio-iommu.c      | 177 ++++++
 tests/libqos/virtio-iommu.h      |  45 ++
 tests/test-vmstate.c             | 170 ++++++
 tests/virtio-iommu-test.c        | 308 +++++++++++
 19 files changed, 1965 insertions(+), 8 deletions(-)
 create mode 100644 hw/virtio/virtio-iommu-pci.c
 create mode 100644 hw/virtio/virtio-iommu.c
 create mode 100644 include/hw/virtio/virtio-iommu.h
 create mode 100644 tests/libqos/virtio-iommu.c
 create mode 100644 tests/libqos/virtio-iommu.h
 create mode 100644 tests/virtio-iommu-test.c

--=20
2.20.1


