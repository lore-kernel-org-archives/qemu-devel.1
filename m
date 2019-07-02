Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91563C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6679321479
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 15:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6679321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiKpE-0006nB-Ju
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 11:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58319)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hiKMr-0005vq-BO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hiKMq-0008GB-1C
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hiKMp-0008Ff-Oa
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:06:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AF313082E71;
 Tue,  2 Jul 2019 15:06:43 +0000 (UTC)
Received: from redhat.com (ovpn-124-209.rdu2.redhat.com [10.10.124.209])
 by smtp.corp.redhat.com (Postfix) with SMTP id CFA2E17537;
 Tue,  2 Jul 2019 15:06:41 +0000 (UTC)
Date: Tue, 2 Jul 2019 11:06:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Message-ID: <20190702150606.24851-3-mst@redhat.com>
References: <20190702150606.24851-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 02 Jul 2019 15:06:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 02/22] pcie: check that slt ctrl changed before
 deleting
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

During boot, linux would sometimes overwrites control of a powered off
slot before powering it on. Unfortunately QEMU interprets that as a
power off request and ejects the device.

For example:

/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -S -machine q35  \
    -device pcie-root-port,id=pcie_root_port_0,slot=2,chassis=2,addr=0x2,bus=pcie.0 \
    -monitor stdio disk.qcow2
(qemu)device_add virtio-balloon-pci,id=balloon,bus=pcie_root_port_0
(qemu)cont

Balloon is deleted during guest boot.

To fix, save control beforehand and check that power
or led state actually change before ejecting.

Note: this is more a hack than a solution, ideally we'd
find a better way to detect ejects, or move away
from ejects completely and instead monitor whether
it's safe to delete device due to e.g. its power state.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Tested-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/pci/pcie.h              |  3 ++-
 hw/pci-bridge/pcie_root_port.c     |  5 ++++-
 hw/pci-bridge/xio3130_downstream.c |  5 ++++-
 hw/pci/pcie.c                      | 14 ++++++++++++--
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index e30334d74d..8d90c0e193 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -107,7 +107,8 @@ void pcie_cap_lnkctl_reset(PCIDevice *dev);
 
 void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
 void pcie_cap_slot_reset(PCIDevice *dev);
-void pcie_cap_slot_write_config(PCIDevice *dev,
+void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slot_ctl, uint16_t *slt_sta);
+void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slot_ctl, uint16_t slt_sta,
                                 uint32_t addr, uint32_t val, int len);
 int pcie_cap_slot_post_load(void *opaque, int version_id);
 void pcie_cap_slot_push_attention_button(PCIDevice *dev);
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 92f253c924..09019ca05d 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -31,10 +31,13 @@ static void rp_write_config(PCIDevice *d, uint32_t address,
 {
     uint32_t root_cmd =
         pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
+    uint16_t slt_ctl, slt_sta;
+
+    pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
 
     pci_bridge_write_config(d, address, val, len);
     rp_aer_vector_update(d);
-    pcie_cap_slot_write_config(d, address, val, len);
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
     pcie_aer_write_config(d, address, val, len);
     pcie_aer_root_write_config(d, address, val, len, root_cmd);
 }
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 264e37d6a6..899b0fd6c9 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -41,9 +41,12 @@
 static void xio3130_downstream_write_config(PCIDevice *d, uint32_t address,
                                          uint32_t val, int len)
 {
+    uint16_t slt_ctl, slt_sta;
+
+    pcie_cap_slot_get(d, &slt_sta, &slt_ctl);
     pci_bridge_write_config(d, address, val, len);
     pcie_cap_flr_write_config(d, address, val, len);
-    pcie_cap_slot_write_config(d, address, val, len);
+    pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
     pcie_aer_write_config(d, address, val, len);
 }
 
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b22527000d..f8490a00de 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -594,7 +594,15 @@ void pcie_cap_slot_reset(PCIDevice *dev)
     hotplug_event_update_event_status(dev);
 }
 
-void pcie_cap_slot_write_config(PCIDevice *dev,
+void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
+{
+    uint32_t pos = dev->exp.exp_cap;
+    uint8_t *exp_cap = dev->config + pos;
+    *slt_ctl = pci_get_word(exp_cap + PCI_EXP_SLTCTL);
+    *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
+}
+
+void pcie_cap_slot_write_config(PCIDevice *dev, uint16_t slt_ctl, uint16_t slt_sta,
                                 uint32_t addr, uint32_t val, int len)
 {
     uint32_t pos = dev->exp.exp_cap;
@@ -623,7 +631,9 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
      * controller is off, it is safe to detach the devices.
      */
     if ((sltsta & PCI_EXP_SLTSTA_PDS) && (val & PCI_EXP_SLTCTL_PCC) &&
-        ((val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF)) {
+        (val & PCI_EXP_SLTCTL_PIC_OFF) == PCI_EXP_SLTCTL_PIC_OFF &&
+        (!(slt_ctl & PCI_EXP_SLTCTL_PCC) ||
+        (slt_ctl & PCI_EXP_SLTCTL_PIC_OFF) != PCI_EXP_SLTCTL_PIC_OFF)) {
         PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
         pci_for_each_device(sec_bus, pci_bus_num(sec_bus),
                             pcie_unplug_device, NULL);
-- 
MST


