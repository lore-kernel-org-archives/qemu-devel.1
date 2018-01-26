Received: from eggs.gnu.org ([2001:4830:134:3::10]:57645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef94M-0002N4-Mm
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ef94J-0003Pe-8e
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59006
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ef94I-0003PO-Uc
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:49:43 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0QInIYf037187
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:49:42 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fr5cw3352-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:49:41 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 26 Jan 2018 11:49:41 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 13:49:28 -0500
In-Reply-To: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516992568-3139-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1516992568-3139-6-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
Interface as defined in TCG PC Client Platform TPM Profile (PTP)
Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22.

The PTP allows device implementation to switch between TIS and CRB
model at run time, but given that CRB is a simpler device to
implement, I chose to implement it as a different device.

The device doesn't implement other locality than 0 for now (my laptop
TPM doesn't either, so I assume this isn't so bad)

Tested with some success with Linux upstream and Windows 10, seabios &
modified ovmf. The device is recognized and correctly transmit
command/response with passthrough & emu. However, we are missing PPI
ACPI part atm.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 default-configs/i386-softmmu.mak   |   1 +
 default-configs/x86_64-softmmu.mak |   1 +
 hw/i386/acpi-build.c               |  34 ++++-
 hw/tpm/Makefile.objs               |   1 +
 hw/tpm/tpm_crb.c                   | 303 +++++++++++++++++++++++++++++++=
++++++
 include/hw/acpi/tpm.h              |  51 +++++++
 include/sysemu/tpm.h               |   3 +
 qapi/tpm.json                      |   5 +-
 tests/Makefile.include             |   2 +
 tests/tpm-crb-test.c               | 275 +++++++++++++++++++++++++++++++=
++
 10 files changed, 666 insertions(+), 10 deletions(-)
 create mode 100644 hw/tpm/tpm_crb.c
 create mode 100644 tests/tpm-crb-test.c

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-soft=
mmu.mak
index 95ac4b4..ac27700 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -37,6 +37,7 @@ CONFIG_APPLESMC=3Dy
 CONFIG_I8259=3Dy
 CONFIG_PFLASH_CFI01=3Dy
 CONFIG_TPM_TIS=3D$(CONFIG_TPM)
+CONFIG_TPM_CRB=3D$(CONFIG_TPM)
 CONFIG_MC146818RTC=3Dy
 CONFIG_PCI_PIIX=3Dy
 CONFIG_WDT_IB700=3Dy
diff --git a/default-configs/x86_64-softmmu.mak b/default-configs/x86_64-=
softmmu.mak
index 0221236..b2104ad 100644
--- a/default-configs/x86_64-softmmu.mak
+++ b/default-configs/x86_64-softmmu.mak
@@ -37,6 +37,7 @@ CONFIG_APPLESMC=3Dy
 CONFIG_I8259=3Dy
 CONFIG_PFLASH_CFI01=3Dy
 CONFIG_TPM_TIS=3D$(CONFIG_TPM)
+CONFIG_TPM_CRB=3D$(CONFIG_TPM)
 CONFIG_MC146818RTC=3Dy
 CONFIG_PCI_PIIX=3Dy
 CONFIG_WDT_IB700=3Dy
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index dc4b2b9..ed78c4e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2224,6 +2224,22 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(sb_scope, scope);
         }
     }
+
+    if (TPM_IS_CRB(tpm_find())) {
+        dev =3D aml_device("TPM");
+        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
+        crs =3D aml_resource_template();
+        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
+                                           TPM_CRB_ADDR_SIZE, AML_READ_W=
RITE));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+
+        method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_return(aml_int(0x0f)));
+        aml_append(dev, method);
+
+        aml_append(sb_scope, dev);
+    }
+
     aml_append(dsdt, sb_scope);
=20
     /* copy AML table into ACPI tables blob and patch header there */
@@ -2285,18 +2301,20 @@ build_tpm2(GArray *table_data, BIOSLinker *linker=
, GArray *tcpalog)
     if (TPM_IS_TIS(tpm_find())) {
         tpm2_ptr->control_area_address =3D cpu_to_le64(0);
         tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
-
-        tpm2_ptr->log_area_minimum_length =3D
-            cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
-
-        /* log area start address to be filled by Guest linker */
-        bios_linker_loader_add_pointer(linker,
-            ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
-            ACPI_BUILD_TPMLOG_FILE, 0);
+    } else if (TPM_IS_CRB(tpm_find())) {
+        tpm2_ptr->control_area_address =3D cpu_to_le64(TPM_CRB_ADDR_CTRL=
);
+        tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_CRB);
     } else {
         g_warn_if_reached();
     }
=20
+    tpm2_ptr->log_area_minimum_length =3D
+        cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
+
+    /* log area start address to be filled by Guest linker */
+    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+                                   log_addr_offset, log_addr_size,
+                                   ACPI_BUILD_TPMLOG_FILE, 0);
     build_header(linker, table_data,
                  (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, N=
ULL);
 }
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 7a93b24..1dc9f8b 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-y +=3D tpm_util.o
 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
+common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
 common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
new file mode 100644
index 0000000..687d255
--- /dev/null
+++ b/hw/tpm/tpm_crb.c
@@ -0,0 +1,303 @@
+/*
+ * tpm_crb.c - QEMU's TPM CRB interface emulator
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB) Interfa=
ce
+ * as defined in TCG PC Client Platform TPM Profile (PTP) Specification
+ * Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22
+ */
+
+#include "qemu/osdep.h"
+
+#include "qemu-common.h"
+#include "qapi/error.h"
+#include "exec/address-spaces.h"
+
+#include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
+#include "hw/pci/pci_ids.h"
+#include "hw/acpi/tpm.h"
+#include "migration/vmstate.h"
+#include "sysemu/tpm_backend.h"
+#include "tpm_int.h"
+#include "tpm_util.h"
+
+typedef struct CRBState {
+    DeviceState parent_obj;
+
+    TPMBackend *tpmbe;
+    TPMBackendCmd cmd;
+    uint32_t regs[TPM_CRB_R_MAX];
+    MemoryRegion mmio;
+    MemoryRegion cmdmem;
+
+    size_t be_buffer_size;
+} CRBState;
+
+#define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
+
+#define DEBUG_CRB 0
+
+#define DPRINTF(fmt, ...) do {                  \
+        if (DEBUG_CRB) {                        \
+            printf(fmt, ## __VA_ARGS__);        \
+        }                                       \
+    } while (0)
+
+#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
+#define CRB_INTF_VERSION_CRB 0b1
+#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
+#define CRB_INTF_CAP_IDLE_FAST 0b0
+#define CRB_INTF_CAP_XFER_SIZE_64 0b11
+#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
+#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
+#define CRB_INTF_IF_SELECTOR_CRB 0b1
+
+#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
+
+enum crb_loc_ctrl {
+    CRB_LOC_CTRL_REQUEST_ACCESS =3D BIT(0),
+    CRB_LOC_CTRL_RELINQUISH =3D BIT(1),
+    CRB_LOC_CTRL_SEIZE =3D BIT(2),
+    CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT =3D BIT(3),
+};
+
+enum crb_ctrl_req {
+    CRB_CTRL_REQ_CMD_READY =3D BIT(0),
+    CRB_CTRL_REQ_GO_IDLE =3D BIT(1),
+};
+
+enum crb_start {
+    CRB_START_INVOKE =3D BIT(0),
+};
+
+enum crb_cancel {
+    CRB_CANCEL_INVOKE =3D BIT(0),
+};
+
+static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
+                                  unsigned size)
+{
+    CRBState *s =3D CRB(opaque);
+    void *regs =3D (void *)&s->regs + (addr & ~3);
+    unsigned offset =3D addr & 3;
+    uint32_t val =3D *(uint32_t *)regs >> (8 * offset);
+
+    DPRINTF("CRB read 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32 "\n",
+            addr, size, val);
+    return val;
+}
+
+static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size)
+{
+    CRBState *s =3D CRB(opaque);
+    DPRINTF("CRB write 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx64 "\n"=
,
+            addr, size, val);
+
+    switch (addr) {
+    case A_CRB_CTRL_REQ:
+        switch (val) {
+        case CRB_CTRL_REQ_CMD_READY:
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                             tpmIdle, 0);
+            break;
+        case CRB_CTRL_REQ_GO_IDLE:
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                             tpmIdle, 1);
+            break;
+        }
+        break;
+    case A_CRB_CTRL_CANCEL:
+        if (val =3D=3D CRB_CANCEL_INVOKE &&
+            s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
+            tpm_backend_cancel_cmd(s->tpmbe);
+        }
+        break;
+    case A_CRB_CTRL_START:
+        if (val =3D=3D CRB_START_INVOKE &&
+            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
+            void *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
+
+            s->regs[R_CRB_CTRL_START] |=3D CRB_START_INVOKE;
+            s->cmd =3D (TPMBackendCmd) {
+                .in =3D mem,
+                .in_len =3D MIN(tpm_cmd_get_size(mem), s->be_buffer_size=
),
+                .out =3D mem,
+                .out_len =3D s->be_buffer_size,
+            };
+
+            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
+        }
+        break;
+    case A_CRB_LOC_CTRL:
+        switch (val) {
+        case CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT:
+            /* not loc 3 or 4 */
+            break;
+        case CRB_LOC_CTRL_RELINQUISH:
+            break;
+        case CRB_LOC_CTRL_REQUEST_ACCESS:
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+                             Granted, 1);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STS,
+                             beenSeized, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                             locAssigned, 1);
+            ARRAY_FIELD_DP32(s->regs, CRB_LOC_STATE,
+                             tpmRegValidSts, 1);
+            break;
+        }
+        break;
+    }
+}
+
+static const MemoryRegionOps tpm_crb_memory_ops =3D {
+    .read =3D tpm_crb_mmio_read,
+    .write =3D tpm_crb_mmio_write,
+    .endianness =3D DEVICE_LITTLE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 4,
+    },
+};
+
+static void tpm_crb_request_completed(TPMIf *ti, int ret)
+{
+    CRBState *s =3D CRB(ti);
+
+    s->regs[R_CRB_CTRL_START] &=3D ~CRB_START_INVOKE;
+    if (ret !=3D 0) {
+        ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
+                         tpmSts, 1); /* fatal error */
+    }
+}
+
+static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
+{
+    CRBState *s =3D CRB(ti);
+
+    return tpm_backend_get_tpm_version(s->tpmbe);
+}
+
+static int tpm_crb_pre_save(void *opaque)
+{
+    CRBState *s =3D opaque;
+
+    tpm_backend_finish_sync(s->tpmbe);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_tpm_crb =3D {
+    .name =3D "tpm-crb",
+    .pre_save =3D tpm_crb_pre_save,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property tpm_crb_properties[] =3D {
+    DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void tpm_crb_realize(DeviceState *dev, Error **errp)
+{
+    CRBState *s =3D CRB(dev);
+
+    if (!tpm_find()) {
+        error_setg(errp, "at most one TPM device is permitted");
+        return;
+    }
+    if (!s->tpmbe) {
+        error_setg(errp, "'tpmdev' property is required");
+        return;
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
+        "tpm-crb-mmio", sizeof(s->regs));
+    memory_region_init_ram(&s->cmdmem, OBJECT(s),
+        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
+
+    memory_region_add_subregion(get_system_memory(),
+        TPM_CRB_ADDR_BASE, &s->mmio);
+    memory_region_add_subregion(get_system_memory(),
+        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
+
+    tpm_backend_reset(s->tpmbe);
+
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     InterfaceType, CRB_INTF_TYPE_CRB_ACTIVE);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     InterfaceVersion, CRB_INTF_VERSION_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapLocality, CRB_INTF_CAP_LOCALITY_0_ONLY);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRBIdleBypass, CRB_INTF_CAP_IDLE_FAST);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapDataXferSizeSupport, CRB_INTF_CAP_XFER_SIZE_64);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapFIFO, CRB_INTF_CAP_FIFO_NOT_SUPPORTED);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     CapCRB, CRB_INTF_CAP_CRB_SUPPORTED);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
+                     RID, 0b0000);
+    ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
+                     VID, PCI_VENDOR_ID_IBM);
+
+    s->regs[R_CRB_CTRL_CMD_SIZE] =3D CRB_CTRL_CMD_SIZE;
+    s->regs[R_CRB_CTRL_CMD_LADDR] =3D TPM_CRB_ADDR_BASE + A_CRB_DATA_BUF=
FER;
+    s->regs[R_CRB_CTRL_RSP_SIZE] =3D CRB_CTRL_CMD_SIZE;
+    s->regs[R_CRB_CTRL_RSP_ADDR] =3D TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFF=
ER;
+
+    s->be_buffer_size =3D MIN(tpm_backend_get_buffer_size(s->tpmbe),
+                            CRB_CTRL_CMD_SIZE);
+
+    tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
+}
+
+static void tpm_crb_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
+
+    dc->realize =3D tpm_crb_realize;
+    dc->props =3D tpm_crb_properties;
+    dc->vmsd  =3D &vmstate_tpm_crb;
+    dc->user_creatable =3D true;
+    tc->model =3D TPM_MODEL_TPM_CRB;
+    tc->get_version =3D tpm_crb_get_version;
+    tc->request_completed =3D tpm_crb_request_completed;
+
+    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
+}
+
+static const TypeInfo tpm_crb_info =3D {
+    .name =3D TYPE_TPM_CRB,
+    /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
+    .parent =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(CRBState),
+    .class_init  =3D tpm_crb_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_TPM_IF },
+        { }
+    }
+};
+
+static void tpm_crb_register(void)
+{
+    type_register_static(&tpm_crb_info);
+}
+
+type_init(tpm_crb_register)
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 6d516c6..96fd3a9 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -16,11 +16,61 @@
 #ifndef HW_ACPI_TPM_H
 #define HW_ACPI_TPM_H
=20
+#include "hw/registerfields.h"
+
 #define TPM_TIS_ADDR_BASE           0xFED40000
 #define TPM_TIS_ADDR_SIZE           0x5000
=20
 #define TPM_TIS_IRQ                 5
=20
+REG32(CRB_LOC_STATE, 0x00)
+  FIELD(CRB_LOC_STATE, tpmEstablished, 0, 1)
+  FIELD(CRB_LOC_STATE, locAssigned, 1, 1)
+  FIELD(CRB_LOC_STATE, activeLocality, 2, 3)
+  FIELD(CRB_LOC_STATE, reserved, 5, 2)
+  FIELD(CRB_LOC_STATE, tpmRegValidSts, 7, 1)
+REG32(CRB_LOC_CTRL, 0x08)
+REG32(CRB_LOC_STS, 0x0C)
+  FIELD(CRB_LOC_STS, Granted, 0, 1)
+  FIELD(CRB_LOC_STS, beenSeized, 1, 1)
+REG32(CRB_INTF_ID, 0x30)
+  FIELD(CRB_INTF_ID, InterfaceType, 0, 4)
+  FIELD(CRB_INTF_ID, InterfaceVersion, 4, 4)
+  FIELD(CRB_INTF_ID, CapLocality, 8, 1)
+  FIELD(CRB_INTF_ID, CapCRBIdleBypass, 9, 1)
+  FIELD(CRB_INTF_ID, Reserved1, 10, 1)
+  FIELD(CRB_INTF_ID, CapDataXferSizeSupport, 11, 2)
+  FIELD(CRB_INTF_ID, CapFIFO, 13, 1)
+  FIELD(CRB_INTF_ID, CapCRB, 14, 1)
+  FIELD(CRB_INTF_ID, CapIFRes, 15, 2)
+  FIELD(CRB_INTF_ID, InterfaceSelector, 17, 2)
+  FIELD(CRB_INTF_ID, IntfSelLock, 19, 1)
+  FIELD(CRB_INTF_ID, Reserved2, 20, 4)
+  FIELD(CRB_INTF_ID, RID, 24, 8)
+REG32(CRB_INTF_ID2, 0x34)
+  FIELD(CRB_INTF_ID2, VID, 0, 16)
+  FIELD(CRB_INTF_ID2, DID, 16, 16)
+REG32(CRB_CTRL_EXT, 0x38)
+REG32(CRB_CTRL_REQ, 0x40)
+REG32(CRB_CTRL_STS, 0x44)
+  FIELD(CRB_CTRL_STS, tpmSts, 0, 1)
+  FIELD(CRB_CTRL_STS, tpmIdle, 1, 1)
+REG32(CRB_CTRL_CANCEL, 0x48)
+REG32(CRB_CTRL_START, 0x4C)
+REG32(CRB_INT_ENABLED, 0x50)
+REG32(CRB_INT_STS, 0x54)
+REG32(CRB_CTRL_CMD_SIZE, 0x58)
+REG32(CRB_CTRL_CMD_LADDR, 0x5C)
+REG32(CRB_CTRL_CMD_HADDR, 0x60)
+REG32(CRB_CTRL_RSP_SIZE, 0x64)
+REG32(CRB_CTRL_RSP_ADDR, 0x68)
+REG32(CRB_DATA_BUFFER, 0x80)
+
+#define TPM_CRB_ADDR_BASE           0xFED40000
+#define TPM_CRB_ADDR_SIZE           0x1000
+#define TPM_CRB_ADDR_CTRL           (TPM_CRB_ADDR_BASE + A_CRB_CTRL_REQ)
+#define TPM_CRB_R_MAX               R_CRB_DATA_BUFFER
+
 #define TPM_LOG_AREA_MINIMUM_SIZE   (64 * 1024)
=20
 #define TPM_TCPA_ACPI_CLASS_CLIENT  0
@@ -30,5 +80,6 @@
 #define TPM2_ACPI_CLASS_SERVER      1
=20
 #define TPM2_START_METHOD_MMIO      6
+#define TPM2_START_METHOD_CRB       7
=20
 #endif /* HW_ACPI_TPM_H */
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index ac04a9d..233b1a3 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -46,9 +46,12 @@ typedef struct TPMIfClass {
 } TPMIfClass;
=20
 #define TYPE_TPM_TIS                "tpm-tis"
+#define TYPE_TPM_CRB                "tpm-crb"
=20
 #define TPM_IS_TIS(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
+#define TPM_IS_CRB(chr)                             \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
=20
 /* returns NULL unless there is exactly one TPM device */
 static inline TPMIf *tpm_find(void)
diff --git a/qapi/tpm.json b/qapi/tpm.json
index 7093f26..d50deef 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -11,10 +11,11 @@
 # An enumeration of TPM models
 #
 # @tpm-tis: TPM TIS model
+# @tpm-crb: TPM CRB model (since 2.12)
 #
 # Since: 1.5
 ##
-{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
+{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
=20
 ##
 # @query-tpm-models:
@@ -28,7 +29,7 @@
 # Example:
 #
 # -> { "execute": "query-tpm-models" }
-# <- { "return": [ "tpm-tis" ] }
+# <- { "return": [ "tpm-tis", "tpm-crb" ] }
 #
 ##
 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 851aafe..ca82e0c 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -286,6 +286,7 @@ check-qtest-i386-$(CONFIG_VHOST_USER_NET_TEST_i386) +=
=3D tests/vhost-user-test$(EX
 ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
 check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) +=3D tests/vhost=
-user-test$(EXESUF)
 endif
+check-qtest-i386-$(CONFIG_TPM) +=3D tests/tpm-crb-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(EXES=
UF)
@@ -708,6 +709,7 @@ tests/test-crypto-tlssession$(EXESUF): tests/test-cry=
pto-tlssession.o \
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
+tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o $(test-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
 tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
diff --git a/tests/tpm-crb-test.c b/tests/tpm-crb-test.c
new file mode 100644
index 0000000..8bf1507
--- /dev/null
+++ b/tests/tpm-crb-test.c
@@ -0,0 +1,275 @@
+/*
+ * QTest testcase for TPM CRB
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Authors:
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <glib/gstdio.h>
+
+#include "hw/acpi/tpm.h"
+#include "hw/tpm/tpm_ioctl.h"
+#include "io/channel-socket.h"
+#include "libqtest.h"
+#include "qapi/error.h"
+
+#define TPM_RC_FAILURE 0x101
+#define TPM2_ST_NO_SESSIONS 0x8001
+
+struct tpm_hdr {
+    uint16_t tag;
+    uint32_t len;
+    uint32_t code; /*ordinal/error */
+    char buffer[];
+} QEMU_PACKED;
+
+typedef struct TestState {
+    CompatGMutex data_mutex;
+    CompatGCond data_cond;
+    SocketAddress *addr;
+    QIOChannel *tpm_ioc;
+    GThread *emu_tpm_thread;
+    struct tpm_hdr *tpm_msg;
+} TestState;
+
+static void test_wait_cond(TestState *s)
+{
+    gint64 end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECOND;
+
+    g_mutex_lock(&s->data_mutex);
+    if (!g_cond_wait_until(&s->data_cond, &s->data_mutex, end_time)) {
+        g_assert_not_reached();
+    }
+    g_mutex_unlock(&s->data_mutex);
+}
+
+static void *emu_tpm_thread(void *data)
+{
+    TestState *s =3D data;
+    QIOChannel *ioc =3D s->tpm_ioc;
+
+    s->tpm_msg =3D g_new(struct tpm_hdr, 1);
+    while (true) {
+        int minhlen =3D sizeof(s->tpm_msg->tag) + sizeof(s->tpm_msg->len=
);
+
+        if (!qio_channel_read(ioc, (char *)s->tpm_msg, minhlen, &error_a=
bort)) {
+            break;
+        }
+        s->tpm_msg->tag =3D be16_to_cpu(s->tpm_msg->tag);
+        s->tpm_msg->len =3D be32_to_cpu(s->tpm_msg->len);
+        g_assert_cmpint(s->tpm_msg->len, >=3D, minhlen);
+        g_assert_cmpint(s->tpm_msg->tag, =3D=3D, TPM2_ST_NO_SESSIONS);
+
+        s->tpm_msg =3D g_realloc(s->tpm_msg, s->tpm_msg->len);
+        qio_channel_read(ioc, (char *)&s->tpm_msg->code,
+                         s->tpm_msg->len - minhlen, &error_abort);
+        s->tpm_msg->code =3D be32_to_cpu(s->tpm_msg->code);
+
+        /* reply error */
+        s->tpm_msg->tag =3D cpu_to_be16(TPM2_ST_NO_SESSIONS);
+        s->tpm_msg->len =3D cpu_to_be32(sizeof(struct tpm_hdr));
+        s->tpm_msg->code =3D cpu_to_be32(TPM_RC_FAILURE);
+        qio_channel_write(ioc, (char *)s->tpm_msg, be32_to_cpu(s->tpm_ms=
g->len),
+                          &error_abort);
+    }
+
+    g_free(s->tpm_msg);
+    s->tpm_msg =3D NULL;
+    object_unref(OBJECT(s->tpm_ioc));
+    return NULL;
+}
+
+static void *emu_ctrl_thread(void *data)
+{
+    TestState *s =3D data;
+    QIOChannelSocket *lioc =3D qio_channel_socket_new();
+    QIOChannel *ioc;
+
+    qio_channel_socket_listen_sync(lioc, s->addr, &error_abort);
+    g_cond_signal(&s->data_cond);
+
+    qio_channel_wait(QIO_CHANNEL(lioc), G_IO_IN);
+    ioc =3D QIO_CHANNEL(qio_channel_socket_accept(lioc, &error_abort));
+    g_assert(ioc);
+
+    {
+        uint32_t cmd =3D 0;
+        struct iovec iov =3D { .iov_base =3D &cmd, .iov_len =3D sizeof(c=
md) };
+        int *pfd =3D NULL;
+        size_t nfd =3D 0;
+
+        qio_channel_readv_full(ioc, &iov, 1, &pfd, &nfd, &error_abort);
+        cmd =3D be32_to_cpu(cmd);
+        g_assert_cmpint(cmd, =3D=3D, CMD_SET_DATAFD);
+        g_assert_cmpint(nfd, =3D=3D, 1);
+        s->tpm_ioc =3D QIO_CHANNEL(qio_channel_socket_new_fd(*pfd, &erro=
r_abort));
+        g_free(pfd);
+
+        cmd =3D 0;
+        qio_channel_write(ioc, (char *)&cmd, sizeof(cmd), &error_abort);
+
+        s->emu_tpm_thread =3D g_thread_new(NULL, emu_tpm_thread, s);
+    }
+
+    while (true) {
+        uint32_t cmd;
+        ssize_t ret;
+
+        ret =3D qio_channel_read(ioc, (char *)&cmd, sizeof(cmd), NULL);
+        if (ret <=3D 0) {
+            break;
+        }
+
+        cmd =3D be32_to_cpu(cmd);
+        switch (cmd) {
+        case CMD_GET_CAPABILITY: {
+            ptm_cap cap =3D cpu_to_be64(0x3fff);
+            qio_channel_write(ioc, (char *)&cap, sizeof(cap), &error_abo=
rt);
+            break;
+        }
+        case CMD_INIT: {
+            ptm_init init;
+            qio_channel_read(ioc, (char *)&init.u.req, sizeof(init.u.req=
),
+                              &error_abort);
+            init.u.resp.tpm_result =3D 0;
+            qio_channel_write(ioc, (char *)&init.u.resp, sizeof(init.u.r=
esp),
+                              &error_abort);
+            break;
+        }
+        case CMD_SHUTDOWN: {
+            ptm_res res =3D 0;
+            qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
+            qio_channel_close(s->tpm_ioc, &error_abort);
+            g_thread_join(s->emu_tpm_thread);
+            break;
+        }
+        case CMD_STOP: {
+            ptm_res res =3D 0;
+            qio_channel_write(ioc, (char *)&res, sizeof(res), &error_abo=
rt);
+            break;
+        }
+        case CMD_SET_BUFFERSIZE: {
+            ptm_setbuffersize sbs;
+            qio_channel_read(ioc, (char *)&sbs.u.req, sizeof(sbs.u.req),
+                             &error_abort);
+            sbs.u.resp.buffersize =3D sbs.u.req.buffersize ?: cpu_to_be3=
2(4096);
+            sbs.u.resp.tpm_result =3D 0;
+            sbs.u.resp.minsize =3D cpu_to_be32(128);
+            sbs.u.resp.maxsize =3D cpu_to_be32(4096);
+            qio_channel_write(ioc, (char *)&sbs.u.resp, sizeof(sbs.u.res=
p),
+                              &error_abort);
+            break;
+        }
+        case CMD_SET_LOCALITY: {
+            ptm_loc loc;
+            /* Note: this time it's not u.req / u.resp... */
+            qio_channel_read(ioc, (char *)&loc, sizeof(loc), &error_abor=
t);
+            g_assert_cmpint(loc.u.req.loc, =3D=3D, 0);
+            loc.u.resp.tpm_result =3D 0;
+            qio_channel_write(ioc, (char *)&loc, sizeof(loc), &error_abo=
rt);
+            break;
+        }
+        default:
+            g_debug("unimplemented %u", cmd);
+            g_assert_not_reached();
+        }
+    }
+
+    object_unref(OBJECT(ioc));
+    object_unref(OBJECT(lioc));
+    return NULL;
+}
+
+#define TPM_CMD "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00"
+
+static void tpm_crb_test(const void *data)
+{
+    const TestState *s =3D data;
+    uint32_t intfid =3D readl(TPM_CRB_ADDR_BASE + A_CRB_INTF_ID);
+    uint32_t csize =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_SIZE);
+    uint64_t caddr =3D readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_CMD_LADDR);
+    uint32_t rsize =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_SIZE);
+    uint64_t raddr =3D readq(TPM_CRB_ADDR_BASE + A_CRB_CTRL_RSP_ADDR);
+
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceType), =3D=3D=
, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceVersion), =3D=
=3D, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapLocality), =3D=3D=
, 0);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRBIdleBypass), =3D=
=3D, 0);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapDataXferSizeSuppo=
rt),
+                    =3D=3D, 3);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapFIFO), =3D=3D, 0)=
;
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, CapCRB), =3D=3D, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, InterfaceSelector), =
=3D=3D, 1);
+    g_assert_cmpint(FIELD_EX32(intfid, CRB_INTF_ID, RID), =3D=3D, 0);
+
+    g_assert_cmpint(csize, >=3D, 128);
+    g_assert_cmpint(rsize, >=3D, 128);
+    g_assert_cmpint(caddr, >, TPM_CRB_ADDR_BASE);
+    g_assert_cmpint(raddr, >, TPM_CRB_ADDR_BASE);
+
+    memwrite(caddr, TPM_CMD, sizeof(TPM_CMD));
+
+    uint32_t sts, start =3D 1;
+    uint64_t end_time =3D g_get_monotonic_time() + 5 * G_TIME_SPAN_SECON=
D;
+    writel(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START, start);
+    do {
+        start =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
+        if ((start & 1) =3D=3D 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+    start =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_START);
+    g_assert_cmpint(start & 1, =3D=3D, 0);
+    sts =3D readl(TPM_CRB_ADDR_BASE + A_CRB_CTRL_STS);
+    g_assert_cmpint(sts & 1, =3D=3D, 0);
+
+    struct tpm_hdr tpm_msg;
+    memread(raddr, &tpm_msg, sizeof(tpm_msg));
+    g_assert_cmpmem(&tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tp=
m_msg));
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    char *args, *tmp_path =3D g_dir_make_tmp("qemu-tpm-crb-test.XXXXXX",=
 NULL);
+    GThread *thread;
+    TestState test;
+
+    module_call_init(MODULE_INIT_QOM);
+    g_test_init(&argc, &argv, NULL);
+
+    test.addr =3D g_new0(SocketAddress, 1);
+    test.addr->type =3D SOCKET_ADDRESS_TYPE_UNIX;
+    test.addr->u.q_unix.path =3D g_build_filename(tmp_path, "sock", NULL=
);
+    g_mutex_init(&test.data_mutex);
+    g_cond_init(&test.data_cond);
+
+    thread =3D g_thread_new(NULL, emu_ctrl_thread, &test);
+    test_wait_cond(&test);
+
+    args =3D g_strdup_printf(
+        "-chardev socket,id=3Dchr,path=3D%s "
+        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
+        "-device tpm-crb,tpmdev=3Ddev",
+        test.addr->u.q_unix.path);
+    qtest_start(args);
+
+    qtest_add_data_func("/tpm-crb/test", &test, tpm_crb_test);
+    ret =3D g_test_run();
+
+    qtest_end();
+
+    g_thread_join(thread);
+    g_unlink(test.addr->u.q_unix.path);
+    qapi_free_SocketAddress(test.addr);
+    g_rmdir(tmp_path);
+    g_free(tmp_path);
+    g_free(args);
+    return ret;
+}
--=20
2.5.5
