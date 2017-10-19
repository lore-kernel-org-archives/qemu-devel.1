Received: from eggs.gnu.org ([2001:4830:134:3::10]:36257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAP-0007QE-29
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAK-0007P8-TE
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007NQ-I7
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI0Z3B105996
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dq0xbg6uw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:52 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-19-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 18/21] tpm-tis: remove tpm_tis.h header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, marcandre.lureau@gmail.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The definitions are now private to TIS implementation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_passthrough.c |  1 -
 hw/tpm/tpm_tis.c         | 72 ++++++++++++++++++++++++++++++++++++-
 hw/tpm/tpm_tis.h         | 94 ------------------------------------------=
------
 3 files changed, 71 insertions(+), 96 deletions(-)
 delete mode 100644 hw/tpm/tpm_tis.h

diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 93d72b8..4274164 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -31,7 +31,6 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "qapi/clone-visitor.h"
-#include "tpm_tis.h"
 #include "tpm_util.h"
=20
 #define DEBUG_TPM 0
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index ad28456..73cda41 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -23,6 +23,7 @@
  */
=20
 #include "qemu/osdep.h"
+#include "hw/isa/isa.h"
 #include "sysemu/tpm_backend.h"
 #include "tpm_int.h"
 #include "sysemu/block-backend.h"
@@ -30,10 +31,79 @@
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
 #include "hw/pci/pci_ids.h"
-#include "tpm_tis.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qemu/main-loop.h"
+#include "hw/acpi/tpm.h"
+
+#define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
+#define TPM_TIS_LOCALITY_SHIFT      12
+#define TPM_TIS_NO_LOCALITY         0xff
+
+#define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
+
+#define TPM_TIS_BUFFER_MAX          4096
+
+typedef enum {
+    TPM_TIS_STATE_IDLE =3D 0,
+    TPM_TIS_STATE_READY,
+    TPM_TIS_STATE_COMPLETION,
+    TPM_TIS_STATE_EXECUTION,
+    TPM_TIS_STATE_RECEPTION,
+} TPMTISState;
+
+typedef struct TPMSizedBuffer {
+    uint32_t size;
+    uint8_t  *buffer;
+} TPMSizedBuffer;
+
+/* locality data  -- all fields are persisted */
+typedef struct TPMLocality {
+    TPMTISState state;
+    uint8_t access;
+    uint32_t sts;
+    uint32_t iface_id;
+    uint32_t inte;
+    uint32_t ints;
+
+    uint16_t w_offset;
+    uint16_t r_offset;
+    TPMSizedBuffer w_buffer;
+    TPMSizedBuffer r_buffer;
+} TPMLocality;
+
+typedef struct TPMTISEmuState {
+    QEMUBH *bh;
+    uint32_t offset;
+    uint8_t buf[TPM_TIS_BUFFER_MAX];
+
+    uint8_t active_locty;
+    uint8_t aborting_locty;
+    uint8_t next_locty;
+
+    TPMLocality loc[TPM_TIS_NUM_LOCALITIES];
+
+    qemu_irq irq;
+    uint32_t irq_num;
+} TPMTISEmuState;
+
+struct TPMState {
+    ISADevice busdev;
+    MemoryRegion mmio;
+
+    union {
+        TPMTISEmuState tis;
+    } s;
+
+    uint8_t     locty_number;
+    TPMBackendCmd cmd;
+
+    char *backend;
+    TPMBackend *be_driver;
+    TPMVersion be_tpm_version;
+};
+
+#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
=20
 #define DEBUG_TIS 0
=20
diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
deleted file mode 100644
index 30e35ee..0000000
--- a/hw/tpm/tpm_tis.h
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * tpm_tis.h - QEMU's TPM TIS interface emulator
- *
- * Copyright (C) 2006, 2010-2013 IBM Corporation
- *
- * Authors:
- *  Stefan Berger <stefanb@us.ibm.com>
- *  David Safford <safford@us.ibm.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or la=
ter.
- * See the COPYING file in the top-level directory.
- *
- * Implementation of the TIS interface according to specs found at
- * http://www.trustedcomputinggroup.org
- *
- */
-#ifndef TPM_TPM_TIS_H
-#define TPM_TPM_TIS_H
-
-#include "hw/isa/isa.h"
-#include "hw/acpi/tpm.h"
-#include "qemu-common.h"
-
-#define TPM_TIS_NUM_LOCALITIES      5     /* per spec */
-#define TPM_TIS_LOCALITY_SHIFT      12
-#define TPM_TIS_NO_LOCALITY         0xff
-
-#define TPM_TIS_IS_VALID_LOCTY(x)   ((x) < TPM_TIS_NUM_LOCALITIES)
-
-#define TPM_TIS_BUFFER_MAX          4096
-
-typedef enum {
-    TPM_TIS_STATE_IDLE =3D 0,
-    TPM_TIS_STATE_READY,
-    TPM_TIS_STATE_COMPLETION,
-    TPM_TIS_STATE_EXECUTION,
-    TPM_TIS_STATE_RECEPTION,
-} TPMTISState;
-
-typedef struct TPMSizedBuffer {
-    uint32_t size;
-    uint8_t  *buffer;
-} TPMSizedBuffer;
-
-/* locality data  -- all fields are persisted */
-typedef struct TPMLocality {
-    TPMTISState state;
-    uint8_t access;
-    uint32_t sts;
-    uint32_t iface_id;
-    uint32_t inte;
-    uint32_t ints;
-
-    uint16_t w_offset;
-    uint16_t r_offset;
-    TPMSizedBuffer w_buffer;
-    TPMSizedBuffer r_buffer;
-} TPMLocality;
-
-typedef struct TPMTISEmuState {
-    QEMUBH *bh;
-    uint32_t offset;
-    uint8_t buf[TPM_TIS_BUFFER_MAX];
-
-    uint8_t active_locty;
-    uint8_t aborting_locty;
-    uint8_t next_locty;
-
-    TPMLocality loc[TPM_TIS_NUM_LOCALITIES];
-
-    qemu_irq irq;
-    uint32_t irq_num;
-} TPMTISEmuState;
-
-/* overall state of the TPM interface */
-struct TPMState {
-    ISADevice busdev;
-    MemoryRegion mmio;
-
-    union {
-        TPMTISEmuState tis;
-    } s;
-
-    uint8_t     locty_number;
-    TPMBackendCmd cmd;
-
-    char *backend;
-    TPMBackend *be_driver;
-    TPMVersion be_tpm_version;
-};
-
-#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
-
-#endif /* TPM_TPM_TIS_H */
--=20
2.5.5
