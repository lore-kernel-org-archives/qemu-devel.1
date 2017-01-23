Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ8A-00056o-8D
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ88-0006kh-If
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:34 -0500
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:34994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cVZ88-0006k8-Aa
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:32 -0500
Received: by mail-pf0-x22f.google.com with SMTP id f144so39242292pfa.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 23:33:32 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun, 22 Jan 2017 23:32:49 -0800
Message-Id: <a29e48287c31cfe98a58861981b0ecbfa0a67b94.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v3 3/6] ACPI: Add Virtual Machine Generation ID
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

The user interface is a simple device with one parameter:
 - guid (string, must be "auto" or in UUID format
   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 hw/acpi/Makefile.objs                |   1 +
 hw/acpi/vmgenid.c                    | 214 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                 |   9 ++
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/vmgenid.h            |  32 ++++++
 7 files changed, 259 insertions(+)
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
index 834c63b..98cb115 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -4,6 +4,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
+common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
 common-obj-$(CONFIG_ACPI) += acpi_interface.o
 common-obj-$(CONFIG_ACPI) += bios-linker-loader.o
 common-obj-$(CONFIG_ACPI) += aml-build.o
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
new file mode 100644
index 0000000..2d831b2
--- /dev/null
+++ b/hw/acpi/vmgenid.c
@@ -0,0 +1,214 @@
+/*
+ *  Virtual Machine Generation ID Device
+ *
+ *  Copyright (C) 2017 Skyport Systems.
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
+         BIOSLinker *linker)
+{
+    Object *obj;
+    VmGenIdState *s;
+    GArray *guid;
+    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
+    uint32_t vgia_offset;
+
+    obj = find_vmgenid_dev(NULL);
+    if (!obj) {
+        return;
+    }
+    s = VMGENID(obj);
+
+    acpi_add_table(table_offsets, table_data);
+
+    guid = g_array_new(false, true, sizeof(s->guid.data));
+    g_array_append_val(guid, s->guid.data);
+
+    /* Put this in a separate SSDT table */
+    ssdt = init_aml_allocator();
+
+    /* Reserve space for header */
+    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
+
+    /* Storage for the GUID address */
+    vgia_offset = table_data->len +
+        build_append_named_qword(ssdt->buf, "VGIA");
+    scope = aml_scope("\\_SB");
+    dev = aml_device("VGEN");
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVGID")));
+    aml_append(dev, aml_name_decl("_CID", aml_string("VM_Gen_Counter")));
+    aml_append(dev, aml_name_decl("_DDN", aml_string("VM_Gen_Counter")));
+
+    /* Simple status method to check that address is linked and non-zero */
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    addr = aml_local(0);
+    aml_append(method, aml_store(aml_int(0xf), addr));
+    if_ctx = aml_if(aml_equal(aml_name("VGIA"), aml_int(0)));
+    aml_append(if_ctx, aml_store(aml_int(0), addr));
+    aml_append(method, if_ctx);
+    aml_append(method, aml_return(addr));
+    aml_append(dev, method);
+
+    /* the ADDR method returns two 32-bit words representing the lower and
+     * upper halves * of the physical address of the fw_cfg blob
+     * (holding the GUID) */
+    method = aml_method("ADDR", 0, AML_NOTSERIALIZED);
+
+    addr = aml_local(0);
+    aml_append(method, aml_store(aml_package(2), addr));
+
+    aml_append(method, aml_store(aml_and(aml_name("VGIA"),
+        aml_int(0xffffffff), NULL), aml_index(addr, aml_int(0))));
+    aml_append(method, aml_store(aml_shiftright(aml_name("VGIA"),
+        aml_int(32), NULL), aml_index(addr, aml_int(1))));
+    aml_append(method, aml_return(addr));
+
+    aml_append(dev, method);
+    aml_append(scope, dev);
+    aml_append(ssdt, scope);
+
+    /* attach an ACPI notify */
+    method = aml_method("\\_GPE._E05", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_notify(aml_name("\\_SB.VGEN"), aml_int(0x80)));
+    aml_append(ssdt, method);
+
+    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
+
+    /* Allocate guest memory for the Address fw_cfg blob */
+    bios_linker_loader_alloc(linker, VMGENID_ADDR_FW_CFG_FILE, s->vgia, 0,
+                             false /* high memory */);
+    /* Allocate guest memory for the GUID fw_cfg blob and return address */
+    bios_linker_loader_alloc_ret_addr(linker, VMGENID_GUID_FW_CFG_FILE, guid,
+                                      0, false, VMGENID_ADDR_FW_CFG_FILE);
+    /* Patch address of GUID fw_cfg blob into the AML */
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint64_t),
+        VMGENID_GUID_FW_CFG_FILE, 0);
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
+    /* Create a read-only fw_cfg file for GUID */
+    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, vms->guid.data,
+        sizeof(vms->guid.data));
+    /* Create a read-write fw_cfg file for Address */
+    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL,
+                             vms->vgia->data, sizeof(uint64_t), false);
+}
+
+static void vmgenid_notify_guest(VmGenIdState *s)
+{
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    if (obj) {
+        /* Send _GPE.E00 event */
+        acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
+    }
+}
+
+static void vmgenid_set_guid(Object *obj, const char *value, Error **errp)
+{
+    VmGenIdState *s = VMGENID(obj);
+    uint64_t *addr;
+
+    if (!strncmp(value, "auto", 4)) {
+        qemu_uuid_generate(&s->guid);
+    } else if (qemu_uuid_parse(value, &s->guid) < 0) {
+        error_setg(errp, "'%s." VMGENID_GUID
+                   "': Failed to parse GUID string: %s",
+                   object_get_typename(OBJECT(s)),
+                   value);
+        return;
+    }
+    /* Find the guest address where the GUID is located and fill it in */
+    addr = &g_array_index(s->vgia, uint64_t, 0);
+    if (addr) {
+        cpu_physical_memory_write(*addr, s->guid.data, 16);
+    }
+
+    /* Send the ACPI notify */
+    vmgenid_notify_guest(s);
+}
+
+static void vmgenid_initfn(Object *obj)
+{
+    VmGenIdState *s = VMGENID(obj);
+
+    object_property_add_str(obj, VMGENID_GUID, NULL, vmgenid_set_guid, NULL);
+
+    s->vgia = g_array_new(false, true, sizeof(uint64_t));
+    g_array_set_size(s->vgia, 1);
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
+    info->guid = qemu_uuid_unparse_strdup(&vdev->guid);
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
index a1d781a..d0821eb 100644
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
@@ -2655,6 +2656,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, pcms);
 
+    if (has_vmgenid()) {
+        vmgenid_build_acpi(table_offsets, tables_blob, tables->linker);
+    }
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker);
@@ -2861,6 +2866,10 @@ void acpi_setup(void)
     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
+    if (has_vmgenid()) {
+        vmgenid_add_fw_cfg(pcms->fw_cfg);
+    }
+
     if (!pcmc->rsdp_in_ram) {
         /*
          * Keep for compatibility with old machine types.
diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/acpi_dev_interface.h
index 901a4ae..960e96f 100644
--- a/include/hw/acpi/acpi_dev_interface.h
+++ b/include/hw/acpi/acpi_dev_interface.h
@@ -11,6 +11,7 @@ typedef enum {
     ACPI_CPU_HOTPLUG_STATUS = 4,
     ACPI_MEMORY_HOTPLUG_STATUS = 8,
     ACPI_NVDIMM_HOTPLUG_STATUS = 16,
+    ACPI_VMGENID_CHANGE_STATUS = 32,
 } AcpiEventStatusBits;
 
 #define TYPE_ACPI_DEVICE_IF "acpi-device-interface"
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
new file mode 100644
index 0000000..5adaf02
--- /dev/null
+++ b/include/hw/acpi/vmgenid.h
@@ -0,0 +1,32 @@
+#ifndef ACPI_VMGENID_H
+#define ACPI_VMGENID_H
+
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/sysbus.h"
+#include "qemu/uuid.h"
+
+#define VMGENID_DEVICE           "vmgenid"
+#define VMGENID_GUID             "guid"
+#define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid"
+#define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
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
+    GArray *vgia;
+
+} VmGenIdState;
+
+static inline bool has_vmgenid(void)
+{
+    return object_resolve_path_type("", VMGENID_DEVICE, NULL) != NULL;
+}
+
+#endif
-- 
2.10.1 (Apple Git-78)
