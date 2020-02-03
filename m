Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2460EC33C9E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C8820658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 06:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="i6GSQZtG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C8820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyVFu-00053h-Mx
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 01:30:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57825)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUy2-0003ih-UA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iyUxm-0003QI-RB
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 01:12:12 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58149 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iyUxl-0002ca-J6; Mon, 03 Feb 2020 01:12:02 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 489yBq28pkz9sSm; Mon,  3 Feb 2020 17:11:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580710291;
 bh=qghgtwA+e8gkhfIsZ51v8xv5K+vikaROzV/1uwWgHe4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i6GSQZtGZ2EvGOXe43gksui/k0hmTj0waNCZ8uykaKqMHpHsdHbn6Ll8JYlma+PMl
 LEvQcoMGAzTXI3dEnJFx493YYzpMWmFC/hHrxYx1vvdKwq50RKLyETteBksceetsbg
 83dtpiMT3Hh4k82wSj7yki1nBlhUydLQVcapkm+4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 19/35] ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge
Date: Mon,  3 Feb 2020 17:11:07 +1100
Message-Id: <20200203061123.59150-20-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

These changes introduces models for the PCIe Host Bridge (PHB4) of the
POWER9 processor. It includes the PowerBus logic interface (PBCQ),
IOMMU support, a single PCIe Gen.4 Root Complex, and support for MSI
and LSI interrupt sources as found on a POWER9 system using the XIVE
interrupt controller.

POWER9 processor comes with 3 PHB4 PEC (PCI Express Controller) and
each PEC can have several PHBs. By default,

  * PEC0 provides 1 PHB  (PHB0)
  * PEC1 provides 2 PHBs (PHB1 and PHB2)
  * PEC2 provides 3 PHBs (PHB3, PHB4 and PHB5)

Each PEC has a set  "global" registers and some "per-stack" (per-PHB)
registers. Those are organized in two XSCOM ranges, the "Nest" range
and the "PCI" range, each range contains both some "PEC" registers and
some "per-stack" registers.

No default device layout is provided and PCI devices can be added on
any of the available PCIe Root Port (pcie.0 .. 2 of a Power9 chip)
with address 0x0 as the firwware (skiboot) only accepts a single
device per root port. To run a simple system with a network and a
storage adapters, use a command line options such as :

  -device e1000e,netdev=3Dnet0,mac=3DC0:FF:EE:00:00:02,bus=3Dpcie.0,addr=3D=
0x0
  -netdev bridge,id=3Dnet0,helper=3D/usr/libexec/qemu-bridge-helper,br=3D=
virbr0,id=3Dhostnet0

  -device megasas,id=3Dscsi0,bus=3Dpcie.1,addr=3D0x0
  -drive file=3D$disk,if=3Dnone,id=3Ddrive-scsi0-0-0-0,format=3Dqcow2,cac=
he=3Dnone
  -device scsi-hd,bus=3Dscsi0.0,channel=3D0,scsi-id=3D0,lun=3D0,drive=3Dd=
rive-scsi0-0-0-0,id=3Dscsi0-0-0-0,bootindex=3D2

If more are needed, include a bridge.

Multi chip is supported, each chip adding its set of PHB4 controllers
and its PCI busses. The model doesn't emulate the EEH error handling.

This model is not ready for hotplug yet.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
[ clg: - numerous cleanups
       - commit log
       - fix for broken LSI support
       - PHB pic printinfo
       - large QOM rework ]
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20200127144506.11132-2-clg@kaod.org>
[dwg: Use device_class_set_props()]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/pci-host/Makefile.objs           |    1 +
 hw/pci-host/pnv_phb4.c              | 1438 +++++++++++++++++++++++++++
 hw/pci-host/pnv_phb4_pec.c          |  593 +++++++++++
 hw/ppc/Kconfig                      |    2 +
 hw/ppc/pnv.c                        |  107 ++
 include/hw/pci-host/pnv_phb4.h      |  230 +++++
 include/hw/pci-host/pnv_phb4_regs.h |  553 ++++++++++
 include/hw/pci/pcie_port.h          |    1 +
 include/hw/ppc/pnv.h                |    7 +
 include/hw/ppc/pnv_xscom.h          |   11 +
 10 files changed, 2943 insertions(+)
 create mode 100644 hw/pci-host/pnv_phb4.c
 create mode 100644 hw/pci-host/pnv_phb4_pec.c
 create mode 100644 include/hw/pci-host/pnv_phb4.h
 create mode 100644 include/hw/pci-host/pnv_phb4_regs.h

diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 9c466fab01..8a296e2f93 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -20,3 +20,4 @@ common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gp=
ex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
=20
 common-obj-$(CONFIG_PCI_EXPRESS_DESIGNWARE) +=3D designware.o
+obj-$(CONFIG_POWERNV) +=3D pnv_phb4.o pnv_phb4_pec.o
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
new file mode 100644
index 0000000000..61235d13a6
--- /dev/null
+++ b/hw/pci-host/pnv_phb4.c
@@ -0,0 +1,1438 @@
+/*
+ * QEMU PowerPC PowerNV (POWER9) PHB4 model
+ *
+ * Copyright (c) 2018-2020, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "qapi/visitor.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "monitor/monitor.h"
+#include "target/ppc/cpu.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "hw/pci-host/pnv_phb4.h"
+#include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/irq.h"
+#include "hw/qdev-properties.h"
+
+#define phb_error(phb, fmt, ...)                                        =
\
+    qemu_log_mask(LOG_GUEST_ERROR, "phb4[%d:%d]: " fmt "\n",            =
\
+                  (phb)->chip_id, (phb)->phb_id, ## __VA_ARGS__)
+
+/*
+ * QEMU version of the GETFIELD/SETFIELD macros
+ *
+ * These are common with the PnvXive model.
+ */
+static inline uint64_t GETFIELD(uint64_t mask, uint64_t word)
+{
+    return (word & mask) >> ctz64(mask);
+}
+
+static inline uint64_t SETFIELD(uint64_t mask, uint64_t word,
+                                uint64_t value)
+{
+    return (word & ~mask) | ((value << ctz64(mask)) & mask);
+}
+
+static PCIDevice *pnv_phb4_find_cfg_dev(PnvPHB4 *phb)
+{
+    PCIHostState *pci =3D PCI_HOST_BRIDGE(phb);
+    uint64_t addr =3D phb->regs[PHB_CONFIG_ADDRESS >> 3];
+    uint8_t bus, devfn;
+
+    if (!(addr >> 63)) {
+        return NULL;
+    }
+    bus =3D (addr >> 52) & 0xff;
+    devfn =3D (addr >> 44) & 0xff;
+
+    /* We don't access the root complex this way */
+    if (bus =3D=3D 0 && devfn =3D=3D 0) {
+        return NULL;
+    }
+    return pci_find_device(pci->bus, bus, devfn);
+}
+
+/*
+ * The CONFIG_DATA register expects little endian accesses, but as the
+ * region is big endian, we have to swap the value.
+ */
+static void pnv_phb4_config_write(PnvPHB4 *phb, unsigned off,
+                                  unsigned size, uint64_t val)
+{
+    uint32_t cfg_addr, limit;
+    PCIDevice *pdev;
+
+    pdev =3D pnv_phb4_find_cfg_dev(phb);
+    if (!pdev) {
+        return;
+    }
+    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xffc;
+    cfg_addr |=3D off;
+    limit =3D pci_config_size(pdev);
+    if (limit <=3D cfg_addr) {
+        /*
+         * conventional pci device can be behind pcie-to-pci bridge.
+         * 256 <=3D addr < 4K has no effects.
+         */
+        return;
+    }
+    switch (size) {
+    case 1:
+        break;
+    case 2:
+        val =3D bswap16(val);
+        break;
+    case 4:
+        val =3D bswap32(val);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    pci_host_config_write_common(pdev, cfg_addr, limit, val, size);
+}
+
+static uint64_t pnv_phb4_config_read(PnvPHB4 *phb, unsigned off,
+                                     unsigned size)
+{
+    uint32_t cfg_addr, limit;
+    PCIDevice *pdev;
+    uint64_t val;
+
+    pdev =3D pnv_phb4_find_cfg_dev(phb);
+    if (!pdev) {
+        return ~0ull;
+    }
+    cfg_addr =3D (phb->regs[PHB_CONFIG_ADDRESS >> 3] >> 32) & 0xffc;
+    cfg_addr |=3D off;
+    limit =3D pci_config_size(pdev);
+    if (limit <=3D cfg_addr) {
+        /*
+         * conventional pci device can be behind pcie-to-pci bridge.
+         * 256 <=3D addr < 4K has no effects.
+         */
+        return ~0ull;
+    }
+    val =3D pci_host_config_read_common(pdev, cfg_addr, limit, size);
+    switch (size) {
+    case 1:
+        return val;
+    case 2:
+        return bswap16(val);
+    case 4:
+        return bswap32(val);
+    default:
+        g_assert_not_reached();
+    }
+}
+
+/*
+ * Root complex register accesses are memory mapped.
+ */
+static void pnv_phb4_rc_config_write(PnvPHB4 *phb, unsigned off,
+                                     unsigned size, uint64_t val)
+{
+    PCIHostState *pci =3D PCI_HOST_BRIDGE(phb);
+    PCIDevice *pdev;
+
+    if (size !=3D 4) {
+        phb_error(phb, "rc_config_write invalid size %d\n", size);
+        return;
+    }
+
+    pdev =3D pci_find_device(pci->bus, 0, 0);
+    assert(pdev);
+
+    pci_host_config_write_common(pdev, off, PHB_RC_CONFIG_SIZE,
+                                 bswap32(val), 4);
+}
+
+static uint64_t pnv_phb4_rc_config_read(PnvPHB4 *phb, unsigned off,
+                                        unsigned size)
+{
+    PCIHostState *pci =3D PCI_HOST_BRIDGE(phb);
+    PCIDevice *pdev;
+    uint64_t val;
+
+    if (size !=3D 4) {
+        phb_error(phb, "rc_config_read invalid size %d\n", size);
+        return ~0ull;
+    }
+
+    pdev =3D pci_find_device(pci->bus, 0, 0);
+    assert(pdev);
+
+    val =3D pci_host_config_read_common(pdev, off, PHB_RC_CONFIG_SIZE, 4=
);
+    return bswap32(val);
+}
+
+static void pnv_phb4_check_mbt(PnvPHB4 *phb, uint32_t index)
+{
+    uint64_t base, start, size, mbe0, mbe1;
+    MemoryRegion *parent;
+    char name[64];
+
+    /* Unmap first */
+    if (memory_region_is_mapped(&phb->mr_mmio[index])) {
+        /* Should we destroy it in RCU friendly way... ? */
+        memory_region_del_subregion(phb->mr_mmio[index].container,
+                                    &phb->mr_mmio[index]);
+    }
+
+    /* Get table entry */
+    mbe0 =3D phb->ioda_MBT[(index << 1)];
+    mbe1 =3D phb->ioda_MBT[(index << 1) + 1];
+
+    if (!(mbe0 & IODA3_MBT0_ENABLE)) {
+        return;
+    }
+
+    /* Grab geometry from registers */
+    base =3D GETFIELD(IODA3_MBT0_BASE_ADDR, mbe0) << 12;
+    size =3D GETFIELD(IODA3_MBT1_MASK, mbe1) << 12;
+    size |=3D 0xff00000000000000ull;
+    size =3D ~size + 1;
+
+    /* Calculate PCI side start address based on M32/M64 window type */
+    if (mbe0 & IODA3_MBT0_TYPE_M32) {
+        start =3D phb->regs[PHB_M32_START_ADDR >> 3];
+        if ((start + size) > 0x100000000ull) {
+            phb_error(phb, "M32 set beyond 4GB boundary !");
+            size =3D 0x100000000 - start;
+        }
+    } else {
+        start =3D base | (phb->regs[PHB_M64_UPPER_BITS >> 3]);
+    }
+
+    /* TODO: Figure out how to implemet/decode AOMASK */
+
+    /* Check if it matches an enabled MMIO region in the PEC stack */
+    if (memory_region_is_mapped(&phb->stack->mmbar0) &&
+        base >=3D phb->stack->mmio0_base &&
+        (base + size) <=3D (phb->stack->mmio0_base + phb->stack->mmio0_s=
ize)) {
+        parent =3D &phb->stack->mmbar0;
+        base -=3D phb->stack->mmio0_base;
+    } else if (memory_region_is_mapped(&phb->stack->mmbar1) &&
+        base >=3D phb->stack->mmio1_base &&
+        (base + size) <=3D (phb->stack->mmio1_base + phb->stack->mmio1_s=
ize)) {
+        parent =3D &phb->stack->mmbar1;
+        base -=3D phb->stack->mmio1_base;
+    } else {
+        phb_error(phb, "PHB MBAR %d out of parent bounds", index);
+        return;
+    }
+
+    /* Create alias (better name ?) */
+    snprintf(name, sizeof(name), "phb4-mbar%d", index);
+    memory_region_init_alias(&phb->mr_mmio[index], OBJECT(phb), name,
+                             &phb->pci_mmio, start, size);
+    memory_region_add_subregion(parent, base, &phb->mr_mmio[index]);
+}
+
+static void pnv_phb4_check_all_mbt(PnvPHB4 *phb)
+{
+    uint64_t i;
+    uint32_t num_windows =3D phb->big_phb ? PNV_PHB4_MAX_MMIO_WINDOWS :
+        PNV_PHB4_MIN_MMIO_WINDOWS;
+
+    for (i =3D 0; i < num_windows; i++) {
+        pnv_phb4_check_mbt(phb, i);
+    }
+}
+
+static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
+                                      unsigned *out_table, unsigned *out=
_idx)
+{
+    uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
+    unsigned int index =3D GETFIELD(PHB_IODA_AD_TADR, adreg);
+    unsigned int table =3D GETFIELD(PHB_IODA_AD_TSEL, adreg);
+    unsigned int mask;
+    uint64_t *tptr =3D NULL;
+
+    switch (table) {
+    case IODA3_TBL_LIST:
+        tptr =3D phb->ioda_LIST;
+        mask =3D 7;
+        break;
+    case IODA3_TBL_MIST:
+        tptr =3D phb->ioda_MIST;
+        mask =3D phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >=
> 1);
+        mask -=3D 1;
+        break;
+    case IODA3_TBL_RCAM:
+        mask =3D phb->big_phb ? 127 : 63;
+        break;
+    case IODA3_TBL_MRT:
+        mask =3D phb->big_phb ? 15 : 7;
+        break;
+    case IODA3_TBL_PESTA:
+    case IODA3_TBL_PESTB:
+        mask =3D phb->big_phb ? PNV_PHB4_MAX_PEs : (PNV_PHB4_MAX_PEs >> =
1);
+        mask -=3D 1;
+        break;
+    case IODA3_TBL_TVT:
+        tptr =3D phb->ioda_TVT;
+        mask =3D phb->big_phb ? PNV_PHB4_MAX_TVEs : (PNV_PHB4_MAX_TVEs >=
> 1);
+        mask -=3D 1;
+        break;
+    case IODA3_TBL_TCR:
+    case IODA3_TBL_TDR:
+        mask =3D phb->big_phb ? 1023 : 511;
+        break;
+    case IODA3_TBL_MBT:
+        tptr =3D phb->ioda_MBT;
+        mask =3D phb->big_phb ? PNV_PHB4_MAX_MBEs : (PNV_PHB4_MAX_MBEs >=
> 1);
+        mask -=3D 1;
+        break;
+    case IODA3_TBL_MDT:
+        tptr =3D phb->ioda_MDT;
+        mask =3D phb->big_phb ? PNV_PHB4_MAX_PEs : (PNV_PHB4_MAX_PEs >> =
1);
+        mask -=3D 1;
+        break;
+    case IODA3_TBL_PEEV:
+        tptr =3D phb->ioda_PEEV;
+        mask =3D phb->big_phb ? PNV_PHB4_MAX_PEEVs : (PNV_PHB4_MAX_PEEVs=
 >> 1);
+        mask -=3D 1;
+        break;
+    default:
+        phb_error(phb, "invalid IODA table %d", table);
+        return NULL;
+    }
+    index &=3D mask;
+    if (out_idx) {
+        *out_idx =3D index;
+    }
+    if (out_table) {
+        *out_table =3D table;
+    }
+    if (tptr) {
+        tptr +=3D index;
+    }
+    if (adreg & PHB_IODA_AD_AUTOINC) {
+        index =3D (index + 1) & mask;
+        adreg =3D SETFIELD(PHB_IODA_AD_TADR, adreg, index);
+    }
+
+    phb->regs[PHB_IODA_ADDR >> 3] =3D adreg;
+    return tptr;
+}
+
+static uint64_t pnv_phb4_ioda_read(PnvPHB4 *phb)
+{
+    unsigned table, idx;
+    uint64_t *tptr;
+
+    tptr =3D pnv_phb4_ioda_access(phb, &table, &idx);
+    if (!tptr) {
+        /* Special PESTA case */
+        if (table =3D=3D IODA3_TBL_PESTA) {
+            return ((uint64_t)(phb->ioda_PEST_AB[idx] & 1)) << 63;
+        } else if (table =3D=3D IODA3_TBL_PESTB) {
+            return ((uint64_t)(phb->ioda_PEST_AB[idx] & 2)) << 62;
+        }
+        /* Return 0 on unsupported tables, not ff's */
+        return 0;
+    }
+    return *tptr;
+}
+
+static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
+{
+    unsigned table, idx;
+    uint64_t *tptr;
+
+    tptr =3D pnv_phb4_ioda_access(phb, &table, &idx);
+    if (!tptr) {
+        /* Special PESTA case */
+        if (table =3D=3D IODA3_TBL_PESTA) {
+            phb->ioda_PEST_AB[idx] &=3D ~1;
+            phb->ioda_PEST_AB[idx] |=3D (val >> 63) & 1;
+        } else if (table =3D=3D IODA3_TBL_PESTB) {
+            phb->ioda_PEST_AB[idx] &=3D ~2;
+            phb->ioda_PEST_AB[idx] |=3D (val >> 62) & 2;
+        }
+        return;
+    }
+
+    /* Handle side effects */
+    switch (table) {
+    case IODA3_TBL_LIST:
+        break;
+    case IODA3_TBL_MIST: {
+        /* Special mask for MIST partial write */
+        uint64_t adreg =3D phb->regs[PHB_IODA_ADDR >> 3];
+        uint32_t mmask =3D GETFIELD(PHB_IODA_AD_MIST_PWV, adreg);
+        uint64_t v =3D *tptr;
+        if (mmask =3D=3D 0) {
+            mmask =3D 0xf;
+        }
+        if (mmask & 8) {
+            v &=3D 0x0000ffffffffffffull;
+            v |=3D 0xcfff000000000000ull & val;
+        }
+        if (mmask & 4) {
+            v &=3D 0xffff0000ffffffffull;
+            v |=3D 0x0000cfff00000000ull & val;
+        }
+        if (mmask & 2) {
+            v &=3D 0xffffffff0000ffffull;
+            v |=3D 0x00000000cfff0000ull & val;
+        }
+        if (mmask & 1) {
+            v &=3D 0xffffffffffff0000ull;
+            v |=3D 0x000000000000cfffull & val;
+        }
+        *tptr =3D val;
+        break;
+    }
+    case IODA3_TBL_MBT:
+        *tptr =3D val;
+
+        /* Copy accross the valid bit to the other half */
+        phb->ioda_MBT[idx ^ 1] &=3D 0x7fffffffffffffffull;
+        phb->ioda_MBT[idx ^ 1] |=3D 0x8000000000000000ull & val;
+
+        /* Update mappings */
+        pnv_phb4_check_mbt(phb, idx >> 1);
+        break;
+    default:
+        *tptr =3D val;
+    }
+}
+
+static void pnv_phb4_rtc_invalidate(PnvPHB4 *phb, uint64_t val)
+{
+    PnvPhb4DMASpace *ds;
+
+    /* Always invalidate all for now ... */
+    QLIST_FOREACH(ds, &phb->dma_spaces, list) {
+        ds->pe_num =3D PHB_INVALID_PE;
+    }
+}
+
+static void pnv_phb4_update_msi_regions(PnvPhb4DMASpace *ds)
+{
+    uint64_t cfg =3D ds->phb->regs[PHB_PHB4_CONFIG >> 3];
+
+    if (cfg & PHB_PHB4C_32BIT_MSI_EN) {
+        if (!memory_region_is_mapped(MEMORY_REGION(&ds->msi32_mr))) {
+            memory_region_add_subregion(MEMORY_REGION(&ds->dma_mr),
+                                        0xffff0000, &ds->msi32_mr);
+        }
+    } else {
+        if (memory_region_is_mapped(MEMORY_REGION(&ds->msi32_mr))) {
+            memory_region_del_subregion(MEMORY_REGION(&ds->dma_mr),
+                                        &ds->msi32_mr);
+        }
+    }
+
+    if (cfg & PHB_PHB4C_64BIT_MSI_EN) {
+        if (!memory_region_is_mapped(MEMORY_REGION(&ds->msi64_mr))) {
+            memory_region_add_subregion(MEMORY_REGION(&ds->dma_mr),
+                                        (1ull << 60), &ds->msi64_mr);
+        }
+    } else {
+        if (memory_region_is_mapped(MEMORY_REGION(&ds->msi64_mr))) {
+            memory_region_del_subregion(MEMORY_REGION(&ds->dma_mr),
+                                        &ds->msi64_mr);
+        }
+    }
+}
+
+static void pnv_phb4_update_all_msi_regions(PnvPHB4 *phb)
+{
+    PnvPhb4DMASpace *ds;
+
+    QLIST_FOREACH(ds, &phb->dma_spaces, list) {
+        pnv_phb4_update_msi_regions(ds);
+    }
+}
+
+static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
+{
+    int shift, flags, i, lsi_base;
+    XiveSource *xsrc =3D &phb->xsrc;
+
+    /* The XIVE source characteristics can be set at run time */
+    if (phb->regs[PHB_CTRLR >> 3] & PHB_CTRLR_IRQ_PGSZ_64K) {
+        shift =3D XIVE_ESB_64K;
+    } else {
+        shift =3D XIVE_ESB_4K;
+    }
+    if (phb->regs[PHB_CTRLR >> 3] & PHB_CTRLR_IRQ_STORE_EOI) {
+        flags =3D XIVE_SRC_STORE_EOI;
+    } else {
+        flags =3D 0;
+    }
+
+    phb->xsrc.esb_shift =3D shift;
+    phb->xsrc.esb_flags =3D flags;
+
+    lsi_base =3D GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >>=
 3]);
+    lsi_base <<=3D 3;
+
+    /* TODO: handle reset values of PHB_LSI_SRC_ID */
+    if (!lsi_base) {
+        return;
+    }
+
+    /* TODO: need a xive_source_irq_reset_lsi() */
+    bitmap_zero(xsrc->lsi_map, xsrc->nr_irqs);
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        bool msi =3D (i < lsi_base || i >=3D (lsi_base + 8));
+        if (!msi) {
+            xive_source_irq_set_lsi(xsrc, i);
+        }
+    }
+}
+
+static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
+                               unsigned size)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(opaque);
+    bool changed;
+
+    /* Special case outbound configuration data */
+    if ((off & 0xfffc) =3D=3D PHB_CONFIG_DATA) {
+        pnv_phb4_config_write(phb, off & 0x3, size, val);
+        return;
+    }
+
+    /* Special case RC configuration space */
+    if ((off & 0xf800) =3D=3D PHB_RC_CONFIG_BASE) {
+        pnv_phb4_rc_config_write(phb, off & 0x7ff, size, val);
+        return;
+    }
+
+    /* Other registers are 64-bit only */
+    if (size !=3D 8 || off & 0x7) {
+        phb_error(phb, "Invalid register access, offset: 0x%"PRIx64" siz=
e: %d",
+                   off, size);
+        return;
+    }
+
+    /* Handle masking */
+    switch (off) {
+    case PHB_LSI_SOURCE_ID:
+        val &=3D PHB_LSI_SRC_ID;
+        break;
+    case PHB_M64_UPPER_BITS:
+        val &=3D 0xff00000000000000ull;
+        break;
+    /* TCE Kill */
+    case PHB_TCE_KILL:
+        /* Clear top 3 bits which HW does to indicate successful queuing=
 */
+        val &=3D ~(PHB_TCE_KILL_ALL | PHB_TCE_KILL_PE | PHB_TCE_KILL_ONE=
);
+        break;
+    case PHB_Q_DMA_R:
+        /*
+         * This is enough logic to make SW happy but we aren't
+         * actually quiescing the DMAs
+         */
+        if (val & PHB_Q_DMA_R_AUTORESET) {
+            val =3D 0;
+        } else {
+            val &=3D PHB_Q_DMA_R_QUIESCE_DMA;
+        }
+        break;
+    /* LEM stuff */
+    case PHB_LEM_FIR_AND_MASK:
+        phb->regs[PHB_LEM_FIR_ACCUM >> 3] &=3D val;
+        return;
+    case PHB_LEM_FIR_OR_MASK:
+        phb->regs[PHB_LEM_FIR_ACCUM >> 3] |=3D val;
+        return;
+    case PHB_LEM_ERROR_AND_MASK:
+        phb->regs[PHB_LEM_ERROR_MASK >> 3] &=3D val;
+        return;
+    case PHB_LEM_ERROR_OR_MASK:
+        phb->regs[PHB_LEM_ERROR_MASK >> 3] |=3D val;
+        return;
+    case PHB_LEM_WOF:
+        val =3D 0;
+        break;
+    /* TODO: More regs ..., maybe create a table with masks... */
+
+    /* Read only registers */
+    case PHB_CPU_LOADSTORE_STATUS:
+    case PHB_ETU_ERR_SUMMARY:
+    case PHB_PHB4_GEN_CAP:
+    case PHB_PHB4_TCE_CAP:
+    case PHB_PHB4_IRQ_CAP:
+    case PHB_PHB4_EEH_CAP:
+        return;
+    }
+
+    /* Record whether it changed */
+    changed =3D phb->regs[off >> 3] !=3D val;
+
+    /* Store in register cache first */
+    phb->regs[off >> 3] =3D val;
+
+    /* Handle side effects */
+    switch (off) {
+    case PHB_PHB4_CONFIG:
+        if (changed) {
+            pnv_phb4_update_all_msi_regions(phb);
+        }
+        break;
+    case PHB_M32_START_ADDR:
+    case PHB_M64_UPPER_BITS:
+        if (changed) {
+            pnv_phb4_check_all_mbt(phb);
+        }
+        break;
+
+    /* IODA table accesses */
+    case PHB_IODA_DATA0:
+        pnv_phb4_ioda_write(phb, val);
+        break;
+
+    /* RTC invalidation */
+    case PHB_RTC_INVALIDATE:
+        pnv_phb4_rtc_invalidate(phb, val);
+        break;
+
+    /* PHB Control (Affects XIVE source) */
+    case PHB_CTRLR:
+    case PHB_LSI_SOURCE_ID:
+        pnv_phb4_update_xsrc(phb);
+        break;
+
+    /* Silent simple writes */
+    case PHB_ASN_CMPM:
+    case PHB_CONFIG_ADDRESS:
+    case PHB_IODA_ADDR:
+    case PHB_TCE_KILL:
+    case PHB_TCE_SPEC_CTL:
+    case PHB_PEST_BAR:
+    case PHB_PELTV_BAR:
+    case PHB_RTT_BAR:
+    case PHB_LEM_FIR_ACCUM:
+    case PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0:
+    case PHB_LEM_ACTION1:
+    case PHB_TCE_TAG_ENABLE:
+    case PHB_INT_NOTIFY_ADDR:
+    case PHB_INT_NOTIFY_INDEX:
+    case PHB_DMARD_SYNC:
+       break;
+
+    /* Noise on anything else */
+    default:
+        qemu_log_mask(LOG_UNIMP, "phb4: reg_write 0x%"PRIx64"=3D%"PRIx64=
"\n",
+                      off, val);
+    }
+}
+
+static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned siz=
e)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(opaque);
+    uint64_t val;
+
+    if ((off & 0xfffc) =3D=3D PHB_CONFIG_DATA) {
+        return pnv_phb4_config_read(phb, off & 0x3, size);
+    }
+
+    /* Special case RC configuration space */
+    if ((off & 0xf800) =3D=3D PHB_RC_CONFIG_BASE) {
+        return pnv_phb4_rc_config_read(phb, off & 0x7ff, size);
+    }
+
+    /* Other registers are 64-bit only */
+    if (size !=3D 8 || off & 0x7) {
+        phb_error(phb, "Invalid register access, offset: 0x%"PRIx64" siz=
e: %d",
+                   off, size);
+        return ~0ull;
+    }
+
+    /* Default read from cache */
+    val =3D phb->regs[off >> 3];
+
+    switch (off) {
+    case PHB_VERSION:
+        return phb->version;
+
+        /* Read-only */
+    case PHB_PHB4_GEN_CAP:
+        return 0xe4b8000000000000ull;
+    case PHB_PHB4_TCE_CAP:
+        return phb->big_phb ? 0x4008440000000400ull : 0x2008440000000200=
ull;
+    case PHB_PHB4_IRQ_CAP:
+        return phb->big_phb ? 0x0800000000001000ull : 0x0800000000000800=
ull;
+    case PHB_PHB4_EEH_CAP:
+        return phb->big_phb ? 0x2000000000000000ull : 0x1000000000000000=
ull;
+
+    /* IODA table accesses */
+    case PHB_IODA_DATA0:
+        return pnv_phb4_ioda_read(phb);
+
+    /* Link training always appears trained */
+    case PHB_PCIE_DLP_TRAIN_CTL:
+        /* TODO: Do something sensible with speed ? */
+        return PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
+
+    /* DMA read sync: make it look like it's complete */
+    case PHB_DMARD_SYNC:
+        return PHB_DMARD_SYNC_COMPLETE;
+
+    /* Silent simple reads */
+    case PHB_LSI_SOURCE_ID:
+    case PHB_CPU_LOADSTORE_STATUS:
+    case PHB_ASN_CMPM:
+    case PHB_PHB4_CONFIG:
+    case PHB_M32_START_ADDR:
+    case PHB_CONFIG_ADDRESS:
+    case PHB_IODA_ADDR:
+    case PHB_RTC_INVALIDATE:
+    case PHB_TCE_KILL:
+    case PHB_TCE_SPEC_CTL:
+    case PHB_PEST_BAR:
+    case PHB_PELTV_BAR:
+    case PHB_RTT_BAR:
+    case PHB_M64_UPPER_BITS:
+    case PHB_CTRLR:
+    case PHB_LEM_FIR_ACCUM:
+    case PHB_LEM_ERROR_MASK:
+    case PHB_LEM_ACTION0:
+    case PHB_LEM_ACTION1:
+    case PHB_TCE_TAG_ENABLE:
+    case PHB_INT_NOTIFY_ADDR:
+    case PHB_INT_NOTIFY_INDEX:
+    case PHB_Q_DMA_R:
+    case PHB_ETU_ERR_SUMMARY:
+        break;
+
+    /* Noise on anything else */
+    default:
+        qemu_log_mask(LOG_UNIMP, "phb4: reg_read 0x%"PRIx64"=3D%"PRIx64"=
\n",
+                      off, val);
+    }
+    return val;
+}
+
+static const MemoryRegionOps pnv_phb4_reg_ops =3D {
+    .read =3D pnv_phb4_reg_read,
+    .write =3D pnv_phb4_reg_write,
+    .valid.min_access_size =3D 1,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 1,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t pnv_phb4_xscom_read(void *opaque, hwaddr addr, unsigned =
size)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(opaque);
+    uint32_t reg =3D addr >> 3;
+    uint64_t val;
+    hwaddr offset;
+
+    switch (reg) {
+    case PHB_SCOM_HV_IND_ADDR:
+        return phb->scom_hv_ind_addr_reg;
+
+    case PHB_SCOM_HV_IND_DATA:
+        if (!(phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_VALID)) {
+            phb_error(phb, "Invalid indirect address");
+            return ~0ull;
+        }
+        size =3D (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_4B) ?=
 4 : 8;
+        offset =3D GETFIELD(PHB_SCOM_HV_IND_ADDR_ADDR, phb->scom_hv_ind_=
addr_reg);
+        val =3D pnv_phb4_reg_read(phb, offset, size);
+        if (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_AUTOINC) {
+            offset +=3D size;
+            offset &=3D 0x3fff;
+            phb->scom_hv_ind_addr_reg =3D SETFIELD(PHB_SCOM_HV_IND_ADDR_=
ADDR,
+                                                 phb->scom_hv_ind_addr_r=
eg,
+                                                 offset);
+        }
+        return val;
+    case PHB_SCOM_ETU_LEM_FIR:
+    case PHB_SCOM_ETU_LEM_FIR_AND:
+    case PHB_SCOM_ETU_LEM_FIR_OR:
+    case PHB_SCOM_ETU_LEM_FIR_MSK:
+    case PHB_SCOM_ETU_LEM_ERR_MSK_AND:
+    case PHB_SCOM_ETU_LEM_ERR_MSK_OR:
+    case PHB_SCOM_ETU_LEM_ACT0:
+    case PHB_SCOM_ETU_LEM_ACT1:
+    case PHB_SCOM_ETU_LEM_WOF:
+        offset =3D ((reg - PHB_SCOM_ETU_LEM_FIR) << 3) + PHB_LEM_FIR_ACC=
UM;
+        return pnv_phb4_reg_read(phb, offset, size);
+    case PHB_SCOM_ETU_PMON_CONFIG:
+    case PHB_SCOM_ETU_PMON_CTR0:
+    case PHB_SCOM_ETU_PMON_CTR1:
+    case PHB_SCOM_ETU_PMON_CTR2:
+    case PHB_SCOM_ETU_PMON_CTR3:
+        offset =3D ((reg - PHB_SCOM_ETU_PMON_CONFIG) << 3) + PHB_PERFMON=
_CONFIG;
+        return pnv_phb4_reg_read(phb, offset, size);
+
+    default:
+        qemu_log_mask(LOG_UNIMP, "phb4: xscom_read 0x%"HWADDR_PRIx"\n", =
addr);
+        return ~0ull;
+    }
+}
+
+static void pnv_phb4_xscom_write(void *opaque, hwaddr addr,
+                                 uint64_t val, unsigned size)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(opaque);
+    uint32_t reg =3D addr >> 3;
+    hwaddr offset;
+
+    switch (reg) {
+    case PHB_SCOM_HV_IND_ADDR:
+        phb->scom_hv_ind_addr_reg =3D val & 0xe000000000001fff;
+        break;
+    case PHB_SCOM_HV_IND_DATA:
+        if (!(phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_VALID)) {
+            phb_error(phb, "Invalid indirect address");
+            break;
+        }
+        size =3D (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_4B) ?=
 4 : 8;
+        offset =3D GETFIELD(PHB_SCOM_HV_IND_ADDR_ADDR, phb->scom_hv_ind_=
addr_reg);
+        pnv_phb4_reg_write(phb, offset, val, size);
+        if (phb->scom_hv_ind_addr_reg & PHB_SCOM_HV_IND_ADDR_AUTOINC) {
+            offset +=3D size;
+            offset &=3D 0x3fff;
+            phb->scom_hv_ind_addr_reg =3D SETFIELD(PHB_SCOM_HV_IND_ADDR_=
ADDR,
+                                                 phb->scom_hv_ind_addr_r=
eg,
+                                                 offset);
+        }
+        break;
+    case PHB_SCOM_ETU_LEM_FIR:
+    case PHB_SCOM_ETU_LEM_FIR_AND:
+    case PHB_SCOM_ETU_LEM_FIR_OR:
+    case PHB_SCOM_ETU_LEM_FIR_MSK:
+    case PHB_SCOM_ETU_LEM_ERR_MSK_AND:
+    case PHB_SCOM_ETU_LEM_ERR_MSK_OR:
+    case PHB_SCOM_ETU_LEM_ACT0:
+    case PHB_SCOM_ETU_LEM_ACT1:
+    case PHB_SCOM_ETU_LEM_WOF:
+        offset =3D ((reg - PHB_SCOM_ETU_LEM_FIR) << 3) + PHB_LEM_FIR_ACC=
UM;
+        pnv_phb4_reg_write(phb, offset, val, size);
+        break;
+    case PHB_SCOM_ETU_PMON_CONFIG:
+    case PHB_SCOM_ETU_PMON_CTR0:
+    case PHB_SCOM_ETU_PMON_CTR1:
+    case PHB_SCOM_ETU_PMON_CTR2:
+    case PHB_SCOM_ETU_PMON_CTR3:
+        offset =3D ((reg - PHB_SCOM_ETU_PMON_CONFIG) << 3) + PHB_PERFMON=
_CONFIG;
+        pnv_phb4_reg_write(phb, offset, val, size);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "phb4: xscom_write 0x%"HWADDR_PRIx
+                      "=3D%"PRIx64"\n", addr, val);
+    }
+}
+
+const MemoryRegionOps pnv_phb4_xscom_ops =3D {
+    .read =3D pnv_phb4_xscom_read,
+    .write =3D pnv_phb4_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static int pnv_phb4_map_irq(PCIDevice *pci_dev, int irq_num)
+{
+    /* Check that out properly ... */
+    return irq_num & 3;
+}
+
+static void pnv_phb4_set_irq(void *opaque, int irq_num, int level)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(opaque);
+    uint32_t lsi_base;
+
+    /* LSI only ... */
+    if (irq_num > 3) {
+        phb_error(phb, "IRQ %x is not an LSI", irq_num);
+    }
+    lsi_base =3D GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >>=
 3]);
+    lsi_base <<=3D 3;
+    qemu_set_irq(phb->qirqs[lsi_base + irq_num], level);
+}
+
+static bool pnv_phb4_resolve_pe(PnvPhb4DMASpace *ds)
+{
+    uint64_t rtt, addr;
+    uint16_t rte;
+    int bus_num;
+    int num_PEs;
+
+    /* Already resolved ? */
+    if (ds->pe_num !=3D PHB_INVALID_PE) {
+        return true;
+    }
+
+    /* We need to lookup the RTT */
+    rtt =3D ds->phb->regs[PHB_RTT_BAR >> 3];
+    if (!(rtt & PHB_RTT_BAR_ENABLE)) {
+        phb_error(ds->phb, "DMA with RTT BAR disabled !");
+        /* Set error bits ? fence ? ... */
+        return false;
+    }
+
+    /* Read RTE */
+    bus_num =3D pci_bus_num(ds->bus);
+    addr =3D rtt & PHB_RTT_BASE_ADDRESS_MASK;
+    addr +=3D 2 * ((bus_num << 8) | ds->devfn);
+    if (dma_memory_read(&address_space_memory, addr, &rte, sizeof(rte)))=
 {
+        phb_error(ds->phb, "Failed to read RTT entry at 0x%"PRIx64, addr=
);
+        /* Set error bits ? fence ? ... */
+        return false;
+    }
+    rte =3D be16_to_cpu(rte);
+
+    /* Fail upon reading of invalid PE# */
+    num_PEs =3D ds->phb->big_phb ? PNV_PHB4_MAX_PEs : (PNV_PHB4_MAX_PEs =
>> 1);
+    if (rte >=3D num_PEs) {
+        phb_error(ds->phb, "RTE for RID 0x%x invalid (%04x", ds->devfn, =
rte);
+        rte &=3D num_PEs - 1;
+    }
+    ds->pe_num =3D rte;
+    return true;
+}
+
+static void pnv_phb4_translate_tve(PnvPhb4DMASpace *ds, hwaddr addr,
+                                   bool is_write, uint64_t tve,
+                                   IOMMUTLBEntry *tlb)
+{
+    uint64_t tta =3D GETFIELD(IODA3_TVT_TABLE_ADDR, tve);
+    int32_t  lev =3D GETFIELD(IODA3_TVT_NUM_LEVELS, tve);
+    uint32_t tts =3D GETFIELD(IODA3_TVT_TCE_TABLE_SIZE, tve);
+    uint32_t tps =3D GETFIELD(IODA3_TVT_IO_PSIZE, tve);
+
+    /* Invalid levels */
+    if (lev > 4) {
+        phb_error(ds->phb, "Invalid #levels in TVE %d", lev);
+        return;
+    }
+
+    /* Invalid entry */
+    if (tts =3D=3D 0) {
+        phb_error(ds->phb, "Access to invalid TVE");
+        return;
+    }
+
+    /* IO Page Size of 0 means untranslated, else use TCEs */
+    if (tps =3D=3D 0) {
+        /* TODO: Handle boundaries */
+
+        /* Use 4k pages like q35 ... for now */
+        tlb->iova =3D addr & 0xfffffffffffff000ull;
+        tlb->translated_addr =3D addr & 0x0003fffffffff000ull;
+        tlb->addr_mask =3D 0xfffull;
+        tlb->perm =3D IOMMU_RW;
+    } else {
+        uint32_t tce_shift, tbl_shift, sh;
+        uint64_t base, taddr, tce, tce_mask;
+
+        /* Address bits per bottom level TCE entry */
+        tce_shift =3D tps + 11;
+
+        /* Address bits per table level */
+        tbl_shift =3D tts + 8;
+
+        /* Top level table base address */
+        base =3D tta << 12;
+
+        /* Total shift to first level */
+        sh =3D tbl_shift * lev + tce_shift;
+
+        /* TODO: Limit to support IO page sizes */
+
+        /* TODO: Multi-level untested */
+        while ((lev--) >=3D 0) {
+            /* Grab the TCE address */
+            taddr =3D base | (((addr >> sh) & ((1ul << tbl_shift) - 1)) =
<< 3);
+            if (dma_memory_read(&address_space_memory, taddr, &tce,
+                                sizeof(tce))) {
+                phb_error(ds->phb, "Failed to read TCE at 0x%"PRIx64, ta=
ddr);
+                return;
+            }
+            tce =3D be64_to_cpu(tce);
+
+            /* Check permission for indirect TCE */
+            if ((lev >=3D 0) && !(tce & 3)) {
+                phb_error(ds->phb, "Invalid indirect TCE at 0x%"PRIx64, =
taddr);
+                phb_error(ds->phb, " xlate %"PRIx64":%c TVE=3D%"PRIx64, =
addr,
+                           is_write ? 'W' : 'R', tve);
+                phb_error(ds->phb, " tta=3D%"PRIx64" lev=3D%d tts=3D%d t=
ps=3D%d",
+                           tta, lev, tts, tps);
+                return;
+            }
+            sh -=3D tbl_shift;
+            base =3D tce & ~0xfffull;
+        }
+
+        /* We exit the loop with TCE being the final TCE */
+        tce_mask =3D ~((1ull << tce_shift) - 1);
+        tlb->iova =3D addr & tce_mask;
+        tlb->translated_addr =3D tce & tce_mask;
+        tlb->addr_mask =3D ~tce_mask;
+        tlb->perm =3D tce & 3;
+        if ((is_write & !(tce & 2)) || ((!is_write) && !(tce & 1))) {
+            phb_error(ds->phb, "TCE access fault at 0x%"PRIx64, taddr);
+            phb_error(ds->phb, " xlate %"PRIx64":%c TVE=3D%"PRIx64, addr=
,
+                       is_write ? 'W' : 'R', tve);
+            phb_error(ds->phb, " tta=3D%"PRIx64" lev=3D%d tts=3D%d tps=3D=
%d",
+                       tta, lev, tts, tps);
+        }
+    }
+}
+
+static IOMMUTLBEntry pnv_phb4_translate_iommu(IOMMUMemoryRegion *iommu,
+                                              hwaddr addr,
+                                              IOMMUAccessFlags flag,
+                                              int iommu_idx)
+{
+    PnvPhb4DMASpace *ds =3D container_of(iommu, PnvPhb4DMASpace, dma_mr)=
;
+    int tve_sel;
+    uint64_t tve, cfg;
+    IOMMUTLBEntry ret =3D {
+        .target_as =3D &address_space_memory,
+        .iova =3D addr,
+        .translated_addr =3D 0,
+        .addr_mask =3D ~(hwaddr)0,
+        .perm =3D IOMMU_NONE,
+    };
+
+    /* Resolve PE# */
+    if (!pnv_phb4_resolve_pe(ds)) {
+        phb_error(ds->phb, "Failed to resolve PE# for bus @%p (%d) devfn=
 0x%x",
+                   ds->bus, pci_bus_num(ds->bus), ds->devfn);
+        return ret;
+    }
+
+    /* Check top bits */
+    switch (addr >> 60) {
+    case 00:
+        /* DMA or 32-bit MSI ? */
+        cfg =3D ds->phb->regs[PHB_PHB4_CONFIG >> 3];
+        if ((cfg & PHB_PHB4C_32BIT_MSI_EN) &&
+            ((addr & 0xffffffffffff0000ull) =3D=3D 0xffff0000ull)) {
+            phb_error(ds->phb, "xlate on 32-bit MSI region");
+            return ret;
+        }
+        /* Choose TVE XXX Use PHB4 Control Register */
+        tve_sel =3D (addr >> 59) & 1;
+        tve =3D ds->phb->ioda_TVT[ds->pe_num * 2 + tve_sel];
+        pnv_phb4_translate_tve(ds, addr, flag & IOMMU_WO, tve, &ret);
+        break;
+    case 01:
+        phb_error(ds->phb, "xlate on 64-bit MSI region");
+        break;
+    default:
+        phb_error(ds->phb, "xlate on unsupported address 0x%"PRIx64, add=
r);
+    }
+    return ret;
+}
+
+#define TYPE_PNV_PHB4_IOMMU_MEMORY_REGION "pnv-phb4-iommu-memory-region"
+#define PNV_PHB4_IOMMU_MEMORY_REGION(obj) \
+    OBJECT_CHECK(IOMMUMemoryRegion, (obj), TYPE_PNV_PHB4_IOMMU_MEMORY_RE=
GION)
+
+static void pnv_phb4_iommu_memory_region_class_init(ObjectClass *klass,
+                                                    void *data)
+{
+    IOMMUMemoryRegionClass *imrc =3D IOMMU_MEMORY_REGION_CLASS(klass);
+
+    imrc->translate =3D pnv_phb4_translate_iommu;
+}
+
+static const TypeInfo pnv_phb4_iommu_memory_region_info =3D {
+    .parent =3D TYPE_IOMMU_MEMORY_REGION,
+    .name =3D TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
+    .class_init =3D pnv_phb4_iommu_memory_region_class_init,
+};
+
+/*
+ * MSI/MSIX memory region implementation.
+ * The handler handles both MSI and MSIX.
+ */
+static void pnv_phb4_msi_write(void *opaque, hwaddr addr,
+                               uint64_t data, unsigned size)
+{
+    PnvPhb4DMASpace *ds =3D opaque;
+    PnvPHB4 *phb =3D ds->phb;
+
+    uint32_t src =3D ((addr >> 4) & 0xffff) | (data & 0x1f);
+
+    /* Resolve PE# */
+    if (!pnv_phb4_resolve_pe(ds)) {
+        phb_error(phb, "Failed to resolve PE# for bus @%p (%d) devfn 0x%=
x",
+                   ds->bus, pci_bus_num(ds->bus), ds->devfn);
+        return;
+    }
+
+    /* TODO: Check it doesn't collide with LSIs */
+    if (src >=3D phb->xsrc.nr_irqs) {
+        phb_error(phb, "MSI %d out of bounds", src);
+        return;
+    }
+
+    /* TODO: check PE/MSI assignement */
+
+    qemu_irq_pulse(phb->qirqs[src]);
+}
+
+/* There is no .read as the read result is undefined by PCI spec */
+static uint64_t pnv_phb4_msi_read(void *opaque, hwaddr addr, unsigned si=
ze)
+{
+    PnvPhb4DMASpace *ds =3D opaque;
+
+    phb_error(ds->phb, "Invalid MSI read @ 0x%" HWADDR_PRIx, addr);
+    return -1;
+}
+
+static const MemoryRegionOps pnv_phb4_msi_ops =3D {
+    .read =3D pnv_phb4_msi_read,
+    .write =3D pnv_phb4_msi_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN
+};
+
+static PnvPhb4DMASpace *pnv_phb4_dma_find(PnvPHB4 *phb, PCIBus *bus, int=
 devfn)
+{
+    PnvPhb4DMASpace *ds;
+
+    QLIST_FOREACH(ds, &phb->dma_spaces, list) {
+        if (ds->bus =3D=3D bus && ds->devfn =3D=3D devfn) {
+            break;
+        }
+    }
+    return ds;
+}
+
+static AddressSpace *pnv_phb4_dma_iommu(PCIBus *bus, void *opaque, int d=
evfn)
+{
+    PnvPHB4 *phb =3D opaque;
+    PnvPhb4DMASpace *ds;
+    char name[32];
+
+    ds =3D pnv_phb4_dma_find(phb, bus, devfn);
+
+    if (ds =3D=3D NULL) {
+        ds =3D g_malloc0(sizeof(PnvPhb4DMASpace));
+        ds->bus =3D bus;
+        ds->devfn =3D devfn;
+        ds->pe_num =3D PHB_INVALID_PE;
+        ds->phb =3D phb;
+        snprintf(name, sizeof(name), "phb4-%d.%d-iommu", phb->chip_id,
+                 phb->phb_id);
+        memory_region_init_iommu(&ds->dma_mr, sizeof(ds->dma_mr),
+                                 TYPE_PNV_PHB4_IOMMU_MEMORY_REGION,
+                                 OBJECT(phb), name, UINT64_MAX);
+        address_space_init(&ds->dma_as, MEMORY_REGION(&ds->dma_mr),
+                           name);
+        memory_region_init_io(&ds->msi32_mr, OBJECT(phb), &pnv_phb4_msi_=
ops,
+                              ds, "msi32", 0x10000);
+        memory_region_init_io(&ds->msi64_mr, OBJECT(phb), &pnv_phb4_msi_=
ops,
+                              ds, "msi64", 0x100000);
+        pnv_phb4_update_msi_regions(ds);
+
+        QLIST_INSERT_HEAD(&phb->dma_spaces, ds, list);
+    }
+    return &ds->dma_as;
+}
+
+static void pnv_phb4_instance_init(Object *obj)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(obj);
+
+    QLIST_INIT(&phb->dma_spaces);
+
+    /* XIVE interrupt source object */
+    object_initialize_child(obj, "source", &phb->xsrc, sizeof(XiveSource=
),
+                            TYPE_XIVE_SOURCE, &error_abort, NULL);
+
+    /* Root Port */
+    object_initialize_child(obj, "root", &phb->root, sizeof(phb->root),
+                            TYPE_PNV_PHB4_ROOT_PORT, &error_abort, NULL)=
;
+
+    qdev_prop_set_int32(DEVICE(&phb->root), "addr", PCI_DEVFN(0, 0));
+    qdev_prop_set_bit(DEVICE(&phb->root), "multifunction", false);
+}
+
+static void pnv_phb4_realize(DeviceState *dev, Error **errp)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(dev);
+    PCIHostState *pci =3D PCI_HOST_BRIDGE(dev);
+    XiveSource *xsrc =3D &phb->xsrc;
+    Error *local_err =3D NULL;
+    int nr_irqs;
+    char name[32];
+
+    assert(phb->stack);
+
+    /* Set the "big_phb" flag */
+    phb->big_phb =3D phb->phb_id =3D=3D 0 || phb->phb_id =3D=3D 3;
+
+    /* Controller Registers */
+    snprintf(name, sizeof(name), "phb4-%d.%d-regs", phb->chip_id,
+             phb->phb_id);
+    memory_region_init_io(&phb->mr_regs, OBJECT(phb), &pnv_phb4_reg_ops,=
 phb,
+                          name, 0x2000);
+
+    /*
+     * PHB4 doesn't support IO space. However, qemu gets very upset if
+     * we don't have an IO region to anchor IO BARs onto so we just
+     * initialize one which we never hook up to anything
+     */
+
+    snprintf(name, sizeof(name), "phb4-%d.%d-pci-io", phb->chip_id,
+             phb->phb_id);
+    memory_region_init(&phb->pci_io, OBJECT(phb), name, 0x10000);
+
+    snprintf(name, sizeof(name), "phb4-%d.%d-pci-mmio", phb->chip_id,
+             phb->phb_id);
+    memory_region_init(&phb->pci_mmio, OBJECT(phb), name,
+                       PCI_MMIO_TOTAL_SIZE);
+
+    pci->bus =3D pci_register_root_bus(dev, "root-bus",
+                                     pnv_phb4_set_irq, pnv_phb4_map_irq,=
 phb,
+                                     &phb->pci_mmio, &phb->pci_io,
+                                     0, 4, TYPE_PNV_PHB4_ROOT_BUS);
+    pci_setup_iommu(pci->bus, pnv_phb4_dma_iommu, phb);
+
+    /* Add a single Root port */
+    qdev_prop_set_uint8(DEVICE(&phb->root), "chassis", phb->chip_id);
+    qdev_prop_set_uint16(DEVICE(&phb->root), "slot", phb->phb_id);
+    qdev_set_parent_bus(DEVICE(&phb->root), BUS(pci->bus));
+    qdev_init_nofail(DEVICE(&phb->root));
+
+    /* Setup XIVE Source */
+    if (phb->big_phb) {
+        nr_irqs =3D PNV_PHB4_MAX_INTs;
+    } else {
+        nr_irqs =3D PNV_PHB4_MAX_INTs >> 1;
+    }
+    object_property_set_int(OBJECT(xsrc), nr_irqs, "nr-irqs", &error_fat=
al);
+    object_property_set_link(OBJECT(xsrc), OBJECT(phb), "xive", &error_f=
atal);
+    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    pnv_phb4_update_xsrc(phb);
+
+    phb->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->n=
r_irqs);
+}
+
+static void pnv_phb4_reset(DeviceState *dev)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(dev);
+    PCIDevice *root_dev =3D PCI_DEVICE(&phb->root);
+
+    /*
+     * Configure PCI device id at reset using a property.
+     */
+    pci_config_set_vendor_id(root_dev->config, PCI_VENDOR_ID_IBM);
+    pci_config_set_device_id(root_dev->config, phb->device_id);
+}
+
+static const char *pnv_phb4_root_bus_path(PCIHostState *host_bridge,
+                                          PCIBus *rootbus)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(host_bridge);
+
+    snprintf(phb->bus_path, sizeof(phb->bus_path), "00%02x:%02x",
+             phb->chip_id, phb->phb_id);
+    return phb->bus_path;
+}
+
+static void pnv_phb4_xive_notify(XiveNotifier *xf, uint32_t srcno)
+{
+    PnvPHB4 *phb =3D PNV_PHB4(xf);
+    uint64_t notif_port =3D phb->regs[PHB_INT_NOTIFY_ADDR >> 3];
+    uint32_t offset =3D phb->regs[PHB_INT_NOTIFY_INDEX >> 3];
+    uint64_t data =3D XIVE_TRIGGER_PQ | offset | srcno;
+    MemTxResult result;
+
+    address_space_stq_be(&address_space_memory, notif_port, data,
+                         MEMTXATTRS_UNSPECIFIED, &result);
+    if (result !=3D MEMTX_OK) {
+        phb_error(phb, "trigger failed @%"HWADDR_PRIx "\n", notif_port);
+        return;
+    }
+}
+
+static Property pnv_phb4_properties[] =3D {
+        DEFINE_PROP_UINT32("index", PnvPHB4, phb_id, 0),
+        DEFINE_PROP_UINT32("chip-id", PnvPHB4, chip_id, 0),
+        DEFINE_PROP_UINT64("version", PnvPHB4, version, 0),
+        DEFINE_PROP_UINT16("device-id", PnvPHB4, device_id, 0),
+        DEFINE_PROP_LINK("stack", PnvPHB4, stack, TYPE_PNV_PHB4_PEC_STAC=
K,
+                         PnvPhb4PecStack *),
+        DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_phb4_class_init(ObjectClass *klass, void *data)
+{
+    PCIHostBridgeClass *hc =3D PCI_HOST_BRIDGE_CLASS(klass);
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    XiveNotifierClass *xfc =3D XIVE_NOTIFIER_CLASS(klass);
+
+    hc->root_bus_path   =3D pnv_phb4_root_bus_path;
+    dc->realize         =3D pnv_phb4_realize;
+    device_class_set_props(dc, pnv_phb4_properties);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
+    dc->user_creatable  =3D true;
+    dc->reset           =3D pnv_phb4_reset;
+
+    xfc->notify         =3D pnv_phb4_xive_notify;
+}
+
+static const TypeInfo pnv_phb4_type_info =3D {
+    .name          =3D TYPE_PNV_PHB4,
+    .parent        =3D TYPE_PCIE_HOST_BRIDGE,
+    .instance_init =3D pnv_phb4_instance_init,
+    .instance_size =3D sizeof(PnvPHB4),
+    .class_init    =3D pnv_phb4_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+            { TYPE_XIVE_NOTIFIER },
+            { },
+    }
+};
+
+static void pnv_phb4_root_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k =3D BUS_CLASS(klass);
+
+    /*
+     * PHB4 has only a single root complex. Enforce the limit on the
+     * parent bus
+     */
+    k->max_dev =3D 1;
+}
+
+static const TypeInfo pnv_phb4_root_bus_info =3D {
+    .name =3D TYPE_PNV_PHB4_ROOT_BUS,
+    .parent =3D TYPE_PCIE_BUS,
+    .class_init =3D pnv_phb4_root_bus_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
+};
+
+static void pnv_phb4_root_port_reset(DeviceState *dev)
+{
+    PCIERootPortClass *rpc =3D PCIE_ROOT_PORT_GET_CLASS(dev);
+    PCIDevice *d =3D PCI_DEVICE(dev);
+    uint8_t *conf =3D d->config;
+
+    rpc->parent_reset(dev);
+
+    pci_byte_test_and_set_mask(conf + PCI_IO_BASE,
+                               PCI_IO_RANGE_MASK & 0xff);
+    pci_byte_test_and_clear_mask(conf + PCI_IO_LIMIT,
+                                 PCI_IO_RANGE_MASK & 0xff);
+    pci_set_word(conf + PCI_MEMORY_BASE, 0);
+    pci_set_word(conf + PCI_MEMORY_LIMIT, 0xfff0);
+    pci_set_word(conf + PCI_PREF_MEMORY_BASE, 0x1);
+    pci_set_word(conf + PCI_PREF_MEMORY_LIMIT, 0xfff1);
+    pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
+    pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
+}
+
+static void pnv_phb4_root_port_realize(DeviceState *dev, Error **errp)
+{
+    PCIERootPortClass *rpc =3D PCIE_ROOT_PORT_GET_CLASS(dev);
+    Error *local_err =3D NULL;
+
+    rpc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+}
+
+static void pnv_phb4_root_port_class_init(ObjectClass *klass, void *data=
)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
+    PCIERootPortClass *rpc =3D PCIE_ROOT_PORT_CLASS(klass);
+
+    dc->desc     =3D "IBM PHB4 PCIE Root Port";
+
+    device_class_set_parent_realize(dc, pnv_phb4_root_port_realize,
+                                    &rpc->parent_realize);
+    device_class_set_parent_reset(dc, pnv_phb4_root_port_reset,
+                                  &rpc->parent_reset);
+
+    k->vendor_id =3D PCI_VENDOR_ID_IBM;
+    k->device_id =3D PNV_PHB4_DEVICE_ID;
+    k->revision  =3D 0;
+
+    rpc->exp_offset =3D 0x48;
+    rpc->aer_offset =3D 0x100;
+
+    dc->reset =3D &pnv_phb4_root_port_reset;
+}
+
+static const TypeInfo pnv_phb4_root_port_info =3D {
+    .name          =3D TYPE_PNV_PHB4_ROOT_PORT,
+    .parent        =3D TYPE_PCIE_ROOT_PORT,
+    .instance_size =3D sizeof(PnvPHB4RootPort),
+    .class_init    =3D pnv_phb4_root_port_class_init,
+};
+
+static void pnv_phb4_register_types(void)
+{
+    type_register_static(&pnv_phb4_root_bus_info);
+    type_register_static(&pnv_phb4_root_port_info);
+    type_register_static(&pnv_phb4_type_info);
+    type_register_static(&pnv_phb4_iommu_memory_region_info);
+}
+
+type_init(pnv_phb4_register_types);
+
+void pnv_phb4_update_regions(PnvPhb4PecStack *stack)
+{
+    PnvPHB4 *phb =3D &stack->phb;
+
+    /* Unmap first always */
+    if (memory_region_is_mapped(&phb->mr_regs)) {
+        memory_region_del_subregion(&stack->phbbar, &phb->mr_regs);
+    }
+    if (memory_region_is_mapped(&phb->xsrc.esb_mmio)) {
+        memory_region_del_subregion(&stack->intbar, &phb->xsrc.esb_mmio)=
;
+    }
+
+    /* Map registers if enabled */
+    if (memory_region_is_mapped(&stack->phbbar)) {
+        memory_region_add_subregion(&stack->phbbar, 0, &phb->mr_regs);
+    }
+
+    /* Map ESB if enabled */
+    if (memory_region_is_mapped(&stack->intbar)) {
+        memory_region_add_subregion(&stack->intbar, 0, &phb->xsrc.esb_mm=
io);
+    }
+
+    /* Check/update m32 */
+    pnv_phb4_check_all_mbt(phb);
+}
+
+void pnv_phb4_pic_print_info(PnvPHB4 *phb, Monitor *mon)
+{
+    uint32_t offset =3D phb->regs[PHB_INT_NOTIFY_INDEX >> 3];
+
+    monitor_printf(mon, "PHB4[%x:%x] Source %08x .. %08x\n",
+                   phb->chip_id, phb->phb_id,
+                   offset, offset + phb->xsrc.nr_irqs - 1);
+    xive_source_pic_print_info(&phb->xsrc, 0, mon);
+}
diff --git a/hw/pci-host/pnv_phb4_pec.c b/hw/pci-host/pnv_phb4_pec.c
new file mode 100644
index 0000000000..fd92041d69
--- /dev/null
+++ b/hw/pci-host/pnv_phb4_pec.c
@@ -0,0 +1,593 @@
+/*
+ * QEMU PowerPC PowerNV (POWER9) PHB4 model
+ *
+ * Copyright (c) 2018-2020, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "target/ppc/cpu.h"
+#include "hw/ppc/fdt.h"
+#include "hw/pci-host/pnv_phb4_regs.h"
+#include "hw/pci-host/pnv_phb4.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/ppc/pnv.h"
+#include "hw/qdev-properties.h"
+
+#include <libfdt.h>
+
+#define phb_pec_error(pec, fmt, ...)                                    =
\
+    qemu_log_mask(LOG_GUEST_ERROR, "phb4_pec[%d:%d]: " fmt "\n",        =
\
+                  (pec)->chip_id, (pec)->index, ## __VA_ARGS__)
+
+
+static uint64_t pnv_pec_nest_xscom_read(void *opaque, hwaddr addr,
+                                        unsigned size)
+{
+    PnvPhb4PecState *pec =3D PNV_PHB4_PEC(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    /* TODO: add list of allowed registers and error out if not */
+    return pec->nest_regs[reg];
+}
+
+static void pnv_pec_nest_xscom_write(void *opaque, hwaddr addr,
+                                     uint64_t val, unsigned size)
+{
+    PnvPhb4PecState *pec =3D PNV_PHB4_PEC(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    switch (reg) {
+    case PEC_NEST_PBCQ_HW_CONFIG:
+    case PEC_NEST_DROP_PRIO_CTRL:
+    case PEC_NEST_PBCQ_ERR_INJECT:
+    case PEC_NEST_PCI_NEST_CLK_TRACE_CTL:
+    case PEC_NEST_PBCQ_PMON_CTRL:
+    case PEC_NEST_PBCQ_PBUS_ADDR_EXT:
+    case PEC_NEST_PBCQ_PRED_VEC_TIMEOUT:
+    case PEC_NEST_CAPP_CTRL:
+    case PEC_NEST_PBCQ_READ_STK_OVR:
+    case PEC_NEST_PBCQ_WRITE_STK_OVR:
+    case PEC_NEST_PBCQ_STORE_STK_OVR:
+    case PEC_NEST_PBCQ_RETRY_BKOFF_CTRL:
+        pec->nest_regs[reg] =3D val;
+        break;
+    default:
+        phb_pec_error(pec, "%s @0x%"HWADDR_PRIx"=3D%"PRIx64"\n", __func_=
_,
+                      addr, val);
+    }
+}
+
+static const MemoryRegionOps pnv_pec_nest_xscom_ops =3D {
+    .read =3D pnv_pec_nest_xscom_read,
+    .write =3D pnv_pec_nest_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t pnv_pec_pci_xscom_read(void *opaque, hwaddr addr,
+                                       unsigned size)
+{
+    PnvPhb4PecState *pec =3D PNV_PHB4_PEC(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    /* TODO: add list of allowed registers and error out if not */
+    return pec->pci_regs[reg];
+}
+
+static void pnv_pec_pci_xscom_write(void *opaque, hwaddr addr,
+                                    uint64_t val, unsigned size)
+{
+    PnvPhb4PecState *pec =3D PNV_PHB4_PEC(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    switch (reg) {
+    case PEC_PCI_PBAIB_HW_CONFIG:
+    case PEC_PCI_PBAIB_READ_STK_OVR:
+        pec->pci_regs[reg] =3D val;
+        break;
+    default:
+        phb_pec_error(pec, "%s @0x%"HWADDR_PRIx"=3D%"PRIx64"\n", __func_=
_,
+                      addr, val);
+    }
+}
+
+static const MemoryRegionOps pnv_pec_pci_xscom_ops =3D {
+    .read =3D pnv_pec_pci_xscom_read,
+    .write =3D pnv_pec_pci_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t pnv_pec_stk_nest_xscom_read(void *opaque, hwaddr addr,
+                                            unsigned size)
+{
+    PnvPhb4PecStack *stack =3D PNV_PHB4_PEC_STACK(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    /* TODO: add list of allowed registers and error out if not */
+    return stack->nest_regs[reg];
+}
+
+static void pnv_pec_stk_update_map(PnvPhb4PecStack *stack)
+{
+    PnvPhb4PecState *pec =3D stack->pec;
+    MemoryRegion *sysmem =3D pec->system_memory;
+    uint64_t bar_en =3D stack->nest_regs[PEC_NEST_STK_BAR_EN];
+    uint64_t bar, mask, size;
+    char name[64];
+
+    /*
+     * NOTE: This will really not work well if those are remapped
+     * after the PHB has created its sub regions. We could do better
+     * if we had a way to resize regions but we don't really care
+     * that much in practice as the stuff below really only happens
+     * once early during boot
+     */
+
+    /* Handle unmaps */
+    if (memory_region_is_mapped(&stack->mmbar0) &&
+        !(bar_en & PEC_NEST_STK_BAR_EN_MMIO0)) {
+        memory_region_del_subregion(sysmem, &stack->mmbar0);
+    }
+    if (memory_region_is_mapped(&stack->mmbar1) &&
+        !(bar_en & PEC_NEST_STK_BAR_EN_MMIO1)) {
+        memory_region_del_subregion(sysmem, &stack->mmbar1);
+    }
+    if (memory_region_is_mapped(&stack->phbbar) &&
+        !(bar_en & PEC_NEST_STK_BAR_EN_PHB)) {
+        memory_region_del_subregion(sysmem, &stack->phbbar);
+    }
+    if (memory_region_is_mapped(&stack->intbar) &&
+        !(bar_en & PEC_NEST_STK_BAR_EN_INT)) {
+        memory_region_del_subregion(sysmem, &stack->intbar);
+    }
+
+    /* Update PHB */
+    pnv_phb4_update_regions(stack);
+
+    /* Handle maps */
+    if (!memory_region_is_mapped(&stack->mmbar0) &&
+        (bar_en & PEC_NEST_STK_BAR_EN_MMIO0)) {
+        bar =3D stack->nest_regs[PEC_NEST_STK_MMIO_BAR0] >> 8;
+        mask =3D stack->nest_regs[PEC_NEST_STK_MMIO_BAR0_MASK];
+        size =3D ((~mask) >> 8) + 1;
+        snprintf(name, sizeof(name), "pec-%d.%d-stack-%d-mmio0",
+                 pec->chip_id, pec->index, stack->stack_no);
+        memory_region_init(&stack->mmbar0, OBJECT(stack), name, size);
+        memory_region_add_subregion(sysmem, bar, &stack->mmbar0);
+        stack->mmio0_base =3D bar;
+        stack->mmio0_size =3D size;
+    }
+    if (!memory_region_is_mapped(&stack->mmbar1) &&
+        (bar_en & PEC_NEST_STK_BAR_EN_MMIO1)) {
+        bar =3D stack->nest_regs[PEC_NEST_STK_MMIO_BAR1] >> 8;
+        mask =3D stack->nest_regs[PEC_NEST_STK_MMIO_BAR1_MASK];
+        size =3D ((~mask) >> 8) + 1;
+        snprintf(name, sizeof(name), "pec-%d.%d-stack-%d-mmio1",
+                 pec->chip_id, pec->index, stack->stack_no);
+        memory_region_init(&stack->mmbar1, OBJECT(stack), name, size);
+        memory_region_add_subregion(sysmem, bar, &stack->mmbar1);
+        stack->mmio1_base =3D bar;
+        stack->mmio1_size =3D size;
+    }
+    if (!memory_region_is_mapped(&stack->phbbar) &&
+        (bar_en & PEC_NEST_STK_BAR_EN_PHB)) {
+        bar =3D stack->nest_regs[PEC_NEST_STK_PHB_REGS_BAR] >> 8;
+        size =3D PNV_PHB4_NUM_REGS << 3;
+        snprintf(name, sizeof(name), "pec-%d.%d-stack-%d-phb",
+                 pec->chip_id, pec->index, stack->stack_no);
+        memory_region_init(&stack->phbbar, OBJECT(stack), name, size);
+        memory_region_add_subregion(sysmem, bar, &stack->phbbar);
+    }
+    if (!memory_region_is_mapped(&stack->intbar) &&
+        (bar_en & PEC_NEST_STK_BAR_EN_INT)) {
+        bar =3D stack->nest_regs[PEC_NEST_STK_INT_BAR] >> 8;
+        size =3D PNV_PHB4_MAX_INTs << 16;
+        snprintf(name, sizeof(name), "pec-%d.%d-stack-%d-int",
+                 stack->pec->chip_id, stack->pec->index, stack->stack_no=
);
+        memory_region_init(&stack->intbar, OBJECT(stack), name, size);
+        memory_region_add_subregion(sysmem, bar, &stack->intbar);
+    }
+
+    /* Update PHB */
+    pnv_phb4_update_regions(stack);
+}
+
+static void pnv_pec_stk_nest_xscom_write(void *opaque, hwaddr addr,
+                                         uint64_t val, unsigned size)
+{
+    PnvPhb4PecStack *stack =3D PNV_PHB4_PEC_STACK(opaque);
+    PnvPhb4PecState *pec =3D stack->pec;
+    uint32_t reg =3D addr >> 3;
+
+    switch (reg) {
+    case PEC_NEST_STK_PCI_NEST_FIR:
+        stack->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] =3D val;
+        break;
+    case PEC_NEST_STK_PCI_NEST_FIR_CLR:
+        stack->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] &=3D val;
+        break;
+    case PEC_NEST_STK_PCI_NEST_FIR_SET:
+        stack->nest_regs[PEC_NEST_STK_PCI_NEST_FIR] |=3D val;
+        break;
+    case PEC_NEST_STK_PCI_NEST_FIR_MSK:
+        stack->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] =3D val;
+        break;
+    case PEC_NEST_STK_PCI_NEST_FIR_MSKC:
+        stack->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] &=3D val;
+        break;
+    case PEC_NEST_STK_PCI_NEST_FIR_MSKS:
+        stack->nest_regs[PEC_NEST_STK_PCI_NEST_FIR_MSK] |=3D val;
+        break;
+    case PEC_NEST_STK_PCI_NEST_FIR_ACT0:
+    case PEC_NEST_STK_PCI_NEST_FIR_ACT1:
+        stack->nest_regs[reg] =3D val;
+        break;
+    case PEC_NEST_STK_PCI_NEST_FIR_WOF:
+        stack->nest_regs[reg] =3D 0;
+        break;
+    case PEC_NEST_STK_ERR_REPORT_0:
+    case PEC_NEST_STK_ERR_REPORT_1:
+    case PEC_NEST_STK_PBCQ_GNRL_STATUS:
+        /* Flag error ? */
+        break;
+    case PEC_NEST_STK_PBCQ_MODE:
+        stack->nest_regs[reg] =3D val & 0xff00000000000000ull;
+        break;
+    case PEC_NEST_STK_MMIO_BAR0:
+    case PEC_NEST_STK_MMIO_BAR0_MASK:
+    case PEC_NEST_STK_MMIO_BAR1:
+    case PEC_NEST_STK_MMIO_BAR1_MASK:
+        if (stack->nest_regs[PEC_NEST_STK_BAR_EN] &
+            (PEC_NEST_STK_BAR_EN_MMIO0 |
+             PEC_NEST_STK_BAR_EN_MMIO1)) {
+            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+        }
+        stack->nest_regs[reg] =3D val & 0xffffffffff000000ull;
+        break;
+    case PEC_NEST_STK_PHB_REGS_BAR:
+        if (stack->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_=
PHB) {
+            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+        }
+        stack->nest_regs[reg] =3D val & 0xffffffffffc00000ull;
+        break;
+    case PEC_NEST_STK_INT_BAR:
+        if (stack->nest_regs[PEC_NEST_STK_BAR_EN] & PEC_NEST_STK_BAR_EN_=
INT) {
+            phb_pec_error(pec, "Changing enabled BAR unsupported\n");
+        }
+        stack->nest_regs[reg] =3D val & 0xfffffff000000000ull;
+        break;
+    case PEC_NEST_STK_BAR_EN:
+        stack->nest_regs[reg] =3D val & 0xf000000000000000ull;
+        pnv_pec_stk_update_map(stack);
+        break;
+    case PEC_NEST_STK_DATA_FRZ_TYPE:
+    case PEC_NEST_STK_PBCQ_TUN_BAR:
+        /* Not used for now */
+        stack->nest_regs[reg] =3D val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "phb4_pec: nest_xscom_write 0x%"HWADDR_=
PRIx
+                      "=3D%"PRIx64"\n", addr, val);
+    }
+}
+
+static const MemoryRegionOps pnv_pec_stk_nest_xscom_ops =3D {
+    .read =3D pnv_pec_stk_nest_xscom_read,
+    .write =3D pnv_pec_stk_nest_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static uint64_t pnv_pec_stk_pci_xscom_read(void *opaque, hwaddr addr,
+                                           unsigned size)
+{
+    PnvPhb4PecStack *stack =3D PNV_PHB4_PEC_STACK(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    /* TODO: add list of allowed registers and error out if not */
+    return stack->pci_regs[reg];
+}
+
+static void pnv_pec_stk_pci_xscom_write(void *opaque, hwaddr addr,
+                                        uint64_t val, unsigned size)
+{
+    PnvPhb4PecStack *stack =3D PNV_PHB4_PEC_STACK(opaque);
+    uint32_t reg =3D addr >> 3;
+
+    switch (reg) {
+    case PEC_PCI_STK_PCI_FIR:
+        stack->nest_regs[reg] =3D val;
+        break;
+    case PEC_PCI_STK_PCI_FIR_CLR:
+        stack->nest_regs[PEC_PCI_STK_PCI_FIR] &=3D val;
+        break;
+    case PEC_PCI_STK_PCI_FIR_SET:
+        stack->nest_regs[PEC_PCI_STK_PCI_FIR] |=3D val;
+        break;
+    case PEC_PCI_STK_PCI_FIR_MSK:
+        stack->nest_regs[reg] =3D val;
+        break;
+    case PEC_PCI_STK_PCI_FIR_MSKC:
+        stack->nest_regs[PEC_PCI_STK_PCI_FIR_MSK] &=3D val;
+        break;
+    case PEC_PCI_STK_PCI_FIR_MSKS:
+        stack->nest_regs[PEC_PCI_STK_PCI_FIR_MSK] |=3D val;
+        break;
+    case PEC_PCI_STK_PCI_FIR_ACT0:
+    case PEC_PCI_STK_PCI_FIR_ACT1:
+        stack->nest_regs[reg] =3D val;
+        break;
+    case PEC_PCI_STK_PCI_FIR_WOF:
+        stack->nest_regs[reg] =3D 0;
+        break;
+    case PEC_PCI_STK_ETU_RESET:
+        stack->nest_regs[reg] =3D val & 0x8000000000000000ull;
+        /* TODO: Implement reset */
+        break;
+    case PEC_PCI_STK_PBAIB_ERR_REPORT:
+        break;
+    case PEC_PCI_STK_PBAIB_TX_CMD_CRED:
+    case PEC_PCI_STK_PBAIB_TX_DAT_CRED:
+        stack->nest_regs[reg] =3D val;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "phb4_pec_stk: pci_xscom_write 0x%"HWAD=
DR_PRIx
+                      "=3D%"PRIx64"\n", addr, val);
+    }
+}
+
+static const MemoryRegionOps pnv_pec_stk_pci_xscom_ops =3D {
+    .read =3D pnv_pec_stk_pci_xscom_read,
+    .write =3D pnv_pec_stk_pci_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_pec_instance_init(Object *obj)
+{
+    PnvPhb4PecState *pec =3D PNV_PHB4_PEC(obj);
+    int i;
+
+    for (i =3D 0; i < PHB4_PEC_MAX_STACKS; i++) {
+        object_initialize_child(obj, "stack[*]", &pec->stacks[i],
+                                sizeof(pec->stacks[i]), TYPE_PNV_PHB4_PE=
C_STACK,
+                                &error_abort, NULL);
+    }
+}
+
+static void pnv_pec_realize(DeviceState *dev, Error **errp)
+{
+    PnvPhb4PecState *pec =3D PNV_PHB4_PEC(dev);
+    Error *local_err =3D NULL;
+    char name[64];
+    int i;
+
+    assert(pec->system_memory);
+
+    /* Create stacks */
+    for (i =3D 0; i < pec->num_stacks; i++) {
+        PnvPhb4PecStack *stack =3D &pec->stacks[i];
+        Object *stk_obj =3D OBJECT(stack);
+
+        object_property_set_int(stk_obj, i, "stack-no", &error_abort);
+        object_property_set_link(stk_obj, OBJECT(pec), "pec", &error_abo=
rt);
+        object_property_set_bool(stk_obj, true, "realized", errp);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    /* Initialize the XSCOM regions for the PEC registers */
+    snprintf(name, sizeof(name), "xscom-pec-%d.%d-nest", pec->chip_id,
+             pec->index);
+    pnv_xscom_region_init(&pec->nest_regs_mr, OBJECT(dev),
+                          &pnv_pec_nest_xscom_ops, pec, name,
+                          PHB4_PEC_NEST_REGS_COUNT);
+
+    snprintf(name, sizeof(name), "xscom-pec-%d.%d-pci", pec->chip_id,
+             pec->index);
+    pnv_xscom_region_init(&pec->pci_regs_mr, OBJECT(dev),
+                          &pnv_pec_pci_xscom_ops, pec, name,
+                          PHB4_PEC_PCI_REGS_COUNT);
+}
+
+static int pnv_pec_dt_xscom(PnvXScomInterface *dev, void *fdt,
+                            int xscom_offset)
+{
+    PnvPhb4PecState *pec =3D PNV_PHB4_PEC(dev);
+    PnvPhb4PecClass *pecc =3D PNV_PHB4_PEC_GET_CLASS(dev);
+    uint32_t nbase =3D pecc->xscom_nest_base(pec);
+    uint32_t pbase =3D pecc->xscom_pci_base(pec);
+    int offset, i;
+    char *name;
+    uint32_t reg[] =3D {
+        cpu_to_be32(nbase),
+        cpu_to_be32(pecc->xscom_nest_size),
+        cpu_to_be32(pbase),
+        cpu_to_be32(pecc->xscom_pci_size),
+    };
+
+    name =3D g_strdup_printf("pbcq@%x", nbase);
+    offset =3D fdt_add_subnode(fdt, xscom_offset, name);
+    _FDT(offset);
+    g_free(name);
+
+    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
+
+    _FDT((fdt_setprop_cell(fdt, offset, "ibm,pec-index", pec->index)));
+    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 1)));
+    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 0)));
+    _FDT((fdt_setprop(fdt, offset, "compatible", pecc->compat,
+                      pecc->compat_size)));
+
+    for (i =3D 0; i < pec->num_stacks; i++) {
+        PnvPhb4PecStack *stack =3D &pec->stacks[i];
+        PnvPHB4 *phb =3D &stack->phb;
+        int stk_offset;
+
+        name =3D g_strdup_printf("stack@%x", i);
+        stk_offset =3D fdt_add_subnode(fdt, offset, name);
+        _FDT(stk_offset);
+        g_free(name);
+        _FDT((fdt_setprop(fdt, stk_offset, "compatible", pecc->stk_compa=
t,
+                          pecc->stk_compat_size)));
+        _FDT((fdt_setprop_cell(fdt, stk_offset, "reg", i)));
+        _FDT((fdt_setprop_cell(fdt, stk_offset, "ibm,phb-index", phb->ph=
b_id)));
+    }
+
+    return 0;
+}
+
+static Property pnv_pec_properties[] =3D {
+        DEFINE_PROP_UINT32("index", PnvPhb4PecState, index, 0),
+        DEFINE_PROP_UINT32("num-stacks", PnvPhb4PecState, num_stacks, 0)=
,
+        DEFINE_PROP_UINT32("chip-id", PnvPhb4PecState, chip_id, 0),
+        DEFINE_PROP_LINK("system-memory", PnvPhb4PecState, system_memory=
,
+                     TYPE_MEMORY_REGION, MemoryRegion *),
+        DEFINE_PROP_END_OF_LIST(),
+};
+
+static uint32_t pnv_pec_xscom_pci_base(PnvPhb4PecState *pec)
+{
+    return PNV9_XSCOM_PEC_PCI_BASE + 0x1000000 * pec->index;
+}
+
+static uint32_t pnv_pec_xscom_nest_base(PnvPhb4PecState *pec)
+{
+    return PNV9_XSCOM_PEC_NEST_BASE + 0x400 * pec->index;
+}
+
+static void pnv_pec_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
+    PnvPhb4PecClass *pecc =3D PNV_PHB4_PEC_CLASS(klass);
+    static const char compat[] =3D "ibm,power9-pbcq";
+    static const char stk_compat[] =3D "ibm,power9-phb-stack";
+
+    xdc->dt_xscom =3D pnv_pec_dt_xscom;
+
+    dc->realize =3D pnv_pec_realize;
+    device_class_set_props(dc, pnv_pec_properties);
+
+    pecc->xscom_nest_base =3D pnv_pec_xscom_nest_base;
+    pecc->xscom_pci_base  =3D pnv_pec_xscom_pci_base;
+    pecc->xscom_nest_size =3D PNV9_XSCOM_PEC_NEST_SIZE;
+    pecc->xscom_pci_size  =3D PNV9_XSCOM_PEC_PCI_SIZE;
+    pecc->compat =3D compat;
+    pecc->compat_size =3D sizeof(compat);
+    pecc->stk_compat =3D stk_compat;
+    pecc->stk_compat_size =3D sizeof(stk_compat);
+}
+
+static const TypeInfo pnv_pec_type_info =3D {
+    .name          =3D TYPE_PNV_PHB4_PEC,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(PnvPhb4PecState),
+    .instance_init =3D pnv_pec_instance_init,
+    .class_init    =3D pnv_pec_class_init,
+    .class_size    =3D sizeof(PnvPhb4PecClass),
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_pec_stk_instance_init(Object *obj)
+{
+    PnvPhb4PecStack *stack =3D PNV_PHB4_PEC_STACK(obj);
+
+    object_initialize_child(obj, "phb", &stack->phb, sizeof(stack->phb),
+                            TYPE_PNV_PHB4, &error_abort, NULL);
+}
+
+static void pnv_pec_stk_realize(DeviceState *dev, Error **errp)
+{
+    PnvPhb4PecStack *stack =3D PNV_PHB4_PEC_STACK(dev);
+    PnvPhb4PecState *pec =3D stack->pec;
+    char name[64];
+
+    assert(pec);
+
+    /* Initialize the XSCOM regions for the stack registers */
+    snprintf(name, sizeof(name), "xscom-pec-%d.%d-nest-stack-%d",
+             pec->chip_id, pec->index, stack->stack_no);
+    pnv_xscom_region_init(&stack->nest_regs_mr, OBJECT(stack),
+                          &pnv_pec_stk_nest_xscom_ops, stack, name,
+                          PHB4_PEC_NEST_STK_REGS_COUNT);
+
+    snprintf(name, sizeof(name), "xscom-pec-%d.%d-pci-stack-%d",
+             pec->chip_id, pec->index, stack->stack_no);
+    pnv_xscom_region_init(&stack->pci_regs_mr, OBJECT(stack),
+                          &pnv_pec_stk_pci_xscom_ops, stack, name,
+                          PHB4_PEC_PCI_STK_REGS_COUNT);
+
+    /* PHB pass-through */
+    snprintf(name, sizeof(name), "xscom-pec-%d.%d-pci-stack-%d-phb",
+             pec->chip_id, pec->index, stack->stack_no);
+    pnv_xscom_region_init(&stack->phb_regs_mr, OBJECT(&stack->phb),
+                          &pnv_phb4_xscom_ops, &stack->phb, name, 0x40);
+
+    /*
+     * Let the machine/chip realize the PHB object to customize more
+     * easily some fields
+     */
+}
+
+static Property pnv_pec_stk_properties[] =3D {
+        DEFINE_PROP_UINT32("stack-no", PnvPhb4PecStack, stack_no, 0),
+        DEFINE_PROP_LINK("pec", PnvPhb4PecStack, pec, TYPE_PNV_PHB4_PEC,
+                         PnvPhb4PecState *),
+        DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_pec_stk_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    device_class_set_props(dc, pnv_pec_stk_properties);
+    dc->realize =3D pnv_pec_stk_realize;
+
+    /* TODO: reset regs ? */
+}
+
+static const TypeInfo pnv_pec_stk_type_info =3D {
+    .name          =3D TYPE_PNV_PHB4_PEC_STACK,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(PnvPhb4PecStack),
+    .instance_init =3D pnv_pec_stk_instance_init,
+    .class_init    =3D pnv_pec_stk_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_pec_register_types(void)
+{
+    type_register_static(&pnv_pec_type_info);
+    type_register_static(&pnv_pec_stk_type_info);
+}
+
+type_init(pnv_pec_register_types);
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index e27efe9a24..354828bf13 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -135,6 +135,8 @@ config XIVE_SPAPR
     default y
     depends on PSERIES
     select XIVE
+    select PCI
+    select PCIE_PORT
=20
 config XIVE_KVM
     bool
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 9442e5eb63..d5ecec6321 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -40,6 +40,7 @@
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
 #include "target/ppc/mmu-hash64.h"
+#include "hw/pci/msi.h"
=20
 #include "hw/ppc/xics.h"
 #include "hw/qdev-properties.h"
@@ -622,9 +623,17 @@ static void pnv_chip_power8_pic_print_info(PnvChip *=
chip, Monitor *mon)
 static void pnv_chip_power9_pic_print_info(PnvChip *chip, Monitor *mon)
 {
     Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
+    int i, j;
=20
     pnv_xive_pic_print_info(&chip9->xive, mon);
     pnv_psi_pic_print_info(&chip9->psi, mon);
+
+    for (i =3D 0; i < PNV9_CHIP_MAX_PEC; i++) {
+        PnvPhb4PecState *pec =3D &chip9->pecs[i];
+        for (j =3D 0; j < pec->num_stacks; j++) {
+            pnv_phb4_pic_print_info(&pec->stacks[j].phb, mon);
+        }
+    }
 }
=20
 static uint64_t pnv_chip_power8_xscom_core_base(PnvChip *chip,
@@ -748,6 +757,9 @@ static void pnv_init(MachineState *machine)
         }
     }
=20
+    /* MSIs are supported on this platform */
+    msi_nonbroken =3D true;
+
     /*
      * Check compatibility of the specified CPU with the machine
      * default.
@@ -1230,7 +1242,10 @@ static void pnv_chip_power8nvl_class_init(ObjectCl=
ass *klass, void *data)
=20
 static void pnv_chip_power9_instance_init(Object *obj)
 {
+    PnvChip *chip =3D PNV_CHIP(obj);
     Pnv9Chip *chip9 =3D PNV9_CHIP(obj);
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(obj);
+    int i;
=20
     object_initialize_child(obj, "xive", &chip9->xive, sizeof(chip9->xiv=
e),
                             TYPE_PNV_XIVE, &error_abort, NULL);
@@ -1248,6 +1263,17 @@ static void pnv_chip_power9_instance_init(Object *=
obj)
=20
     object_initialize_child(obj, "homer",  &chip9->homer, sizeof(chip9->=
homer),
                             TYPE_PNV9_HOMER, &error_abort, NULL);
+
+    for (i =3D 0; i < PNV9_CHIP_MAX_PEC; i++) {
+        object_initialize_child(obj, "pec[*]", &chip9->pecs[i],
+                                sizeof(chip9->pecs[i]), TYPE_PNV_PHB4_PE=
C,
+                                &error_abort, NULL);
+    }
+
+    /*
+     * Number of PHBs is the chip default
+     */
+    chip->num_phbs =3D pcc->num_phbs;
 }
=20
 static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
@@ -1276,6 +1302,78 @@ static void pnv_chip_quad_realize(Pnv9Chip *chip9,=
 Error **errp)
     }
 }
=20
+static void pnv_chip_power9_phb_realize(PnvChip *chip, Error **errp)
+{
+    Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
+    Error *local_err =3D NULL;
+    int i, j;
+    int phb_id =3D 0;
+
+    for (i =3D 0; i < PNV9_CHIP_MAX_PEC; i++) {
+        PnvPhb4PecState *pec =3D &chip9->pecs[i];
+        PnvPhb4PecClass *pecc =3D PNV_PHB4_PEC_GET_CLASS(pec);
+        uint32_t pec_nest_base;
+        uint32_t pec_pci_base;
+
+        object_property_set_int(OBJECT(pec), i, "index", &error_fatal);
+        /*
+         * PEC0 -> 1 stack
+         * PEC1 -> 2 stacks
+         * PEC2 -> 3 stacks
+         */
+        object_property_set_int(OBJECT(pec), i + 1, "num-stacks",
+                                &error_fatal);
+        object_property_set_int(OBJECT(pec), chip->chip_id, "chip-id",
+                                 &error_fatal);
+        object_property_set_link(OBJECT(pec), OBJECT(get_system_memory()=
),
+                                 "system-memory", &error_abort);
+        object_property_set_bool(OBJECT(pec), true, "realized", &local_e=
rr);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+
+        pec_nest_base =3D pecc->xscom_nest_base(pec);
+        pec_pci_base =3D pecc->xscom_pci_base(pec);
+
+        pnv_xscom_add_subregion(chip, pec_nest_base, &pec->nest_regs_mr)=
;
+        pnv_xscom_add_subregion(chip, pec_pci_base, &pec->pci_regs_mr);
+
+        for (j =3D 0; j < pec->num_stacks && phb_id < chip->num_phbs;
+             j++, phb_id++) {
+            PnvPhb4PecStack *stack =3D &pec->stacks[j];
+            Object *obj =3D OBJECT(&stack->phb);
+
+            object_property_set_int(obj, phb_id, "index", &error_fatal);
+            object_property_set_int(obj, chip->chip_id, "chip-id",
+                                    &error_fatal);
+            object_property_set_int(obj, PNV_PHB4_VERSION, "version",
+                                    &error_fatal);
+            object_property_set_int(obj, PNV_PHB4_DEVICE_ID, "device-id"=
,
+                                    &error_fatal);
+            object_property_set_link(obj, OBJECT(stack), "stack", &error=
_abort);
+            object_property_set_bool(obj, true, "realized", &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return;
+            }
+            qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
+
+            /* Populate the XSCOM address space. */
+            pnv_xscom_add_subregion(chip,
+                                   pec_nest_base + 0x40 * (stack->stack_=
no + 1),
+                                   &stack->nest_regs_mr);
+            pnv_xscom_add_subregion(chip,
+                                    pec_pci_base + 0x40 * (stack->stack_=
no + 1),
+                                    &stack->pci_regs_mr);
+            pnv_xscom_add_subregion(chip,
+                                    pec_pci_base + PNV9_XSCOM_PEC_PCI_ST=
K0 +
+                                    0x40 * stack->stack_no,
+                                    &stack->phb_regs_mr);
+        }
+    }
+}
+
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
@@ -1378,6 +1476,13 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
     /* Homer mmio region */
     memory_region_add_subregion(get_system_memory(), PNV9_HOMER_BASE(chi=
p),
                                 &chip9->homer.regs);
+
+    /* PHBs */
+    pnv_chip_power9_phb_realize(chip, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
=20
 static uint32_t pnv_chip_power9_xscom_pcba(PnvChip *chip, uint64_t addr)
@@ -1404,6 +1509,7 @@ static void pnv_chip_power9_class_init(ObjectClass =
*klass, void *data)
     k->xscom_core_base =3D pnv_chip_power9_xscom_core_base;
     k->xscom_pcba =3D pnv_chip_power9_xscom_pcba;
     dc->desc =3D "PowerNV Chip POWER9";
+    k->num_phbs =3D 6;
=20
     device_class_set_parent_realize(dc, pnv_chip_power9_realize,
                                     &k->parent_realize);
@@ -1608,6 +1714,7 @@ static Property pnv_chip_properties[] =3D {
     DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
     DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
     DEFINE_PROP_UINT32("nr-threads", PnvChip, nr_threads, 1),
+    DEFINE_PROP_UINT32("num-phbs", PnvChip, num_phbs, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb=
4.h
new file mode 100644
index 0000000000..c882bfd0aa
--- /dev/null
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -0,0 +1,230 @@
+/*
+ * QEMU PowerPC PowerNV (POWER9) PHB4 model
+ *
+ * Copyright (c) 2018-2020, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PCI_HOST_PNV_PHB4_H
+#define PCI_HOST_PNV_PHB4_H
+
+#include "hw/pci/pcie_host.h"
+#include "hw/pci/pcie_port.h"
+#include "hw/ppc/xive.h"
+
+typedef struct PnvPhb4PecState PnvPhb4PecState;
+typedef struct PnvPhb4PecStack PnvPhb4PecStack;
+typedef struct PnvPHB4 PnvPHB4;
+typedef struct PnvChip PnvChip;
+
+/*
+ * We have one such address space wrapper per possible device under
+ * the PHB since they need to be assigned statically at qemu device
+ * creation time. The relationship to a PE is done later
+ * dynamically. This means we can potentially create a lot of these
+ * guys. Q35 stores them as some kind of radix tree but we never
+ * really need to do fast lookups so instead we simply keep a QLIST of
+ * them for now, we can add the radix if needed later on.
+ *
+ * We do cache the PE number to speed things up a bit though.
+ */
+typedef struct PnvPhb4DMASpace {
+    PCIBus *bus;
+    uint8_t devfn;
+    int pe_num;         /* Cached PE number */
+#define PHB_INVALID_PE (-1)
+    PnvPHB4 *phb;
+    AddressSpace dma_as;
+    IOMMUMemoryRegion dma_mr;
+    MemoryRegion msi32_mr;
+    MemoryRegion msi64_mr;
+    QLIST_ENTRY(PnvPhb4DMASpace) list;
+} PnvPhb4DMASpace;
+
+/*
+ * PHB4 PCIe Root port
+ */
+#define TYPE_PNV_PHB4_ROOT_BUS "pnv-phb4-root-bus"
+#define TYPE_PNV_PHB4_ROOT_PORT "pnv-phb4-root-port"
+
+typedef struct PnvPHB4RootPort {
+    PCIESlot parent_obj;
+} PnvPHB4RootPort;
+
+/*
+ * PHB4 PCIe Host Bridge for PowerNV machines (POWER9)
+ */
+#define TYPE_PNV_PHB4 "pnv-phb4"
+#define PNV_PHB4(obj) OBJECT_CHECK(PnvPHB4, (obj), TYPE_PNV_PHB4)
+
+#define PNV_PHB4_MAX_LSIs          8
+#define PNV_PHB4_MAX_INTs          4096
+#define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
+#define PNV_PHB4_MAX_MMIO_WINDOWS  32
+#define PNV_PHB4_MIN_MMIO_WINDOWS  16
+#define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
+#define PNV_PHB4_MAX_PEs           512
+#define PNV_PHB4_MAX_TVEs          (PNV_PHB4_MAX_PEs * 2)
+#define PNV_PHB4_MAX_PEEVs         (PNV_PHB4_MAX_PEs / 64)
+#define PNV_PHB4_MAX_MBEs          (PNV_PHB4_MAX_MMIO_WINDOWS * 2)
+
+#define PNV_PHB4_VERSION           0x000000a400000002ull
+#define PNV_PHB4_DEVICE_ID         0x04c1
+
+#define PCI_MMIO_TOTAL_SIZE        (0x1ull << 60)
+
+struct PnvPHB4 {
+    PCIExpressHost parent_obj;
+
+    PnvPHB4RootPort root;
+
+    uint32_t chip_id;
+    uint32_t phb_id;
+
+    uint64_t version;
+    uint16_t device_id;
+
+    char bus_path[8];
+
+    /* Main register images */
+    uint64_t regs[PNV_PHB4_NUM_REGS];
+    MemoryRegion mr_regs;
+
+    /* Extra SCOM-only register */
+    uint64_t scom_hv_ind_addr_reg;
+
+    /*
+     * Geometry of the PHB. There are two types, small and big PHBs, a
+     * number of resources (number of PEs, windows etc...) are doubled
+     * for a big PHB
+     */
+    bool big_phb;
+
+    /* Memory regions for MMIO space */
+    MemoryRegion mr_mmio[PNV_PHB4_MAX_MMIO_WINDOWS];
+
+    /* PCI side space */
+    MemoryRegion pci_mmio;
+    MemoryRegion pci_io;
+
+    /* On-chip IODA tables */
+    uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
+    uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
+    uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
+    uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
+    uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
+    uint64_t ioda_PEEV[PNV_PHB4_MAX_PEEVs];
+
+    /*
+     * The internal PESTA/B is 2 bits per PE split into two tables, we
+     * store them in a single array here to avoid wasting space.
+     */
+    uint8_t  ioda_PEST_AB[PNV_PHB4_MAX_PEs];
+
+    /* P9 Interrupt generation */
+    XiveSource xsrc;
+    qemu_irq *qirqs;
+
+    PnvPhb4PecStack *stack;
+
+    QLIST_HEAD(, PnvPhb4DMASpace) dma_spaces;
+};
+
+void pnv_phb4_pic_print_info(PnvPHB4 *phb, Monitor *mon);
+void pnv_phb4_update_regions(PnvPhb4PecStack *stack);
+extern const MemoryRegionOps pnv_phb4_xscom_ops;
+
+/*
+ * PHB4 PEC (PCI Express Controller)
+ */
+#define TYPE_PNV_PHB4_PEC "pnv-phb4-pec"
+#define PNV_PHB4_PEC(obj) \
+    OBJECT_CHECK(PnvPhb4PecState, (obj), TYPE_PNV_PHB4_PEC)
+
+#define TYPE_PNV_PHB4_PEC_STACK "pnv-phb4-pec-stack"
+#define PNV_PHB4_PEC_STACK(obj) \
+    OBJECT_CHECK(PnvPhb4PecStack, (obj), TYPE_PNV_PHB4_PEC_STACK)
+
+/* Per-stack data */
+struct PnvPhb4PecStack {
+    DeviceState parent;
+
+    /* My own stack number */
+    uint32_t stack_no;
+
+    /* Nest registers */
+#define PHB4_PEC_NEST_STK_REGS_COUNT  0x17
+    uint64_t nest_regs[PHB4_PEC_NEST_STK_REGS_COUNT];
+    MemoryRegion nest_regs_mr;
+
+    /* PCI registers (excluding pass-through) */
+#define PHB4_PEC_PCI_STK_REGS_COUNT  0xf
+    uint64_t pci_regs[PHB4_PEC_PCI_STK_REGS_COUNT];
+    MemoryRegion pci_regs_mr;
+
+    /* PHB pass-through XSCOM */
+    MemoryRegion phb_regs_mr;
+
+    /* Memory windows from PowerBus to PHB */
+    MemoryRegion mmbar0;
+    MemoryRegion mmbar1;
+    MemoryRegion phbbar;
+    MemoryRegion intbar;
+    uint64_t mmio0_base;
+    uint64_t mmio0_size;
+    uint64_t mmio1_base;
+    uint64_t mmio1_size;
+
+    /* The owner PEC */
+    PnvPhb4PecState *pec;
+
+    /* The actual PHB */
+    PnvPHB4 phb;
+};
+
+struct PnvPhb4PecState {
+    DeviceState parent;
+
+    /* PEC number in chip */
+    uint32_t index;
+    uint32_t chip_id;
+
+    MemoryRegion *system_memory;
+
+    /* Nest registers, excuding per-stack */
+#define PHB4_PEC_NEST_REGS_COUNT    0xf
+    uint64_t nest_regs[PHB4_PEC_NEST_REGS_COUNT];
+    MemoryRegion nest_regs_mr;
+
+    /* PCI registers, excluding per-stack */
+#define PHB4_PEC_PCI_REGS_COUNT     0x2
+    uint64_t pci_regs[PHB4_PEC_PCI_REGS_COUNT];
+    MemoryRegion pci_regs_mr;
+
+    /* Stacks */
+    #define PHB4_PEC_MAX_STACKS     3
+    uint32_t num_stacks;
+    PnvPhb4PecStack stacks[PHB4_PEC_MAX_STACKS];
+};
+
+#define PNV_PHB4_PEC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(PnvPhb4PecClass, (klass), TYPE_PNV_PHB4_PEC)
+#define PNV_PHB4_PEC_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PnvPhb4PecClass, (obj), TYPE_PNV_PHB4_PEC)
+
+typedef struct PnvPhb4PecClass {
+    DeviceClass parent_class;
+
+    uint32_t (*xscom_nest_base)(PnvPhb4PecState *pec);
+    uint32_t xscom_nest_size;
+    uint32_t (*xscom_pci_base)(PnvPhb4PecState *pec);
+    uint32_t xscom_pci_size;
+    const char *compat;
+    int compat_size;
+    const char *stk_compat;
+    int stk_compat_size;
+} PnvPhb4PecClass;
+
+#endif /* PCI_HOST_PNV_PHB4_H */
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pn=
v_phb4_regs.h
new file mode 100644
index 0000000000..55df2c3e5e
--- /dev/null
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -0,0 +1,553 @@
+/*
+ * QEMU PowerPC PowerNV (POWER9) PHB4 model
+ *
+ * Copyright (c) 2013-2020, IBM Corporation.
+ *
+ * This code is licensed under the GPL version 2 or later. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef PCI_HOST_PNV_PHB4_REGS_H
+#define PCI_HOST_PNV_PHB4_REGS_H
+
+/*
+ * PEC XSCOM registers
+ *
+ * There a 3 PECs in P9. Each PEC can have several PHBs. Each PEC has so=
me
+ * "global" registers and some "per-stack" (per-PHB) registers. Those ar=
e
+ * organized in two XSCOM ranges, the "Nest" range and the "PCI" range, =
each
+ * range contains both some "PEC" registers and some "per-stack" registe=
rs.
+ *
+ * Finally the PCI range also contains an additional range per stack tha=
t
+ * passes through to some of the PHB own registers.
+ *
+ * PEC0 can contain 1 PHB  (PHB0)
+ * PEC1 can contain 2 PHBs (PHB1 and PHB2)
+ * PEC2 can contain 3 PHBs (PHB3, PHB4 and PHB5)
+ */
+
+/*
+ * This is the "stack" offset, it's the offset from a given range base
+ * to the first "per-stack" registers and also the stride between
+ * stacks, thus for PEC2, the global registers are at offset 0, the
+ * PHB3 registers at offset 0x40, the PHB4 at offset 0x80 etc....
+ *
+ * It is *also* the offset to the pass-through SCOM region but in this c=
ase
+ * it is 0 based, ie PHB3 is at 0x100 PHB4 is a 0x140 etc..
+ */
+#define PEC_STACK_OFFSET        0x40
+
+/* XSCOM Nest global registers */
+#define PEC_NEST_PBCQ_HW_CONFIG         0x00
+#define PEC_NEST_DROP_PRIO_CTRL         0x01
+#define PEC_NEST_PBCQ_ERR_INJECT        0x02
+#define PEC_NEST_PCI_NEST_CLK_TRACE_CTL 0x03
+#define PEC_NEST_PBCQ_PMON_CTRL         0x04
+#define PEC_NEST_PBCQ_PBUS_ADDR_EXT     0x05
+#define PEC_NEST_PBCQ_PRED_VEC_TIMEOUT  0x06
+#define PEC_NEST_CAPP_CTRL              0x07
+#define PEC_NEST_PBCQ_READ_STK_OVR      0x08
+#define PEC_NEST_PBCQ_WRITE_STK_OVR     0x09
+#define PEC_NEST_PBCQ_STORE_STK_OVR     0x0a
+#define PEC_NEST_PBCQ_RETRY_BKOFF_CTRL  0x0b
+
+/* XSCOM Nest per-stack registers */
+#define PEC_NEST_STK_PCI_NEST_FIR       0x00
+#define PEC_NEST_STK_PCI_NEST_FIR_CLR   0x01
+#define PEC_NEST_STK_PCI_NEST_FIR_SET   0x02
+#define PEC_NEST_STK_PCI_NEST_FIR_MSK   0x03
+#define PEC_NEST_STK_PCI_NEST_FIR_MSKC  0x04
+#define PEC_NEST_STK_PCI_NEST_FIR_MSKS  0x05
+#define PEC_NEST_STK_PCI_NEST_FIR_ACT0  0x06
+#define PEC_NEST_STK_PCI_NEST_FIR_ACT1  0x07
+#define PEC_NEST_STK_PCI_NEST_FIR_WOF   0x08
+#define PEC_NEST_STK_ERR_REPORT_0       0x0a
+#define PEC_NEST_STK_ERR_REPORT_1       0x0b
+#define PEC_NEST_STK_PBCQ_GNRL_STATUS   0x0c
+#define PEC_NEST_STK_PBCQ_MODE          0x0d
+#define PEC_NEST_STK_MMIO_BAR0          0x0e
+#define PEC_NEST_STK_MMIO_BAR0_MASK     0x0f
+#define PEC_NEST_STK_MMIO_BAR1          0x10
+#define PEC_NEST_STK_MMIO_BAR1_MASK     0x11
+#define PEC_NEST_STK_PHB_REGS_BAR       0x12
+#define PEC_NEST_STK_INT_BAR            0x13
+#define PEC_NEST_STK_BAR_EN             0x14
+#define   PEC_NEST_STK_BAR_EN_MMIO0             PPC_BIT(0)
+#define   PEC_NEST_STK_BAR_EN_MMIO1             PPC_BIT(1)
+#define   PEC_NEST_STK_BAR_EN_PHB               PPC_BIT(2)
+#define   PEC_NEST_STK_BAR_EN_INT               PPC_BIT(3)
+#define PEC_NEST_STK_DATA_FRZ_TYPE      0x15
+#define PEC_NEST_STK_PBCQ_TUN_BAR       0x16
+
+/* XSCOM PCI global registers */
+#define PEC_PCI_PBAIB_HW_CONFIG         0x00
+#define PEC_PCI_PBAIB_READ_STK_OVR      0x02
+
+/* XSCOM PCI per-stack registers */
+#define PEC_PCI_STK_PCI_FIR             0x00
+#define PEC_PCI_STK_PCI_FIR_CLR         0x01
+#define PEC_PCI_STK_PCI_FIR_SET         0x02
+#define PEC_PCI_STK_PCI_FIR_MSK         0x03
+#define PEC_PCI_STK_PCI_FIR_MSKC        0x04
+#define PEC_PCI_STK_PCI_FIR_MSKS        0x05
+#define PEC_PCI_STK_PCI_FIR_ACT0        0x06
+#define PEC_PCI_STK_PCI_FIR_ACT1        0x07
+#define PEC_PCI_STK_PCI_FIR_WOF         0x08
+#define PEC_PCI_STK_ETU_RESET           0x0a
+#define PEC_PCI_STK_PBAIB_ERR_REPORT    0x0b
+#define PEC_PCI_STK_PBAIB_TX_CMD_CRED   0x0d
+#define PEC_PCI_STK_PBAIB_TX_DAT_CRED   0x0e
+
+/*
+ * PHB "SCOM" registers. This is accessed via the above window
+ * and provides a backdoor to the PHB when the AIB bus is not
+ * functional. Some of these directly map some of the PHB MMIO
+ * registers, some are specific and allow indirect access to a
+ * wider range of PHB registers
+ */
+#define PHB_SCOM_HV_IND_ADDR            0x00
+#define   PHB_SCOM_HV_IND_ADDR_VALID            PPC_BIT(0)
+#define   PHB_SCOM_HV_IND_ADDR_4B               PPC_BIT(1)
+#define   PHB_SCOM_HV_IND_ADDR_AUTOINC          PPC_BIT(2)
+#define   PHB_SCOM_HV_IND_ADDR_ADDR             PPC_BITMASK(51, 63)
+#define PHB_SCOM_HV_IND_DATA            0x01
+#define PHB_SCOM_ETU_LEM_FIR            0x08
+#define PHB_SCOM_ETU_LEM_FIR_AND        0x09
+#define PHB_SCOM_ETU_LEM_FIR_OR         0x0a
+#define PHB_SCOM_ETU_LEM_FIR_MSK        0x0b
+#define PHB_SCOM_ETU_LEM_ERR_MSK_AND    0x0c
+#define PHB_SCOM_ETU_LEM_ERR_MSK_OR     0x0d
+#define PHB_SCOM_ETU_LEM_ACT0           0x0e
+#define PHB_SCOM_ETU_LEM_ACT1           0x0f
+#define PHB_SCOM_ETU_LEM_WOF            0x10
+#define PHB_SCOM_ETU_PMON_CONFIG        0x17
+#define PHB_SCOM_ETU_PMON_CTR0          0x18
+#define PHB_SCOM_ETU_PMON_CTR1          0x19
+#define PHB_SCOM_ETU_PMON_CTR2          0x1a
+#define PHB_SCOM_ETU_PMON_CTR3          0x1b
+
+
+/*
+ * PHB MMIO registers
+ */
+
+/* PHB Fundamental register set A */
+#define PHB_LSI_SOURCE_ID               0x100
+#define   PHB_LSI_SRC_ID                PPC_BITMASK(4, 12)
+#define PHB_DMA_CHAN_STATUS             0x110
+#define   PHB_DMA_CHAN_ANY_ERR          PPC_BIT(27)
+#define   PHB_DMA_CHAN_ANY_ERR1         PPC_BIT(28)
+#define   PHB_DMA_CHAN_ANY_FREEZE       PPC_BIT(29)
+#define PHB_CPU_LOADSTORE_STATUS        0x120
+#define   PHB_CPU_LS_ANY_ERR            PPC_BIT(27)
+#define   PHB_CPU_LS_ANY_ERR1           PPC_BIT(28)
+#define   PHB_CPU_LS_ANY_FREEZE         PPC_BIT(29)
+#define PHB_CONFIG_DATA                 0x130
+#define PHB_LOCK0                       0x138
+#define PHB_CONFIG_ADDRESS              0x140
+#define   PHB_CA_ENABLE                 PPC_BIT(0)
+#define   PHB_CA_STATUS                 PPC_BITMASK(1, 3)
+#define     PHB_CA_STATUS_GOOD          0
+#define     PHB_CA_STATUS_UR            1
+#define     PHB_CA_STATUS_CRS           2
+#define     PHB_CA_STATUS_CA            4
+#define   PHB_CA_BUS                    PPC_BITMASK(4, 11)
+#define   PHB_CA_DEV                    PPC_BITMASK(12, 16)
+#define   PHB_CA_FUNC                   PPC_BITMASK(17, 19)
+#define   PHB_CA_BDFN                   PPC_BITMASK(4, 19) /* bus,dev,fu=
nc */
+#define   PHB_CA_REG                    PPC_BITMASK(20, 31)
+#define   PHB_CA_PE                     PPC_BITMASK(39, 47)
+#define PHB_LOCK1                       0x148
+#define PHB_PHB4_CONFIG                 0x160
+#define   PHB_PHB4C_32BIT_MSI_EN        PPC_BIT(8)
+#define   PHB_PHB4C_64BIT_MSI_EN        PPC_BIT(14)
+#define PHB_RTT_BAR                     0x168
+#define   PHB_RTT_BAR_ENABLE            PPC_BIT(0)
+#define   PHB_RTT_BASE_ADDRESS_MASK     PPC_BITMASK(8, 46)
+#define PHB_PELTV_BAR                   0x188
+#define   PHB_PELTV_BAR_ENABLE          PPC_BIT(0)
+#define   PHB_PELTV_BASE_ADDRESS        PPC_BITMASK(8, 50)
+#define PHB_M32_START_ADDR              0x1a0
+#define PHB_PEST_BAR                    0x1a8
+#define   PHB_PEST_BAR_ENABLE           PPC_BIT(0)
+#define   PHB_PEST_BASE_ADDRESS         PPC_BITMASK(8, 51)
+#define PHB_ASN_CMPM                    0x1C0
+#define   PHB_ASN_CMPM_ENABLE           PPC_BIT(63)
+#define PHB_CAPI_CMPM                   0x1C8
+#define   PHB_CAPI_CMPM_ENABLE          PPC_BIT(63)
+#define PHB_M64_AOMASK                  0x1d0
+#define PHB_M64_UPPER_BITS              0x1f0
+#define PHB_NXLATE_PREFIX               0x1f8
+#define PHB_DMARD_SYNC                  0x200
+#define   PHB_DMARD_SYNC_START          PPC_BIT(0)
+#define   PHB_DMARD_SYNC_COMPLETE       PPC_BIT(1)
+#define PHB_RTC_INVALIDATE              0x208
+#define   PHB_RTC_INVALIDATE_ALL        PPC_BIT(0)
+#define   PHB_RTC_INVALIDATE_RID        PPC_BITMASK(16, 31)
+#define PHB_TCE_KILL                    0x210
+#define   PHB_TCE_KILL_ALL              PPC_BIT(0)
+#define   PHB_TCE_KILL_PE               PPC_BIT(1)
+#define   PHB_TCE_KILL_ONE              PPC_BIT(2)
+#define   PHB_TCE_KILL_PSEL             PPC_BIT(3)
+#define   PHB_TCE_KILL_64K              0x1000 /* Address override */
+#define   PHB_TCE_KILL_2M               0x2000 /* Address override */
+#define   PHB_TCE_KILL_1G               0x3000 /* Address override */
+#define   PHB_TCE_KILL_PENUM            PPC_BITMASK(55, 63)
+#define PHB_TCE_SPEC_CTL                0x218
+#define PHB_IODA_ADDR                   0x220
+#define   PHB_IODA_AD_AUTOINC           PPC_BIT(0)
+#define   PHB_IODA_AD_TSEL              PPC_BITMASK(11, 15)
+#define   PHB_IODA_AD_MIST_PWV          PPC_BITMASK(28, 31)
+#define   PHB_IODA_AD_TADR              PPC_BITMASK(54, 63)
+#define PHB_IODA_DATA0                  0x228
+#define PHB_PHB4_GEN_CAP                0x250
+#define PHB_PHB4_TCE_CAP                0x258
+#define PHB_PHB4_IRQ_CAP                0x260
+#define PHB_PHB4_EEH_CAP                0x268
+#define PHB_PAPR_ERR_INJ_CTL            0x2b0
+#define   PHB_PAPR_ERR_INJ_CTL_INB      PPC_BIT(0)
+#define   PHB_PAPR_ERR_INJ_CTL_OUTB     PPC_BIT(1)
+#define   PHB_PAPR_ERR_INJ_CTL_STICKY   PPC_BIT(2)
+#define   PHB_PAPR_ERR_INJ_CTL_CFG      PPC_BIT(3)
+#define   PHB_PAPR_ERR_INJ_CTL_RD       PPC_BIT(4)
+#define   PHB_PAPR_ERR_INJ_CTL_WR       PPC_BIT(5)
+#define   PHB_PAPR_ERR_INJ_CTL_FREEZE   PPC_BIT(6)
+#define PHB_PAPR_ERR_INJ_ADDR           0x2b8
+#define   PHB_PAPR_ERR_INJ_ADDR_MMIO            PPC_BITMASK(16, 63)
+#define PHB_PAPR_ERR_INJ_MASK           0x2c0
+#define   PHB_PAPR_ERR_INJ_MASK_CFG             PPC_BITMASK(4, 11)
+#define   PHB_PAPR_ERR_INJ_MASK_CFG_ALL         PPC_BITMASK(4, 19)
+#define   PHB_PAPR_ERR_INJ_MASK_MMIO            PPC_BITMASK(16, 63)
+#define PHB_ETU_ERR_SUMMARY             0x2c8
+#define PHB_INT_NOTIFY_ADDR             0x300
+#define PHB_INT_NOTIFY_INDEX            0x308
+
+/* Fundamental register set B */
+#define PHB_VERSION                     0x800
+#define PHB_CTRLR                       0x810
+#define   PHB_CTRLR_IRQ_PGSZ_64K        PPC_BIT(11)
+#define   PHB_CTRLR_IRQ_STORE_EOI       PPC_BIT(12)
+#define   PHB_CTRLR_MMIO_RD_STRICT      PPC_BIT(13)
+#define   PHB_CTRLR_MMIO_EEH_DISABLE    PPC_BIT(14)
+#define   PHB_CTRLR_CFG_EEH_BLOCK       PPC_BIT(15)
+#define   PHB_CTRLR_FENCE_LNKILL_DIS    PPC_BIT(16)
+#define   PHB_CTRLR_TVT_ADDR_SEL        PPC_BITMASK(17, 19)
+#define     TVT_DD1_1_PER_PE            0
+#define     TVT_DD1_2_PER_PE            1
+#define     TVT_DD1_4_PER_PE            2
+#define     TVT_DD1_8_PER_PE            3
+#define     TVT_DD1_16_PER_PE           4
+#define     TVT_2_PER_PE                0
+#define     TVT_4_PER_PE                1
+#define     TVT_8_PER_PE                2
+#define     TVT_16_PER_PE               3
+#define   PHB_CTRLR_DMA_RD_SPACING      PPC_BITMASK(28, 31)
+#define PHB_AIB_FENCE_CTRL              0x860
+#define PHB_TCE_TAG_ENABLE              0x868
+#define PHB_TCE_WATERMARK               0x870
+#define PHB_TIMEOUT_CTRL1               0x878
+#define PHB_TIMEOUT_CTRL2               0x880
+#define PHB_Q_DMA_R                     0x888
+#define   PHB_Q_DMA_R_QUIESCE_DMA       PPC_BIT(0)
+#define   PHB_Q_DMA_R_AUTORESET         PPC_BIT(1)
+#define   PHB_Q_DMA_R_DMA_RESP_STATUS   PPC_BIT(4)
+#define   PHB_Q_DMA_R_MMIO_RESP_STATUS  PPC_BIT(5)
+#define   PHB_Q_DMA_R_TCE_RESP_STATUS   PPC_BIT(6)
+#define   PHB_Q_DMA_R_TCE_KILL_STATUS   PPC_BIT(7)
+#define PHB_TCE_TAG_STATUS              0x908
+
+/* FIR & Error registers */
+#define PHB_LEM_FIR_ACCUM               0xc00
+#define PHB_LEM_FIR_AND_MASK            0xc08
+#define PHB_LEM_FIR_OR_MASK             0xc10
+#define PHB_LEM_ERROR_MASK              0xc18
+#define PHB_LEM_ERROR_AND_MASK          0xc20
+#define PHB_LEM_ERROR_OR_MASK           0xc28
+#define PHB_LEM_ACTION0                 0xc30
+#define PHB_LEM_ACTION1                 0xc38
+#define PHB_LEM_WOF                     0xc40
+#define PHB_ERR_STATUS                  0xc80
+#define PHB_ERR1_STATUS                 0xc88
+#define PHB_ERR_INJECT                  0xc90
+#define PHB_ERR_LEM_ENABLE              0xc98
+#define PHB_ERR_IRQ_ENABLE              0xca0
+#define PHB_ERR_FREEZE_ENABLE           0xca8
+#define PHB_ERR_AIB_FENCE_ENABLE        0xcb0
+#define PHB_ERR_LOG_0                   0xcc0
+#define PHB_ERR_LOG_1                   0xcc8
+#define PHB_ERR_STATUS_MASK             0xcd0
+#define PHB_ERR1_STATUS_MASK            0xcd8
+
+#define PHB_TXE_ERR_STATUS                      0xd00
+#define PHB_TXE_ERR1_STATUS                     0xd08
+#define PHB_TXE_ERR_INJECT                      0xd10
+#define PHB_TXE_ERR_LEM_ENABLE                  0xd18
+#define PHB_TXE_ERR_IRQ_ENABLE                  0xd20
+#define PHB_TXE_ERR_FREEZE_ENABLE               0xd28
+#define PHB_TXE_ERR_AIB_FENCE_ENABLE            0xd30
+#define PHB_TXE_ERR_LOG_0                       0xd40
+#define PHB_TXE_ERR_LOG_1                       0xd48
+#define PHB_TXE_ERR_STATUS_MASK                 0xd50
+#define PHB_TXE_ERR1_STATUS_MASK                0xd58
+
+#define PHB_RXE_ARB_ERR_STATUS                  0xd80
+#define PHB_RXE_ARB_ERR1_STATUS                 0xd88
+#define PHB_RXE_ARB_ERR_INJECT                  0xd90
+#define PHB_RXE_ARB_ERR_LEM_ENABLE              0xd98
+#define PHB_RXE_ARB_ERR_IRQ_ENABLE              0xda0
+#define PHB_RXE_ARB_ERR_FREEZE_ENABLE           0xda8
+#define PHB_RXE_ARB_ERR_AIB_FENCE_ENABLE        0xdb0
+#define PHB_RXE_ARB_ERR_LOG_0                   0xdc0
+#define PHB_RXE_ARB_ERR_LOG_1                   0xdc8
+#define PHB_RXE_ARB_ERR_STATUS_MASK             0xdd0
+#define PHB_RXE_ARB_ERR1_STATUS_MASK            0xdd8
+
+#define PHB_RXE_MRG_ERR_STATUS                  0xe00
+#define PHB_RXE_MRG_ERR1_STATUS                 0xe08
+#define PHB_RXE_MRG_ERR_INJECT                  0xe10
+#define PHB_RXE_MRG_ERR_LEM_ENABLE              0xe18
+#define PHB_RXE_MRG_ERR_IRQ_ENABLE              0xe20
+#define PHB_RXE_MRG_ERR_FREEZE_ENABLE           0xe28
+#define PHB_RXE_MRG_ERR_AIB_FENCE_ENABLE        0xe30
+#define PHB_RXE_MRG_ERR_LOG_0                   0xe40
+#define PHB_RXE_MRG_ERR_LOG_1                   0xe48
+#define PHB_RXE_MRG_ERR_STATUS_MASK             0xe50
+#define PHB_RXE_MRG_ERR1_STATUS_MASK            0xe58
+
+#define PHB_RXE_TCE_ERR_STATUS                  0xe80
+#define PHB_RXE_TCE_ERR1_STATUS                 0xe88
+#define PHB_RXE_TCE_ERR_INJECT                  0xe90
+#define PHB_RXE_TCE_ERR_LEM_ENABLE              0xe98
+#define PHB_RXE_TCE_ERR_IRQ_ENABLE              0xea0
+#define PHB_RXE_TCE_ERR_FREEZE_ENABLE           0xea8
+#define PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE        0xeb0
+#define PHB_RXE_TCE_ERR_LOG_0                   0xec0
+#define PHB_RXE_TCE_ERR_LOG_1                   0xec8
+#define PHB_RXE_TCE_ERR_STATUS_MASK             0xed0
+#define PHB_RXE_TCE_ERR1_STATUS_MASK            0xed8
+
+/* Performance monitor & Debug registers */
+#define PHB_TRACE_CONTROL                       0xf80
+#define PHB_PERFMON_CONFIG                      0xf88
+#define PHB_PERFMON_CTR0                        0xf90
+#define PHB_PERFMON_CTR1                        0xf98
+#define PHB_PERFMON_CTR2                        0xfa0
+#define PHB_PERFMON_CTR3                        0xfa8
+
+/* Root complex config space memory mapped */
+#define PHB_RC_CONFIG_BASE                      0x1000
+#define   PHB_RC_CONFIG_SIZE                    0x800
+
+/* PHB4 REGB registers */
+
+/* PBL core */
+#define PHB_PBL_CONTROL                         0x1800
+#define PHB_PBL_TIMEOUT_CTRL                    0x1810
+#define PHB_PBL_NPTAG_ENABLE                    0x1820
+#define PHB_PBL_NBW_CMP_MASK                    0x1830
+#define   PHB_PBL_NBW_MASK_ENABLE               PPC_BIT(63)
+#define PHB_PBL_SYS_LINK_INIT                   0x1838
+#define PHB_PBL_BUF_STATUS                      0x1840
+#define PHB_PBL_ERR_STATUS                      0x1900
+#define PHB_PBL_ERR1_STATUS                     0x1908
+#define PHB_PBL_ERR_INJECT                      0x1910
+#define PHB_PBL_ERR_INF_ENABLE                  0x1920
+#define PHB_PBL_ERR_ERC_ENABLE                  0x1928
+#define PHB_PBL_ERR_FAT_ENABLE                  0x1930
+#define PHB_PBL_ERR_LOG_0                       0x1940
+#define PHB_PBL_ERR_LOG_1                       0x1948
+#define PHB_PBL_ERR_STATUS_MASK                 0x1950
+#define PHB_PBL_ERR1_STATUS_MASK                0x1958
+
+/* PCI-E stack */
+#define PHB_PCIE_SCR                    0x1A00
+#define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
+#define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
+
+
+#define PHB_PCIE_CRESET                 0x1A10
+#define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
+#define   PHB_PCIE_CRESET_TLDLP         PPC_BIT(1)
+#define   PHB_PCIE_CRESET_PBL           PPC_BIT(2)
+#define   PHB_PCIE_CRESET_PERST_N       PPC_BIT(3)
+#define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
+
+
+#define PHB_PCIE_HOTPLUG_STATUS         0x1A20
+#define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
+
+#define PHB_PCIE_DLP_TRAIN_CTL          0x1A40
+#define   PHB_PCIE_DLP_LINK_WIDTH       PPC_BITMASK(30, 35)
+#define   PHB_PCIE_DLP_LINK_SPEED       PPC_BITMASK(36, 39)
+#define   PHB_PCIE_DLP_LTSSM_TRC        PPC_BITMASK(24, 27)
+#define     PHB_PCIE_DLP_LTSSM_RESET    0
+#define     PHB_PCIE_DLP_LTSSM_DETECT   1
+#define     PHB_PCIE_DLP_LTSSM_POLLING  2
+#define     PHB_PCIE_DLP_LTSSM_CONFIG   3
+#define     PHB_PCIE_DLP_LTSSM_L0       4
+#define     PHB_PCIE_DLP_LTSSM_REC      5
+#define     PHB_PCIE_DLP_LTSSM_L1       6
+#define     PHB_PCIE_DLP_LTSSM_L2       7
+#define     PHB_PCIE_DLP_LTSSM_HOTRESET 8
+#define     PHB_PCIE_DLP_LTSSM_DISABLED 9
+#define     PHB_PCIE_DLP_LTSSM_LOOPBACK 10
+#define   PHB_PCIE_DLP_TL_LINKACT       PPC_BIT(23)
+#define   PHB_PCIE_DLP_DL_PGRESET       PPC_BIT(22)
+#define   PHB_PCIE_DLP_TRAINING         PPC_BIT(20)
+#define   PHB_PCIE_DLP_INBAND_PRESENCE  PPC_BIT(19)
+
+#define PHB_PCIE_DLP_CTL                0x1A78
+#define   PHB_PCIE_DLP_CTL_BYPASS_PH2   PPC_BIT(4)
+#define   PHB_PCIE_DLP_CTL_BYPASS_PH3   PPC_BIT(5)
+
+#define PHB_PCIE_DLP_TRWCTL             0x1A80
+#define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
+
+#define PHB_PCIE_DLP_ERRLOG1            0x1AA0
+#define PHB_PCIE_DLP_ERRLOG2            0x1AA8
+#define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
+#define PHB_PCIE_DLP_ERR_COUNTERS       0x1AB8
+
+#define PHB_PCIE_LANE_EQ_CNTL0          0x1AD0
+#define PHB_PCIE_LANE_EQ_CNTL1          0x1AD8
+#define PHB_PCIE_LANE_EQ_CNTL2          0x1AE0
+#define PHB_PCIE_LANE_EQ_CNTL3          0x1AE8
+#define PHB_PCIE_LANE_EQ_CNTL20         0x1AF0
+#define PHB_PCIE_LANE_EQ_CNTL21         0x1AF8
+#define PHB_PCIE_LANE_EQ_CNTL22         0x1B00 /* DD1 only */
+#define PHB_PCIE_LANE_EQ_CNTL23         0x1B08 /* DD1 only */
+#define PHB_PCIE_TRACE_CTRL             0x1B20
+#define PHB_PCIE_MISC_STRAP             0x1B30
+
+/* Error */
+#define PHB_REGB_ERR_STATUS             0x1C00
+#define PHB_REGB_ERR1_STATUS            0x1C08
+#define PHB_REGB_ERR_INJECT             0x1C10
+#define PHB_REGB_ERR_INF_ENABLE         0x1C20
+#define PHB_REGB_ERR_ERC_ENABLE         0x1C28
+#define PHB_REGB_ERR_FAT_ENABLE         0x1C30
+#define PHB_REGB_ERR_LOG_0              0x1C40
+#define PHB_REGB_ERR_LOG_1              0x1C48
+#define PHB_REGB_ERR_STATUS_MASK        0x1C50
+#define PHB_REGB_ERR1_STATUS_MASK       0x1C58
+
+/*
+ * IODA3 on-chip tables
+ */
+
+#define IODA3_TBL_LIST          1
+#define IODA3_TBL_MIST          2
+#define IODA3_TBL_RCAM          5
+#define IODA3_TBL_MRT           6
+#define IODA3_TBL_PESTA         7
+#define IODA3_TBL_PESTB         8
+#define IODA3_TBL_TVT           9
+#define IODA3_TBL_TCR           10
+#define IODA3_TBL_TDR           11
+#define IODA3_TBL_MBT           16
+#define IODA3_TBL_MDT           17
+#define IODA3_TBL_PEEV          20
+
+/* LIST */
+#define IODA3_LIST_P                    PPC_BIT(6)
+#define IODA3_LIST_Q                    PPC_BIT(7)
+#define IODA3_LIST_STATE                PPC_BIT(14)
+
+/* MIST */
+#define IODA3_MIST_P3                   PPC_BIT(48 + 0)
+#define IODA3_MIST_Q3                   PPC_BIT(48 + 1)
+#define IODA3_MIST_PE3                  PPC_BITMASK(48 + 4, 48 + 15)
+
+/* TVT */
+#define IODA3_TVT_TABLE_ADDR            PPC_BITMASK(0, 47)
+#define IODA3_TVT_NUM_LEVELS            PPC_BITMASK(48, 50)
+#define   IODA3_TVE_1_LEVEL     0
+#define   IODA3_TVE_2_LEVELS    1
+#define   IODA3_TVE_3_LEVELS    2
+#define   IODA3_TVE_4_LEVELS    3
+#define   IODA3_TVE_5_LEVELS    4
+#define IODA3_TVT_TCE_TABLE_SIZE        PPC_BITMASK(51, 55)
+#define IODA3_TVT_NON_TRANSLATE_50      PPC_BIT(56)
+#define IODA3_TVT_IO_PSIZE              PPC_BITMASK(59, 63)
+
+/* PESTA */
+#define IODA3_PESTA_MMIO_FROZEN         PPC_BIT(0)
+#define IODA3_PESTA_TRANS_TYPE          PPC_BITMASK(5, 7)
+#define  IODA3_PESTA_TRANS_TYPE_MMIOLOAD 0x4
+#define IODA3_PESTA_CA_CMPLT_TMT        PPC_BIT(8)
+#define IODA3_PESTA_UR                  PPC_BIT(9)
+
+/* PESTB */
+#define IODA3_PESTB_DMA_STOPPED         PPC_BIT(0)
+
+/* MDT */
+/* FIXME: check this field with Eric and add a B, C and D */
+#define IODA3_MDT_PE_A                  PPC_BITMASK(0, 15)
+#define IODA3_MDT_PE_B                  PPC_BITMASK(16, 31)
+#define IODA3_MDT_PE_C                  PPC_BITMASK(32, 47)
+#define IODA3_MDT_PE_D                  PPC_BITMASK(48, 63)
+
+/* MBT */
+#define IODA3_MBT0_ENABLE               PPC_BIT(0)
+#define IODA3_MBT0_TYPE                 PPC_BIT(1)
+#define   IODA3_MBT0_TYPE_M32           IODA3_MBT0_TYPE
+#define   IODA3_MBT0_TYPE_M64           0
+#define IODA3_MBT0_MODE                 PPC_BITMASK(2, 3)
+#define   IODA3_MBT0_MODE_PE_SEG        0
+#define   IODA3_MBT0_MODE_MDT           1
+#define   IODA3_MBT0_MODE_SINGLE_PE     2
+#define IODA3_MBT0_SEG_DIV              PPC_BITMASK(4, 5)
+#define   IODA3_MBT0_SEG_DIV_MAX        0
+#define   IODA3_MBT0_SEG_DIV_128        1
+#define   IODA3_MBT0_SEG_DIV_64         2
+#define   IODA3_MBT0_SEG_DIV_8          3
+#define IODA3_MBT0_MDT_COLUMN           PPC_BITMASK(4, 5)
+#define IODA3_MBT0_BASE_ADDR            PPC_BITMASK(8, 51)
+
+#define IODA3_MBT1_ENABLE               PPC_BIT(0)
+#define IODA3_MBT1_MASK                 PPC_BITMASK(8, 51)
+#define IODA3_MBT1_SEG_BASE             PPC_BITMASK(55, 63)
+#define IODA3_MBT1_SINGLE_PE_NUM        PPC_BITMASK(55, 63)
+
+/*
+ * IODA3 in-memory tables
+ */
+
+/*
+ * PEST
+ *
+ * 2x8 bytes entries, PEST0 and PEST1
+ */
+
+#define IODA3_PEST0_MMIO_CAUSE          PPC_BIT(2)
+#define IODA3_PEST0_CFG_READ            PPC_BIT(3)
+#define IODA3_PEST0_CFG_WRITE           PPC_BIT(4)
+#define IODA3_PEST0_TTYPE               PPC_BITMASK(5, 7)
+#define   PEST_TTYPE_DMA_WRITE          0
+#define   PEST_TTYPE_MSI                1
+#define   PEST_TTYPE_DMA_READ           2
+#define   PEST_TTYPE_DMA_READ_RESP      3
+#define   PEST_TTYPE_MMIO_LOAD          4
+#define   PEST_TTYPE_MMIO_STORE         5
+#define   PEST_TTYPE_OTHER              7
+#define IODA3_PEST0_CA_RETURN           PPC_BIT(8)
+#define IODA3_PEST0_UR_RETURN           PPC_BIT(9)
+#define IODA3_PEST0_PCIE_NONFATAL       PPC_BIT(10)
+#define IODA3_PEST0_PCIE_FATAL          PPC_BIT(11)
+#define IODA3_PEST0_PARITY_UE           PPC_BIT(13)
+#define IODA3_PEST0_PCIE_CORRECTABLE    PPC_BIT(14)
+#define IODA3_PEST0_PCIE_INTERRUPT      PPC_BIT(15)
+#define IODA3_PEST0_MMIO_XLATE          PPC_BIT(16)
+#define IODA3_PEST0_IODA3_ERROR         PPC_BIT(16) /* Same bit as MMIO =
xlate */
+#define IODA3_PEST0_TCE_PAGE_FAULT      PPC_BIT(18)
+#define IODA3_PEST0_TCE_ACCESS_FAULT    PPC_BIT(19)
+#define IODA3_PEST0_DMA_RESP_TIMEOUT    PPC_BIT(20)
+#define IODA3_PEST0_AIB_SIZE_INVALID    PPC_BIT(21)
+#define IODA3_PEST0_LEM_BIT             PPC_BITMASK(26, 31)
+#define IODA3_PEST0_RID                 PPC_BITMASK(32, 47)
+#define IODA3_PEST0_MSI_DATA            PPC_BITMASK(48, 63)
+
+#define IODA3_PEST1_FAIL_ADDR           PPC_BITMASK(3, 63)
+
+
+#endif /* PCI_HOST_PNV_PHB4_REGS_H */
diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
index 7515430087..4b3d254b08 100644
--- a/include/hw/pci/pcie_port.h
+++ b/include/hw/pci/pcie_port.h
@@ -72,6 +72,7 @@ void pcie_chassis_del_slot(PCIESlot *s);
 typedef struct PCIERootPortClass {
     PCIDeviceClass parent_class;
     DeviceRealize parent_realize;
+    DeviceReset parent_reset;
=20
     uint8_t (*aer_vector)(const PCIDevice *dev);
     int (*interrupts_init)(PCIDevice *dev, Error **errp);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f225f2f6bf..805f9058f5 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -30,6 +30,7 @@
 #include "hw/ppc/pnv_homer.h"
 #include "hw/ppc/pnv_xive.h"
 #include "hw/ppc/pnv_core.h"
+#include "hw/pci-host/pnv_phb4.h"
=20
 #define TYPE_PNV_CHIP "pnv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -52,6 +53,8 @@ typedef struct PnvChip {
     uint64_t     cores_mask;
     PnvCore      **cores;
=20
+    uint32_t     num_phbs;
+
     MemoryRegion xscom_mmio;
     MemoryRegion xscom;
     AddressSpace xscom_as;
@@ -93,6 +96,9 @@ typedef struct Pnv9Chip {
=20
     uint32_t     nr_quads;
     PnvQuad      *quads;
+
+#define PNV9_CHIP_MAX_PEC 3
+    PnvPhb4PecState pecs[PNV9_CHIP_MAX_PEC];
 } Pnv9Chip;
=20
 /*
@@ -120,6 +126,7 @@ typedef struct PnvChipClass {
     /*< public >*/
     uint64_t     chip_cfam_id;
     uint64_t     cores_mask;
+    uint32_t     num_phbs;
=20
     DeviceRealize parent_realize;
=20
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f74c81a980..0fc57b0367 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -94,6 +94,17 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV9_XSCOM_XIVE_BASE      0x5013000
 #define PNV9_XSCOM_XIVE_SIZE      0x300
=20
+#define PNV9_XSCOM_PEC_NEST_BASE  0x4010c00
+#define PNV9_XSCOM_PEC_NEST_SIZE  0x100
+
+#define PNV9_XSCOM_PEC_PCI_BASE   0xd010800
+#define PNV9_XSCOM_PEC_PCI_SIZE   0x200
+
+/* XSCOM PCI "pass-through" window to PHB SCOM */
+#define PNV9_XSCOM_PEC_PCI_STK0   0x100
+#define PNV9_XSCOM_PEC_PCI_STK1   0x140
+#define PNV9_XSCOM_PEC_PCI_STK2   0x180
+
 /*
  * Layout of the XSCOM PCB addresses (POWER 10)
  */
--=20
2.24.1


