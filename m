Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31A7C33C9E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 02:32:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86F10207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 02:32:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86F10207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwd9Y-0001vK-Py
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 21:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51973)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aik@ozlabs.ru>) id 1iwd8v-0001O3-6B
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 21:31:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1iwd8t-0008OD-75
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 21:31:48 -0500
Received: from [107.174.27.60] (port=33910 helo=ozlabs.ru)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>)
 id 1iwd8t-0008Cb-13; Tue, 28 Jan 2020 21:31:47 -0500
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 20E11AE80021;
 Tue, 28 Jan 2020 21:29:49 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH qemu] spapr_pci: Create assigned properties for bridges
Date: Wed, 29 Jan 2020 13:31:11 +1100
Message-Id: <20200129023111.1699-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 107.174.27.60
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
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU assigns bus numbers so tell the guest about assigned values.

This also adds an empty "ranges" to let the existing linux kernels proceed
far enough to trigger resource reassignment (which is rather a hack).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This is a part of the "kill CAS reboot" effort, the SLOF's side of it was
posted as "[PATCH slof] fdt: Fix creating new nodes at H_CAS"

---
 hw/ppc/spapr_pci.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 723373de732c..877ff1d0d5fa 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1336,7 +1336,23 @@ static int spapr_dt_pci_bus(SpaprPhbState *sphb, PCIBus *bus,
     if (pci_bus_is_root(bus)) {
         owner = OBJECT(sphb);
     } else {
-        owner = OBJECT(pci_bridge_get_device(bus));
+        PCIDevice *pdev = pci_bridge_get_device(bus);
+        uint8_t pri = pci_default_read_config(pdev, PCI_PRIMARY_BUS, 1);
+        uint8_t sec  = pci_default_read_config(pdev, PCI_SECONDARY_BUS, 1);
+        uint8_t sub  = pci_default_read_config(pdev, PCI_SUBORDINATE_BUS, 1);
+        uint32_t range[] = { cpu_to_be32(sec), cpu_to_be32(sub) };
+
+        /*
+         * Create these to get existing Linux kernels proceed far enough to
+         * trigger resource reassignment. We creates these for vPHB already.
+         */
+        _FDT(fdt_setprop_cell(fdt, offset, "primary-bus", pri));
+        _FDT(fdt_setprop_cell(fdt, offset, "secondary-bus", sec));
+        _FDT(fdt_setprop_cell(fdt, offset, "subordinate-bus", sub));
+        _FDT(fdt_setprop(fdt, offset, "bus-range", range, sizeof(range)));
+        _FDT(fdt_setprop_string(fdt, offset, "device_type", "pci"));
+        _FDT(fdt_setprop(fdt, offset, "ranges", NULL, 0));
+        owner = OBJECT(pdev);
     }
 
     ret = spapr_dt_drc(fdt, offset, owner,
-- 
2.17.1


