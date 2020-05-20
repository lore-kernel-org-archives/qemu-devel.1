Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F09C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:39:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF772075F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 09:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF772075F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbLCG-0005Jb-Ju
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 05:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jbLAa-0003aM-0h
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:37:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3765 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <miaoyubo@huawei.com>)
 id 1jbLAY-000078-IF
 for qemu-devel@nongnu.org; Wed, 20 May 2020 05:37:47 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 6F37790190838BCF825B;
 Wed, 20 May 2020 17:37:42 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 20 May 2020 17:37:33 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v7 4/8] acpi: Refactor the source of host bridge and build
 tables for pxb
Date: Wed, 20 May 2020 17:36:25 +0800
Message-ID: <20200520093629.1495-5-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200520093629.1495-1-miaoyubo@huawei.com>
References: <20200520093629.1495-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191; envelope-from=miaoyubo@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 05:37:42
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

The resources of pxbs are obtained by crs_build and the resources
used by pxbs would be moved from the resources defined for host-bridge.

The resources for pxb are composed of following two parts
1. The bar space of the pci-bridge/pcie-root-port behined it
2. The config space of devices behind it.

Signed-off-by: Yubo Miao <miaoyubo@huawei.com>
---
 hw/arm/virt-acpi-build.c | 127 +++++++++++++++++++++++++++++++++------
 1 file changed, 110 insertions(+), 17 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 24ebc06a9f..14fcabd197 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -51,6 +51,10 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 
+#include "hw/arm/virt.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pcie_host.h"
 #define ARM_SPI_BASE 32
 
 static void acpi_dsdt_add_cpus(Aml *scope, int smp_cpus)
@@ -268,19 +272,80 @@ static void acpi_dsdt_add_pci_osc(Aml *dev, Aml *scope)
 }
 
 static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
-                              uint32_t irq, bool use_highmem, bool highmem_ecam)
+                              uint32_t irq, bool use_highmem, bool highmem_ecam,
+                              VirtMachineState *vms)
 {
     int ecam_id = VIRT_ECAM_ID(highmem_ecam);
-    Aml *method, *crs;
+    int i;
+    Aml *method, *crs, *dev_pxb;
     hwaddr base_mmio = memmap[VIRT_PCIE_MMIO].base;
     hwaddr size_mmio = memmap[VIRT_PCIE_MMIO].size;
     hwaddr base_pio = memmap[VIRT_PCIE_PIO].base;
     hwaddr size_pio = memmap[VIRT_PCIE_PIO].size;
     hwaddr base_ecam = memmap[ecam_id].base;
     hwaddr size_ecam = memmap[ecam_id].size;
+    CrsRangeEntry *entry;
+    CrsRangeSet crs_range_set;
+
+    crs_range_set_init(&crs_range_set);
     int nr_pcie_buses = size_ecam / PCIE_MMCFG_SIZE_MIN;
 
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
+            acpi_dsdt_add_pci_route_table(dev_pxb, scope, irq);
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
@@ -301,25 +366,51 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
         aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
                             0x0000, 0x0000, nr_pcie_buses - 1, 0x0000,
                             nr_pcie_buses));
-    aml_append(rbuf,
-        aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                         AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000, base_mmio,
-                         base_mmio + size_mmio - 1, 0x0000, size_mmio));
-    aml_append(rbuf,
-        aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
-                     AML_ENTIRE_RANGE, 0x0000, 0x0000, size_pio - 1, base_pio,
-                     size_pio));
+
+    /*
+     * Remove the resources used by PXBs.
+     */
+    crs_replace_with_free_ranges(crs_range_set.mem_ranges,
+                                 base_mmio,
+                                 base_mmio + size_mmio - 1);
+    for (i = 0; i < crs_range_set.mem_ranges->len; i++) {
+        entry = g_ptr_array_index(crs_range_set.mem_ranges, i);
+        aml_append(rbuf,
+            aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
+                             entry->base, entry->limit,
+                             0x0000, entry->limit - entry->base + 1));
+    }
+
+    crs_replace_with_free_ranges(crs_range_set.io_ranges,
+                                 0x0000,
+                                 size_pio - 1);
+    for (i = 0; i < crs_range_set.io_ranges->len; i++) {
+        entry = g_ptr_array_index(crs_range_set.io_ranges, i);
+        aml_append(rbuf,
+            aml_dword_io(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE,
+                         AML_ENTIRE_RANGE, 0x0000, entry->base,
+                         entry->limit, base_pio,
+                         entry->limit - entry->base + 1));
+    }
+
 
     if (use_highmem) {
         hwaddr base_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].base;
         hwaddr size_mmio_high = memmap[VIRT_HIGH_PCIE_MMIO].size;
 
-        aml_append(rbuf,
-            aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
-                             AML_NON_CACHEABLE, AML_READ_WRITE, 0x0000,
-                             base_mmio_high,
-                             base_mmio_high + size_mmio_high - 1, 0x0000,
-                             size_mmio_high));
+        crs_replace_with_free_ranges(crs_range_set.mem_64bit_ranges,
+                                     base_mmio_high,
+                                     base_mmio_high + size_mmio_high - 1);
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
 
     aml_append(method, aml_return(rbuf));
@@ -337,6 +428,8 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
     aml_append(dev_res0, aml_name_decl("_CRS", crs));
     aml_append(dev, dev_res0);
     aml_append(scope, dev);
+
+    crs_range_set_free(&crs_range_set);
 }
 
 static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
@@ -748,7 +841,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_virtio(scope, &memmap[VIRT_MMIO],
                     (irqmap[VIRT_MMIO] + ARM_SPI_BASE), NUM_VIRTIO_TRANSPORTS);
     acpi_dsdt_add_pci(scope, memmap, (irqmap[VIRT_PCIE] + ARM_SPI_BASE),
-                      vms->highmem, vms->highmem_ecam);
+                      vms->highmem, vms->highmem_ecam, vms);
     if (vms->acpi_dev) {
         build_ged_aml(scope, "\\_SB."GED_DEVICE,
                       HOTPLUG_HANDLER(vms->acpi_dev),
-- 
2.19.1



