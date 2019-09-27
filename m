Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C74AC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 02:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAAA2207FF
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 02:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAAA2207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDfzF-0000aa-T5
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 22:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40282)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iDfyH-0008RD-5e
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 22:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iDfyE-0005cp-RT
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 22:27:00 -0400
Received: from ozlabs.ru ([107.173.13.209]:40900)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1iDfyD-0005Y0-32; Thu, 26 Sep 2019 22:26:58 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 98917AE8000A;
 Thu, 26 Sep 2019 22:26:18 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] spapr-pci: Stop providing assigned-addresses
Date: Fri, 27 Sep 2019 12:26:51 +1000
Message-Id: <20190927022651.71642-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.173.13.209
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU does not allocate PCI resources (BARs) in any case - coldplug devices
are configured by the firmware and hotplug devices rely on the guest
system to do the assignment via the PCI rescan mechanism. Also in order
to create non empty "assigned-addresses", the device has to be enabled
(i.e. PCI_COMMAND needs the MMIO bit set) first as otherwise
io_regions[i].addr are -1, and devices are not enabled at this point.

This removes "assigned-addresses" and leaves it to those who actually
do resource allocation.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This replaces:
[PATCH qemu] spapr-pci: Provide either correct assigned-addresses or none

---
 hw/ppc/spapr_pci.c | 42 +++++++-----------------------------------
 1 file changed, 7 insertions(+), 35 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 6934d506a7e9..01ff41d4c43f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -836,7 +836,7 @@ static char *spapr_phb_get_loc_code(SpaprPhbState *sphb, PCIDevice *pdev)
 #define b_fff(x)        b_x((x), 8, 3)  /* function number */
 #define b_rrrrrrrr(x)   b_x((x), 0, 8)  /* register number */
 
-/* for 'reg'/'assigned-addresses' OF properties */
+/* for 'reg' OF properties */
 #define RESOURCE_CELLS_SIZE 2
 #define RESOURCE_CELLS_ADDRESS 3
 
@@ -850,17 +850,14 @@ typedef struct ResourceFields {
 
 typedef struct ResourceProps {
     ResourceFields reg[8];
-    ResourceFields assigned[7];
     uint32_t reg_len;
-    uint32_t assigned_len;
 } ResourceProps;
 
-/* fill in the 'reg'/'assigned-resources' OF properties for
+/* fill in the 'reg' OF properties for
  * a PCI device. 'reg' describes resource requirements for a
- * device's IO/MEM regions, 'assigned-addresses' describes the
- * actual resource assignments.
+ * device's IO/MEM regions.
  *
- * the properties are arrays of ('phys-addr', 'size') pairs describing
+ * the property is an array of ('phys-addr', 'size') pairs describing
  * the addressable regions of the PCI device, where 'phys-addr' is a
  * RESOURCE_CELLS_ADDRESS-tuple of 32-bit integers corresponding to
  * (phys.hi, phys.mid, phys.lo), and 'size' is a
@@ -889,18 +886,7 @@ typedef struct ResourceProps {
  * phys.mid and phys.lo correspond respectively to the hi/lo portions
  * of the actual address of the region.
  *
- * how the phys-addr/size values are used differ slightly between
- * 'reg' and 'assigned-addresses' properties. namely, 'reg' has
- * an additional description for the config space region of the
- * device, and in the case of QEMU has n=0 and phys.mid=phys.lo=0
- * to describe the region as relocatable, with an address-mapping
- * that corresponds directly to the PHB's address space for the
- * resource. 'assigned-addresses' always has n=1 set with an absolute
- * address assigned for the resource. in general, 'assigned-addresses'
- * won't be populated, since addresses for PCI devices are generally
- * unmapped initially and left to the guest to assign.
- *
- * note also that addresses defined in these properties are, at least
+ * note also that addresses defined in this property are, at least
  * for PAPR guests, relative to the PHBs IO/MEM windows, and
  * correspond directly to the addresses in the BARs.
  *
@@ -914,8 +900,8 @@ static void populate_resource_props(PCIDevice *d, ResourceProps *rp)
     uint32_t dev_id = (b_bbbbbbbb(bus_num) |
                        b_ddddd(PCI_SLOT(d->devfn)) |
                        b_fff(PCI_FUNC(d->devfn)));
-    ResourceFields *reg, *assigned;
-    int i, reg_idx = 0, assigned_idx = 0;
+    ResourceFields *reg;
+    int i, reg_idx = 0;
 
     /* config space region */
     reg = &rp->reg[reg_idx++];
@@ -944,21 +930,9 @@ static void populate_resource_props(PCIDevice *d, ResourceProps *rp)
         reg->phys_lo = 0;
         reg->size_hi = cpu_to_be32(d->io_regions[i].size >> 32);
         reg->size_lo = cpu_to_be32(d->io_regions[i].size);
-
-        if (d->io_regions[i].addr == PCI_BAR_UNMAPPED) {
-            continue;
-        }
-
-        assigned = &rp->assigned[assigned_idx++];
-        assigned->phys_hi = cpu_to_be32(be32_to_cpu(reg->phys_hi) | b_n(1));
-        assigned->phys_mid = cpu_to_be32(d->io_regions[i].addr >> 32);
-        assigned->phys_lo = cpu_to_be32(d->io_regions[i].addr);
-        assigned->size_hi = reg->size_hi;
-        assigned->size_lo = reg->size_lo;
     }
 
     rp->reg_len = reg_idx * sizeof(ResourceFields);
-    rp->assigned_len = assigned_idx * sizeof(ResourceFields);
 }
 
 typedef struct PCIClass PCIClass;
@@ -1472,8 +1446,6 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
 
     populate_resource_props(dev, &rp);
     _FDT(fdt_setprop(fdt, offset, "reg", (uint8_t *)rp.reg, rp.reg_len));
-    _FDT(fdt_setprop(fdt, offset, "assigned-addresses",
-                     (uint8_t *)rp.assigned, rp.assigned_len));
 
     if (sphb->pcie_ecs && pci_is_express(dev)) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
-- 
2.17.1


