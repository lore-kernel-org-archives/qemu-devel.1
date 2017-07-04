Received: from eggs.gnu.org ([2001:4830:134:3::10]:41555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZ0-0003nF-6p
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHYv-0002sH-As
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHYv-0002r6-1C
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:43:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 41514C0587C8
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:43:51 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:27 +0800
Message-Id: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 00/20] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

v3: Include Igor's patch, and fix virtio-crypto too.
    Always use qdev_prop_allow_set_link_before_realize and
    OBJ_PROP_LINK_UNREF_ON_RELEASE.
    Include as many applicable devices as possible and some more clean-ups.
    There are still more left but they use uncommon check and flags parameters,
    it's better to take care of them in following batches.

v2: Create a new header for link properties. [Paolo]
    Don't wrap, use PropertyInfo.create() (much better diffstat, yay!).
    [Paolo]

Link properties of devices created with object_property_add_link() are not
reflected in HMP "info qtree". For example, whether a virtio-blk device has an
iothread (i.e. has enabled data plane) can not be introspected easily.

Introduce a new type of qdev property macro to fix that.

Fam Zheng (19):
  qdev: Introduce PropertyInfo.create
  qdev: Introduce DEFINE_PROP_LINK
  qmp: Use ObjectProperty.type if present
  qdev: Add const qualifier to PropertyInfo definitions
  virtio-blk: Convert to DEFINE_PROP_LINK
  virtio-scsi: Convert to DEFINE_PROP_LINK
  virtio-rng: Convert to DEFINE_PROP_LINK
  virtio-crypto: Convert to DEFINE_PROP_LINK
  dimm: Convert to DEFINE_PROP_LINK
  ivshmem: Convert to DEFINE_PROP_LINK
  armv7m: Convert bitband.source-mamory to DEFINE_PROP_LINK
  armv7m: Convert armv7m.memory to DEFINE_PROP_LINK
  gicv3: Convert to DEFINE_PROP_LINK
  xlnx_zynqmp: Convert to DEFINE_PROP_LINK
  xilinx_axienet: Convert to DEFINE_PROP_LINK
  xilinx_axidma: Convert to DEFINE_PROP_LINK
  mips_cmgcr: Convert to DEFINE_PROP_LINK
  cpu: Convert to DEFINE_PROP_LINK
  spapr_rng: Convert to DEFINE_PROP_LINK

Igor Mammedov (1):
  qom: enforce readonly nature of link's check callback

 cpus.c                                 |  5 +--
 exec.c                                 | 30 ++++++++--------
 hw/arm/armv7m.c                        | 20 ++++-------
 hw/arm/xlnx-zynqmp.c                   | 12 +++----
 hw/block/dataplane/virtio-blk.c        |  2 +-
 hw/block/virtio-blk.c                  |  5 +--
 hw/core/qdev-properties-system.c       |  8 ++---
 hw/core/qdev-properties.c              | 63 ++++++++++++++++++++++------------
 hw/core/qdev.c                         | 31 ++++++++++-------
 hw/display/xlnx_dp.c                   |  2 +-
 hw/dma/xilinx_axidma.c                 | 26 ++++++--------
 hw/intc/arm_gicv3_its_kvm.c            | 18 ++++------
 hw/ipmi/ipmi.c                         |  2 +-
 hw/mem/nvdimm.c                        | 11 +++---
 hw/mem/pc-dimm.c                       | 42 ++++++++---------------
 hw/misc/ivshmem.c                      | 34 +++++++-----------
 hw/misc/mips_cmgcr.c                   | 22 ++++--------
 hw/net/xilinx_axienet.c                | 31 +++++++----------
 hw/ppc/spapr_rng.c                     | 13 +++----
 hw/s390x/css.c                         |  4 +--
 hw/s390x/s390-pci-bus.c                |  2 +-
 hw/s390x/virtio-ccw.c                  |  9 -----
 hw/scsi/virtio-scsi-dataplane.c        |  2 +-
 hw/scsi/virtio-scsi.c                  | 13 ++-----
 hw/virtio/virtio-crypto-pci.c          |  2 --
 hw/virtio/virtio-crypto.c              | 56 ++++++++++--------------------
 hw/virtio/virtio-pci.c                 |  6 ----
 hw/virtio/virtio-rng.c                 | 14 ++------
 include/hw/arm/armv7m.h                |  5 +--
 include/hw/arm/xlnx-zynqmp.h           |  3 +-
 include/hw/intc/arm_gicv3_its_common.h |  3 +-
 include/hw/mem/pc-dimm.h               |  3 +-
 include/hw/misc/mips_cmgcr.h           |  5 +--
 include/hw/qdev-core.h                 |  6 ++--
 include/hw/qdev-properties.h           | 62 +++++++++++++++++++--------------
 include/hw/s390x/css.h                 |  4 +--
 include/hw/virtio/virtio-blk.h         |  3 +-
 include/hw/virtio/virtio-crypto.h      |  3 +-
 include/hw/virtio/virtio-rng.h         |  3 +-
 include/hw/virtio/virtio-scsi.h        |  3 +-
 include/qom/cpu.h                      |  4 ++-
 include/qom/object.h                   |  6 ++--
 qmp.c                                  |  5 +--
 qom/cpu.c                              |  1 +
 qom/object.c                           |  8 ++---
 target/arm/cpu.c                       |  6 ++--
 target/i386/cpu.c                      |  7 ++--
 target/ppc/translate_init.c            |  2 +-
 48 files changed, 282 insertions(+), 345 deletions(-)

-- 
2.9.4
