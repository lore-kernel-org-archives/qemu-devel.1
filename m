Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F52C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:38:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E43E5206F6
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 03:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E43E5206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbc2R-0002X1-22
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 23:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jbc1V-0001Ic-MX
 for qemu-devel@nongnu.org; Wed, 20 May 2020 23:37:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3698 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jbc1U-0001rt-6N
 for qemu-devel@nongnu.org; Wed, 20 May 2020 23:37:33 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E6E389E5823D491327C9;
 Thu, 21 May 2020 11:37:28 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 11:37:08 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v8 1/8] acpi: Extract two APIs from acpi_dsdt_add_pci
Date: Thu, 21 May 2020 11:36:24 +0800
Message-ID: <20200521033631.1605-2-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200521033631.1605-1-miaoyubo@huawei.com>
References: <20200521033631.1605-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=miaoyubo@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 23:37:29
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, miaoyubo@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract two APIs acpi_dsdt_add_pci_route_table and
acpi_dsdt_add_pci_osc from acpi_dsdt_add_pci. The first
API is used to specify the pci route table and the second
API is used to declare the operation system capabilities.
These two APIs would be used to specify the pxb-pcie in DSDT.

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
---
 hw/arm/virt-acpi-build.c | 129 ++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 57 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1b0a584c7b..24ebc06a9f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -148,29 +148,11 @@ static void acpi_dsdt_add_virtio(Aml *scope,
     }
 }
 
-static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
-                              uint32_t irq, bool use_highmem, bool highmem_ecam)
+static void acpi_dsdt_add_pci_route_table(Aml *dev, Aml *scope,
+                                          uint32_t irq)
 {
-    int ecam_id = VIRT_ECAM_ID(highmem_ecam);
-    Aml *method, *crs, *ifctx, *UUID, *ifctx1, *elsectx, *buf;
     int i, slot_no;
-    hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
-    hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
-    hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
-    hwaddr size_pio = memmap[VIRT_PCIE_PIO].size;
-    hwaddr base_ecam = memmap[ecam_id].base;
-    hwaddr size_ecam = memmap[ecam_id].size;
-    int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
-
-    Aml *dev = aml_device("%s", "PCI0");
-    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
-    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
-    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
-    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
-    aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
-    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
-    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
-
+    Aml *method, *crs;
     /* Declare the PCI Routing Table. */
     Aml *rt_pkg = aml_varpackage(PCI_SLOT_MAX * PCI_NUM_PINS);
     for (slot_no = 0; slot_no < PCI_SLOT_MAX; slot_no++) {
@@ -206,41 +188,11 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         aml_append(dev_gsi, method);
         aml_append(dev, dev_gsi);
     }
+}
 
-    method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
-    aml_append(method, aml_return(aml_int(base_ecam)));
-    aml_append(dev, method);
-
-    method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
-    Aml *rbuf = aml_resource_template();
-    aml_append(rbuf,
-        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
-                            nr_pcie_buses));
-    aml_append(rbuf,
-        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_mmio,
-                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
-    aml_append(rbuf,
-        aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, base_pio,
-                     size_pio));
-
-    if (use_highmem) {
-        hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
-        hwaddr size_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].size;
-
-        aml_append(rbuf,
-            aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                             base_mmio_high,
-                             base_mmio_high + size_mmio_high - 1, 0x0000,
-                             size_mmio_high));
-    }
-
-    aml_append(method, aml_return(rbuf));
-    aml_append(dev, method);
-
+static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)
+{
+    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
     /* Declare an _OSC (OS Control Handoff) method */
     aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
@@ -248,7 +200,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(method,
         aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
 
-    /* PCI Firmware Specification 3.0
+    /*
+     * PCI Firmware Specification 3.0
      * 4.5.1. _OSC Interface for PCI Host Bridge Devices
      * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
      * identified by the Universal Unique IDentifier (UUID)
@@ -293,7 +246,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
 
     method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
 
-    /* PCI Firmware Specification 3.0
+    /*
+     * PCI Firmware Specification 3.0
      * 4.6.1. _DSM for PCI Express Slot Information
      * The UUID in _DSM in this context is
      * {E5C937D0-3553-4D7A-9117-EA4D19C3434D}
@@ -311,6 +265,67 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     buf = aml_buffer(1, byte_list);
     aml_append(method, aml_return(buf));
     aml_append(dev, method);
+}
+
+static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
+                              uint32_t irq, bool use_highmem, bool highmem_ecam)
+{
+    int ecam_id = VIRT_ECAM_ID(highmem_ecam);
+    Aml *method, *crs;
+    hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
+    hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
+    hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
+    hwaddr size_pio = memmap[VIRT_PCIE_PIO].size;
+    hwaddr base_ecam = memmap[ecam_id].base;
+    hwaddr size_ecam = memmap[ecam_id].size;
+    int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
+
+    Aml *dev = aml_device("%s", "PCI0");
+    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
+    aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
+    aml_append(dev, aml_name_decl("_BBN", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_string("PCI0")));
+    aml_append(dev, aml_name_decl("_STR", aml_unicode("PCIe 0 Device")));
+    aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+    acpi_dsdt_add_pci_route_table(dev, scope, irq);
+
+    method = aml_method("_CBA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(base_ecam)));
+    aml_append(dev, method);
+
+    method = aml_method("_CRS", 0, AML_NOTSERIALIZED);
+    Aml *rbuf = aml_resource_template();
+    aml_append(rbuf,
+        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                            0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
+                            nr_pcie_buses));
+    aml_append(rbuf,
+        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_mmio,
+                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
+    aml_append(rbuf,
+        aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, base_pio,
+                     size_pio));
+
+    if (use_highmem) {
+        hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
+        hwaddr size_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].size;
+
+        aml_append(rbuf,
+            aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                             base_mmio_high,
+                             base_mmio_high + size_mmio_high - 1, 0x0000,
+                             size_mmio_high));
+    }
+
+    aml_append(method, aml_return(rbuf));
+    aml_append(dev, method);
+
+    acpi_dsdt_add_pci_osc(dev, scope);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
-- 
2.19.1



