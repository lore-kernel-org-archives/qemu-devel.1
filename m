Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC968C2BA80
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 12:59:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BFF206F7
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 12:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BFF206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMAJ8-0001nN-OR
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 08:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI7-0008VR-7h
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <miaoyubo@huawei.com>) id 1jMAI4-00057N-Mq
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3666 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <miaoyubo@huawei.com>) id 1jMAI4-00054h-1O
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 08:58:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 0F1E7D26D27C882CD86E;
 Wed,  8 Apr 2020 20:58:40 +0800 (CST)
Received: from DESKTOP-D7EVK5B.china.huawei.com (10.173.221.29) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 20:58:33 +0800
From: Yubo Miao <miaoyubo@huawei.com>
To: <peter.maydell@linaro.org>, <shannon.zhaosl@gmail.com>, <lersek@redhat.com>
Subject: [PATCH v6 3/8] acpi: Extract crs build form acpi_build.c
Date: Wed, 8 Apr 2020 20:58:11 +0800
Message-ID: <20200408125816.955-4-miaoyubo@huawei.com>
X-Mailer: git-send-email 2.24.1.windows.2
In-Reply-To: <20200408125816.955-1-miaoyubo@huawei.com>
References: <20200408125816.955-1-miaoyubo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.29]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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

From: miaoyubo <miaoyubo@huawei.com>

Extract crs build form acpi_build.c, the function could also be used
to build the crs for pxbs for arm. The resources are composed by two part=
s:
1. The bar space of pci-bridge/pcie-root-ports
2. The resources devices behind PXBs need.
The base and limit of memory/io are obtained from the config via two APIs=
:
pci_bridge_get_base and pci_bridge_get_limit

Signed-off-by: miaoyubo <miaoyubo@huawei.com>
---
 hw/acpi/aml-build.c         | 275 ++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c        | 285 ------------------------------------
 include/hw/acpi/aml-build.h |  25 ++++
 3 files changed, 300 insertions(+), 285 deletions(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2c3702b882..252349d96d 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -26,6 +26,9 @@
 #include "qemu/bitops.h"
 #include "sysemu/numa.h"
 #include "hw/boards.h"
+#include "hw/pci/pci_host.h"
+#include "hw/pci/pci_bus.h"
+#include "hw/pci/pci_bridge.h"
=20
 static GArray *build_alloc_array(void)
 {
@@ -54,6 +57,125 @@ static void build_append_array(GArray *array, GArray =
*val)
=20
 #define ACPI_NAMESEG_LEN 4
=20
+void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit)
+{
+    CrsRangeEntry *entry;
+
+    entry =3D g_malloc(sizeof(*entry));
+    entry->base =3D base;
+    entry->limit =3D limit;
+
+    g_ptr_array_add(ranges, entry);
+}
+
+static void crs_range_free(gpointer data)
+{
+    CrsRangeEntry *entry =3D (CrsRangeEntry *)data;
+    g_free(entry);
+}
+
+void crs_range_set_init(CrsRangeSet *range_set)
+{
+    range_set->io_ranges =3D g_ptr_array_new_with_free_func(crs_range_fr=
ee);
+    range_set->mem_ranges =3D g_ptr_array_new_with_free_func(crs_range_f=
ree);
+    range_set->mem_64bit_ranges =3D
+            g_ptr_array_new_with_free_func(crs_range_free);
+}
+
+void crs_range_set_free(CrsRangeSet *range_set)
+{
+    g_ptr_array_free(range_set->io_ranges, true);
+    g_ptr_array_free(range_set->mem_ranges, true);
+    g_ptr_array_free(range_set->mem_64bit_ranges, true);
+}
+
+static gint crs_range_compare(gconstpointer a, gconstpointer b)
+{
+    CrsRangeEntry *entry_a =3D *(CrsRangeEntry **)a;
+    CrsRangeEntry *entry_b =3D *(CrsRangeEntry **)b;
+
+    if (entry_a->base < entry_b->base) {
+        return -1;
+    } else if (entry_a->base > entry_b->base) {
+        return 1;
+    } else {
+        return 0;
+    }
+}
+
+/*
+ * crs_replace_with_free_ranges - given the 'used' ranges within [start =
- end]
+ * interval, computes the 'free' ranges from the same interval.
+ * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
+ * will return { [base - a1], [a2 - b1], [b2 - limit] }.
+ */
+void crs_replace_with_free_ranges(GPtrArray *ranges,
+                                         uint64_t start, uint64_t end)
+{
+    GPtrArray *free_ranges =3D g_ptr_array_new();
+    uint64_t free_base =3D start;
+    int i;
+
+    g_ptr_array_sort(ranges, crs_range_compare);
+    for (i =3D 0; i < ranges->len; i++) {
+        CrsRangeEntry *used =3D g_ptr_array_index(ranges, i);
+
+        if (free_base < used->base) {
+            crs_range_insert(free_ranges, free_base, used->base - 1);
+        }
+
+        free_base =3D used->limit + 1;
+    }
+
+    if (free_base < end) {
+        crs_range_insert(free_ranges, free_base, end);
+    }
+
+    g_ptr_array_set_size(ranges, 0);
+    for (i =3D 0; i < free_ranges->len; i++) {
+        g_ptr_array_add(ranges, g_ptr_array_index(free_ranges, i));
+    }
+
+    g_ptr_array_free(free_ranges, true);
+}
+
+static void crs_range_merge(GPtrArray *range)
+{
+    GPtrArray *tmp =3D  g_ptr_array_new_with_free_func(crs_range_free);
+    CrsRangeEntry *entry;
+    uint64_t range_base, range_limit;
+    int i;
+
+    if (!range->len) {
+        return;
+    }
+
+    g_ptr_array_sort(range, crs_range_compare);
+
+    entry =3D g_ptr_array_index(range, 0);
+    range_base =3D entry->base;
+    range_limit =3D entry->limit;
+    for (i =3D 1; i < range->len; i++) {
+        entry =3D g_ptr_array_index(range, i);
+        if (entry->base - 1 =3D=3D range_limit) {
+            range_limit =3D entry->limit;
+        } else {
+            crs_range_insert(tmp, range_base, range_limit);
+            range_base =3D entry->base;
+            range_limit =3D entry->limit;
+        }
+    }
+    crs_range_insert(tmp, range_base, range_limit);
+
+    g_ptr_array_set_size(range, 0);
+    for (i =3D 0; i < tmp->len; i++) {
+        entry =3D g_ptr_array_index(tmp, i);
+        crs_range_insert(range, entry->base, entry->limit);
+    }
+    g_ptr_array_free(tmp, true);
+}
+
+
 static void
 build_append_nameseg(GArray *array, const char *seg)
 {
@@ -1875,6 +1997,159 @@ build_hdr:
                  "FACP", tbl->len - fadt_start, f->rev, oem_id, oem_tabl=
e_id);
 }
=20
+Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
+{
+    Aml *crs =3D aml_resource_template();
+    CrsRangeSet temp_range_set;
+    CrsRangeEntry *entry;
+    uint8_t max_bus =3D pci_bus_num(host->bus);
+    uint8_t type;
+    int devfn;
+    int i;
+
+    crs_range_set_init(&temp_range_set);
+    for (devfn =3D 0; devfn < ARRAY_SIZE(host->bus->devices); devfn++) {
+        uint64_t range_base, range_limit;
+        PCIDevice *dev =3D host->bus->devices[devfn];
+
+        if (!dev) {
+            continue;
+        }
+
+        for (i =3D 0; i < PCI_NUM_REGIONS; i++) {
+            PCIIORegion *r =3D &dev->io_regions[i];
+
+            range_base =3D r->addr;
+            range_limit =3D r->addr + r->size - 1;
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (!range_base || range_base > range_limit) {
+                continue;
+            }
+
+            if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
+                crs_range_insert(temp_range_set.io_ranges,
+                                 range_base, range_limit);
+            } else { /* "memory" */
+                crs_range_insert(temp_range_set.mem_ranges,
+                                 range_base, range_limit);
+            }
+        }
+
+        type =3D dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_F=
UNCTION;
+        if (type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
+            uint8_t subordinate =3D dev->config[PCI_SUBORDINATE_BUS];
+            if (subordinate > max_bus) {
+                max_bus =3D subordinate;
+            }
+
+            range_base =3D pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPA=
CE_IO);
+            range_limit =3D pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_S=
PACE_IO);
+             /*
+              * Work-around for old bioses
+              * that do not support multiple root buses
+              */
+            if (range_base && range_base <=3D range_limit) {
+                crs_range_insert(temp_range_set.io_ranges,
+                                 range_base, range_limit);
+            }
+
+            range_base =3D
+                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
+            range_limit =3D
+                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_MEMORY)=
;
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (range_base && range_base <=3D range_limit) {
+                uint64_t length =3D range_limit - range_base + 1;
+                if (range_limit <=3D UINT32_MAX && length <=3D UINT32_MA=
X) {
+                    crs_range_insert(temp_range_set.mem_ranges,
+                                     range_base, range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
+            }
+
+            range_base =3D
+                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
+            range_limit =3D
+                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH)=
;
+
+            /*
+             * Work-around for old bioses
+             * that do not support multiple root buses
+             */
+            if (range_base && range_base <=3D range_limit) {
+                uint64_t length =3D range_limit - range_base + 1;
+                if (range_limit <=3D UINT32_MAX && length <=3D UINT32_MA=
X) {
+                    crs_range_insert(temp_range_set.mem_ranges,
+                                     range_base, range_limit);
+                } else {
+                    crs_range_insert(temp_range_set.mem_64bit_ranges,
+                                     range_base, range_limit);
+                }
+            }
+        }
+    }
+
+    crs_range_merge(temp_range_set.io_ranges);
+    for (i =3D 0; i < temp_range_set.io_ranges->len; i++) {
+        entry =3D g_ptr_array_index(temp_range_set.io_ranges, i);
+        aml_append(crs,
+                   aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
+                               AML_POS_DECODE, AML_ENTIRE_RANGE,
+                               0, entry->base, entry->limit, 0,
+                               entry->limit - entry->base + 1));
+        crs_range_insert(range_set->io_ranges, entry->base, entry->limit=
);
+    }
+
+    crs_range_merge(temp_range_set.mem_ranges);
+    for (i =3D 0; i < temp_range_set.mem_ranges->len; i++) {
+        entry =3D g_ptr_array_index(temp_range_set.mem_ranges, i);
+        aml_append(crs,
+                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE,
+                                    0, entry->base, entry->limit, 0,
+                                    entry->limit - entry->base + 1));
+        crs_range_insert(range_set->mem_ranges, entry->base, entry->limi=
t);
+    }
+
+    crs_range_merge(temp_range_set.mem_64bit_ranges);
+    for (i =3D 0; i < temp_range_set.mem_64bit_ranges->len; i++) {
+        entry =3D g_ptr_array_index(temp_range_set.mem_64bit_ranges, i);
+        aml_append(crs,
+                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                    AML_READ_WRITE,
+                                    0, entry->base, entry->limit, 0,
+                                    entry->limit - entry->base + 1));
+        crs_range_insert(range_set->mem_64bit_ranges,
+                         entry->base, entry->limit);
+    }
+
+    crs_range_set_free(&temp_range_set);
+
+    aml_append(crs,
+        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE=
,
+                            0,
+                            pci_bus_num(host->bus),
+                            max_bus,
+                            0,
+                            max_bus - pci_bus_num(host->bus) + 1));
+
+    return crs;
+}
+
+
+
 /* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
 static Aml *aml_serial_bus_device(uint8_t serial_bus_type, uint8_t flags=
,
                                   uint16_t type_flags,
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2a7e55bae7..ba7750480f 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -715,291 +715,6 @@ static Aml *build_prt(bool is_pci0_prt)
     return method;
 }
=20
-typedef struct CrsRangeEntry {
-    uint64_t base;
-    uint64_t limit;
-} CrsRangeEntry;
-
-static void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t =
limit)
-{
-    CrsRangeEntry *entry;
-
-    entry =3D g_malloc(sizeof(*entry));
-    entry->base =3D base;
-    entry->limit =3D limit;
-
-    g_ptr_array_add(ranges, entry);
-}
-
-static void crs_range_free(gpointer data)
-{
-    CrsRangeEntry *entry =3D (CrsRangeEntry *)data;
-    g_free(entry);
-}
-
-typedef struct CrsRangeSet {
-    GPtrArray *io_ranges;
-    GPtrArray *mem_ranges;
-    GPtrArray *mem_64bit_ranges;
- } CrsRangeSet;
-
-static void crs_range_set_init(CrsRangeSet *range_set)
-{
-    range_set->io_ranges =3D g_ptr_array_new_with_free_func(crs_range_fr=
ee);
-    range_set->mem_ranges =3D g_ptr_array_new_with_free_func(crs_range_f=
ree);
-    range_set->mem_64bit_ranges =3D
-            g_ptr_array_new_with_free_func(crs_range_free);
-}
-
-static void crs_range_set_free(CrsRangeSet *range_set)
-{
-    g_ptr_array_free(range_set->io_ranges, true);
-    g_ptr_array_free(range_set->mem_ranges, true);
-    g_ptr_array_free(range_set->mem_64bit_ranges, true);
-}
-
-static gint crs_range_compare(gconstpointer a, gconstpointer b)
-{
-    CrsRangeEntry *entry_a =3D *(CrsRangeEntry **)a;
-    CrsRangeEntry *entry_b =3D *(CrsRangeEntry **)b;
-
-    if (entry_a->base < entry_b->base) {
-        return -1;
-    } else if (entry_a->base > entry_b->base) {
-        return 1;
-    } else {
-        return 0;
-    }
-}
-
-/*
- * crs_replace_with_free_ranges - given the 'used' ranges within [start =
- end]
- * interval, computes the 'free' ranges from the same interval.
- * Example: If the input array is { [a1 - a2],[b1 - b2] }, the function
- * will return { [base - a1], [a2 - b1], [b2 - limit] }.
- */
-static void crs_replace_with_free_ranges(GPtrArray *ranges,
-                                         uint64_t start, uint64_t end)
-{
-    GPtrArray *free_ranges =3D g_ptr_array_new();
-    uint64_t free_base =3D start;
-    int i;
-
-    g_ptr_array_sort(ranges, crs_range_compare);
-    for (i =3D 0; i < ranges->len; i++) {
-        CrsRangeEntry *used =3D g_ptr_array_index(ranges, i);
-
-        if (free_base < used->base) {
-            crs_range_insert(free_ranges, free_base, used->base - 1);
-        }
-
-        free_base =3D used->limit + 1;
-    }
-
-    if (free_base < end) {
-        crs_range_insert(free_ranges, free_base, end);
-    }
-
-    g_ptr_array_set_size(ranges, 0);
-    for (i =3D 0; i < free_ranges->len; i++) {
-        g_ptr_array_add(ranges, g_ptr_array_index(free_ranges, i));
-    }
-
-    g_ptr_array_free(free_ranges, true);
-}
-
-/*
- * crs_range_merge - merges adjacent ranges in the given array.
- * Array elements are deleted and replaced with the merged ranges.
- */
-static void crs_range_merge(GPtrArray *range)
-{
-    GPtrArray *tmp =3D  g_ptr_array_new_with_free_func(crs_range_free);
-    CrsRangeEntry *entry;
-    uint64_t range_base, range_limit;
-    int i;
-
-    if (!range->len) {
-        return;
-    }
-
-    g_ptr_array_sort(range, crs_range_compare);
-
-    entry =3D g_ptr_array_index(range, 0);
-    range_base =3D entry->base;
-    range_limit =3D entry->limit;
-    for (i =3D 1; i < range->len; i++) {
-        entry =3D g_ptr_array_index(range, i);
-        if (entry->base - 1 =3D=3D range_limit) {
-            range_limit =3D entry->limit;
-        } else {
-            crs_range_insert(tmp, range_base, range_limit);
-            range_base =3D entry->base;
-            range_limit =3D entry->limit;
-        }
-    }
-    crs_range_insert(tmp, range_base, range_limit);
-
-    g_ptr_array_set_size(range, 0);
-    for (i =3D 0; i < tmp->len; i++) {
-        entry =3D g_ptr_array_index(tmp, i);
-        crs_range_insert(range, entry->base, entry->limit);
-    }
-    g_ptr_array_free(tmp, true);
-}
-
-static Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set)
-{
-    Aml *crs =3D aml_resource_template();
-    CrsRangeSet temp_range_set;
-    CrsRangeEntry *entry;
-    uint8_t max_bus =3D pci_bus_num(host->bus);
-    uint8_t type;
-    int devfn;
-    int i;
-
-    crs_range_set_init(&temp_range_set);
-    for (devfn =3D 0; devfn < ARRAY_SIZE(host->bus->devices); devfn++) {
-        uint64_t range_base, range_limit;
-        PCIDevice *dev =3D host->bus->devices[devfn];
-
-        if (!dev) {
-            continue;
-        }
-
-        for (i =3D 0; i < PCI_NUM_REGIONS; i++) {
-            PCIIORegion *r =3D &dev->io_regions[i];
-
-            range_base =3D r->addr;
-            range_limit =3D r->addr + r->size - 1;
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (!range_base || range_base > range_limit) {
-                continue;
-            }
-
-            if (r->type & PCI_BASE_ADDRESS_SPACE_IO) {
-                crs_range_insert(temp_range_set.io_ranges,
-                                 range_base, range_limit);
-            } else { /* "memory" */
-                crs_range_insert(temp_range_set.mem_ranges,
-                                 range_base, range_limit);
-            }
-        }
-
-        type =3D dev->config[PCI_HEADER_TYPE] & ~PCI_HEADER_TYPE_MULTI_F=
UNCTION;
-        if (type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
-            uint8_t subordinate =3D dev->config[PCI_SUBORDINATE_BUS];
-            if (subordinate > max_bus) {
-                max_bus =3D subordinate;
-            }
-
-            range_base =3D pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPA=
CE_IO);
-            range_limit =3D pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_S=
PACE_IO);
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <=3D range_limit) {
-                crs_range_insert(temp_range_set.io_ranges,
-                                 range_base, range_limit);
-            }
-
-            range_base =3D
-                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_SPACE_MEMORY);
-            range_limit =3D
-                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_SPACE_MEMORY)=
;
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <=3D range_limit) {
-                uint64_t length =3D range_limit - range_base + 1;
-                if (range_limit <=3D UINT32_MAX && length <=3D UINT32_MA=
X) {
-                    crs_range_insert(temp_range_set.mem_ranges,
-                                     range_base, range_limit);
-                } else {
-                    crs_range_insert(temp_range_set.mem_64bit_ranges,
-                                     range_base, range_limit);
-                }
-            }
-
-            range_base =3D
-                pci_bridge_get_base(dev, PCI_BASE_ADDRESS_MEM_PREFETCH);
-            range_limit =3D
-                pci_bridge_get_limit(dev, PCI_BASE_ADDRESS_MEM_PREFETCH)=
;
-
-            /*
-             * Work-around for old bioses
-             * that do not support multiple root buses
-             */
-            if (range_base && range_base <=3D range_limit) {
-                uint64_t length =3D range_limit - range_base + 1;
-                if (range_limit <=3D UINT32_MAX && length <=3D UINT32_MA=
X) {
-                    crs_range_insert(temp_range_set.mem_ranges,
-                                     range_base, range_limit);
-                } else {
-                    crs_range_insert(temp_range_set.mem_64bit_ranges,
-                                     range_base, range_limit);
-                }
-            }
-        }
-    }
-
-    crs_range_merge(temp_range_set.io_ranges);
-    for (i =3D 0; i < temp_range_set.io_ranges->len; i++) {
-        entry =3D g_ptr_array_index(temp_range_set.io_ranges, i);
-        aml_append(crs,
-                   aml_word_io(AML_MIN_FIXED, AML_MAX_FIXED,
-                               AML_POS_DECODE, AML_ENTIRE_RANGE,
-                               0, entry->base, entry->limit, 0,
-                               entry->limit - entry->base + 1));
-        crs_range_insert(range_set->io_ranges, entry->base, entry->limit=
);
-    }
-
-    crs_range_merge(temp_range_set.mem_ranges);
-    for (i =3D 0; i < temp_range_set.mem_ranges->len; i++) {
-        entry =3D g_ptr_array_index(temp_range_set.mem_ranges, i);
-        aml_append(crs,
-                   aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
-                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
-                                    AML_READ_WRITE,
-                                    0, entry->base, entry->limit, 0,
-                                    entry->limit - entry->base + 1));
-        crs_range_insert(range_set->mem_ranges, entry->base, entry->limi=
t);
-    }
-
-    crs_range_merge(temp_range_set.mem_64bit_ranges);
-    for (i =3D 0; i < temp_range_set.mem_64bit_ranges->len; i++) {
-        entry =3D g_ptr_array_index(temp_range_set.mem_64bit_ranges, i);
-        aml_append(crs,
-                   aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
-                                    AML_MAX_FIXED, AML_NON_CACHEABLE,
-                                    AML_READ_WRITE,
-                                    0, entry->base, entry->limit, 0,
-                                    entry->limit - entry->base + 1));
-        crs_range_insert(range_set->mem_64bit_ranges,
-                         entry->base, entry->limit);
-    }
-
-    crs_range_set_free(&temp_range_set);
-
-    aml_append(crs,
-        aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED, AML_POS_DECODE=
,
-                            0,
-                            pci_bus_num(host->bus),
-                            max_bus,
-                            0,
-                            max_bus - pci_bus_num(host->bus) + 1));
-
-    return crs;
-}
-
 static void build_hpet_aml(Aml *table)
 {
     Aml *crs;
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index de4a406568..2894825ffb 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -223,6 +223,20 @@ struct AcpiBuildTables {
     BIOSLinker *linker;
 } AcpiBuildTables;
=20
+typedef
+struct CrsRangeEntry {
+    uint64_t base;
+    uint64_t limit;
+} CrsRangeEntry;
+
+typedef
+struct CrsRangeSet {
+    GPtrArray *io_ranges;
+    GPtrArray *mem_ranges;
+    GPtrArray *mem_64bit_ranges;
+} CrsRangeSet;
+
+
 /*
  * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
  * Serial Bus Type
@@ -429,6 +443,17 @@ build_append_gas_from_struct(GArray *table, const st=
ruct AcpiGenericAddress *s)
                      s->access_width, s->address);
 }
=20
+Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set);
+
+void crs_range_insert(GPtrArray *ranges, uint64_t base, uint64_t limit);
+
+void crs_replace_with_free_ranges(GPtrArray *ranges,
+                                         uint64_t start, uint64_t end);
+
+void crs_range_set_init(CrsRangeSet *range_set);
+
+void crs_range_set_free(CrsRangeSet *range_set);
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags=
);
=20
--=20
2.19.1



