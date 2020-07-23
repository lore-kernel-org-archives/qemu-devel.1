Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEBBC433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:24:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E4B20792
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 12:24:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E4B20792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyaH7-0005ha-IV
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 08:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <king.wang@huawei.com>)
 id 1jyaFx-0005EA-2L
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:23:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3721 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <king.wang@huawei.com>)
 id 1jyaFs-0002gp-NM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 08:23:24 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C44FE57DBCF19FC971AF;
 Thu, 23 Jul 2020 20:23:10 +0800 (CST)
Received: from localhost (10.174.149.56) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 23 Jul 2020
 20:23:04 +0800
From: Wang King <king.wang@huawei.com>
To: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2] hw/pci-host: save/restore pci host config register
Date: Thu, 23 Jul 2020 20:23:01 +0800
Message-ID: <20200723122301.2344-1-king.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.56]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=king.wang@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 06:49:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com, qemu-devel@nongnu.org,
 king.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hogan Wang <king.wang@huawei.com>

The pci host config register is used to save PCI address for
read/write config data. If guest write a value to config register,
and then pause the vcpu to migrate, After the migration, the guest
continue to write pci config data, and the write data will be ignored
because of new qemu process lost the config register state.

Reproduction steps are:
1. guest booting in seabios.
2. guest enable the SMRAM in seabios:piix4_apmc_smm_setup, and then
   expect to disable the SMRAM by pci_config_writeb.
3. after guest write the pci host config register, and then pasued vcpu
   to finish migration.
4. guest write config data(0x0A) fail to disable the SMRAM becasue of
   config register state lost.
5. guest continue to boot and crash in ipxe option ROM due to SMRAM in
   enabled state.

---
 hw/pci-host/i440fx.c       | 11 +++++++++++
 hw/pci-host/q35.c          | 11 +++++++++++
 hw/pci/pci_host.c          | 11 +++++++++++
 hw/pci/pcie_host.c         | 11 +++++++++++
 include/hw/pci/pci_host.h  | 10 ++++++++++
 include/hw/pci/pcie_host.h | 10 ++++++++++
 6 files changed, 64 insertions(+)

diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 8ed2417f0c..17705bb025 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -118,6 +118,16 @@ static const VMStateDescription vmstate_i440fx = {
     }
 };
 
+static const VMStateDescription vmstate_i440fx_pcihost = {
+    .name = "I440FX_PCIHost",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_HOST(parent_obj, I440FXState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void i440fx_pcihost_get_pci_hole_start(Object *obj, Visitor *v,
                                               const char *name, void *opaque,
                                               Error **errp)
@@ -398,6 +408,7 @@ static void i440fx_pcihost_class_init(ObjectClass *klass, void *data)
     hc->root_bus_path = i440fx_pcihost_root_bus_path;
     dc->realize = i440fx_pcihost_realize;
     dc->fw_name = "pci";
+    dc->vmsd = &vmstate_i440fx_pcihost;
     device_class_set_props(dc, i440fx_props);
     /* Reason: needs to be wired up by pc_init1 */
     dc->user_creatable = false;
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index b67cb9c29f..5e323be2e3 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -165,6 +165,16 @@ static void q35_host_get_pci_hole64_end(Object *obj, Visitor *v,
     visit_type_uint64(v, name, &value, errp);
 }
 
+static const VMStateDescription vmstate_q35_pcihost = {
+    .name = "Q35_PCIHost",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCIE_HOST(parent_obj, Q35PCIHost),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /*
  * NOTE: setting defaults for the mch.* fields in this table
  * doesn't work, because mch is a separate QOM object that is
@@ -194,6 +204,7 @@ static void q35_host_class_init(ObjectClass *klass, void *data)
 
     hc->root_bus_path = q35_host_root_bus_path;
     dc->realize = q35_host_realize;
+    dc->vmsd = &vmstate_q35_pcihost;
     device_class_set_props(dc, q35_host_props);
     /* Reason: needs to be wired up by pc_q35_init */
     dc->user_creatable = false;
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index ce7bcdb1d5..7cdd5a3ea3 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pci_host.h"
 #include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 /* debug PCI */
@@ -200,6 +201,16 @@ const MemoryRegionOps pci_host_data_be_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+const VMStateDescription vmstate_pcihost = {
+    .name = "PCIHost",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(config_reg, PCIHostState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const TypeInfo pci_host_type_info = {
     .name = TYPE_PCI_HOST_BRIDGE,
     .parent = TYPE_SYS_BUS_DEVICE,
diff --git a/hw/pci/pcie_host.c b/hw/pci/pcie_host.c
index 3534006f99..a653c39bb7 100644
--- a/hw/pci/pcie_host.c
+++ b/hw/pci/pcie_host.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pcie_host.h"
 #include "qemu/module.h"
 #include "exec/address-spaces.h"
+#include "migration/vmstate.h"
 
 /* a helper function to get a PCIDevice for a given mmconfig address */
 static inline PCIDevice *pcie_dev_find_by_mmcfg_addr(PCIBus *s,
@@ -121,6 +122,16 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
     memory_region_transaction_commit();
 }
 
+const VMStateDescription vmstate_pciehost = {
+    .name = "PCIEHost",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCI_HOST(pci, PCIExpressHost),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const TypeInfo pcie_host_type_info = {
     .name = TYPE_PCIE_HOST_BRIDGE,
     .parent = TYPE_PCI_HOST_BRIDGE,
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 9ce088bd13..fc88305e04 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -70,4 +70,14 @@ extern const MemoryRegionOps pci_host_conf_be_ops;
 extern const MemoryRegionOps pci_host_data_le_ops;
 extern const MemoryRegionOps pci_host_data_be_ops;
 
+extern const VMStateDescription vmstate_pcihost;
+
+#define VMSTATE_PCI_HOST(_field, _state) {                           \
+    .name       = (stringify(_field)),                               \
+    .size       = sizeof(PCIHostState),                              \
+    .vmsd       = &vmstate_pcihost,                                  \
+    .flags      = VMS_STRUCT,                                        \
+    .offset     = vmstate_offset_value(_state, _field, PCIHostState),\
+}
+
 #endif /* PCI_HOST_H */
diff --git a/include/hw/pci/pcie_host.h b/include/hw/pci/pcie_host.h
index 3f7b9886d1..e8856f03e9 100644
--- a/include/hw/pci/pcie_host.h
+++ b/include/hw/pci/pcie_host.h
@@ -78,4 +78,14 @@ void pcie_host_mmcfg_update(PCIExpressHost *e,
                                          PCIE_MMCFG_DEVFN_MASK)
 #define PCIE_MMCFG_CONFOFFSET(addr)     ((addr) & PCIE_MMCFG_CONFOFFSET_MASK)
 
+extern const VMStateDescription vmstate_pciehost;
+
+#define VMSTATE_PCIE_HOST(_field, _state) {                            \
+    .name       = (stringify(_field)),                                 \
+    .size       = sizeof(PCIExpressHost),                              \
+    .vmsd       = &vmstate_pciehost,                                   \
+    .flags      = VMS_STRUCT,                                          \
+    .offset     = vmstate_offset_value(_state, _field, PCIExpressHost),\
+}
+
 #endif /* PCIE_HOST_H */
-- 
2.23.0



