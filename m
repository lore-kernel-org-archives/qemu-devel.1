Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYahJ-0007QL-3i
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fYahH-0003uI-JA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:27:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fYahH-0003tI-Dl
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 13:27:07 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 28 Jun 2018 19:26:55 +0200
Message-Id: <20180628172657.11646-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180628172657.11646-1-marcandre.lureau@redhat.com>
References: <20180628172657.11646-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 2/4] tpm: implement virtual memory device
 for TPM PPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Implement a virtual memory device for the TPM Physical Presence interface=
.
The memory is located at 0xFED45000 and used by ACPI to send messages to =
the
firmware (BIOS) and by the firmware to provide parameters for each one of
the supported codes.

This device should be used by all TPM interfaces on x86 and can be added
by calling tpm_ppi_init_io().

Note: bios_linker cannot be used to allocate the PPI memory region,
since the reserved memory should stay stable across reboots, and might
be needed before the ACPI tables are installed.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---

v5 (Marc-Andr=C3=A9):
 - replace mmio region with ram

v4 (Marc-Andr=C3=A9):
 - pass TPM_PPI_ADDR_BASE as argument to tpm_ppi_init_io()
 - only enable PPI if property is set

v3 (Marc-Andr=C3=A9):
 - merge CRB support
 - use trace events instead of DEBUG printf
 - headers inclusion simplification

v2:
 - moved to byte access since an infrequently used device;
   this simplifies code
 - increase size of device to 0x400
 - move device to 0xfffef000 since SeaBIOS has some code at 0xffff0000:
   'On the emulators, the bios at 0xf0000 is also at 0xffff0000'
---
 hw/tpm/tpm_ppi.h      | 25 +++++++++++++++++++++++++
 include/hw/acpi/tpm.h |  6 ++++++
 hw/tpm/tpm_crb.c      |  8 ++++++++
 hw/tpm/tpm_ppi.c      | 33 +++++++++++++++++++++++++++++++++
 hw/tpm/tpm_tis.c      |  8 ++++++++
 hw/tpm/Makefile.objs  |  2 +-
 hw/tpm/trace-events   |  4 ++++
 7 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
new file mode 100644
index 0000000000..10e760fdd5
--- /dev/null
+++ b/hw/tpm/tpm_ppi.h
@@ -0,0 +1,25 @@
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
+} TPMPPI;
+
+bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
+                  hwaddr addr, Object *obj, Error **errp);
+
+#endif /* TPM_TPM_PPI_H */
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 46ac4dc581..c082df7d1d 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -187,4 +187,10 @@ REG32(CRB_DATA_BUFFER, 0x80)
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
index d5b0ac5920..b243222fd6 100644
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
@@ -294,6 +296,12 @@ static void tpm_crb_realize(DeviceState *dev, Error =
**errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
=20
+    if (s->ppi_enabled &&
+        !tpm_ppi_init(&s->ppi, get_system_memory(),
+                      TPM_PPI_ADDR_BASE, OBJECT(s), errp)) {
+        return;
+    }
+
     qemu_register_reset(tpm_crb_reset, dev);
 }
=20
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
new file mode 100644
index 0000000000..987daf099f
--- /dev/null
+++ b/hw/tpm/tpm_ppi.c
@@ -0,0 +1,33 @@
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
+#include "tpm_ppi.h"
+
+bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
+                  hwaddr addr, Object *obj, Error **errp)
+{
+    Error *err =3D NULL;
+
+    memory_region_init_ram(&tpmppi->ram, obj, "tpm-ppi",
+                           TPM_PPI_ADDR_SIZE, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return false;
+    }
+
+    memory_region_add_subregion(m, addr, &tpmppi->ram);
+    return true;
+}
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d9ddf9b723..70432ffe8b 100644
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
@@ -979,6 +981,12 @@ static void tpm_tis_realizefn(DeviceState *dev, Erro=
r **errp)
=20
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
+
+    if (s->ppi_enabled &&
+        !tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                      TPM_PPI_ADDR_BASE, OBJECT(s), errp)) {
+        return;
+    }
 }
=20
 static void tpm_tis_initfn(Object *obj)
diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 1dc9f8bf2c..eedd8b6858 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y +=3D tpm_util.o
+common-obj-y +=3D tpm_util.o tpm_ppi.o
 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
 common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index 25bee0cecf..81f9923401 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -8,6 +8,10 @@ tpm_crb_mmio_write(uint64_t addr, unsigned size, uint32_=
t val) "CRB write 0x" TA
 tpm_passthrough_handle_request(void *cmd) "processing command %p"
 tpm_passthrough_reset(void) "reset"
=20
+# hw/tpm/tpm_ppi.c
+tpm_ppi_mmio_read(uint64_t addr, unsigned size, uint32_t val) "PPI read =
0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
+tpm_ppi_mmio_write(uint64_t addr, unsigned size, uint32_t val) "PPI writ=
e 0x" TARGET_FMT_plx " len:%u val: 0x%" PRIx32
+
 # hw/tpm/tpm_util.c
 tpm_util_get_buffer_size_hdr_len(uint32_t len, size_t expected) "tpm_res=
p->hdr.len =3D %u, expected =3D %zu"
 tpm_util_get_buffer_size_len(uint32_t len, size_t expected) "tpm_resp->l=
en =3D %u, expected =3D %zu"
--=20
2.18.0.rc1
