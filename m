Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA64C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2E52089F
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 17:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synology.com header.i=@synology.com header.b="p3X7HSNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2E52089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7NMA-0002e3-3O
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 13:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andychiu@synology.com>) id 1i7NJe-0000eK-3z
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andychiu@synology.com>) id 1i7NJc-0002Cv-VH
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 13:19:02 -0400
Received: from mail.synology.com ([211.23.38.101]:49488 helo=synology.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andychiu@synology.com>)
 id 1i7NJY-0001zr-Gq; Mon, 09 Sep 2019 13:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
 t=1568049525; bh=de2UEnntffiGmiMGCYzD4cvGPp0KLbbKHu1ehSBcQkI=;
 h=From:To:Cc:Subject:Date;
 b=p3X7HSNS4P3S6+WI80pgScY7xLzz4uffVBrnXN7bwKvG7MtrqDaXudJqj9saz9niG
 b84laCgR6c3Dwm27dC+Q4IJyk0elVYk+p4k9gEN2DAOuhJi4nt2SQPE7UeSBmxbvKC
 dspNXJLazs3ArQg8vTeaGvIyIhntaRAWn+ecIVrM=
To: qemu-devel@nongnu.org
Date: Tue, 10 Sep 2019 01:18:37 +0800
Message-Id: <1568049517-10261-1-git-send-email-andychiu@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 211.23.38.101
Subject: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
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
From: andychiu via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: andychiu <andychiu@synology.com>
Cc: andychiu <andychiu@synology.com>, jsnow@redhat.com, qemu-block@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If Windows 10 guests have enabled 'turn off hard disk after idle'
option in power settings, and the guest has a SATA disk plugged in,
the SATA disk will be turned off after a specified idle time.
If the guest is live migrated or saved/loaded with its SATA disk
turned off, the following error will occur:

qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
qemu-system-x86_64: Failed to load ich9_ahci:ahci
qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
qemu-system-x86_64: load of migration failed: Operation not permitted

Observation from trace logs shows that a while after Windows 10 turns off
a SATA disk (IDE disks don't have the following behavior),
it will disable the PCI_COMMAND_MASTER flag of the pci device containing
the ahci device. When the the disk is turning back on,
the PCI_COMMAND_MASTER flag will be restored first.
But if the guest is migrated or saved/loaded while the disk is off,
the post_load callback of ahci device, ahci_state_post_load(), will fail
at ahci_cond_start_engines() if the MemoryRegion
pci_dev->bus_master_enable_region is not enabled, with pci_dev pointing
to the PCIDevice struct containing the ahci device.

This patch enables pci_dev->bus_master_enable_region before calling
ahci_cond_start_engines() in ahci_state_post_load(), and restore the
MemoryRegion to its original state afterwards.

Signed-off-by: andychiu <andychiu@synology.com>
---
 hw/ide/ahci.c | 53 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index d45393c..83f8c30 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1649,33 +1649,52 @@ static const VMStateDescription vmstate_ahci_device = {
     },
 };
 
+static int ahci_state_load_engines(AHCIState *s, AHCIDevice *ad)
+{
+    AHCIPortRegs *pr = &ad->port_regs;
+    DeviceState *dev_state = s->container;
+    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
+                                                           TYPE_PCI_DEVICE);
+    bool pci_bus_master_enabled = pci_dev->bus_master_enable_region.enabled;
+
+    if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
+        error_report("AHCI: DMA engine should be off, but status bit "
+                     "indicates it is still running.");
+        return -1;
+    }
+    if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_ON)) {
+        error_report("AHCI: FIS RX engine should be off, but status bit "
+                     "indicates it is still running.");
+        return -1;
+    }
+
+    memory_region_set_enabled(&pci_dev->bus_master_enable_region, true);
+
+    /*
+     * After a migrate, the DMA/FIS engines are "off" and
+     * need to be conditionally restarted
+     */
+    pr->cmd &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
+    if (ahci_cond_start_engines(ad) != 0) {
+        return -1;
+    }
+    memory_region_set_enabled(&pci_dev->bus_master_enable_region,
+                              pci_bus_master_enabled);
+
+    return 0;
+}
+
 static int ahci_state_post_load(void *opaque, int version_id)
 {
     int i, j;
     struct AHCIDevice *ad;
     NCQTransferState *ncq_tfs;
-    AHCIPortRegs *pr;
     AHCIState *s = opaque;
 
     for (i = 0; i < s->ports; i++) {
         ad = &s->dev[i];
-        pr = &ad->port_regs;
-
-        if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
-            error_report("AHCI: DMA engine should be off, but status bit "
-                         "indicates it is still running.");
-            return -1;
-        }
-        if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_ON)) {
-            error_report("AHCI: FIS RX engine should be off, but status bit "
-                         "indicates it is still running.");
-            return -1;
-        }
 
-        /* After a migrate, the DMA/FIS engines are "off" and
-         * need to be conditionally restarted */
-        pr->cmd &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
-        if (ahci_cond_start_engines(ad) != 0) {
+        if (ahci_state_load_engines(s, ad)) {
             return -1;
         }
 
-- 
2.7.4


