Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fXn0j-00036K-Ci
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fXn0h-0008IB-Vu
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:23:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fXn0h-0008I6-QG
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 08:23:51 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 26 Jun 2018 14:23:41 +0200
Message-Id: <20180626122343.13473-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180626122343.13473-1-marcandre.lureau@redhat.com>
References: <20180626122343.13473-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 2/4] tpm: implement virtual memory device
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

Implement a virtual memory device for the TPM Physical Presence interface=
.
The memory is located at 0xFED45000 and used by ACPI to send messages to =
the
firmware (BIOS) and by the firmware to provide parameters for each one of
the supported codes.

This device should be used by all TPM interfaces on x86 and can be added
by calling tpm_ppi_init_io().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---

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
 hw/tpm/tpm_ppi.h      | 27 ++++++++++++++++++++
 include/hw/acpi/tpm.h |  6 +++++
 hw/tpm/tpm_crb.c      |  7 ++++++
 hw/tpm/tpm_ppi.c      | 57 +++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_tis.c      |  7 ++++++
 hw/tpm/Makefile.objs  |  2 +-
 hw/tpm/trace-events   |  4 +++
 7 files changed, 109 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_ppi.h
 create mode 100644 hw/tpm/tpm_ppi.c

diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
new file mode 100644
index 0000000000..ac7ad47238
--- /dev/null
+++ b/hw/tpm/tpm_ppi.h
@@ -0,0 +1,27 @@
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
+    MemoryRegion mmio;
+
+    uint8_t ram[TPM_PPI_ADDR_SIZE];
+} TPMPPI;
+
+void tpm_ppi_init_io(TPMPPI *tpmppi, struct MemoryRegion *m,
+                     hwaddr addr, Object *obj);
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
index d5b0ac5920..37c095f00f 100644
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
+        tpm_ppi_init_io(&s->ppi, get_system_memory(),
+                        TPM_PPI_ADDR_BASE, OBJECT(s));
+    }
+
     qemu_register_reset(tpm_crb_reset, dev);
 }
=20
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
new file mode 100644
index 0000000000..79bec186c7
--- /dev/null
+++ b/hw/tpm/tpm_ppi.c
@@ -0,0 +1,57 @@
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
+#include "tpm_ppi.h"
+#include "trace.h"
+
+static uint64_t tpm_ppi_mmio_read(void *opaque, hwaddr addr,
+                                  unsigned size)
+{
+    TPMPPI *s =3D opaque;
+
+    trace_tpm_ppi_mmio_read(addr, size, s->ram[addr]);
+
+    return s->ram[addr];
+}
+
+static void tpm_ppi_mmio_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size)
+{
+    TPMPPI *s =3D opaque;
+
+    trace_tpm_ppi_mmio_write(addr, size, val);
+
+    s->ram[addr] =3D val;
+}
+
+static const MemoryRegionOps tpm_ppi_memory_ops =3D {
+    .read =3D tpm_ppi_mmio_read,
+    .write =3D tpm_ppi_mmio_write,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 1,
+        .max_access_size =3D 1,
+    },
+};
+
+void tpm_ppi_init_io(TPMPPI *tpmppi, struct MemoryRegion *m,
+                     hwaddr addr, Object *obj)
+{
+    memory_region_init_io(&tpmppi->mmio, obj, &tpm_ppi_memory_ops,
+                          tpmppi, "tpm-ppi-mmio",
+                          TPM_PPI_ADDR_SIZE);
+
+    memory_region_add_subregion(m, addr, &tpmppi->mmio);
+}
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d9ddf9b723..e7f45a05b9 100644
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
@@ -979,6 +981,11 @@ static void tpm_tis_realizefn(DeviceState *dev, Erro=
r **errp)
=20
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
+
+    if (s->ppi_enabled) {
+        tpm_ppi_init_io(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                        TPM_PPI_ADDR_BASE, OBJECT(s));
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
