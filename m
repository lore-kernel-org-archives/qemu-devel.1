Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E59C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7838320873
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 16:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7838320873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGQCG-0001oR-Qa
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 12:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuc-0006MM-C3
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPua-0000dL-AD
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:54:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44630 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1iGPuO-0000QM-94; Fri, 04 Oct 2019 11:54:21 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B36C77D93F924710ECAC;
 Fri,  4 Oct 2019 23:54:12 +0800 (CST)
Received: from S00345302A-PC.china.huawei.com (10.202.227.237) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Fri, 4 Oct 2019 23:54:05 +0800
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <eric.auger@redhat.com>,
 <imammedo@redhat.com>
Subject: [PATCH 2/5] nvdimm: Use configurable ACPI IO base and size
Date: Fri, 4 Oct 2019 16:52:59 +0100
Message-ID: <20191004155302.4632-3-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: peter.maydell@linaro.org, lersek@redhat.com, linuxarm@huawei.com,
 xuwei5@hisilicon.com, shannon.zhaosl@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Kwangwoo Lee <kwangwoo.lee@sk.com>

This patch makes IO base and size configurable to create NPIO AML for
ACPI NFIT. Since a different architecture like AArch64 does not use
port-mapped IO, a configurable IO base is required to create correct
mapping of ACPI IO address and size.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@sk.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 hw/acpi/nvdimm.c        | 32 ++++++++++++++++++++++----------
 hw/i386/acpi-build.c    |  6 ++++++
 hw/i386/acpi-build.h    |  3 +++
 hw/i386/pc_piix.c       |  2 ++
 hw/i386/pc_q35.c        |  2 ++
 include/hw/mem/nvdimm.h |  3 +++
 6 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..f91eea3802 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -926,11 +926,13 @@ void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
 }
 
 void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
+                            struct AcpiGenericAddress dsm_io,
                             FWCfgState *fw_cfg, Object *owner)
 {
+    state->dsm_io = dsm_io;
     memory_region_init_io(&state->io_mr, owner, &nvdimm_dsm_ops, state,
-                          "nvdimm-acpi-io", NVDIMM_ACPI_IO_LEN);
-    memory_region_add_subregion(io, NVDIMM_ACPI_IO_BASE, &state->io_mr);
+                          "nvdimm-acpi-io", dsm_io.bit_width >> 3);
+    memory_region_add_subregion(io, dsm_io.address, &state->io_mr);
 
     state->dsm_mem = g_array_new(false, true /* clear */, 1);
     acpi_data_push(state->dsm_mem, sizeof(NvdimmDsmIn));
@@ -959,12 +961,14 @@ void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
 
 #define NVDIMM_QEMU_RSVD_UUID   "648B9CF2-CDA1-4312-8AD9-49C4AF32BD62"
 
-static void nvdimm_build_common_dsm(Aml *dev)
+static void nvdimm_build_common_dsm(Aml *dev,
+                                    NVDIMMState *nvdimm_state)
 {
     Aml *method, *ifctx, *function, *handle, *uuid, *dsm_mem, *elsectx2;
     Aml *elsectx, *unsupport, *unpatched, *expected_uuid, *uuid_invalid;
     Aml *pckg, *pckg_index, *pckg_buf, *field, *dsm_out_buf, *dsm_out_buf_size;
     uint8_t byte_list[1];
+    AmlRegionSpace rs;
 
     method = aml_method(NVDIMM_COMMON_DSM, 5, AML_SERIALIZED);
     uuid = aml_arg(0);
@@ -975,9 +979,16 @@ static void nvdimm_build_common_dsm(Aml *dev)
 
     aml_append(method, aml_store(aml_name(NVDIMM_ACPI_MEM_ADDR), dsm_mem));
 
+    if (nvdimm_state->dsm_io.space_id == AML_AS_SYSTEM_IO) {
+        rs = AML_SYSTEM_IO;
+    } else {
+        rs = AML_SYSTEM_MEMORY;
+    }
+
     /* map DSM memory and IO into ACPI namespace. */
-    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, AML_SYSTEM_IO,
-               aml_int(NVDIMM_ACPI_IO_BASE), NVDIMM_ACPI_IO_LEN));
+    aml_append(method, aml_operation_region(NVDIMM_DSM_IOPORT, rs,
+               aml_int(nvdimm_state->dsm_io.address),
+               nvdimm_state->dsm_io.bit_width >> 3));
     aml_append(method, aml_operation_region(NVDIMM_DSM_MEMORY,
                AML_SYSTEM_MEMORY, dsm_mem, sizeof(NvdimmDsmIn)));
 
@@ -992,7 +1003,7 @@ static void nvdimm_build_common_dsm(Aml *dev)
     field = aml_field(NVDIMM_DSM_IOPORT, AML_DWORD_ACC, AML_NOLOCK,
                       AML_PRESERVE);
     aml_append(field, aml_named_field(NVDIMM_DSM_NOTIFY,
-               NVDIMM_ACPI_IO_LEN * BITS_PER_BYTE));
+              (nvdimm_state->dsm_io.bit_width >> 3) * BITS_PER_BYTE));
     aml_append(method, field);
 
     /*
@@ -1260,7 +1271,8 @@ static void nvdimm_build_nvdimm_devices(Aml *root_dev, uint32_t ram_slots)
 }
 
 static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
-                              BIOSLinker *linker, GArray *dsm_dma_area,
+                              BIOSLinker *linker,
+                              NVDIMMState *nvdimm_state,
                               uint32_t ram_slots)
 {
     Aml *ssdt, *sb_scope, *dev;
@@ -1288,7 +1300,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
      */
     aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0012")));
 
-    nvdimm_build_common_dsm(dev);
+    nvdimm_build_common_dsm(dev, nvdimm_state);
 
     /* 0 is reserved for root device. */
     nvdimm_build_device_dsm(dev, 0);
@@ -1307,7 +1319,7 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
                                                NVDIMM_ACPI_MEM_ADDR);
 
     bios_linker_loader_alloc(linker,
-                             NVDIMM_DSM_MEM_FILE, dsm_dma_area,
+                             NVDIMM_DSM_MEM_FILE, nvdimm_state->dsm_mem,
                              sizeof(NvdimmDsmIn), false /* high memory */);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
@@ -1329,7 +1341,7 @@ void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
         return;
     }
 
-    nvdimm_build_ssdt(table_offsets, table_data, linker, state->dsm_mem,
+    nvdimm_build_ssdt(table_offsets, table_data, linker, state,
                       ram_slots);
 
     device_list = nvdimm_get_device_list();
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 1d077a7cb7..b5170912a8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -126,6 +126,12 @@ typedef struct FwCfgTPMConfig {
 
 static bool acpi_get_mcfg(AcpiMcfgInfo *mcfg);
 
+const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio = {
+    .space_id = AML_AS_SYSTEM_IO,
+    .address = NVDIMM_ACPI_IO_BASE,
+    .bit_width = NVDIMM_ACPI_IO_LEN << 3
+};
+
 static void init_common_fadt_data(MachineState *ms, Object *o,
                                   AcpiFadtData *data)
 {
diff --git a/hw/i386/acpi-build.h b/hw/i386/acpi-build.h
index 007332e51c..74df5fc612 100644
--- a/hw/i386/acpi-build.h
+++ b/hw/i386/acpi-build.h
@@ -1,6 +1,9 @@
 
 #ifndef HW_I386_ACPI_BUILD_H
 #define HW_I386_ACPI_BUILD_H
+#include "hw/acpi/acpi-defs.h"
+
+extern const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio;
 
 void acpi_setup(void);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6824b72124..78521cf017 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -58,6 +58,7 @@
 #include "migration/misc.h"
 #include "kvm_i386.h"
 #include "sysemu/numa.h"
+#include "hw/i386/acpi-build.h"
 
 #define MAX_IDE_BUS 2
 
@@ -303,6 +304,7 @@ else {
 
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8fad20f314..d53ee8de84 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -53,6 +53,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "sysemu/numa.h"
+#include "hw/i386/acpi-build.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
@@ -330,6 +331,7 @@ static void pc_q35_init(MachineState *machine)
 
     if (machine->nvdimms_state->is_enabled) {
         nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
+                               x86_nvdimm_acpi_dsmio,
                                pcms->fw_cfg, OBJECT(pcms));
     }
 }
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 523a9b3d4a..5fe440861e 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -25,6 +25,7 @@
 
 #include "hw/mem/pc-dimm.h"
 #include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/aml-build.h"
 
 #define NVDIMM_DEBUG 0
 #define nvdimm_debug(fmt, ...)                                \
@@ -140,10 +141,12 @@ struct NVDIMMState {
      */
     int32_t persistence;
     char    *persistence_string;
+    struct AcpiGenericAddress dsm_io;
 };
 typedef struct NVDIMMState NVDIMMState;
 
 void nvdimm_init_acpi_state(NVDIMMState *state, MemoryRegion *io,
+                            struct AcpiGenericAddress dsm_io,
                             FWCfgState *fw_cfg, Object *owner);
 void nvdimm_build_acpi(GArray *table_offsets, GArray *table_data,
                        BIOSLinker *linker, NVDIMMState *state,
-- 
2.17.1



