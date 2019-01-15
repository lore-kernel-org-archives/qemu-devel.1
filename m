Received: from eggs.gnu.org ([209.51.188.92]:35216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyT-0007aH-RD
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjUyO-0003Ku-5i
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gjUyJ-0003Bg-H5
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 15:06:06 -0500
Date: Tue, 15 Jan 2019 15:05:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190115200252.25911-39-mst@redhat.com>
References: <20190115200252.25911-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115200252.25911-1-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 38/49] tpm: allocate/map buffer for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Implement a virtual memory device for the TPM Physical Presence interface=
.
The memory is located at 0xFED45000 and used by ACPI to send messages to =
the
firmware (BIOS) and by the firmware to provide parameters for each one of
the supported codes.

This interface should be used by all TPM devices on x86 and can be
added by calling tpm_ppi_init_io().

Note: bios_linker cannot be used to allocate the PPI memory region,
since the reserved memory should stay stable across reboots, and might
be needed before the ACPI tables are installed.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/tpm/tpm_ppi.h      | 36 ++++++++++++++++++++++++++++++++++++
 include/hw/acpi/tpm.h |  6 ++++++
 hw/tpm/tpm_crb.c      |  7 +++++++
 hw/tpm/tpm_ppi.c      | 31 +++++++++++++++++++++++++++++++
 hw/tpm/tpm_tis.c      |  7 +++++++
 hw/tpm/Makefile.objs  |  1 +
 6 files changed, 88 insertions(+)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
new file mode 100644
index 0000000000..c5e555fe2c
--- /dev/null
+++ b/hw/tpm/tpm_ppi.h
@@ -0,0 +1,36 @@
+/*
+ * TPM Physical Presence Interface
+ *
+ * Copyright (C) 2018 IBM Corporation
+ *
+ * Authors:
+ *  Stefan Berger    <stefanb@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ */
+#ifndef TPM_TPM_PPI_H
+#define TPM_TPM_PPI_H
+
+#include "hw/acpi/tpm.h"
+#include "exec/address-spaces.h"
+
+typedef struct TPMPPI {
+    MemoryRegion ram;
+    uint8_t *buf;
+} TPMPPI;
+
+/**
+ * tpm_ppi_init:
+ * @tpmppi: a TPMPPI
+ * @m: the address-space / MemoryRegion to use
+ * @addr: the address of the PPI region
+ * @obj: the owner object
+ *
+ * Register the TPM PPI memory region at @addr on the given address
+ * space for the object @obj.
+ **/
+void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
+                  hwaddr addr, Object *obj);
+
+#endif /* TPM_TPM_PPI_H */
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 3580ffd50c..b8796df916 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -188,4 +188,10 @@ REG32(CRB_DATA_BUFFER, 0x80)
 #define TPM2_START_METHOD_MMIO      6
 #define TPM2_START_METHOD_CRB       7
=20
+/*
+ * Physical Presence Interface
+ */
+#define TPM_PPI_ADDR_SIZE           0x400
+#define TPM_PPI_ADDR_BASE           0xFED45000
+
 #endif /* HW_ACPI_TPM_H */
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index d5b0ac5920..012ec686d4 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -29,6 +29,7 @@
 #include "sysemu/reset.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
+#include "tpm_ppi.h"
 #include "trace.h"
=20
 typedef struct CRBState {
@@ -43,6 +44,7 @@ typedef struct CRBState {
     size_t be_buffer_size;
=20
     bool ppi_enabled;
+    TPMPPI ppi;
 } CRBState;
=20
 #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
@@ -294,6 +296,11 @@ static void tpm_crb_realize(DeviceState *dev, Error =
**errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
=20
+    if (s->ppi_enabled) {
+        tpm_ppi_init(&s->ppi, get_system_memory(),
+                     TPM_PPI_ADDR_BASE, OBJECT(s));
+    }
+
     qemu_register_reset(tpm_crb_reset, dev);
 }
=20
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
new file mode 100644
index 0000000000..cf17779c20
--- /dev/null
+++ b/hw/tpm/tpm_ppi.c
@@ -0,0 +1,31 @@
+/*
+ * tpm_ppi.c - TPM Physical Presence Interface
+ *
+ * Copyright (C) 2018 IBM Corporation
+ *
+ * Authors:
+ *  Stefan Berger <stefanb@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "cpu.h"
+#include "sysemu/memory_mapping.h"
+#include "migration/vmstate.h"
+#include "tpm_ppi.h"
+
+void tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
+                  hwaddr addr, Object *obj)
+{
+    tpmppi->buf =3D g_malloc0(HOST_PAGE_ALIGN(TPM_PPI_ADDR_SIZE));
+    memory_region_init_ram_device_ptr(&tpmppi->ram, obj, "tpm-ppi",
+                                      TPM_PPI_ADDR_SIZE, tpmppi->buf);
+    vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
+
+    memory_region_add_subregion(m, addr, &tpmppi->ram);
+}
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 1698d83cd3..02d9d5c911 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -31,6 +31,7 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
+#include "tpm_ppi.h"
 #include "trace.h"
=20
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
@@ -83,6 +84,7 @@ typedef struct TPMState {
     size_t be_buffer_size;
=20
     bool ppi_enabled;
+    TPMPPI ppi;
 } TPMState;
=20
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -983,6 +985,11 @@ static void tpm_tis_realizefn(DeviceState *dev, Erro=
r **errp)
=20
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
+
+    if (s->ppi_enabled) {
+        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                     TPM_PPI_ADDR_BASE, OBJECT(s));
+    }
 }
=20
 static void tpm_tis_initfn(Object *obj)
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 1dc9f8bf2c..700c878622 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,4 +1,5 @@
 common-obj-y +=3D tpm_util.o
+obj-y +=3D tpm_ppi.o
 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
 common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
--=20
MST
