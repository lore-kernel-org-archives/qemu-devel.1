Received: from eggs.gnu.org ([2001:4830:134:3::10]:59551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsE-0002Z4-GA
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsC-0001s9-Nc
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:42 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:36567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1caIsC-0001rs-Fb
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:40 -0500
Received: by mail-pg0-x230.google.com with SMTP id v184so19465631pgv.3
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 01:12:40 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun,  5 Feb 2017 01:12:00 -0800
Message-Id: <28ff6ff023dd041fc7557955dea916adce72efea.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v5 05/10] ACPI: Add Virtual Machine Generation
 ID support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This implements the VM Generation ID feature by passing a 128-bit
GUID to the guest via a fw_cfg blob.
Any time the GUID changes, an ACPI notify event is sent to the guest

The user interface is a simple device with one parameter:
 - guid (string, must be "auto" or in UUID format
   xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 default-configs/i386-softmmu.mak     |   1 +
 default-configs/x86_64-softmmu.mak   |   1 +
 hw/acpi/Makefile.objs                |   1 +
 hw/acpi/vmgenid.c                    | 206 +++++++++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                 |  10 ++
 include/hw/acpi/acpi_dev_interface.h |   1 +
 include/hw/acpi/vmgenid.h            |  37 +++++++
 7 files changed, 257 insertions(+)
 create mode 100644 hw/acpi/vmgenid.c
 create mode 100644 include/hw/acpi/vmgenid.h

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 384cefb..1a43542 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -58,3 +58,4 @@ CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
+CONFIG_ACPI_VMGENID=y
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-softmmu.mak
index 491a191..aee8b08 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -58,3 +58,4 @@ CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_HYPERV_TESTDEV=$(CONFIG_KVM)
 CONFIG_PXB=y
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
index 0000000..6c9ecfd
--- /dev/null
+++ b/hw/acpi/vmgenid.c
@@ -0,0 +1,206 @@
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
+void vmgenid_build_acpi(GArray *table_data, GArray *guid, BIOSLinker *linker)
+{
+    Object *obj;
+    VmGenIdState *s;
+    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
+    uint32_t vgia_offset;
+
+    obj = find_vmgenid_dev(NULL);
+    assert(obj);
+    s = VMGENID(obj);
+
+    /* Fill in the GUID values */
+    if (guid->len != VMGENID_FW_CFG_SIZE) {
+        g_array_set_size(guid, VMGENID_FW_CFG_SIZE);
+    }
+    g_array_insert_vals(guid, VMGENID_GUID_OFFSET, s->guid.data, 16);
+
+    /* Put this in a separate SSDT table */
+    ssdt = init_aml_allocator();
+
+    /* Reserve space for header */
+    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
+
+    /* Storage for the GUID address */
+    vgia_offset = table_data->len +
+        build_append_named_dword(ssdt->buf, "VGIA");
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
+    aml_append(method, aml_store(aml_add(aml_name("VGIA"),
+                                         aml_int(VMGENID_GUID_OFFSET), NULL),
+                                 aml_index(addr, aml_int(0))));
+    aml_append(method, aml_store(aml_int(0), aml_index(addr, aml_int(1))));
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
+    /* Allocate guest memory for the Data fw_cfg blob */
+    bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, guid, 4096,
+                             false /* page boundary, high memory */);
+
+    /* Patch address of GUID fw_cfg blob into the ADDR fw_cfg blob */
+    bios_linker_loader_add_pointer(linker,
+        VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint32_t),
+        VMGENID_GUID_FW_CFG_FILE, 0, true);
+
+    /* Patch address of GUID fw_cfg blob into the AML */
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, vgia_offset, sizeof(uint32_t),
+        VMGENID_GUID_FW_CFG_FILE, 0, false);
+
+    build_header(linker, table_data,
+        (void *)(table_data->data + table_data->len - ssdt->buf->len),
+        "SSDT", ssdt->buf->len, 1, NULL, "VMGENID");
+    free_aml_allocator();
+}
+
+void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid)
+{
+    Object *obj = find_vmgenid_dev(NULL);
+    assert(obj);
+    VmGenIdState *vms = VMGENID(obj);
+
+    /* Create a read-only fw_cfg file for GUID */
+    fw_cfg_add_file(s, VMGENID_GUID_FW_CFG_FILE, guid->data,
+                    VMGENID_FW_CFG_SIZE);
+    /* Create a read-write fw_cfg file for Address */
+    fw_cfg_add_file_callback(s, VMGENID_ADDR_FW_CFG_FILE, NULL, NULL,
+                             vms->vgia_le, sizeof(uint32_t), false);
+}
+
+static void vmgenid_update_guest(VmGenIdState *s)
+{
+    Object *obj = object_resolve_path_type("", TYPE_ACPI_DEVICE_IF, NULL);
+    uint32_t vgia;
+
+    if (obj) {
+        /* Write the GUID to guest memory */
+        memcpy(&vgia, s->vgia_le, sizeof(vgia));
+        vgia = le32_to_cpu(vgia);
+        if (vgia) {
+            cpu_physical_memory_write(vgia + VMGENID_GUID_OFFSET,
+                                      s->guid.data, sizeof(s->guid.data));
+            /* Send _GPE.E05 event */
+            acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
+        }
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
+        error_setg(errp, "'%s. %s': Failed to parse GUID string: %s",
+                   object_get_typename(OBJECT(s)), VMGENID_GUID, value);
+        return;
+    }
+    /* QemuUUID has the first three words as big-endian, and expect that any
+     * GUIDs passed in will always be BE.  The guest, however will expect
+     * the fields to be little-endian, so store that way internally.  Make
+     * sure to swap back whenever reporting via monitor */
+    qemu_uuid_bswap(&s->guid);
+
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
+static const VMStateDescription vmstate_vmgenid = {
+    .name = "vmgenid",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmgenid_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(vgia_le, VmGenIdState, sizeof(uint32_t)),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vmgenid_initfn(Object *obj)
+{
+    object_property_add_str(obj, VMGENID_GUID, NULL, vmgenid_set_guid, NULL);
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
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 78a1d84..4c40f76 100644
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
@@ -2653,6 +2654,11 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
     acpi_add_table(table_offsets, tables_blob);
     build_madt(tables_blob, tables->linker, pcms);
 
+    if (find_vmgenid_dev(NULL)) {
+        acpi_add_table(table_offsets, tables_blob);
+        vmgenid_build_acpi(tables_blob, tables->vmgenid, tables->linker);
+    }
+
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
         build_hpet(tables_blob, tables->linker);
@@ -2859,6 +2865,10 @@ void acpi_setup(void)
     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
+    if (find_vmgenid_dev(NULL)) {
+        vmgenid_add_fw_cfg(pcms->fw_cfg, tables.vmgenid);
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
index 0000000..b60437a
--- /dev/null
+++ b/include/hw/acpi/vmgenid.h
@@ -0,0 +1,37 @@
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
+#define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
+#define VMGENID_GUID_OFFSET      40   /* allow space for
+                                       * OVMF SDT Header Probe Supressor */
+
+void vmgenid_add_fw_cfg(FWCfgState *s, GArray *guid);
+void vmgenid_build_acpi(GArray *table_data, GArray *guid, BIOSLinker *linker);
+
+#define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), VMGENID_DEVICE)
+
+typedef struct VmGenIdState {
+    SysBusDevice parent_obj;
+    QemuUUID guid;
+    uint8_t vgia_le[4];
+} VmGenIdState;
+
+static Object *find_vmgenid_dev(Error **errp)
+{
+    Object *obj = object_resolve_path_type("", VMGENID_DEVICE, NULL);
+    if (!obj && errp) {
+        error_setg(errp, "%s is not found", VMGENID_DEVICE);
+    }
+    return obj;
+}
+
+#endif
-- 
2.7.4
