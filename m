Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcw-0003hC-Kp
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:44:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcu-0005NU-Jl
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:58 -0500
Received: from mail-yw0-x22f.google.com ([2607:f8b0:4002:c05::22f]:32960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCcu-0005NP-E6
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:56 -0500
Received: by mail-yw0-x22f.google.com with SMTP id u68so3012959ywg.0
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:43:56 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:23 -0800
Message-Id: <b9ead8f0965c42f78e73e17e461ef7f476ae4318.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 4/9] ACPI: Add Virtual Machine Generation ID
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
 hw/acpi/vmgenid.c                    | 244 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                 |   9 ++
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/vmgenid.h            |  32 +++++
 7 files changed, 289 insertions(+)
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
index 6acf798..11c35bc 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -5,6 +5,7 @@ common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu_hotplug.o
 common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) += memory_hotplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) += cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) += nvdimm.o
+common-obj-$(CONFIG_ACPI_VMGENID) += vmgenid.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) += acpi-stub.o
 
 common-obj-y += acpi_interface.o
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
new file mode 100644
index 0000000..63cb039
--- /dev/null
+++ b/hw/acpi/vmgenid.c
@@ -0,0 +1,244 @@
+/*
+ *  Virtual Machine Generation ID Device
+ *
+ *  Copyright (C) 2017 Skyport Systems.
+ *
+ *  Author: Ben Warren <ben@skyportsystems.com>
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
+    GArray *guid, *vgia;
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
+    vgia = g_array_new(false, true, sizeof(uint64_t));
+    g_array_append_val(vgia, s->vgia);
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
+    bios_linker_loader_alloc(linker, VMGENID_ADDR_FW_CFG_FILE, vgia, 0,
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
+                             &vms->vgia, sizeof(uint64_t), false);
+}
+
+static void vmgenid_update_guest(VmGenIdState *s)
+{
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    if (obj) {
+
+        /* Write the GUID to guest memory */
+        if (s->vgia) {
+            cpu_physical_memory_write(s->vgia, s->guid.data,
+                                      sizeof(s->guid.data));
+        }
+        /* Send _GPE.E05 event */
+        acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
+    }
+}
+
+static void vmgenid_set_guid(Object *obj, const char *value, Error **errp)
+{
+    VmGenIdState *s = VMGENID(obj);
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
+    /* Send the ACPI notify */
+    vmgenid_update_guest(s);
+}
+
+/* After restoring an image, we need to update the guest memory and notify
+ * it of a potential change to VM Generation ID */
+static int vmgenid_post_load(void *opaque, int version_id)
+{
+    VmGenIdState *s = opaque;
+    vmgenid_update_guest(s);
+    return 0;
+}
+
+/* Store the VM Generation ID guest address as part of state info
+ * This is necessary because BIOS will not run when a VM is restored
+ * and so will not tell QEMU the guest address */
+static const VMStateDescription vmstate_vmgenid = {
+    .name = "vmgenid",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmgenid_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(vgia, VmGenIdState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vmgenid_initfn(Object *obj)
+{
+    VmGenIdState *s = VMGENID(obj);
+
+    object_property_add_str(obj, VMGENID_GUID, NULL, vmgenid_set_guid, NULL);
+    s->vgia = 0;
+}
+
+static void vmgenid_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_vmgenid;
+}
+
+static const TypeInfo vmgenid_device_info = {
+    .name          = VMGENID_DEVICE,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VmGenIdState),
+    .instance_init = vmgenid_initfn,
+    .class_init    = vmgenid_device_class_init,
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
index 1c928ab..78b4da5 100644
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
@@ -2653,6 +2654,10 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, pcms);
 
+    if (has_vmgenid()) {
+        vmgenid_build_acpi(table_offsets, tables_blob, tables->linker);
+    }
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker);
@@ -2859,6 +2864,10 @@ void acpi_setup(void)
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
index 71d3c48..3c2e4e9 100644
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
index 0000000..e4ac6f8
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
+    uint64_t vgia;
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
2.7.4
