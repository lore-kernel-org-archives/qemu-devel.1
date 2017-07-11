Received: from eggs.gnu.org ([2001:4830:134:3::10]:58980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dUsR5-0006o6-0D
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:30:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dUsR2-0005f2-LN
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:30:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dUsR2-0005eh-Bo
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 06:30:28 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 11 Jul 2017 12:30:06 +0200
Message-Id: <20170711103011.32631-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170711103011.32631-1-marcandre.lureau@redhat.com>
References: <20170711103011.32631-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 2/7] acpi: add vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, anderson@redhat.com, berrange@redhat.com, ehabkost@redhat.com, lersek@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

The VM coreinfo (vmcoreinfo) device is an emulated device which
exposes a 4k memory range to the guest to store various informations
useful to debug the guest OS. (it is greatly inspired by the VMGENID
device implementation)

This is an early-boot alternative to the qemu-ga VMDUMP_INFO event
proposed in "[PATCH 00/21] WIP: dump: add kaslr support".

A proof-of-concept kernel module:
https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/acpi/aml-build.h        |   1 +
 include/hw/acpi/vmcoreinfo.h       |  37 +++++++
 hw/acpi/aml-build.c                |   2 +
 hw/acpi/vmcoreinfo.c               | 208 +++++++++++++++++++++++++++++++=
++++++
 hw/i386/acpi-build.c               |  14 +++
 default-configs/arm-softmmu.mak    |   1 +
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 docs/specs/vmcoreinfo.txt          | 138 ++++++++++++++++++++++++
 hw/acpi/Makefile.objs              |   1 +
 10 files changed, 404 insertions(+)
 create mode 100644 include/hw/acpi/vmcoreinfo.h
 create mode 100644 hw/acpi/vmcoreinfo.c
 create mode 100644 docs/specs/vmcoreinfo.txt

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 88d0738d76..cf781bcd34 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -211,6 +211,7 @@ struct AcpiBuildTables {
     GArray *rsdp;
     GArray *tcpalog;
     GArray *vmgenid;
+    GArray *vmcoreinfo;
     BIOSLinker *linker;
 } AcpiBuildTables;
=20
diff --git a/include/hw/acpi/vmcoreinfo.h b/include/hw/acpi/vmcoreinfo.h
new file mode 100644
index 0000000000..6a73bcd1b2
--- /dev/null
+++ b/include/hw/acpi/vmcoreinfo.h
@@ -0,0 +1,37 @@
+#ifndef ACPI_VMCOREINFO_H
+#define ACPI_VMCOREINFO_H
+
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/qdev.h"
+
+#define VMCOREINFO_DEVICE           "vmcoreinfo"
+#define VMCOREINFO_FW_CFG_FILE      "etc/vmcoreinfo"
+#define VMCOREINFO_ADDR_FW_CFG_FILE "etc/vmcoreinfo-addr"
+
+/* Occupy a page of memory */
+#define VMCOREINFO_FW_CFG_SIZE      4096
+
+/* allow space for OVMF SDT Header Probe Supressor */
+#define VMCOREINFO_OFFSET           sizeof(AcpiTableHeader)
+
+#define VMCOREINFO(obj) OBJECT_CHECK(VMCoreInfoState, (obj), VMCOREINFO_=
DEVICE)
+
+typedef struct VMCoreInfoState {
+    DeviceClass parent_obj;
+    uint8_t vmcoreinfo_addr_le[8];   /* Address of memory region */
+    bool write_pointer_available;
+} VMCoreInfoState;
+
+/* returns NULL unless there is exactly one device */
+static inline Object *find_vmcoreinfo_dev(void)
+{
+    return object_resolve_path_type("", VMCOREINFO_DEVICE, NULL);
+}
+
+void vmcoreinfo_build_acpi(VMCoreInfoState *vis, GArray *table_data,
+                           GArray *vmci, BIOSLinker *linker);
+void vmcoreinfo_add_fw_cfg(VMCoreInfoState *vis, FWCfgState *s, GArray *=
vmci);
+bool vmcoreinfo_get(VMCoreInfoState *vis, uint64_t *paddr, uint32_t *siz=
e,
+                    Error **errp);
+
+#endif
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc450e..47043ade4a 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1561,6 +1561,7 @@ void acpi_build_tables_init(AcpiBuildTables *tables=
)
     tables->table_data =3D g_array_new(false, true /* clear */, 1);
     tables->tcpalog =3D g_array_new(false, true /* clear */, 1);
     tables->vmgenid =3D g_array_new(false, true /* clear */, 1);
+    tables->vmcoreinfo =3D g_array_new(false, true /* clear */, 1);
     tables->linker =3D bios_linker_loader_init();
 }
=20
@@ -1571,6 +1572,7 @@ void acpi_build_tables_cleanup(AcpiBuildTables *tab=
les, bool mfre)
     g_array_free(tables->table_data, true);
     g_array_free(tables->tcpalog, mfre);
     g_array_free(tables->vmgenid, mfre);
+    g_array_free(tables->vmcoreinfo, mfre);
 }
=20
 /* Build rsdt table */
diff --git a/hw/acpi/vmcoreinfo.c b/hw/acpi/vmcoreinfo.c
new file mode 100644
index 0000000000..0ea41de8d9
--- /dev/null
+++ b/hw/acpi/vmcoreinfo.c
@@ -0,0 +1,208 @@
+/*
+ *  Virtual Machine coreinfo device
+ *  (based on Virtual Machine Generation ID Device)
+ *
+ *  Copyright (C) 2017 Red Hat, Inc.
+ *  Copyright (C) 2017 Skyport Systems.
+ *
+ *  Authors: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *           Ben Warren <ben@skyportsystems.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/vmcoreinfo.h"
+#include "hw/nvram/fw_cfg.h"
+#include "sysemu/sysemu.h"
+#include "qapi/error.h"
+
+void vmcoreinfo_build_acpi(VMCoreInfoState *vis, GArray *table_data,
+                           GArray *vmci, BIOSLinker *linker)
+{
+    Aml *ssdt, *dev, *scope, *method, *addr, *if_ctx;
+    uint32_t vcia_offset;
+
+    g_array_set_size(vmci, VMCOREINFO_FW_CFG_SIZE);
+
+    /* Put this in a separate SSDT table */
+    ssdt =3D init_aml_allocator();
+
+    /* Reserve space for header */
+    acpi_data_push(ssdt->buf, sizeof(AcpiTableHeader));
+
+    /* Storage address */
+    vcia_offset =3D table_data->len +
+        build_append_named_dword(ssdt->buf, "VCIA");
+    scope =3D aml_scope("\\_SB");
+    dev =3D aml_device("VMCI");
+    aml_append(dev, aml_name_decl("_HID", aml_string("QEMUVMCI")));
+
+    /* Simple status method to check that address is linked and non-zero=
 */
+    method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
+    addr =3D aml_local(0);
+    aml_append(method, aml_store(aml_int(0xf), addr));
+    if_ctx =3D aml_if(aml_equal(aml_name("VCIA"), aml_int(0)));
+    aml_append(if_ctx, aml_store(aml_int(0), addr));
+    aml_append(method, if_ctx);
+    aml_append(method, aml_return(addr));
+    aml_append(dev, method);
+
+    /* the ADDR method returns two 32-bit words representing the lower a=
nd
+     * upper halves of the physical address of the vmcoreinfo area
+     */
+    method =3D aml_method("ADDR", 0, AML_NOTSERIALIZED);
+
+    addr =3D aml_local(0);
+    aml_append(method, aml_store(aml_package(2), addr));
+
+    aml_append(method, aml_store(aml_add(aml_name("VCIA"),
+                                         aml_int(VMCOREINFO_OFFSET), NUL=
L),
+                                 aml_index(addr, aml_int(0))));
+    aml_append(method, aml_store(aml_int(0), aml_index(addr, aml_int(1))=
));
+    aml_append(method, aml_return(addr));
+
+    aml_append(dev, method);
+    aml_append(scope, dev);
+    aml_append(ssdt, scope);
+
+    g_array_append_vals(table_data, ssdt->buf->data, ssdt->buf->len);
+
+    /* Allocate guest memory */
+    bios_linker_loader_alloc(linker, VMCOREINFO_FW_CFG_FILE, vmci, 4096,
+                             false /* page boundary, high memory */);
+
+    /* Patch address of vmcoreinfo fw_cfg blob into the ADDR fw_cfg
+     * blob so QEMU can read the info from there.  The address is
+     * expected to be < 4GB, but write 64 bits anyway.
+     * The address that is patched in is offset in order to implement
+     * the "OVMF SDT Header probe suppressor"
+     * see docs/specs/vmcoreinfo.txt for more details.
+     */
+    bios_linker_loader_write_pointer(linker,
+        VMCOREINFO_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
+        VMCOREINFO_FW_CFG_FILE, VMCOREINFO_OFFSET);
+
+    /* Patch address of vmcoreinfo into the AML so OSPM can retrieve
+     * and read it.  Note that while we provide storage for 64 bits, onl=
y
+     * the least-signficant 32 get patched into AML.
+     */
+    bios_linker_loader_add_pointer(linker,
+        ACPI_BUILD_TABLE_FILE, vcia_offset, sizeof(uint32_t),
+        VMCOREINFO_FW_CFG_FILE, 0);
+
+    build_header(linker, table_data,
+        (void *)(table_data->data + table_data->len - ssdt->buf->len),
+        "SSDT", ssdt->buf->len, 1, NULL, "VMCOREIN");
+    free_aml_allocator();
+}
+
+void vmcoreinfo_add_fw_cfg(VMCoreInfoState *vis, FWCfgState *s, GArray *=
vmci)
+{
+    /* Create a read-only fw_cfg file for vmcoreinfo allocation */
+    /* XXX: linker could learn to allocate without backing fw_cfg? */
+    fw_cfg_add_file(s, VMCOREINFO_FW_CFG_FILE, vmci->data,
+                    VMCOREINFO_FW_CFG_SIZE);
+    /* Create a read-write fw_cfg file for Address */
+    fw_cfg_add_file_callback(s, VMCOREINFO_ADDR_FW_CFG_FILE, NULL, NULL,
+                             vis->vmcoreinfo_addr_le,
+                             ARRAY_SIZE(vis->vmcoreinfo_addr_le), false)=
;
+}
+
+bool vmcoreinfo_get(VMCoreInfoState *vis,
+                    uint64_t *paddr, uint32_t *size,
+                    Error **errp)
+{
+    uint32_t vmcoreinfo_addr;
+    uint32_t version;
+
+    assert(vis);
+    assert(paddr);
+    assert(size);
+
+    memcpy(&vmcoreinfo_addr, vis->vmcoreinfo_addr_le, sizeof(vmcoreinfo_=
addr));
+    vmcoreinfo_addr =3D le32_to_cpu(vmcoreinfo_addr);
+    if (!vmcoreinfo_addr) {
+        error_setg(errp, "BIOS has not yet written the address of %s",
+                   VMCOREINFO_DEVICE);
+        return false;
+    }
+
+    cpu_physical_memory_read(vmcoreinfo_addr, &version, sizeof(version))=
;
+    if (version !=3D 0) {
+        error_setg(errp, "Unknown %s memory version", VMCOREINFO_DEVICE)=
;
+        return false;
+    }
+
+    cpu_physical_memory_read(vmcoreinfo_addr + 4, paddr, sizeof(*paddr))=
;
+    *paddr =3D le64_to_cpu(*paddr);
+    cpu_physical_memory_read(vmcoreinfo_addr + 12, size, sizeof(*size));
+    *size =3D le32_to_cpu(*size);
+
+    return true;
+}
+
+static const VMStateDescription vmstate_vmcoreinfo =3D {
+    .name =3D "vmcoreinfo",
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(vmcoreinfo_addr_le, VMCoreInfoState, sizeof(=
uint64_t)),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
+static void vmcoreinfo_handle_reset(void *opaque)
+{
+    VMCoreInfoState *vis =3D VMCOREINFO(opaque);
+
+    /* Clear the guest-allocated address when the VM resets */
+    memset(vis->vmcoreinfo_addr_le, 0, ARRAY_SIZE(vis->vmcoreinfo_addr_l=
e));
+}
+
+static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
+{
+    if (!bios_linker_loader_can_write_pointer()) {
+        error_setg(errp, "%s requires DMA write support in fw_cfg, "
+                   "which this machine type does not provide",
+                   VMCOREINFO_DEVICE);
+        return;
+    }
+
+    /* Given that this function is executing, there is at least one VMCO=
REINFO
+     * device. Check if there are several.
+     */
+    if (!find_vmcoreinfo_dev()) {
+        error_setg(errp, "at most one %s device is permitted",
+                   VMCOREINFO_DEVICE);
+        return;
+    }
+
+    qemu_register_reset(vmcoreinfo_handle_reset, dev);
+}
+
+static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd =3D &vmstate_vmcoreinfo;
+    dc->realize =3D vmcoreinfo_realize;
+    dc->hotpluggable =3D false;
+}
+
+static const TypeInfo vmcoreinfo_device_info =3D {
+    .name          =3D VMCOREINFO_DEVICE,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(VMCoreInfoState),
+    .class_init    =3D vmcoreinfo_device_class_init,
+};
+
+static void vmcoreinfo_register_types(void)
+{
+    type_register_static(&vmcoreinfo_device_info);
+}
+
+type_init(vmcoreinfo_register_types)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 5464977424..6266b9d1bf 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -43,6 +43,7 @@
 #include "sysemu/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
+#include "hw/acpi/vmcoreinfo.h"
 #include "sysemu/tpm_backend.h"
 #include "hw/timer/mc146818rtc_regs.h"
 #include "sysemu/numa.h"
@@ -2631,6 +2632,7 @@ void acpi_build(AcpiBuildTables *tables, MachineSta=
te *machine)
     GArray *tables_blob =3D tables->table_data;
     AcpiSlicOem slic_oem =3D { .id =3D NULL, .table_id =3D NULL };
     Object *vmgenid_dev;
+    Object *vmcoreinfo_dev;
=20
     acpi_get_pm_info(&pm);
     acpi_get_misc_info(&misc);
@@ -2680,6 +2682,12 @@ void acpi_build(AcpiBuildTables *tables, MachineSt=
ate *machine)
         vmgenid_build_acpi(VMGENID(vmgenid_dev), tables_blob,
                            tables->vmgenid, tables->linker);
     }
+    vmcoreinfo_dev =3D find_vmcoreinfo_dev();
+    if (vmcoreinfo_dev) {
+        acpi_add_table(table_offsets, tables_blob);
+        vmcoreinfo_build_acpi(VMCOREINFO(vmcoreinfo_dev), tables_blob,
+                              tables->vmcoreinfo, tables->linker);
+    }
=20
     if (misc.has_hpet) {
         acpi_add_table(table_offsets, tables_blob);
@@ -2856,6 +2864,7 @@ void acpi_setup(void)
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
+    Object *vmcoreinfo_dev;
=20
     if (!pcms->fw_cfg) {
         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
@@ -2897,6 +2906,11 @@ void acpi_setup(void)
         vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
                            tables.vmgenid);
     }
+    vmcoreinfo_dev =3D find_vmcoreinfo_dev();
+    if (vmcoreinfo_dev) {
+        vmcoreinfo_add_fw_cfg(VMCOREINFO(vmcoreinfo_dev), pcms->fw_cfg,
+                              tables.vmcoreinfo);
+    }
=20
     if (!pcmc->rsdp_in_ram) {
         /*
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 93e995d318..320dd3680d 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -120,6 +120,7 @@ CONFIG_XIO3130=3Dy
 CONFIG_IOH3420=3Dy
 CONFIG_I82801B11=3Dy
 CONFIG_ACPI=3Dy
+CONFIG_ACPI_VMCOREINFO=3Dy
 CONFIG_SMBIOS=3Dy
 CONFIG_ASPEED_SOC=3Dy
 CONFIG_GPIO_KEY=3Dy
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index d2ab2f6655..df68628895 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -59,3 +59,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_ACPI_VMCOREINFO=3Dy
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-=
softmmu.mak
index 9bde2f1c4b..e39ad5a680 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -59,3 +59,4 @@ CONFIG_SMBIOS=3Dy
 CONFIG_HYPERV_TESTDEV=3D$(CONFIG_KVM)
 CONFIG_PXB=3Dy
 CONFIG_ACPI_VMGENID=3Dy
+CONFIG_ACPI_VMCOREINFO=3Dy
diff --git a/docs/specs/vmcoreinfo.txt b/docs/specs/vmcoreinfo.txt
new file mode 100644
index 0000000000..36d5a39ab1
--- /dev/null
+++ b/docs/specs/vmcoreinfo.txt
@@ -0,0 +1,138 @@
+VIRTUAL MACHINE COREINFO DEVICE
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+
+Copyright (C) 2017 Red Hat, Inc.
+
+This work is licensed under the terms of the GNU GPL, version 2 or later=
.
+See the COPYING file in the top-level directory.
+
+=3D=3D=3D
+
+The VM coreinfo (vmcoreinfo) device is an emulated device which
+exposes a 4k memory range to the guest to store various informations
+useful to debug the guest OS.
+
+QEMU Implementation
+-------------------
+
+The vmcoreinfo device is put in its own ACPI descriptor table, in a
+Secondary System Description Table, or SSDT.
+
+The following is a dump of the contents from a running system:
+
+# iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
+/*
+ * Intel ACPI Component Architecture
+ * AML/ASL+ Disassembler version 20160831-64
+ * Copyright (c) 2000 - 2016 Intel Corporation
+ *
+ * Disassembling to symbolic ASL+ operators
+ *
+ * Disassembly of /sys/firmware/acpi/tables/SSDT, Mon Apr 24 15:59:53 20=
17
+ *
+ * Original Table Header:
+ *     Signature        "SSDT"
+ *     Length           0x00000086 (134)
+ *     Revision         0x01
+ *     Checksum         0x5C
+ *     OEM ID           "BOCHS "
+ *     OEM Table ID     "VMCOREIN"
+ *     OEM Revision     0x00000001 (1)
+ *     Compiler ID      "BXPC"
+ *     Compiler Version 0x00000001 (1)
+ */
+DefinitionBlock ("", "SSDT", 1, "BOCHS ", "VMCOREIN", 0x00000001)
+{
+    Name (VCIA, 0x3FFFF000)
+    Scope (\_SB)
+    {
+        Device (VMCI)
+        {
+            Name (_HID, "QEMUVMCI")  // _HID: Hardware ID
+            Method (_STA, 0, NotSerialized)  // _STA: Status
+            {
+                Local0 =3D 0x0F
+                If (VCIA =3D=3D Zero)
+                {
+                    Local0 =3D Zero
+                }
+
+                Return (Local0)
+            }
+
+            Method (ADDR, 0, NotSerialized)
+            {
+                Local0 =3D Package (0x02) {}
+                Local0 [Zero] =3D (VCIA + 0x24)
+                Local0 [One] =3D Zero
+                Return (Local0)
+            }
+        }
+    }
+}
+
+
+Design Details:
+---------------
+
+QEMU must be able to read the contents of the device memory,
+specifically when starting a memory dump.  In order to do this, QEMU
+must know the address that has been allocated.
+
+The mechanism chosen for this memory sharing is writeable fw_cfg blobs.
+These are data object that are visible to both QEMU and guests, and are
+addressable as sequential files.
+
+More information about fw_cfg can be found in "docs/specs/fw_cfg.txt"
+
+Two fw_cfg blobs are used in this case:
+
+/etc/vmcoreinfo      - used to allocate memory range, read-only to the g=
uest
+/etc/vmcoreinfo-addr - contains the address of the allocated range
+                     - writeable by the guest
+
+
+QEMU sends the following commands to the guest at startup:
+
+1. Allocate memory for vmcoreinfo fw_cfg blob.
+2. Write the address of vmcoreinfo into the SSDT (VCIA ACPI variable as
+   shown above in the iasl dump).  Note that this change is not propagat=
ed
+   back to QEMU.
+3. Write the address of vmcoreinfo back to QEMU's copy of vmcoreinfo-add=
r
+   via the fw_cfg DMA interface.
+
+After step 3, QEMU is able to read the contents of vmcoreinfo.
+
+The value of VCIA is persisted via the VMState mechanism.
+
+
+Storage Format:
+---------------
+
+The content is expected to use little-endian format.
+
+In order to implement an OVMF "SDT Header Probe Suppressor", the content=
s of
+the vmcoreinfo blob has 36 bytes of padding:
+
++-----------------------------------+
+| SSDT with OEM Table ID =3D VMCOREIN |
++-----------------------------------+
+| ...                               |       TOP OF PAGE
+| VCIA dword object ----------------|-----> +---------------------------=
+
+| ...                               |       | fw-allocated array for    =
|
+| _STA method referring to VCIA     |       | "etc/vmcoreinfo"          =
|
+| ...                               |       +---------------------------=
+
+| ADDR method referring to VCIA     |       |  0: OVMF SDT Header probe =
|
+| ...                               |       |     suppressor            =
|
++-----------------------------------+       | 36: uint32 version field  =
|
+                                            | 40: info contents         =
|
+                                            |     ....                  =
|
+                                            +---------------------------=
+
+                                            END OF PAGE
+
+Version 0 content:
+
+ uint64 paddr:
+  Physical address of the Linux vmcoreinfo ELF note.
+ uint32 size:
+  Size of the vmcoreinfo ELF note.
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 11c35bcb44..9623078f95 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,6 +6,7 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hotp=
lug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
+common-obj-$(CONFIG_ACPI_VMCOREINFO) +=3D vmcoreinfo.o
 common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
=20
 common-obj-y +=3D acpi_interface.o
--=20
2.13.1.395.gf7b71de06
