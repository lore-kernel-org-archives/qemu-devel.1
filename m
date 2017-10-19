Received: from eggs.gnu.org ([2001:4830:134:3::10]:36263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAP-0007QG-48
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAK-0007PW-VY
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007NV-I1
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI2pGL113239
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dq0xbg6v3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:28 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:51 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-18-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 17/21] tpm-tis: move TPMState to TIS header
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

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_int.h  | 23 ++---------------------
 hw/tpm/tpm_tis.h  | 19 +++++++++++++++++++
 hw/tpm/tpm_util.c |  1 +
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 252c408..e231d0e 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -12,28 +12,9 @@
 #ifndef TPM_TPM_INT_H
 #define TPM_TPM_INT_H
=20
-#include "exec/memory.h"
-#include "tpm_tis.h"
+#include "qemu/osdep.h"
=20
-/* overall state of the TPM interface */
-struct TPMState {
-    ISADevice busdev;
-    MemoryRegion mmio;
-
-    union {
-        TPMTISEmuState tis;
-    } s;
-
-    TPMBackendCmd cmd;
-
-    char *backend;
-    TPMBackend *be_driver;
-    TPMVersion be_tpm_version;
-};
-
-#define TPM(obj) OBJECT_CHECK(TPMState, (obj), TYPE_TPM_TIS)
-
-#define TPM_STANDARD_CMDLINE_OPTS \
+#define TPM_STANDARD_CMDLINE_OPTS               \
     { \
         .name =3D "type", \
         .type =3D QEMU_OPT_STRING, \
diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 31e612a..30e35ee 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -72,4 +72,23 @@ typedef struct TPMTISEmuState {
     uint32_t irq_num;
 } TPMTISEmuState;
=20
+/* overall state of the TPM interface */
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
+
 #endif /* TPM_TPM_TIS_H */
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index 73d7796..daf1faa 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "tpm_util.h"
 #include "tpm_int.h"
+#include "exec/memory.h"
=20
 /*
  * Write an error message in the given output buffer.
--=20
2.5.5
