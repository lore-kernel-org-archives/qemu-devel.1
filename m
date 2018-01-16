Received: from eggs.gnu.org ([2001:4830:134:3::10]:53632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWo-0002m8-HV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ebTWi-0003sD-Kt
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43140
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ebTWi-0003rM-F4
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:51:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0GFnbnW037709
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:50 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fhm4m0vfx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 10:51:49 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 16 Jan 2018 08:51:49 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 16 Jan 2018 10:51:37 -0500
In-Reply-To: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1516117900-11382-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/4] tpm: implement virtual memory device
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
Cc: mst@redhat.com, stefanb@linux.vnet.ibm.com, kevin@koconnor.net, marcandre.lureau@redhat.com, lersek@redhat.com

Implement a virtual memory device for the TPM Physical Presence interface.
The memory is located at 0xfffef000 and used by ACPI to send messages to the
firmware (BIOS) and by the firmware to provide parameters for each one of
the supported codes.

This device should be used by all TPM interfaces on x86 and can be added
by calling tpm_ppi_init_io().

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

---

v1->v2:
 - moved to byte access since an infrequently used device;
   this simplifies code
 - increase size of device to 0x400
 - move device to 0xfffef000 since SeaBIOS has some code at 0xffff0000:
   'On the emulators, the bios at 0xf0000 is also at 0xffff0000'
---
 hw/tpm/Makefile.objs  |  2 +-
 hw/tpm/tpm_ppi.c      | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/tpm/tpm_ppi.h      | 26 ++++++++++++++++++++
 hw/tpm/tpm_tis.c      |  5 ++++
 include/hw/acpi/tpm.h |  6 +++++
 5 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 hw/tpm/tpm_ppi.c
 create mode 100644 hw/tpm/tpm_ppi.h

diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
index 7a93b24..3eb0558 100644
--- a/hw/tpm/Makefile.objs
+++ b/hw/tpm/Makefile.objs
@@ -1,4 +1,4 @@
-common-obj-y += tpm_util.o
+common-obj-y += tpm_util.o tpm_ppi.o
 common-obj-$(CONFIG_TPM_TIS) += tpm_tis.o
 common-obj-$(CONFIG_TPM_PASSTHROUGH) += tpm_passthrough.o
 common-obj-$(CONFIG_TPM_EMULATOR) += tpm_emulator.o
diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
new file mode 100644
index 0000000..98e8318
--- /dev/null
+++ b/hw/tpm/tpm_ppi.c
@@ -0,0 +1,67 @@
+/*
+ * tpm_ppi.c - TPM Physical Presence Interface
+ *
+ * Copyright (C) 2018 IBM Corporation
+ *
+ * Authors:
+ *  Stefan Berger <stefanb@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "exec/memory.h"
+#include "exec/address-spaces.h"
+
+#include "tpm_ppi.h"
+
+#define DEBUG_PPI 0
+
+#define DPRINTF(fmt, ...) do { \
+    if (DEBUG_PPI) { \
+        printf(fmt, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+static uint64_t tpm_ppi_mmio_read(void *opaque, hwaddr addr,
+                                  unsigned size)
+{
+    TPMPPI *s = opaque;
+
+    DPRINTF("tpm_ppi:  read(%04x) = %02x\n",
+            (unsigned int)addr, (unsigned int)s->ram[addr]);
+
+    return s->ram[addr];
+}
+
+static void tpm_ppi_mmio_write(void *opaque, hwaddr addr,
+                               uint64_t val, unsigned size)
+{
+    TPMPPI *s = opaque;
+
+    DPRINTF("tpm_ppi: write(%04x) = %02x\n",
+            (unsigned int)addr, (unsigned int)val);
+
+    s->ram[addr] = val;
+}
+
+static const MemoryRegionOps tpm_ppi_memory_ops = {
+    .read = tpm_ppi_mmio_read,
+    .write = tpm_ppi_mmio_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 1,
+    },
+};
+
+void tpm_ppi_init_io(TPMPPI *tpmppi, struct MemoryRegion *m, Object *obj)
+{
+    memory_region_init_io(&tpmppi->mmio, obj, &tpm_ppi_memory_ops,
+                          tpmppi, "tpm-ppi-mmio",
+                          TPM_PPI_ADDR_SIZE);
+
+    memory_region_add_subregion(m, TPM_PPI_ADDR_BASE, &tpmppi->mmio);
+}
diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
new file mode 100644
index 0000000..17030bd
--- /dev/null
+++ b/hw/tpm/tpm_ppi.h
@@ -0,0 +1,26 @@
+/*
+ * TPM Physical Presence Interface
+ *
+ * Copyright (C) 2018 IBM Corporation
+ *
+ * Authors:
+ *  Stefan Berger    <stefanb@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
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
+void tpm_ppi_init_io(TPMPPI *tpmppi, struct MemoryRegion *m, Object *obj);
+
+#endif /* TPM_TPM_PPI_H */
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 561384c..13e7dd3 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -31,6 +31,7 @@
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
+#include "tpm_ppi.h"
 
 #define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
 #define TPM_TIS_LOCALITY_SHIFT      12
@@ -80,6 +81,8 @@ typedef struct TPMState {
     TPMVersion be_tpm_version;
 
     size_t be_buffer_size;
+
+    TPMPPI ppi;
 } TPMState;
 
 #define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
@@ -1041,6 +1044,8 @@ static void tpm_tis_realizefn(DeviceState *dev, Error **errp)
 
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
+
+    tpm_ppi_init_io(&s->ppi, isa_address_space(ISA_DEVICE(dev)), OBJECT(s));
 }
 
 static void tpm_tis_initfn(Object *obj)
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 6d516c6..16227bc 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -31,4 +31,10 @@
 
 #define TPM2_START_METHOD_MMIO      6
 
+/*
+ * Physical Presence Interface
+ */
+#define TPM_PPI_ADDR_SIZE           0x400
+#define TPM_PPI_ADDR_BASE           0xfffef000
+
 #endif /* HW_ACPI_TPM_H */
-- 
2.5.5
