Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70211C4742C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:26:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD53222264
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD53222264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvNw-00079J-RI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIN-0008PI-CE
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:2322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIH-00084w-Qf
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:14 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQTPZ2HkYzkcQ0;
 Tue,  3 Nov 2020 20:20:02 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 20:19:55 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v9 1/8] acpi: Extract two APIs from acpi_dsdt_add_pci
Date: Tue, 3 Nov 2020 20:01:50 +0800
Message-ID: <20201103120157.2286-2-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103120157.2286-1-cenjiahui@huawei.com>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=cenjiahui@huawei.com;
 helo=szxga04-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 04:56:56
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: xieyingtai@huawei.com, peter.maydell@linaro.org,
 Jiahui Cen <cenjiahui@huawei.com>, berrange@redhat.com, mst@redhat.com,
 xiexiangyou@huawei.com, shannon.zhaosl@gmail.com, miaoyubo@huawei.com,
 imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yubo Miao <miaoyubo@huawei.com>

Extract two APIs acpi_dsdt_add_pci_route_table and
acpi_dsdt_add_pci_osc from acpi_dsdt_add_pci. The first
API is used to specify the pci route table and the second
API is used to declare the operation system capabilities.
These two APIs would be used to specify the pxb-pcie in DSDT.

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 hw/pci-host/gpex-acpi.c | 118 +++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 51 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index dbb350a837..86ddb52cbd 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -2,20 +2,10 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/pci-host/gpex.h"
 
-void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
+static void acpi_dsdt_add_pci_route_table(Aml *dev, Aml *scope, uint32_t irq)
 {
-    int nr_pcie_buses = cfg->ecam.size / PCIE_MMCFG_SIZE_MIN;
-    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
     int i, slot_no;
-
-    Aml *dev = aml_device("%s", "PCI0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
-    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
-    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
-    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
-    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+    Aml *method, *crs;
 
     /* Declare the PCI Routing Table. */
     Aml *rt_pkg = aml_varpackage(PCI_SLOT_MAX * PCI_NUM_PINS);
@@ -34,7 +24,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 
     /* Create GSI link device */
     for (i = 0; i < PCI_NUM_PINS; i++) {
-        uint32_t irqs = cfg->irq + i;
+        uint32_t irqs = irq + i;
         Aml *dev_gsi = aml_device("GSI%d", i);
         aml_append(dev_gsi, aml_name_decl("_HID", aml_string("PNP0C0F")));
         aml_append(dev_gsi, aml_name_decl("_UID", aml_int(i)));
@@ -52,43 +42,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
         aml_append(dev_gsi, method);
         aml_append(dev, dev_gsi);
     }
+}
 
-    method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_return(aml_int(cfg->ecam.base)));
-    aml_append(dev, method);
-
-    Aml *rbuf = aml_resource_template();
-    aml_append(rbuf,
-        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
-                            nr_pcie_buses));
-    if (cfg->mmio32.size) {
-        aml_append(rbuf,
-                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                                    cfg->mmio32.base,
-                                    cfg->mmio32.base + cfg->mmio32.size - 1,
-                                    0x0000,
-                                    cfg->mmio32.size));
-    }
-    if (cfg->pio.size) {
-        aml_append(rbuf,
-                   aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                                AML_ENTIRE_RANGE, 0x0000, 0x0000,
-                                cfg->pio.size - 1,
-                                cfg->pio.base,
-                                cfg->pio.size));
-    }
-    if (cfg->mmio64.size) {
-        aml_append(rbuf,
-                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                                    cfg->mmio64.base,
-                                    cfg->mmio64.base + cfg->mmio64.size - 1,
-                                    0x0000,
-                                    cfg->mmio64.size));
-    }
-    aml_append(dev, aml_name_decl("_CRS", rbuf));
+static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)
+{
+    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
 
     /* Declare an _OSC (OS Control Handoff) method */
     aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
@@ -97,7 +55,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     aml_append(method,
         aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
 
-    /* PCI Firmware Specification 3.0
+    /*
+     * PCI Firmware Specification 3.0
      * 4.5.1. _OSC Interface for PCI Host Bridge Devices
      * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
      * identified by the Universal Unique IDentifier (UUID)
@@ -142,7 +101,8 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 
     method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
 
-    /* PCI Firmware Specification 3.0
+    /*
+     * PCI Firmware Specification 3.0
      * 4.6.1. _DSM for PCI Express Slot Information
      * The UUID in _DSM in this context is
      * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
@@ -160,6 +120,62 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     buf = aml_buffer(1, byte_list);
     aml_append(method, aml_return(buf));
     aml_append(dev, method);
+}
+
+void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
+{
+    int nr_pcie_buses = cfg->ecam.size / PCIE_MMCFG_SIZE_MIN;
+    Aml *method, *crs;
+
+    Aml *dev = aml_device("%s", "PCI0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
+    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
+    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
+    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+    acpi_dsdt_add_pci_route_table(dev, scope, cfg->irq);
+
+    method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(cfg->ecam.base)));
+    aml_append(dev, method);
+
+    Aml *rbuf = aml_resource_template();
+    aml_append(rbuf,
+        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
+                            nr_pcie_buses));
+    if (cfg->mmio32.size) {
+        aml_append(rbuf,
+                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                                    cfg->mmio32.base,
+                                    cfg->mmio32.base + cfg->mmio32.size - 1,
+                                    0x0000,
+                                    cfg->mmio32.size));
+    }
+    if (cfg->pio.size) {
+        aml_append(rbuf,
+                   aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                                AML_ENTIRE_RANGE, 0x0000, 0x0000,
+                                cfg->pio.size - 1,
+                                cfg->pio.base,
+                                cfg->pio.size));
+    }
+    if (cfg->mmio64.size) {
+        aml_append(rbuf,
+                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                                    cfg->mmio64.base,
+                                    cfg->mmio64.base + cfg->mmio64.size - 1,
+                                    0x0000,
+                                    cfg->mmio64.size));
+    }
+    aml_append(dev, aml_name_decl("_CRS", rbuf));
+
+    acpi_dsdt_add_pci_osc(dev, scope);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
-- 
2.19.1


