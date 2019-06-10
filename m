Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1FCC28EBD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 01:20:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29959207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 01:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29959207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ha8zM-0006qM-0O
	for qemu-devel@archiver.kernel.org; Sun, 09 Jun 2019 21:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45981)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ha8xs-0005p9-9F
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 21:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richardw.yang@linux.intel.com>) id 1ha8xq-0005RP-Of
 for qemu-devel@nongnu.org; Sun, 09 Jun 2019 21:19:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:18537)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
 id 1ha8xl-0005OX-41; Sun, 09 Jun 2019 21:19:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Jun 2019 18:19:02 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
 by orsmga007.jf.intel.com with ESMTP; 09 Jun 2019 18:19:00 -0700
From: Wei Yang <richardw.yang@linux.intel.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Mon, 10 Jun 2019 09:18:30 +0800
Message-Id: <20190610011830.28398-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.126
Subject: [Qemu-devel] [PATCH v7] hw/acpi: extract acpi_add_rom_blob()
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
Cc: yang.zhong@intel.com, peter.maydell@linaro.org, mst@redhat.com,
 shannon.zhaosl@gmail.com, Wei Yang <richardw.yang@linux.intel.com>,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

arm and i386 has almost the same function acpi_add_rom_blob(), except
giving different FWCfgCallback function.

This patch moves acpi_add_rom_blob() to utils.c by passing
FWCfgCallback to it.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

v7:
  * rebase on top of current master because of conflict
v6:
  * change author from Igor to Michael
v5:
  * remove unnecessary header glib/gprintf.h
  * rearrange include header to make it more suitable
v4:
  * extract -> moves
  * adjust comment in source to make checkpatch happy
v3:
  * put acpi_add_rom_blob() to hw/acpi/utils.c
v2:
  * remove unused header in original source file
---
 hw/acpi/Makefile.objs    |  2 +-
 hw/acpi/utils.c          | 35 +++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c | 26 ++++++++++----------------
 hw/i386/acpi-build.c     | 26 ++++++++++----------------
 include/hw/acpi/utils.h  |  9 +++++++++
 5 files changed, 65 insertions(+), 33 deletions(-)
 create mode 100644 hw/acpi/utils.c
 create mode 100644 include/hw/acpi/utils.h

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 661a9b8c2f..9bb2101e3b 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -10,7 +10,7 @@ common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
 common-obj-y += bios-linker-loader.o
-common-obj-y += aml-build.o
+common-obj-y += aml-build.o utils.o
 common-obj-$(CONFIG_ACPI_PCI) += pci.o
 common-obj-$(CONFIG_TPM) += tpm.o
 
diff --git a/hw/acpi/utils.c b/hw/acpi/utils.c
new file mode 100644
index 0000000000..a134a4d554
--- /dev/null
+++ b/hw/acpi/utils.c
@@ -0,0 +1,35 @@
+/*
+ * Utilities for generating ACPI tables and passing them to Guests
+ *
+ * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019 Red Hat Inc
+ *
+ * Author: Wei Yang <richardw.yang@linux.intel.com>
+ * Author: Michael S. Tsirkin <mst@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/utils.h"
+#include "hw/loader.h"
+
+MemoryRegion *acpi_add_rom_blob(FWCfgCallback update, void *opaque,
+                                GArray *blob, const char *name,
+                                uint64_t max_size)
+{
+    return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
+                        name, update, opaque, NULL, true);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 4a64f9985c..e3353de9e4 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -37,9 +37,9 @@
 #include "hw/acpi/acpi.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/loader.h"
 #include "hw/hw.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/pci/pcie_host.h"
 #include "hw/pci/pci.h"
@@ -866,14 +866,6 @@ static void virt_acpi_build_reset(void *build_opaque)
     build_state->patched = false;
 }
 
-static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
-                                       GArray *blob, const char *name,
-                                       uint64_t max_size)
-{
-    return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
-                        name, virt_acpi_build_update, build_state, NULL, true);
-}
-
 static const VMStateDescription vmstate_virt_acpi_build = {
     .name = "virt_acpi_build",
     .version_id = 1,
@@ -905,20 +897,22 @@ void virt_acpi_setup(VirtMachineState *vms)
     virt_acpi_build(vms, &tables);
 
     /* Now expose it all to Guest */
-    build_state->table_mr = acpi_add_rom_blob(build_state, tables.table_data,
-                                               ACPI_BUILD_TABLE_FILE,
-                                               ACPI_BUILD_TABLE_MAX_SIZE);
+    build_state->table_mr = acpi_add_rom_blob(virt_acpi_build_update,
+                                              build_state, tables.table_data,
+                                              ACPI_BUILD_TABLE_FILE,
+                                              ACPI_BUILD_TABLE_MAX_SIZE);
     assert(build_state->table_mr != NULL);
 
     build_state->linker_mr =
-        acpi_add_rom_blob(build_state, tables.linker->cmd_blob,
-                          "etc/table-loader", 0);
+        acpi_add_rom_blob(virt_acpi_build_update, build_state,
+                          tables.linker->cmd_blob, "etc/table-loader", 0);
 
     fw_cfg_add_file(vms->fw_cfg, ACPI_BUILD_TPMLOG_FILE, tables.tcpalog->data,
                     acpi_data_len(tables.tcpalog));
 
-    build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
-                                              ACPI_BUILD_RSDP_FILE, 0);
+    build_state->rsdp_mr = acpi_add_rom_blob(virt_acpi_build_update,
+                                             build_state, tables.rsdp,
+                                             ACPI_BUILD_RSDP_FILE, 0);
 
     qemu_register_reset(virt_acpi_build_reset, build_state);
     virt_acpi_build_reset(build_state);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 85dc1640bc..5fdf7e2da7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -38,7 +38,6 @@
 #include "hw/acpi/piix4.h"
 #include "hw/nvram/fw_cfg.h"
 #include "hw/acpi/bios-linker-loader.h"
-#include "hw/loader.h"
 #include "hw/isa/isa.h"
 #include "hw/block/fdc.h"
 #include "hw/acpi/memory_hotplug.h"
@@ -59,6 +58,7 @@
 #include "hw/i386/x86-iommu.h"
 
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 
 #include "qom/qom-qobject.h"
@@ -2824,14 +2824,6 @@ static void acpi_build_reset(void *build_opaque)
     build_state->patched = 0;
 }
 
-static MemoryRegion *acpi_add_rom_blob(AcpiBuildState *build_state,
-                                       GArray *blob, const char *name,
-                                       uint64_t max_size)
-{
-    return rom_add_blob(name, blob->data, acpi_data_len(blob), max_size, -1,
-                        name, acpi_build_update, build_state, NULL, true);
-}
-
 static const VMStateDescription vmstate_acpi_build = {
     .name = "acpi_build",
     .version_id = 1,
@@ -2873,14 +2865,15 @@ void acpi_setup(void)
     acpi_build(&tables, MACHINE(pcms));
 
     /* Now expose it all to Guest */
-    build_state->table_mr = acpi_add_rom_blob(build_state, tables.table_data,
-                                               ACPI_BUILD_TABLE_FILE,
-                                               ACPI_BUILD_TABLE_MAX_SIZE);
+    build_state->table_mr = acpi_add_rom_blob(acpi_build_update,
+                                              build_state, tables.table_data,
+                                              ACPI_BUILD_TABLE_FILE,
+                                              ACPI_BUILD_TABLE_MAX_SIZE);
     assert(build_state->table_mr != NULL);
 
     build_state->linker_mr =
-        acpi_add_rom_blob(build_state, tables.linker->cmd_blob,
-                          "etc/table-loader", 0);
+        acpi_add_rom_blob(acpi_build_update, build_state,
+                          tables.linker->cmd_blob, "etc/table-loader", 0);
 
     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
@@ -2917,8 +2910,9 @@ void acpi_setup(void)
         build_state->rsdp_mr = NULL;
     } else {
         build_state->rsdp = NULL;
-        build_state->rsdp_mr = acpi_add_rom_blob(build_state, tables.rsdp,
-                                                  ACPI_BUILD_RSDP_FILE, 0);
+        build_state->rsdp_mr = acpi_add_rom_blob(acpi_build_update,
+                                                 build_state, tables.rsdp,
+                                                 ACPI_BUILD_RSDP_FILE, 0);
     }
 
     qemu_register_reset(acpi_build_reset, build_state);
diff --git a/include/hw/acpi/utils.h b/include/hw/acpi/utils.h
new file mode 100644
index 0000000000..140b4de603
--- /dev/null
+++ b/include/hw/acpi/utils.h
@@ -0,0 +1,9 @@
+#ifndef HW_ACPI_UTILS_H
+#define HW_ACPI_UTILS_H
+
+#include "hw/nvram/fw_cfg.h"
+
+MemoryRegion *acpi_add_rom_blob(FWCfgCallback update, void *opaque,
+                                GArray *blob, const char *name,
+                                uint64_t max_size);
+#endif
-- 
2.19.1


