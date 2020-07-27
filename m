Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D550C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:47:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 027FD206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 08:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 027FD206E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jzynR-000203-5D
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 04:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1jzymZ-0000aA-22
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:46:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4222 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hogan.wang@huawei.com>)
 id 1jzymW-0006va-Gh
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 04:46:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C39B195CB142C3350B59;
 Mon, 27 Jul 2020 16:46:37 +0800 (CST)
Received: from localhost (10.174.149.56) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Mon, 27 Jul 2020
 16:46:27 +0800
From: Hogan Wang <hogan.wang@huawei.com>
To: <marcel.apfelbaum@gmail.com>, <dgilbert@redhat.com>, <jusual@redhat.com>, 
 <mst@redhat.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v4 1/2] hw/pci-host: save/restore pci host config register
Date: Mon, 27 Jul 2020 16:46:20 +0800
Message-ID: <20200727084621.3279-1-hogan.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.149.56]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=hogan.wang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 04:46:37
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
Cc: wangxinxin.wang@huawei.com, weidong.huang@huawei.com, hogan.wang@huawei.com,
 Hogan Wang <king.wang@huawei.com>
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

Signed-off-by: Hogan Wang <hogan.wang@huawei.com>
---
 hw/i386/pc.c              |  4 +++-
 hw/pci/pci_host.c         | 33 +++++++++++++++++++++++++++++++++
 include/hw/pci/pci_host.h |  1 +
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3d419d5991..f6ff0c5514 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -97,7 +97,9 @@
 #include "fw_cfg.h"
 #include "trace.h"
 
-GlobalProperty pc_compat_5_0[] = {};
+GlobalProperty pc_compat_5_0[] = {
+    { "pci-host-bridge", "x-config-reg-migration-enabled", "off" },
+};
 const size_t pc_compat_5_0_len = G_N_ELEMENTS(pc_compat_5_0);
 
 GlobalProperty pc_compat_4_2[] = {
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index ce7bcdb1d5..8ca5fadcbd 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -22,8 +22,10 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
+#include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "hw/pci/pci_bus.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 /* debug PCI */
@@ -200,12 +202,43 @@ const MemoryRegionOps pci_host_data_be_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
+static bool pci_host_needed(void *opaque)
+{
+    PCIHostState *s = opaque;
+    return s->mig_enabled;
+}
+
+const VMStateDescription vmstate_pcihost = {
+    .name = "PCIHost",
+    .needed = pci_host_needed,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(config_reg, PCIHostState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static Property pci_host_properties_common[] = {
+    DEFINE_PROP_BOOL("x-config-reg-migration-enabled", PCIHostState,
+                     mig_enabled, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pci_host_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    device_class_set_props(dc, pci_host_properties_common);
+    dc->vmsd = &vmstate_pcihost;
+}
+
 static const TypeInfo pci_host_type_info = {
     .name = TYPE_PCI_HOST_BRIDGE,
     .parent = TYPE_SYS_BUS_DEVICE,
     .abstract = true,
     .class_size = sizeof(PCIHostBridgeClass),
     .instance_size = sizeof(PCIHostState),
+    .class_init = pci_host_class_init,
 };
 
 static void pci_host_register_types(void)
diff --git a/include/hw/pci/pci_host.h b/include/hw/pci/pci_host.h
index 9ce088bd13..6210a7e14d 100644
--- a/include/hw/pci/pci_host.h
+++ b/include/hw/pci/pci_host.h
@@ -45,6 +45,7 @@ struct PCIHostState {
     MemoryRegion data_mem;
     MemoryRegion mmcfg;
     uint32_t config_reg;
+    bool mig_enabled;
     PCIBus *bus;
 
     QLIST_ENTRY(PCIHostState) next;
-- 
2.27.0



