Received: from eggs.gnu.org ([2001:4830:134:3::10]:57122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1epL4Q-0004dT-AS
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:40:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1epL4M-00062s-6o
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:39:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47438
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1epL4L-00061N-UL
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 16:39:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NLd3Lu006787
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:39:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gatx488mw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 16:39:51 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 16:39:51 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 16:39:45 -0500
In-Reply-To: <1519421985-18185-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1519421985-18185-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1519421985-18185-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 2/2] tests: add test for TPM TIS device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Move the TPM TIS related register and flag #defines into
include/hw/acpi/tpm.h for access by the test case.

Write a test case that covers the TIS functionality.

Add the tests cases to the MAINTAINERS file.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS            |   1 +
 hw/tpm/tpm_tis.c       | 101 ----------
 include/hw/acpi/tpm.h  | 105 +++++++++++
 tests/Makefile.include |   2 +
 tests/tpm-emu.c        |   7 +
 tests/tpm-tis-test.c   | 486 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 6 files changed, 601 insertions(+), 101 deletions(-)
 create mode 100644 tests/tpm-tis-test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e7adad..8c1ae1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1633,6 +1633,7 @@ F: include/hw/acpi/tpm.h
 F: include/sysemu/tpm*
 F: qapi/tpm.json
 F: backends/tpm.c
+F: tests/*tpm*
 T: git git://github.com/stefanberger/qemu-tpm.git tpm-next
=20
 Checkpatch
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index f81168a..834eef7 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -92,107 +92,6 @@ typedef struct TPMState {
     } \
 } while (0)
=20
-/* tis registers */
-#define TPM_TIS_REG_ACCESS                0x00
-#define TPM_TIS_REG_INT_ENABLE            0x08
-#define TPM_TIS_REG_INT_VECTOR            0x0c
-#define TPM_TIS_REG_INT_STATUS            0x10
-#define TPM_TIS_REG_INTF_CAPABILITY       0x14
-#define TPM_TIS_REG_STS                   0x18
-#define TPM_TIS_REG_DATA_FIFO             0x24
-#define TPM_TIS_REG_INTERFACE_ID          0x30
-#define TPM_TIS_REG_DATA_XFIFO            0x80
-#define TPM_TIS_REG_DATA_XFIFO_END        0xbc
-#define TPM_TIS_REG_DID_VID               0xf00
-#define TPM_TIS_REG_RID                   0xf04
-
-/* vendor-specific registers */
-#define TPM_TIS_REG_DEBUG                 0xf90
-
-#define TPM_TIS_STS_TPM_FAMILY_MASK         (0x3 << 26)/* TPM 2.0 */
-#define TPM_TIS_STS_TPM_FAMILY1_2           (0 << 26)  /* TPM 2.0 */
-#define TPM_TIS_STS_TPM_FAMILY2_0           (1 << 26)  /* TPM 2.0 */
-#define TPM_TIS_STS_RESET_ESTABLISHMENT_BIT (1 << 25)  /* TPM 2.0 */
-#define TPM_TIS_STS_COMMAND_CANCEL          (1 << 24)  /* TPM 2.0 */
-
-#define TPM_TIS_STS_VALID                 (1 << 7)
-#define TPM_TIS_STS_COMMAND_READY         (1 << 6)
-#define TPM_TIS_STS_TPM_GO                (1 << 5)
-#define TPM_TIS_STS_DATA_AVAILABLE        (1 << 4)
-#define TPM_TIS_STS_EXPECT                (1 << 3)
-#define TPM_TIS_STS_SELFTEST_DONE         (1 << 2)
-#define TPM_TIS_STS_RESPONSE_RETRY        (1 << 1)
-
-#define TPM_TIS_BURST_COUNT_SHIFT         8
-#define TPM_TIS_BURST_COUNT(X) \
-    ((X) << TPM_TIS_BURST_COUNT_SHIFT)
-
-#define TPM_TIS_ACCESS_TPM_REG_VALID_STS  (1 << 7)
-#define TPM_TIS_ACCESS_ACTIVE_LOCALITY    (1 << 5)
-#define TPM_TIS_ACCESS_BEEN_SEIZED        (1 << 4)
-#define TPM_TIS_ACCESS_SEIZE              (1 << 3)
-#define TPM_TIS_ACCESS_PENDING_REQUEST    (1 << 2)
-#define TPM_TIS_ACCESS_REQUEST_USE        (1 << 1)
-#define TPM_TIS_ACCESS_TPM_ESTABLISHMENT  (1 << 0)
-
-#define TPM_TIS_INT_ENABLED               (1 << 31)
-#define TPM_TIS_INT_DATA_AVAILABLE        (1 << 0)
-#define TPM_TIS_INT_STS_VALID             (1 << 1)
-#define TPM_TIS_INT_LOCALITY_CHANGED      (1 << 2)
-#define TPM_TIS_INT_COMMAND_READY         (1 << 7)
-
-#define TPM_TIS_INT_POLARITY_MASK         (3 << 3)
-#define TPM_TIS_INT_POLARITY_LOW_LEVEL    (1 << 3)
-
-#define TPM_TIS_INTERRUPTS_SUPPORTED (TPM_TIS_INT_LOCALITY_CHANGED | \
-                                      TPM_TIS_INT_DATA_AVAILABLE   | \
-                                      TPM_TIS_INT_STS_VALID | \
-                                      TPM_TIS_INT_COMMAND_READY)
-
-#define TPM_TIS_CAP_INTERFACE_VERSION1_3 (2 << 28)
-#define TPM_TIS_CAP_INTERFACE_VERSION1_3_FOR_TPM2_0 (3 << 28)
-#define TPM_TIS_CAP_DATA_TRANSFER_64B    (3 << 9)
-#define TPM_TIS_CAP_DATA_TRANSFER_LEGACY (0 << 9)
-#define TPM_TIS_CAP_BURST_COUNT_DYNAMIC  (0 << 8)
-#define TPM_TIS_CAP_INTERRUPT_LOW_LEVEL  (1 << 4) /* support is mandator=
y */
-#define TPM_TIS_CAPABILITIES_SUPPORTED1_3 \
-    (TPM_TIS_CAP_INTERRUPT_LOW_LEVEL | \
-     TPM_TIS_CAP_BURST_COUNT_DYNAMIC | \
-     TPM_TIS_CAP_DATA_TRANSFER_64B | \
-     TPM_TIS_CAP_INTERFACE_VERSION1_3 | \
-     TPM_TIS_INTERRUPTS_SUPPORTED)
-
-#define TPM_TIS_CAPABILITIES_SUPPORTED2_0 \
-    (TPM_TIS_CAP_INTERRUPT_LOW_LEVEL | \
-     TPM_TIS_CAP_BURST_COUNT_DYNAMIC | \
-     TPM_TIS_CAP_DATA_TRANSFER_64B | \
-     TPM_TIS_CAP_INTERFACE_VERSION1_3_FOR_TPM2_0 | \
-     TPM_TIS_INTERRUPTS_SUPPORTED)
-
-#define TPM_TIS_IFACE_ID_INTERFACE_TIS1_3   (0xf)     /* TPM 2.0 */
-#define TPM_TIS_IFACE_ID_INTERFACE_FIFO     (0x0)     /* TPM 2.0 */
-#define TPM_TIS_IFACE_ID_INTERFACE_VER_FIFO (0 << 4)  /* TPM 2.0 */
-#define TPM_TIS_IFACE_ID_CAP_5_LOCALITIES   (1 << 8)  /* TPM 2.0 */
-#define TPM_TIS_IFACE_ID_CAP_TIS_SUPPORTED  (1 << 13) /* TPM 2.0 */
-#define TPM_TIS_IFACE_ID_INT_SEL_LOCK       (1 << 19) /* TPM 2.0 */
-
-#define TPM_TIS_IFACE_ID_SUPPORTED_FLAGS1_3 \
-    (TPM_TIS_IFACE_ID_INTERFACE_TIS1_3 | \
-     (~0u << 4)/* all of it is don't care */)
-
-/* if backend was a TPM 2.0: */
-#define TPM_TIS_IFACE_ID_SUPPORTED_FLAGS2_0 \
-    (TPM_TIS_IFACE_ID_INTERFACE_FIFO | \
-     TPM_TIS_IFACE_ID_INTERFACE_VER_FIFO | \
-     TPM_TIS_IFACE_ID_CAP_5_LOCALITIES | \
-     TPM_TIS_IFACE_ID_CAP_TIS_SUPPORTED)
-
-#define TPM_TIS_TPM_DID       0x0001
-#define TPM_TIS_TPM_VID       PCI_VENDOR_ID_IBM
-#define TPM_TIS_TPM_RID       0x0001
-
-#define TPM_TIS_NO_DATA_BYTE  0xff
-
 /* local prototypes */
=20
 static uint64_t tpm_tis_mmio_read(void *opaque, hwaddr addr,
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index 96fd3a9..46ac4dc 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -23,6 +23,111 @@
=20
 #define TPM_TIS_IRQ                 5
=20
+#define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
+#define TPM_TIS_LOCALITY_SHIFT      12
+
+/* tis registers */
+#define TPM_TIS_REG_ACCESS                0x00
+#define TPM_TIS_REG_INT_ENABLE            0x08
+#define TPM_TIS_REG_INT_VECTOR            0x0c
+#define TPM_TIS_REG_INT_STATUS            0x10
+#define TPM_TIS_REG_INTF_CAPABILITY       0x14
+#define TPM_TIS_REG_STS                   0x18
+#define TPM_TIS_REG_DATA_FIFO             0x24
+#define TPM_TIS_REG_INTERFACE_ID          0x30
+#define TPM_TIS_REG_DATA_XFIFO            0x80
+#define TPM_TIS_REG_DATA_XFIFO_END        0xbc
+#define TPM_TIS_REG_DID_VID               0xf00
+#define TPM_TIS_REG_RID                   0xf04
+
+/* vendor-specific registers */
+#define TPM_TIS_REG_DEBUG                 0xf90
+
+#define TPM_TIS_STS_TPM_FAMILY_MASK         (0x3 << 26)/* TPM 2.0 */
+#define TPM_TIS_STS_TPM_FAMILY1_2           (0 << 26)  /* TPM 2.0 */
+#define TPM_TIS_STS_TPM_FAMILY2_0           (1 << 26)  /* TPM 2.0 */
+#define TPM_TIS_STS_RESET_ESTABLISHMENT_BIT (1 << 25)  /* TPM 2.0 */
+#define TPM_TIS_STS_COMMAND_CANCEL          (1 << 24)  /* TPM 2.0 */
+
+#define TPM_TIS_STS_VALID                 (1 << 7)
+#define TPM_TIS_STS_COMMAND_READY         (1 << 6)
+#define TPM_TIS_STS_TPM_GO                (1 << 5)
+#define TPM_TIS_STS_DATA_AVAILABLE        (1 << 4)
+#define TPM_TIS_STS_EXPECT                (1 << 3)
+#define TPM_TIS_STS_SELFTEST_DONE         (1 << 2)
+#define TPM_TIS_STS_RESPONSE_RETRY        (1 << 1)
+
+#define TPM_TIS_BURST_COUNT_SHIFT         8
+#define TPM_TIS_BURST_COUNT(X) \
+    ((X) << TPM_TIS_BURST_COUNT_SHIFT)
+
+#define TPM_TIS_ACCESS_TPM_REG_VALID_STS  (1 << 7)
+#define TPM_TIS_ACCESS_ACTIVE_LOCALITY    (1 << 5)
+#define TPM_TIS_ACCESS_BEEN_SEIZED        (1 << 4)
+#define TPM_TIS_ACCESS_SEIZE              (1 << 3)
+#define TPM_TIS_ACCESS_PENDING_REQUEST    (1 << 2)
+#define TPM_TIS_ACCESS_REQUEST_USE        (1 << 1)
+#define TPM_TIS_ACCESS_TPM_ESTABLISHMENT  (1 << 0)
+
+#define TPM_TIS_INT_ENABLED               (1 << 31)
+#define TPM_TIS_INT_DATA_AVAILABLE        (1 << 0)
+#define TPM_TIS_INT_STS_VALID             (1 << 1)
+#define TPM_TIS_INT_LOCALITY_CHANGED      (1 << 2)
+#define TPM_TIS_INT_COMMAND_READY         (1 << 7)
+
+#define TPM_TIS_INT_POLARITY_MASK         (3 << 3)
+#define TPM_TIS_INT_POLARITY_LOW_LEVEL    (1 << 3)
+
+#define TPM_TIS_INTERRUPTS_SUPPORTED (TPM_TIS_INT_LOCALITY_CHANGED | \
+                                      TPM_TIS_INT_DATA_AVAILABLE   | \
+                                      TPM_TIS_INT_STS_VALID | \
+                                      TPM_TIS_INT_COMMAND_READY)
+
+#define TPM_TIS_CAP_INTERFACE_VERSION1_3 (2 << 28)
+#define TPM_TIS_CAP_INTERFACE_VERSION1_3_FOR_TPM2_0 (3 << 28)
+#define TPM_TIS_CAP_DATA_TRANSFER_64B    (3 << 9)
+#define TPM_TIS_CAP_DATA_TRANSFER_LEGACY (0 << 9)
+#define TPM_TIS_CAP_BURST_COUNT_DYNAMIC  (0 << 8)
+#define TPM_TIS_CAP_INTERRUPT_LOW_LEVEL  (1 << 4) /* support is mandator=
y */
+#define TPM_TIS_CAPABILITIES_SUPPORTED1_3 \
+    (TPM_TIS_CAP_INTERRUPT_LOW_LEVEL | \
+     TPM_TIS_CAP_BURST_COUNT_DYNAMIC | \
+     TPM_TIS_CAP_DATA_TRANSFER_64B | \
+     TPM_TIS_CAP_INTERFACE_VERSION1_3 | \
+     TPM_TIS_INTERRUPTS_SUPPORTED)
+
+#define TPM_TIS_CAPABILITIES_SUPPORTED2_0 \
+    (TPM_TIS_CAP_INTERRUPT_LOW_LEVEL | \
+     TPM_TIS_CAP_BURST_COUNT_DYNAMIC | \
+     TPM_TIS_CAP_DATA_TRANSFER_64B | \
+     TPM_TIS_CAP_INTERFACE_VERSION1_3_FOR_TPM2_0 | \
+     TPM_TIS_INTERRUPTS_SUPPORTED)
+
+#define TPM_TIS_IFACE_ID_INTERFACE_TIS1_3   (0xf)     /* TPM 2.0 */
+#define TPM_TIS_IFACE_ID_INTERFACE_FIFO     (0x0)     /* TPM 2.0 */
+#define TPM_TIS_IFACE_ID_INTERFACE_VER_FIFO (0 << 4)  /* TPM 2.0 */
+#define TPM_TIS_IFACE_ID_CAP_5_LOCALITIES   (1 << 8)  /* TPM 2.0 */
+#define TPM_TIS_IFACE_ID_CAP_TIS_SUPPORTED  (1 << 13) /* TPM 2.0 */
+#define TPM_TIS_IFACE_ID_INT_SEL_LOCK       (1 << 19) /* TPM 2.0 */
+
+#define TPM_TIS_IFACE_ID_SUPPORTED_FLAGS1_3 \
+    (TPM_TIS_IFACE_ID_INTERFACE_TIS1_3 | \
+     (~0u << 4)/* all of it is don't care */)
+
+/* if backend was a TPM 2.0: */
+#define TPM_TIS_IFACE_ID_SUPPORTED_FLAGS2_0 \
+    (TPM_TIS_IFACE_ID_INTERFACE_FIFO | \
+     TPM_TIS_IFACE_ID_INTERFACE_VER_FIFO | \
+     TPM_TIS_IFACE_ID_CAP_5_LOCALITIES | \
+     TPM_TIS_IFACE_ID_CAP_TIS_SUPPORTED)
+
+#define TPM_TIS_TPM_DID       0x0001
+#define TPM_TIS_TPM_VID       PCI_VENDOR_ID_IBM
+#define TPM_TIS_TPM_RID       0x0001
+
+#define TPM_TIS_NO_DATA_BYTE  0xff
+
+
 REG32(CRB_LOC_STATE, 0x00)
   FIELD(CRB_LOC_STATE, tpmEstablished, 0, 1)
   FIELD(CRB_LOC_STATE, locAssigned, 1, 1)
diff --git a/tests/Makefile.include b/tests/Makefile.include
index ff44264..b89f20b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -287,6 +287,7 @@ ifeq ($(CONFIG_VHOST_USER_NET_TEST_i386),)
 check-qtest-x86_64-$(CONFIG_VHOST_USER_NET_TEST_x86_64) +=3D tests/vhost=
-user-test$(EXESUF)
 endif
 check-qtest-i386-$(CONFIG_TPM) +=3D tests/tpm-crb-test$(EXESUF)
+check-qtest-i386-$(CONFIG_TPM) +=3D tests/tpm-tis-test$(EXESUF)
 check-qtest-i386-$(CONFIG_SLIRP) +=3D tests/test-netfilter$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-mirror$(EXESUF)
 check-qtest-i386-$(CONFIG_POSIX) +=3D tests/test-filter-redirector$(EXES=
UF)
@@ -715,6 +716,7 @@ tests/test-io-task$(EXESUF): tests/test-io-task.o $(t=
est-io-obj-y)
 tests/test-io-channel-socket$(EXESUF): tests/test-io-channel-socket.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
 tests/tpm-crb-test$(EXESUF): tests/tpm-crb-test.o tests/tpm-emu.o $(test=
-io-obj-y)
+tests/tpm-tis-test$(EXESUF): tests/tpm-tis-test.o tests/tpm-emu.o $(test=
-io-obj-y)
 tests/test-io-channel-file$(EXESUF): tests/test-io-channel-file.o \
         tests/io-channel-helpers.o $(test-io-obj-y)
 tests/test-io-channel-tls$(EXESUF): tests/test-io-channel-tls.o \
diff --git a/tests/tpm-emu.c b/tests/tpm-emu.c
index cbb92af..4dada76 100644
--- a/tests/tpm-emu.c
+++ b/tests/tpm-emu.c
@@ -155,6 +155,13 @@ void *tpm_emu_ctrl_thread(void *data)
             qio_channel_write(ioc, (char *)&loc, sizeof(loc), &error_abo=
rt);
             break;
         }
+        case CMD_GET_TPMESTABLISHED: {
+            ptm_est est =3D {
+                .u.resp.bit =3D 0,
+            };
+            qio_channel_write(ioc, (char *)&est, sizeof(est), &error_abo=
rt);
+            break;
+        }
         default:
             g_debug("unimplemented %u", cmd);
             g_assert_not_reached();
diff --git a/tests/tpm-tis-test.c b/tests/tpm-tis-test.c
new file mode 100644
index 0000000..14754d9
--- /dev/null
+++ b/tests/tpm-tis-test.c
@@ -0,0 +1,486 @@
+/*
+ * QTest testcase for TPM TIS
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ * Copyright (c) 2018 IBM Corporation
+ *
+ * Authors:
+ *   Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
+ *   Stefan Berger <stefanb@linux.vnet.ibm.com>
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
+#include "io/channel-socket.h"
+#include "libqtest.h"
+#include "tpm-emu.h"
+
+#define TIS_REG(LOCTY, REG) \
+    (TPM_TIS_ADDR_BASE + ((LOCTY) << 12) + REG)
+
+#define DEBUG_TIS_TEST 0
+
+#define DPRINTF(fmt, ...) do { \
+    if (DEBUG_TIS_TEST) { \
+        printf(fmt, ## __VA_ARGS__); \
+    } \
+} while (0)
+
+#define DPRINTF_ACCESS \
+    DPRINTF("%s: %d: locty=3D%d l=3D%d access=3D0x%02x pending_request_f=
lag=3D0x%x\n", \
+            __func__, __LINE__, locty, l, access, pending_request_flag)
+
+#define DPRINTF_STS \
+    DPRINTF("%s: %d: sts =3D 0x%08x\n", __func__, __LINE__, sts)
+
+static const uint8_t TPM_CMD[12] =3D
+    "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
+
+static void tpm_tis_test_check_localities(const void *data)
+{
+    uint8_t locty;
+    uint8_t access;
+    uint32_t ifaceid;
+    uint32_t capability;
+    uint32_t didvid;
+    uint32_t rid;
+
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES; locty++) {
+        access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        capability =3D readl(TIS_REG(locty, TPM_TIS_REG_INTF_CAPABILITY)=
);
+        g_assert_cmpint(capability, =3D=3D, TPM_TIS_CAPABILITIES_SUPPORT=
ED2_0);
+
+        ifaceid =3D readl(TIS_REG(locty, TPM_TIS_REG_INTERFACE_ID));
+        g_assert_cmpint(ifaceid, =3D=3D, TPM_TIS_IFACE_ID_SUPPORTED_FLAG=
S2_0);
+
+        didvid =3D readl(TIS_REG(locty, TPM_TIS_REG_DID_VID));
+        g_assert_cmpint(didvid, !=3D, 0);
+        g_assert_cmpint(didvid, !=3D, 0xffffffff);
+
+        rid =3D readl(TIS_REG(locty, TPM_TIS_REG_RID));
+        g_assert_cmpint(rid, !=3D, 0);
+        g_assert_cmpint(rid, !=3D, 0xffffffff);
+    }
+}
+
+static void tpm_tis_test_check_access_reg(const void *data)
+{
+    uint8_t locty;
+    uint8_t access;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* release access */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+    }
+}
+
+/*
+ * Test case for seizing access by a higher number locality
+ */
+static void tpm_tis_test_check_access_reg_seize(const void *data)
+{
+    int locty, l;
+    uint8_t access;
+    uint8_t pending_request_flag;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D 0; locty < TPM_TIS_NUM_LOCALITIES - 1; locty++) {
+        pending_request_flag =3D 0;
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* lower localities cannot seize access */
+        for (l =3D 0; l < locty; l++) {
+            /* lower locality is not active */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* try to request use from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+
+            /* requesting use from 'l' was not possible;
+               we must see REQUEST_USE and possibly PENDING_REQUEST */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* locality 'locty' must be unchanged;
+               we must see PENDING_REQUEST */
+            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* try to seize from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE)=
;
+            /* seize from 'l' was not possible */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* locality 'locty' must be unchanged */
+            access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* on the next loop we will have a PENDING_REQUEST flag
+               set for locality 'l' */
+            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
+        }
+
+        /* higher localities can 'seize' access but not 'request use';
+           note: this will activate first l+1, then l+2 etc. */
+        for (l =3D locty + 1; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            /* try to 'request use' from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+
+            /* requesting use from 'l' was not possible; we should see
+               REQUEST_USE and may see PENDING_REQUEST */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* locality 'l-1' must be unchanged; we should always
+               see PENDING_REQUEST from 'l' requesting access */
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        TPM_TIS_ACCESS_PENDING_REQUEST |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* try to seize from 'l' */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_SEIZE)=
;
+
+            /* seize from 'l' was possible */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* l - 1 should show that it has BEEN_SEIZED */
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_BEEN_SEIZED |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* clear the BEEN_SEIZED flag and make sure it's gone */
+            writeb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_BEEN_SEIZED);
+
+            access =3D readb(TIS_REG(l - 1, TPM_TIS_REG_ACCESS));
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+        }
+
+        /* PENDING_REQUEST will not be set if locty =3D 0 since all loca=
lities
+           were active; in case of locty =3D 1, locality 0 will be activ=
e
+           but no PENDING_REQUEST anywhere */
+        if (locty <=3D 1) {
+            pending_request_flag =3D 0;
+        }
+
+        /* release access from l - 1; this activates locty - 1 */
+        l--;
+
+        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+        DPRINTF_ACCESS;
+
+        DPRINTF("%s: %d: relinquishing control on l =3D %d\n",
+                __func__, __LINE__, l);
+        writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+
+        access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+        DPRINTF_ACCESS;
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    pending_request_flag |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        for (l =3D locty - 1; l >=3D 0; l--) {
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+
+            /* release this locality */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+
+            if (l =3D=3D 1) {
+                pending_request_flag =3D 0;
+            }
+        }
+
+        /* no locality may be active now */
+        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+        }
+    }
+}
+
+/*
+ * Test case for getting access when higher number locality relinquishes=
 access
+ */
+static void tpm_tis_test_check_access_reg_release(const void *data)
+{
+    int locty, l;
+    uint8_t access;
+    uint8_t pending_request_flag;
+
+    /* do not test locality 4 (hw only) */
+    for (locty =3D TPM_TIS_NUM_LOCALITIES - 2; locty >=3D 0; locty--) {
+        pending_request_flag =3D 0;
+
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of locality */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+        access =3D readb(TIS_REG(locty, TPM_TIS_REG_ACCESS));
+        g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS=
 |
+                                    TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                    TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+        /* request use of all other localities */
+        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES - 1; l++) {
+            if (l =3D=3D locty) {
+                continue;
+            }
+            /* request use of locality 'l' -- we MUST see REQUEST USE an=
d
+               may see PENDING_REQUEST */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUES=
T_USE);
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_REQUEST_USE |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+            pending_request_flag =3D TPM_TIS_ACCESS_PENDING_REQUEST;
+        }
+        /* release locality 'locty' */
+        writeb(TIS_REG(locty, TPM_TIS_REG_ACCESS),
+               TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+        /* highest locality should now be active; release it and make su=
re the
+           next higest locality is active afterwards */
+        for (l =3D TPM_TIS_NUM_LOCALITIES - 2; l >=3D 0; l--) {
+            if (l =3D=3D locty) {
+                continue;
+            }
+            /* 'l' should be active now */
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+            /* 'l' relinquishes access */
+            writeb(TIS_REG(l, TPM_TIS_REG_ACCESS),
+                   TPM_TIS_ACCESS_ACTIVE_LOCALITY);
+            access =3D readb(TIS_REG(l, TPM_TIS_REG_ACCESS));
+            DPRINTF_ACCESS;
+            if (l =3D=3D 1 || (locty <=3D 1 && l =3D=3D 2)) {
+                pending_request_flag =3D 0;
+            }
+            g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID=
_STS |
+                                        pending_request_flag |
+                                        TPM_TIS_ACCESS_TPM_ESTABLISHMENT=
);
+        }
+    }
+}
+
+/*
+ * Test case for transmitting packets
+ */
+static void tpm_tis_test_check_transmit(const void *data)
+{
+    const TestState *s =3D data;
+    uint8_t access;
+    uint32_t sts;
+    uint16_t bcount;
+    size_t i;
+
+    /* request use of locality 0 */
+    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_REQUEST_USE);
+    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+    g_assert_cmpint(access, =3D=3D, TPM_TIS_ACCESS_TPM_REG_VALID_STS |
+                                TPM_TIS_ACCESS_ACTIVE_LOCALITY |
+                                TPM_TIS_ACCESS_TPM_ESTABLISHMENT);
+
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+
+    g_assert_cmpint(sts & 0xff, =3D=3D, 0);
+    g_assert_cmpint(sts & TPM_TIS_STS_TPM_FAMILY_MASK, =3D=3D,
+                    TPM_TIS_STS_TPM_FAMILY2_0);
+
+    bcount =3D (sts >> 8) & 0xffff;
+    g_assert_cmpint(bcount, >=3D, 128);
+
+    writel(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_COMMAND_READY);
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+    g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_COMMAND_READY);
+
+    /* transmit command */
+    for (i =3D 0; i < sizeof(TPM_CMD); i++) {
+        writeb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO), TPM_CMD[i]);
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        DPRINTF_STS;
+        if (i < sizeof(TPM_CMD) - 1) {
+            g_assert_cmpint(sts & 0xff, =3D=3D,
+                            TPM_TIS_STS_EXPECT | TPM_TIS_STS_VALID);
+        } else {
+            g_assert_cmpint(sts & 0xff, =3D=3D, TPM_TIS_STS_VALID);
+        }
+        g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
+    }
+    /* start processing */
+    writeb(TIS_REG(0, TPM_TIS_REG_STS), TPM_TIS_STS_TPM_GO);
+
+    uint64_t end_time =3D g_get_monotonic_time() + 50 * G_TIME_SPAN_SECO=
ND;
+    do {
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        if ((sts & TPM_TIS_STS_DATA_AVAILABLE) !=3D 0) {
+            break;
+        }
+    } while (g_get_monotonic_time() < end_time);
+
+    sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+    DPRINTF_STS;
+    g_assert_cmpint(sts & 0xff, =3D=3D ,
+                    TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
+    bcount =3D (sts >> 8) & 0xffff;
+
+    /* read response */
+    uint8_t tpm_msg[sizeof(struct tpm_hdr)];
+    g_assert_cmpint(sizeof(tpm_msg), =3D=3D, bcount);
+
+    for (i =3D 0; i < sizeof(tpm_msg); i++) {
+        tpm_msg[i] =3D readb(TIS_REG(0, TPM_TIS_REG_DATA_FIFO));
+        sts =3D readl(TIS_REG(0, TPM_TIS_REG_STS));
+        DPRINTF_STS;
+        if (sts & TPM_TIS_STS_DATA_AVAILABLE) {
+            g_assert_cmpint((sts >> 8) & 0xffff, =3D=3D, --bcount);
+        }
+    }
+    g_assert_cmpmem(tpm_msg, sizeof(tpm_msg), s->tpm_msg, sizeof(*s->tpm=
_msg));
+
+    /* relinquish use of locality 0 */
+    writeb(TIS_REG(0, TPM_TIS_REG_ACCESS), TPM_TIS_ACCESS_ACTIVE_LOCALIT=
Y);
+    access =3D readb(TIS_REG(0, TPM_TIS_REG_ACCESS));
+}
+
+int main(int argc, char **argv)
+{
+    int ret;
+    char *args, *tmp_path =3D g_dir_make_tmp("qemu-tpm-tis-test.XXXXXX",=
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
+    thread =3D g_thread_new(NULL, tpm_emu_ctrl_thread, &test);
+    tpm_emu_test_wait_cond(&test);
+
+    args =3D g_strdup_printf(
+        "-chardev socket,id=3Dchr,path=3D%s "
+        "-tpmdev emulator,id=3Ddev,chardev=3Dchr "
+        "-device tpm-tis,tpmdev=3Ddev",
+        test.addr->u.q_unix.path);
+    qtest_start(args);
+
+    qtest_add_data_func("/tpm-tis/test_check_localities", &test,
+                        tpm_tis_test_check_localities);
+
+    qtest_add_data_func("/tpm-tis/test_check_access_reg", &test,
+                        tpm_tis_test_check_access_reg);
+
+    qtest_add_data_func("/tpm-tis/test_check_access_reg_seize", &test,
+                        tpm_tis_test_check_access_reg_seize);
+
+    qtest_add_data_func("/tpm-tis/test_check_access_reg_release", &test,
+                        tpm_tis_test_check_access_reg_release);
+
+    qtest_add_data_func("/tpm-tis/test_check_transmit", &test,
+                        tpm_tis_test_check_transmit);
+
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
