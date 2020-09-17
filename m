Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267D6C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8309420708
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 14:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNwkaUqu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8309420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIui1-0004Nx-DC
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 10:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuMW-0000Rn-98
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kIuME-00086u-Rp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 09:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600350832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1NCgt4l64gt68xjIJWkKuSXQKSC44wW0nyYcU64st4=;
 b=iNwkaUquwi19sLWVJIWzRvQQYLZyRQUphjrtP9nAT8fgfgH5rGuu9pIMa7a+yE4zVCEmGl
 qBG92wDf84pMMdwuo7ATL3RNXfoypiIKsgrwXoRfueeSAiGvQ0kcp59x3MAWUlzpANumbO
 O8ZXh9zlVoA+uyMm2Q+xKIQjD+rHp3M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-LPnEItxFO7yAJw24sIKDJw-1; Thu, 17 Sep 2020 09:53:47 -0400
X-MC-Unique: LPnEItxFO7yAJw24sIKDJw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83CDA1084C93;
 Thu, 17 Sep 2020 13:53:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9806D73662;
 Thu, 17 Sep 2020 13:53:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EC13D1FCF5; Thu, 17 Sep 2020 15:53:23 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] microvm/acpi: add minimal acpi support
Date: Thu, 17 Sep 2020 15:53:10 +0200
Message-Id: <20200917135323.18022-9-kraxel@redhat.com>
In-Reply-To: <20200917135323.18022-1-kraxel@redhat.com>
References: <20200917135323.18022-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

$subject says all.  Can be controlled using -M microvm,acpi=on/off.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20200915120909.20838-9-kraxel@redhat.com
---
 hw/i386/acpi-microvm.h    |   8 ++
 include/hw/i386/microvm.h |   9 ++
 hw/i386/acpi-microvm.c    | 187 ++++++++++++++++++++++++++++++++++++++
 hw/i386/microvm.c         |  40 ++++++++
 hw/i386/Kconfig           |   1 +
 hw/i386/meson.build       |   2 +-
 6 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 hw/i386/acpi-microvm.h
 create mode 100644 hw/i386/acpi-microvm.c

diff --git a/hw/i386/acpi-microvm.h b/hw/i386/acpi-microvm.h
new file mode 100644
index 000000000000..dfe853690e15
--- /dev/null
+++ b/hw/i386/acpi-microvm.h
@@ -0,0 +1,8 @@
+#ifndef HW_I386_ACPI_MICROVM_H
+#define HW_I386_ACPI_MICROVM_H
+
+#include "hw/i386/microvm.h"
+
+void acpi_setup_microvm(MicrovmMachineState *mms);
+
+#endif
diff --git a/include/hw/i386/microvm.h b/include/hw/i386/microvm.h
index 87593694eb0e..d75dcf8203b7 100644
--- a/include/hw/i386/microvm.h
+++ b/include/hw/i386/microvm.h
@@ -24,6 +24,7 @@
 
 #include "hw/boards.h"
 #include "hw/i386/x86.h"
+#include "hw/acpi/acpi_dev_interface.h"
 #include "qom/object.h"
 
 /* Platform virtio definitions */
@@ -31,6 +32,11 @@
 #define VIRTIO_NUM_TRANSPORTS 8
 #define VIRTIO_CMDLINE_MAXLEN 64
 
+#define GED_MMIO_BASE         0xfea00000
+#define GED_MMIO_BASE_MEMHP   (GED_MMIO_BASE + 0x100)
+#define GED_MMIO_BASE_REGS    (GED_MMIO_BASE + 0x200)
+#define GED_MMIO_IRQ          9
+
 /* Machine type options */
 #define MICROVM_MACHINE_PIT                 "pit"
 #define MICROVM_MACHINE_PIC                 "pic"
@@ -60,6 +66,9 @@ struct MicrovmMachineState {
     /* Machine state */
     uint32_t virtio_irq_base;
     bool kernel_cmdline_fixed;
+    Notifier machine_done;
+    Notifier powerdown_req;
+    AcpiDeviceIf *acpi_dev;
 };
 typedef struct MicrovmMachineState MicrovmMachineState;
 
diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
new file mode 100644
index 000000000000..06ef33949f5f
--- /dev/null
+++ b/hw/i386/acpi-microvm.c
@@ -0,0 +1,187 @@
+/* Support for generating ACPI tables and passing them to Guests
+ *
+ * Copyright (C) 2008-2010  Kevin O'Connor <kevin@koconnor.net>
+ * Copyright (C) 2006 Fabrice Bellard
+ * Copyright (C) 2013 Red Hat Inc
+ *
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
+#include "qapi/error.h"
+
+#include "exec/memory.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/generic_event_device.h"
+#include "hw/acpi/utils.h"
+#include "hw/boards.h"
+#include "hw/i386/fw_cfg.h"
+#include "hw/i386/microvm.h"
+
+#include "acpi-common.h"
+#include "acpi-microvm.h"
+
+static void
+build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
+                   MicrovmMachineState *mms)
+{
+    X86MachineState *x86ms = X86_MACHINE(mms);
+    Aml *dsdt, *sb_scope, *scope, *pkg;
+    bool ambiguous;
+    Object *isabus;
+
+    isabus = object_resolve_path_type("", TYPE_ISA_BUS, &ambiguous);
+    assert(isabus);
+    assert(!ambiguous);
+
+    dsdt = init_aml_allocator();
+
+    /* Reserve space for header */
+    acpi_data_push(dsdt->buf, sizeof(AcpiTableHeader));
+
+    sb_scope = aml_scope("_SB");
+    fw_cfg_add_acpi_dsdt(sb_scope, x86ms->fw_cfg);
+    isa_build_aml(ISA_BUS(isabus), sb_scope);
+    build_ged_aml(sb_scope, GED_DEVICE, HOTPLUG_HANDLER(mms->acpi_dev),
+                  GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
+    acpi_dsdt_add_power_button(sb_scope);
+    aml_append(dsdt, sb_scope);
+
+    /* ACPI 5.0: Table 7-209 System State Package */
+    scope = aml_scope("\\");
+    pkg = aml_package(4);
+    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
+    aml_append(pkg, aml_int(0)); /* ignored */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(scope, aml_name_decl("_S5", pkg));
+    aml_append(dsdt, scope);
+
+    /* copy AML table into ACPI tables blob and patch header there */
+    g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
+    build_header(linker, table_data,
+        (void *)(table_data->data + table_data->len - dsdt->buf->len),
+        "DSDT", dsdt->buf->len, 2, NULL, NULL);
+    free_aml_allocator();
+}
+
+static void acpi_build_microvm(AcpiBuildTables *tables,
+                               MicrovmMachineState *mms)
+{
+    MachineState *machine = MACHINE(mms);
+    GArray *table_offsets;
+    GArray *tables_blob = tables->table_data;
+    unsigned dsdt, xsdt;
+    AcpiFadtData pmfadt = {
+        /* ACPI 5.0: 4.1 Hardware-Reduced ACPI */
+        .rev = 5,
+        .flags = ((1 << ACPI_FADT_F_HW_REDUCED_ACPI) |
+                  (1 << ACPI_FADT_F_RESET_REG_SUP)),
+
+        /* ACPI 5.0: 4.8.3.7 Sleep Control and Status Registers */
+        .sleep_ctl = {
+            .space_id = AML_AS_SYSTEM_MEMORY,
+            .bit_width = 8,
+            .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_SLEEP_CTL,
+        },
+        .sleep_sts = {
+            .space_id = AML_AS_SYSTEM_MEMORY,
+            .bit_width = 8,
+            .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_SLEEP_STS,
+        },
+
+        /* ACPI 5.0: 4.8.3.6 Reset Register */
+        .reset_reg = {
+            .space_id = AML_AS_SYSTEM_MEMORY,
+            .bit_width = 8,
+            .address = GED_MMIO_BASE_REGS + ACPI_GED_REG_RESET,
+        },
+        .reset_val = ACPI_GED_RESET_VALUE,
+    };
+
+    table_offsets = g_array_new(false, true /* clear */,
+                                        sizeof(uint32_t));
+    bios_linker_loader_alloc(tables->linker,
+                             ACPI_BUILD_TABLE_FILE, tables_blob,
+                             64 /* Ensure FACS is aligned */,
+                             false /* high memory */);
+
+    dsdt = tables_blob->len;
+    build_dsdt_microvm(tables_blob, tables->linker, mms);
+
+    pmfadt.dsdt_tbl_offset = &dsdt;
+    pmfadt.xdsdt_tbl_offset = &dsdt;
+    acpi_add_table(table_offsets, tables_blob);
+    build_fadt(tables_blob, tables->linker, &pmfadt, NULL, NULL);
+
+    acpi_add_table(table_offsets, tables_blob);
+    acpi_build_madt(tables_blob, tables->linker, X86_MACHINE(machine),
+                    mms->acpi_dev, false);
+
+    xsdt = tables_blob->len;
+    build_xsdt(tables_blob, tables->linker, table_offsets, NULL, NULL);
+
+    /* RSDP is in FSEG memory, so allocate it separately */
+    {
+        AcpiRsdpData rsdp_data = {
+            /* ACPI 2.0: 5.2.4.3 RSDP Structure */
+            .revision = 2, /* xsdt needs v2 */
+            .oem_id = ACPI_BUILD_APPNAME6,
+            .xsdt_tbl_offset = &xsdt,
+            .rsdt_tbl_offset = NULL,
+        };
+        build_rsdp(tables->rsdp, tables->linker, &rsdp_data);
+    }
+
+    /* Cleanup memory that's no longer used. */
+    g_array_free(table_offsets, true);
+}
+
+static void acpi_build_no_update(void *build_opaque)
+{
+    /* nothing, microvm tables don't change at runtime */
+}
+
+void acpi_setup_microvm(MicrovmMachineState *mms)
+{
+    X86MachineState *x86ms = X86_MACHINE(mms);
+    AcpiBuildTables tables;
+
+    assert(x86ms->fw_cfg);
+
+    if (!x86_machine_is_acpi_enabled(x86ms)) {
+        return;
+    }
+
+    acpi_build_tables_init(&tables);
+    acpi_build_microvm(&tables, mms);
+
+    /* Now expose it all to Guest */
+    acpi_add_rom_blob(acpi_build_no_update, NULL,
+                      tables.table_data,
+                      ACPI_BUILD_TABLE_FILE,
+                      ACPI_BUILD_TABLE_MAX_SIZE);
+    acpi_add_rom_blob(acpi_build_no_update, NULL,
+                      tables.linker->cmd_blob,
+                      "etc/table-loader", 0);
+    acpi_add_rom_blob(acpi_build_no_update, NULL,
+                      tables.rsdp,
+                      ACPI_BUILD_RSDP_FILE, 0);
+
+    acpi_build_tables_cleanup(&tables, false);
+}
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index e4501f2cdfbd..e1b86da8a92e 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -26,6 +26,8 @@
 #include "sysemu/cpus.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
+#include "acpi-microvm.h"
 
 #include "hw/loader.h"
 #include "hw/irq.h"
@@ -41,6 +43,8 @@
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/virtio/virtio-mmio.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/generic_event_device.h"
 
 #include "cpu.h"
 #include "elf.h"
@@ -129,6 +133,17 @@ static void microvm_devices_init(MicrovmMachineState *mms)
     }
 
     /* Optional and legacy devices */
+    if (x86_machine_is_acpi_enabled(x86ms)) {
+        DeviceState *dev = qdev_new(TYPE_ACPI_GED_X86);
+        qdev_prop_set_uint32(dev, "ged-event", ACPI_GED_PWR_DOWN_EVT);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, GED_MMIO_BASE);
+        /* sysbus_mmio_map(SYS_BUS_DEVICE(dev), 1, GED_MMIO_BASE_MEMHP); */
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, GED_MMIO_BASE_REGS);
+        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           x86ms->gsi[GED_MMIO_IRQ]);
+        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
+        mms->acpi_dev = ACPI_DEVICE_IF(dev);
+    }
 
     if (mms->pic == ON_OFF_AUTO_ON || mms->pic == ON_OFF_AUTO_AUTO) {
         qemu_irq *i8259;
@@ -438,6 +453,26 @@ static void microvm_machine_set_auto_kernel_cmdline(Object *obj, bool value,
     mms->auto_kernel_cmdline = value;
 }
 
+static void microvm_machine_done(Notifier *notifier, void *data)
+{
+    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
+                                            machine_done);
+
+    acpi_setup_microvm(mms);
+}
+
+static void microvm_powerdown_req(Notifier *notifier, void *data)
+{
+    MicrovmMachineState *mms = container_of(notifier, MicrovmMachineState,
+                                            powerdown_req);
+
+    if (mms->acpi_dev) {
+        Object *obj = OBJECT(mms->acpi_dev);
+        AcpiDeviceIfClass *adevc = ACPI_DEVICE_IF_GET_CLASS(obj);
+        adevc->send_event(mms->acpi_dev, ACPI_POWER_DOWN_STATUS);
+    }
+}
+
 static void microvm_machine_initfn(Object *obj)
 {
     MicrovmMachineState *mms = MICROVM_MACHINE(obj);
@@ -452,6 +487,11 @@ static void microvm_machine_initfn(Object *obj)
 
     /* State */
     mms->kernel_cmdline_fixed = false;
+
+    mms->machine_done.notify = microvm_machine_done;
+    qemu_add_machine_init_done_notifier(&mms->machine_done);
+    mms->powerdown_req.notify = microvm_powerdown_req;
+    qemu_register_powerdown_notifier(&mms->powerdown_req);
 }
 
 static void microvm_class_init(ObjectClass *oc, void *data)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 03e347b2078f..d0bd8b537d55 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -103,6 +103,7 @@ config MICROVM
     select I8259
     select MC146818RTC
     select VIRTIO_MMIO
+    select ACPI_HW_REDUCED
 
 config X86_IOMMU
     bool
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 1a7d1a685d77..e5d109f5c64d 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -11,7 +11,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
                                       if_false: files('x86-iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
-i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c'))
+i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c', 'acpi-microvm.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
 i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
 i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
-- 
2.27.0


