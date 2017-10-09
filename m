Received: from eggs.gnu.org ([2001:4830:134:3::10]:54839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzG-00062F-9r
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzF-0005Ar-HG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzF-0005Ac-Ac
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:25 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:58 +0200
Message-Id: <20171009225623.29232-18-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 17/42] tpm-tis: move TPMState to TIS header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_int.h  | 23 ++---------------------
 hw/tpm/tpm_tis.h  | 19 +++++++++++++++++++
 hw/tpm/tpm_util.c |  1 +
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 252c4082ef..e231d0eb4f 100644
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
index 31e612a7f4..30e35eef64 100644
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
index fb929f6e92..7dc5b08824 100644
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
2.14.1.146.gd35faa819
