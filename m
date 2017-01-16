Received: from eggs.gnu.org ([2001:4830:134:3::10]:56895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq5-0002UB-JF
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cTCq4-0007Hu-0B
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:09 -0500
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:33137)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cTCq3-0007Hf-O9
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:21:07 -0500
Received: by mail-pf0-x236.google.com with SMTP id y143so55498622pfb.0
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:21:07 -0800 (PST)
From: ben@skyportsystems.com
Date: Mon, 16 Jan 2017 11:20:55 -0800
Message-Id: <ac2ea4262e8e64d010b152493ce3a3e1cc85e225.1484594095.git.ben@skyportsystems.com>
In-Reply-To: <cover.1484593565.git.ben@skyportsystems.com>
References: <cover.1484593565.git.ben@skyportsystems.com>
In-Reply-To: <cover.1484594095.git.ben@skyportsystems.com>
References: <cover.1484594095.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v2 3/6] ACPI: Add Virtual Machine Generation ID
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This implements the VM Generation ID feature by passing a 128-bit
GUID to the guest via a fw_cfg blob.
Any time the GUID changes, and ACPI notify event is sent to the guest

The user interface is a simple device with one parameters:
 - guid (string, must be in UUID format
   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/acpi/Makefile.objs              |   1 +
 hw/acpi/vmgenid.c                  | 207 +++++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c               |   5 +
 hw/misc/Makefile.objs              |   1 +
 include/hw/acpi/vmgenid.h          |  24 +++++
 7 files changed, 240 insertions(+)
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 0b51360..b2bccf6 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -56,3 +56,4 @@ CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
+CONFIG_ACPI_VMGENID=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 7f89503..c6bd310 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -56,3 +56,4 @@ CONFIG_IOH3420=y
 CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
+CONFIG_ACPI_VMGENID=y
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 489e63b..7dc95cd 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o memory_hotplug_acpi_table.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
+common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
 common-obj-$(CONFIG_ACPI) += acpi_interface.o
 common-obj-$(CONFIG_ACPI) += bios-linker-loader.o
 common-obj-$(CONFIG_ACPI) += aml-build.o
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
new file mode 100644
index 0000000..596c8b7
--- /dev/null
+++ b/hw/acpi/vmgenid.c
@@ -0,0 +1,207 @@
+/*
+ *  Virtual Machine Generation ID Device
+ *
+ *  Copyright (C) 2016 Skyport Systems.
+ *
+ *  Authors: Ben Warren <ben@skyportsystems.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "qmp-commands.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/vmgenid.h"
+#include "hw/nvram/fw_cfg.h"
+#include "sysemu/sysemu.h"
+
+Object *find_vmgenid_dev(Error **errp)
+{
+    Object *obj = object_resolve_path_type("", VMGENID_DEVICE, NULL);
+    if (!obj) {
+        error_setg(errp, VMGENID_DEVICE " is not found");
+    }
+    return obj;
+}
+
+void vmgenid_build_acpi(GArray *table_offsets, GArray *table_data,
+        BIOSLinker *linker)
+{
+    Object *obj = find_vmgenid_dev(NULL);
+    if (!obj) {
+        return;
+    }
+    VmGenIdState *s = VMGENID(obj);
+
+    acpi_add_table(table_offsets, table_data);
+
+    GArray *guid = g_array_new(false, true, sizeof(s->guid.data));
+    g_array_append_val(guid, s->guid.data);
+
+    Aml *ssdt, *dev, *scope, *pkg, *method;
+
+    /* Put this in a separate SSDT table */
+    ssdt = init_aml_allocator();
+
+    /* Reserve space for header */
+    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
+
+    /* Storage for the GUID address */
+    uint32_t vgia_offset = table_data->len +
+        build_append_named_qword(ssdt->buf, "VGIA");
+    dev = aml_device("VGEN");
+    scope = aml_scope("\\_SB");
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("VM_Gen_Counter")));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VM_Gen_Counter")));
+
+    /* Simple status method to check that address is linked and non-zero */
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    Aml *if_ctx = aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
+    aml_append(if_ctx, aml_return(aml_int(0)));
+    aml_append(method, if_ctx);
+    Aml *else_ctx = aml_else();
+    aml_append(else_ctx, aml_return(aml_int(0xf)));
+    aml_append(method, else_ctx);
+    aml_append(dev, method);
+
+    /* the ADDR method returns two 32-bit words representing the lower and
+     * upper halves * of the physical address of the fw_cfg blob
+     * (holding the GUID) */
+    method = aml_method("ADDR", 0, AML_NOTSERIALIZED);
+
+    pkg = aml_package(2);
+    aml_append(pkg, aml_int(0));
+    aml_append(pkg, aml_int(0));
+
+    aml_append(method, aml_name_decl("LPKG", pkg));
+    aml_append(method, aml_store(aml_and(aml_name("VGIA"),
+        aml_int(0xffffffff), NULL), aml_index(aml_name("LPKG"), aml_int(0))));
+    aml_append(method, aml_store(aml_shiftright(aml_name("VGIA"),
+        aml_int(32), NULL), aml_index(aml_name("LPKG"), aml_int(1))));
+    aml_append(method, aml_return(aml_name("LPKG")));
+
+    aml_append(dev, method);
+    aml_append(scope, dev);
+    aml_append(ssdt, scope);
+
+    /* attach an ACPI notify */
+    scope = aml_scope("_GPE");
+    method = aml_method("_E00", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), aml_int(0x80)));
+    aml_append(scope, method);
+    aml_append(ssdt, scope);
+
+    /* copy AML table into ACPI tables blob and patch in fw_cfg blob */
+    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
+    bios_linker_loader_alloc(linker, VMGENID_FW_CFG_FILE, guid, 0,
+                             false /* high memory */);
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint64_t),
+        VMGENID_FW_CFG_FILE, 0);
+
+    build_header(linker, table_data,
+        (void *)(table_data->data + table_data->len - ssdt->buf->len),
+        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
+    free_aml_allocator();
+}
+
+void vmgenid_add_fw_cfg(FWCfgState *s)
+{
+    Object *obj = find_vmgenid_dev(NULL);
+    if (!obj) {
+        return;
+    }
+    VmGenIdState *vms = VMGENID(obj);
+    fw_cfg_add_file(s, VMGENID_FW_CFG_FILE, vms->guid.data,
+        sizeof(vms->guid.data));
+}
+
+static void vmgenid_notify_guest(VmGenIdState *s)
+{
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    if (obj) {
+        /* Send _GPE.E00 event */
+        acpi_send_event(DEVICE(obj), 1 << 0);
+    }
+}
+
+static void vmgenid_set_guid(Object *obj, const char *value, Error **errp)
+{
+    VmGenIdState *s = VMGENID(obj);
+
+    if (qemu_uuid_parse(value, &s->guid) < 0) {
+        error_setg(errp, "'%s." VMGENID_GUID
+                   "': Failed to parse GUID string: %s",
+                   object_get_typename(OBJECT(s)),
+                   value);
+        return;
+    }
+    vmgenid_notify_guest(s);
+}
+
+static void vmgenid_state_change(void *priv, int running, RunState state)
+{
+    VmGenIdState *s;
+
+    if (state != RUN_STATE_RUNNING) {
+        return;
+    }
+    s = VMGENID((Object *)priv);
+    vmgenid_notify_guest(s);
+}
+
+static void vmgenid_initfn(Object *obj)
+{
+    object_property_add_str(obj, VMGENID_GUID, NULL, vmgenid_set_guid, NULL);
+    qemu_add_vm_change_state_handler(vmgenid_state_change, obj);
+}
+
+static const TypeInfo vmgenid_device_info = {
+    .name          = VMGENID_DEVICE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VmGenIdState),
+    .instance_init = vmgenid_initfn,
+};
+
+static void vmgenid_register_types(void)
+{
+    type_register_static(&vmgenid_device_info);
+}
+
+type_init(vmgenid_register_types)
+
+GuidInfo *qmp_query_vm_generation_id(Error **errp)
+{
+    GuidInfo *info;
+    VmGenIdState *vdev;
+    Object *obj = find_vmgenid_dev(errp);
+
+    if (!obj) {
+        return NULL;
+    }
+    vdev = VMGENID(obj);
+    info = g_malloc0(sizeof(*info));
+    info->guid = g_strdup_printf(UUID_FMT, vdev->guid.data[0],
+            vdev->guid.data[1], vdev->guid.data[2], vdev->guid.data[3],
+            vdev->guid.data[4], vdev->guid.data[5], vdev->guid.data[6],
+            vdev->guid.data[7], vdev->guid.data[8], vdev->guid.data[9],
+            vdev->guid.data[10], vdev->guid.data[11], vdev->guid.data[12],
+            vdev->guid.data[13], vdev->guid.data[14], vdev->guid.data[15]);
+    return info;
+}
+
+void qmp_set_vm_generation_id(const char *guid, Error **errp)
+{
+    Object *obj = find_vmgenid_dev(errp);
+
+    if (!obj) {
+        return;
+    }
+
+    object_property_set_str(obj, guid, VMGENID_GUID, errp);
+    return;
+}
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 9708cdc..cde81b7 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -42,6 +42,7 @@
 #include "hw/acpi/memory_hotplug.h"
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
+#include "hw/acpi/vmgenid.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/timer/mc146818rtc_regs.h"
 #include "sysemu/numa.h"
@@ -2785,6 +2786,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, pcms);
 
+    vmgenid_build_acpi(table_offsets, tables_blob, tables->linker);
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker);
@@ -2991,6 +2994,8 @@ void acpi_setup(void)
     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
+    vmgenid_add_fw_cfg(pcms->fw_cfg);
+
     if (!pcmc->rsdp_in_ram) {
         /*
          * Keep for compatibility with old machine types.
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 1a89615..ca0f1bb 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -53,3 +53,4 @@ obj-$(CONFIG_EDU) += edu.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
+obj-$(CONFIG_VMGENID) += vmgenid.o
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
new file mode 100644
index 0000000..f8bdff2
--- /dev/null
+++ b/include/hw/acpi/vmgenid.h
@@ -0,0 +1,24 @@
+#ifndef ACPI_VMGENID_H
+#define ACPI_VMGENID_H
+
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/sysbus.h"
+#include "qemu/uuid.h"
+
+#define VMGENID_DEVICE           "vmgenid"
+#define VMGENID_GUID             "guid"
+#define VMGENID_FW_CFG_FILE      "etc/vmgenid"
+
+Object *find_vmgenid_dev(Error **errp);
+void vmgenid_add_fw_cfg(FWCfgState *s);
+void vmgenid_build_acpi(GArray *table_offsets, GArray *table_data,
+                       BIOSLinker *linker);
+
+#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), VMGENID_DEVICE)
+
+typedef struct VmGenIdState {
+    SysBusDevice parent_obj;
+    QemuUUID guid;
+} VmGenIdState;
+
+#endif
-- 
2.7.4
