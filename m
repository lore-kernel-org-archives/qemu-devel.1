Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A338C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0EB20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0EB20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCHHK-0002Tc-Fv
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 01:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50379)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iCHGP-0001Yg-Dw
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iCHGN-0007XH-Px
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:51:56 -0400
Received: from ozlabs.ru ([107.173.13.209]:35942)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1iCHGN-0007Vt-J0; Mon, 23 Sep 2019 01:51:55 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 111DDAE807F4;
 Mon, 23 Sep 2019 01:50:48 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] spapr-pci: Provide either correct assigned-addresses or
 none
Date: Mon, 23 Sep 2019 15:51:19 +1000
Message-Id: <20190923055119.31683-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Sam Bobroff <sbobroff@linux.ibm.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU stores current BAR assignments in 2 places - in the raw config space
array and io_regions structs. Once set, the config space array remembers
these but BARs in io_regions are reset/restored every time the device is
disabled/enabled, i.e. when MMIO bit in the command register is flipped.

A sPAPR guest OS normally expects BARs to be assigned by the firmware
and reported to the guest via the "assigned-addresses" property
(below - "aa"). For hotplug devices QEMU creates "aa" and it only does
so if the device is enabled which is odd and relies on the guest linux
kernel ability to assign unassigned resources; other OSes may not do this.

For coldplugged devices QEMU does not provide "aa" as SLOF does BAR
allocation and creates "aa" from the config space values which is ok
for now but since we are going to implement full device tree update on
"ibm,client-architecture-support", we will be having transitions between
QEMU/SLOF/GRUB/Linux and we need to preserve BAR allocations done by SLOF.

This uses non-zero BAR addresses for "aa" ("Unimplemented Base Address
registers are hardwired to zero" says the PCI spec") which preserves
BARs during the boot process.

This only creates "aa" if any BAR was assigned. This violates the
"PCI Bus Binding to Open Firmware" spec from the last millennia which
states:
"If no resources were assigned address space, the "assigned-addresses"
property shall have a prop-encoded-array of zero length".
However this allows older guests to try allocating BARs if for some reason
QEMU or SLOF failed to do so.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_pci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7b71ad7c74f1..2e5f5c52a33a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -925,13 +925,17 @@ static void populate_resource_props(PCIDevice *d, ResourceProps *rp)
     reg->size_lo = 0;
 
     for (i = 0; i < PCI_NUM_REGIONS; i++) {
+        hwaddr addr;
+        int bar;
+
         if (!d->io_regions[i].size) {
             continue;
         }
 
+        bar = pci_bar(d, i);
         reg = &rp->reg[reg_idx++];
 
-        reg->phys_hi = cpu_to_be32(dev_id | b_rrrrrrrr(pci_bar(d, i)));
+        reg->phys_hi = cpu_to_be32(dev_id | b_rrrrrrrr(bar));
         if (d->io_regions[i].type & PCI_BASE_ADDRESS_SPACE_IO) {
             reg->phys_hi |= cpu_to_be32(b_ss(1));
         } else if (d->io_regions[i].type & PCI_BASE_ADDRESS_MEM_TYPE_64) {
@@ -944,14 +948,15 @@ static void populate_resource_props(PCIDevice *d, ResourceProps *rp)
         reg->size_hi = cpu_to_be32(d->io_regions[i].size >> 32);
         reg->size_lo = cpu_to_be32(d->io_regions[i].size);
 
-        if (d->io_regions[i].addr == PCI_BAR_UNMAPPED) {
+        addr = pci_get_long(d->config + bar) & ~(d->io_regions[i].size - 1);
+        if (!addr) {
             continue;
         }
 
         assigned = &rp->assigned[assigned_idx++];
         assigned->phys_hi = cpu_to_be32(be32_to_cpu(reg->phys_hi) | b_n(1));
-        assigned->phys_mid = cpu_to_be32(d->io_regions[i].addr >> 32);
-        assigned->phys_lo = cpu_to_be32(d->io_regions[i].addr);
+        assigned->phys_mid = cpu_to_be32(addr >> 32);
+        assigned->phys_lo = cpu_to_be32(addr);
         assigned->size_hi = reg->size_hi;
         assigned->size_lo = reg->size_lo;
     }
@@ -1471,8 +1476,10 @@ static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
 
     populate_resource_props(dev, &rp);
     _FDT(fdt_setprop(fdt, offset, "reg", (uint8_t *)rp.reg, rp.reg_len));
-    _FDT(fdt_setprop(fdt, offset, "assigned-addresses",
-                     (uint8_t *)rp.assigned, rp.assigned_len));
+    if (rp.assigned_len) {
+        _FDT(fdt_setprop(fdt, offset, "assigned-addresses",
+                         (uint8_t *)rp.assigned, rp.assigned_len));
+    }
 
     if (sphb->pcie_ecs && pci_is_express(dev)) {
         _FDT(fdt_setprop_cell(fdt, offset, "ibm,pci-config-space-type", 0x1));
-- 
2.17.1


