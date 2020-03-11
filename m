Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA18C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0394320736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0394320736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC56D-0004Pe-Ht
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC550-0001p3-PB
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC54z-0003bD-5j
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:23:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3197 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1jC54v-0003Tj-U4; Wed, 11 Mar 2020 13:23:34 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 907E0EED1A18A9D8ED9C;
 Thu, 12 Mar 2020 01:23:29 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Mar 2020 01:23:21 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH v3 02/10] fw_cfg: Migrate ACPI table mr sizes separately
Date: Wed, 11 Mar 2020 17:20:06 +0000
Message-ID: <20200311172014.33052-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
References: <20200311172014.33052-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
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
Cc: peter.maydell@linaro.org, xiaoguangrong.eric@gmail.com, david@redhat.com,
 mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 shannon.zhaosl@gmail.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Any sub-page size update to ACPI table MRs will be lost during
migration, as we use aligned size in ram_load_precopy() ->
qemu_ram_resize() path. This will result in inconsistency in sizes
between source and destination. In order to avoid this, save and
restore them separately during migration.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
Please find the discussion here,
https://patchwork.kernel.org/patch/11339591/
---
 hw/core/machine.c         |  1 +
 hw/nvram/fw_cfg.c         | 86 ++++++++++++++++++++++++++++++++++++++-
 include/hw/nvram/fw_cfg.h |  6 +++
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9e8c06036f..6d960bd47f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,7 @@ GlobalProperty hw_compat_4_2[] = {
     { "usb-redir", "suppress-remote-wake", "off" },
     { "qxl", "revision", "4" },
     { "qxl-vga", "revision", "4" },
+    { "fw_cfg", "acpi-mr-restore", "false" },
 };
 const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
 
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 179b302f01..36d1e32f83 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -39,6 +39,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "hw/acpi/aml-build.h"
 
 #define FW_CFG_FILE_SLOTS_DFLT 0x20
 
@@ -610,6 +611,50 @@ bool fw_cfg_dma_enabled(void *opaque)
     return s->dma_enabled;
 }
 
+static bool fw_cfg_acpi_mr_restore(void *opaque)
+{
+    FWCfgState *s = opaque;
+    return s->acpi_mr_restore;
+}
+
+static void fw_cfg_update_mr(FWCfgState *s, uint16_t key, size_t size)
+{
+    MemoryRegion *mr;
+    ram_addr_t offset;
+    int arch = !!(key & FW_CFG_ARCH_LOCAL);
+    void *ptr;
+
+    key &= FW_CFG_ENTRY_MASK;
+    assert(key < fw_cfg_max_entry(s));
+
+    ptr = s->entries[arch][key].data;
+    mr = memory_region_from_host(ptr, &offset);
+
+    memory_region_ram_resize(mr, size, &error_abort);
+}
+
+static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
+{
+    FWCfgState *s = opaque;
+    int i, index;
+
+    assert(s->files);
+
+    index = be32_to_cpu(s->files->count);
+
+    for (i = 0; i < index; i++) {
+        if (!strcmp(s->files->f[i].name, ACPI_BUILD_TABLE_FILE)) {
+            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->table_mr_size);
+        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_LOADER_FILE)) {
+            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->linker_mr_size);
+        } else if (!strcmp(s->files->f[i].name, ACPI_BUILD_RSDP_FILE)) {
+            fw_cfg_update_mr(s, FW_CFG_FILE_FIRST + i, s->rsdp_mr_size);
+        }
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_fw_cfg_dma = {
     .name = "fw_cfg/dma",
     .needed = fw_cfg_dma_enabled,
@@ -619,6 +664,20 @@ static const VMStateDescription vmstate_fw_cfg_dma = {
     },
 };
 
+static const VMStateDescription vmstate_fw_cfg_acpi_mr = {
+    .name = "fw_cfg/acpi_mr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = fw_cfg_acpi_mr_restore,
+    .post_load = fw_cfg_acpi_mr_restore_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(table_mr_size, FWCfgState),
+        VMSTATE_UINT64(linker_mr_size, FWCfgState),
+        VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_fw_cfg = {
     .name = "fw_cfg",
     .version_id = 2,
@@ -631,6 +690,7 @@ static const VMStateDescription vmstate_fw_cfg = {
     },
     .subsections = (const VMStateDescription*[]) {
         &vmstate_fw_cfg_dma,
+        &vmstate_fw_cfg_acpi_mr,
         NULL,
     }
 };
@@ -815,6 +875,23 @@ static struct {
 #define FW_CFG_ORDER_OVERRIDE_LAST 200
 };
 
+/*
+ * Any sub-page size update to these table MRs will be lost during migration,
+ * as we use aligned size in ram_load_precopy() -> qemu_ram_resize() path.
+ * In order to avoid the inconsistency in sizes save them seperately and
+ * migrate over in vmstate post_load().
+ */
+static void fw_cfg_acpi_mr_save(FWCfgState *s, const char *filename, size_t len)
+{
+    if (!strcmp(filename, ACPI_BUILD_TABLE_FILE)) {
+        s->table_mr_size = len;
+    } else if (!strcmp(filename, ACPI_BUILD_LOADER_FILE)) {
+        s->linker_mr_size = len;
+    } else if (!strcmp(filename, ACPI_BUILD_RSDP_FILE)) {
+        s->rsdp_mr_size = len;
+    }
+}
+
 static int get_fw_cfg_order(FWCfgState *s, const char *name)
 {
     int i;
@@ -914,6 +991,7 @@ void fw_cfg_add_file_callback(FWCfgState *s,  const char *filename,
     trace_fw_cfg_add_file(s, index, s->files->f[index].name, len);
 
     s->files->count = cpu_to_be32(count+1);
+    fw_cfg_acpi_mr_save(s, filename, len);
 }
 
 void fw_cfg_add_file(FWCfgState *s,  const char *filename,
@@ -937,6 +1015,7 @@ void *fw_cfg_modify_file(FWCfgState *s, const char *filename,
             ptr = fw_cfg_modify_bytes_read(s, FW_CFG_FILE_FIRST + i,
                                            data, len);
             s->files->f[i].size   = cpu_to_be32(len);
+            fw_cfg_acpi_mr_save(s, filename, len);
             return ptr;
         }
     }
@@ -973,7 +1052,10 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
     qemu_register_reset(fw_cfg_machine_reset, s);
 }
 
-
+static Property fw_cfg_properties[] = {
+    DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
 
 static void fw_cfg_common_realize(DeviceState *dev, Error **errp)
 {
@@ -1097,6 +1179,8 @@ static void fw_cfg_class_init(ObjectClass *klass, void *data)
 
     dc->reset = fw_cfg_reset;
     dc->vmsd = &vmstate_fw_cfg;
+
+    device_class_set_props(dc, fw_cfg_properties);
 }
 
 static const TypeInfo fw_cfg_info = {
diff --git a/include/hw/nvram/fw_cfg.h b/include/hw/nvram/fw_cfg.h
index b5291eefad..457fee7425 100644
--- a/include/hw/nvram/fw_cfg.h
+++ b/include/hw/nvram/fw_cfg.h
@@ -53,6 +53,12 @@ struct FWCfgState {
     dma_addr_t dma_addr;
     AddressSpace *dma_as;
     MemoryRegion dma_iomem;
+
+    /* restore during migration */
+    bool acpi_mr_restore;
+    size_t table_mr_size;
+    size_t linker_mr_size;
+    size_t rsdp_mr_size;
 };
 
 struct FWCfgIoState {
-- 
2.17.1



