Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F47C55178
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0706322384
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0706322384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvRj-0002tf-1r
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIQ-00005N-M6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2501)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kZvIG-00084q-8Q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:20:18 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CQTPb2FPnzhbhH;
 Tue,  3 Nov 2020 20:20:03 +0800 (CST)
Received: from localhost (10.174.184.155) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 3 Nov 2020
 20:19:57 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v9 4/8] acpi: Refactor the source of host bridge and build
 tables for pxb
Date: Tue, 3 Nov 2020 20:01:53 +0800
Message-ID: <20201103120157.2286-5-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201103120157.2286-1-cenjiahui@huawei.com>
References: <20201103120157.2286-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.184.155]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=cenjiahui@huawei.com;
 helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 06:47:30
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

The resources of pxbs are obtained by crs_build and the resources
used by pxbs would be moved from the resources defined for host-bridge.

The resources for pxb are composed of following two parts:
1. The bar space of the pci-bridge/pcie-root-port behined it
2. The config space of devices behind it.

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
---
 hw/arm/virt-acpi-build.c |   5 +-
 hw/pci-host/gpex-acpi.c  | 129 ++++++++++++++++++++++++++++++++-------
 2 files changed, 111 insertions(+), 23 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9747a6458f..fd9c2007c0 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -153,7 +153,8 @@ static void acpi_dsdt_add_virtio(Aml *scope,
 }
 
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
-                              uint32_t irq, bool use_highmem, bool highmem_ecam)
+                              uint32_t irq, bool use_highmem, bool highmem_ecam,
+                              VirtMachineState *vms)
 {
     int ecam_id = VIRT_ECAM_ID(highmem_ecam);
     struct GPEXConfig cfg = {
@@ -609,7 +610,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
     acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
-                      vms->highmem, vms->highmem_ecam);
+                      vms->highmem, vms->highmem_ecam, vms);
     if (vms->acpi_dev) {
         build_ged_aml(scope, "\\_SB."GED_DEVICE,
                       HOTPLUG_HANDLER(vms->acpi_dev),
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 86ddb52cbd..b5436c7128 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -1,6 +1,10 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/arm/virt.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_host.h"
 
 static void acpi_dsdt_add_pci_route_table(Aml *dev, Aml *scope, uint32_t irq)
 {
@@ -125,9 +129,69 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
 {
     int nr_pcie_buses = cfg->ecam.size / PCIE_MMCFG_SIZE_MIN;
-    Aml *method, *crs;
+    Aml *method, *crs, *dev_pxb;
+    int i;
+    CrsRangeEntry *entry;
+    CrsRangeSet crs_range_set;
+
+    crs_range_set_init(&crs_range_set);
 
     Aml *dev = aml_device("%s", "PCI0");
+    PCIHostState *s = PCI_GET_PCIE_HOST_STATE;
+
+    PCIBus *bus = s->bus;
+    /* start to construct the tables for pxb */
+    if (bus) {
+        QLIST_FOREACH(bus, &bus->child, sibling) {
+            uint8_t bus_num = pci_bus_num(bus);
+            uint8_t numa_node = pci_bus_numa_node(bus);
+
+            if (!pci_bus_is_root(bus)) {
+                continue;
+            }
+            /*
+             * 0 - (nr_pcie_buses - 1) is the bus range for the main
+             * host-bridge and it equals the MIN of the
+             * busNr defined for pxb-pcie.
+             */
+            if (bus_num < nr_pcie_buses) {
+                nr_pcie_buses = bus_num;
+            }
+
+            dev_pxb = aml_device("PC%.02X", bus_num);
+            aml_append(dev_pxb, aml_name_decl("_HID", aml_string("PNP0A08")));
+            aml_append(dev_pxb, aml_name_decl("_CID", aml_string("PNP0A03")));
+            aml_append(dev_pxb, aml_name_decl("_ADR", aml_int(0)));
+            aml_append(dev_pxb, aml_name_decl("_CCA", aml_int(1)));
+            aml_append(dev_pxb, aml_name_decl("_SEG", aml_int(0)));
+            aml_append(dev_pxb, aml_name_decl("_BBN", aml_int(bus_num)));
+            aml_append(dev_pxb, aml_name_decl("_UID", aml_int(bus_num)));
+            aml_append(dev_pxb,
+                       aml_name_decl("_STR", aml_unicode("pxb Device")));
+            if (numa_node != NUMA_NODE_UNASSIGNED) {
+                method = aml_method("_PXM", 0, AML_NOTSERIALIZED);
+                aml_append(method, aml_return(aml_int(numa_node)));
+                aml_append(dev_pxb, method);
+            }
+
+            acpi_dsdt_add_pci_route_table(dev_pxb, scope, cfg->irq);
+
+            /*
+             * Resources defined for PXBs are composed by the folling parts:
+             * 1. The resources the pci-brige/pcie-root-port need.
+             * 2. The resources the devices behind pxb need.
+             */
+            crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_range_set);
+            aml_append(dev_pxb, aml_name_decl("_CRS", crs));
+
+            acpi_dsdt_add_pci_osc(dev_pxb, scope);
+
+            aml_append(scope, dev_pxb);
+
+        }
+    }
+
+    /* tables for the main */
     aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
     aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
     aml_append(dev, aml_name_decl("_SEG", aml_int(0)));
@@ -147,32 +211,53 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
         aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
                             0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
                             nr_pcie_buses));
+
+    /*
+     * Remove the resources used by PXBs.
+     */
     if (cfg->mmio32.size) {
-        aml_append(rbuf,
-                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                                    cfg->mmio32.base,
-                                    cfg->mmio32.base + cfg->mmio32.size - 1,
-                                    0x0000,
-                                    cfg->mmio32.size));
+        crs_replace_with_free_ranges(crs_range_set.mem_ranges,
+                                     cfg->mmio32.base,
+                                     cfg->mmio32.base + cfg->mmio32.size - 1);
+        for (i = 0; i < crs_range_set.mem_ranges->len; i++) {
+            entry = g_ptr_array_index(crs_range_set.mem_ranges, i);
+            aml_append(rbuf,
+                aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                 AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                                 entry->base, entry->limit,
+                                 0x0000, entry->limit - entry->base + 1));
+        }
     }
+
     if (cfg->pio.size) {
-        aml_append(rbuf,
-                   aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                                AML_ENTIRE_RANGE, 0x0000, 0x0000,
-                                cfg->pio.size - 1,
-                                cfg->pio.base,
-                                cfg->pio.size));
+        crs_replace_with_free_ranges(crs_range_set.io_ranges,
+                                     0x0000,
+                                     cfg->pio.size - 1);
+        for (i = 0; i < crs_range_set.io_ranges->len; i++) {
+            entry = g_ptr_array_index(crs_range_set.io_ranges, i);
+            aml_append(rbuf,
+                aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                             AML_ENTIRE_RANGE, 0x0000, entry->base,
+                             entry->limit, cfg->pio.base,
+                             entry->limit - entry->base + 1));
+        }
     }
+
     if (cfg->mmio64.size) {
-        aml_append(rbuf,
-                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                                    AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                                    cfg->mmio64.base,
-                                    cfg->mmio64.base + cfg->mmio64.size - 1,
-                                    0x0000,
-                                    cfg->mmio64.size));
+        crs_replace_with_free_ranges(crs_range_set.mem_64bit_ranges,
+                                     cfg->mmio64.base,
+                                     cfg->mmio64.base + cfg->mmio64.size - 1);
+        for (i = 0; i < crs_range_set.mem_64bit_ranges->len; i++) {
+            entry = g_ptr_array_index(crs_range_set.mem_64bit_ranges, i);
+            aml_append(rbuf,
+                aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                 AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                                 entry->base,
+                                 entry->limit, 0x0000,
+                                 entry->limit - entry->base + 1));
+        }
     }
+
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
     acpi_dsdt_add_pci_osc(dev, scope);
@@ -190,4 +275,6 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     aml_append(dev_res0, aml_name_decl("_CRS", crs));
     aml_append(dev, dev_res0);
     aml_append(scope, dev);
+
+    crs_range_set_free(&crs_range_set);
 }
-- 
2.19.1


