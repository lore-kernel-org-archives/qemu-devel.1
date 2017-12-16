Received: from eggs.gnu.org ([2001:4830:134:3::10]:45709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTQ-0005lu-0H
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTM-00088U-30
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTL-00087P-Qb
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:04 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHflS5040144
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:01 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew0vstj17-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:01 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:00 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:19 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-3-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 02/32] tpm: move TpmIf in include/sysemu/tpm.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

This is a better location than hw/tpm, since we are going to use the
interface from outside hw/tpm.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c       |  1 -
 hw/tpm/tpm_int.h     | 22 +---------------------
 include/sysemu/tpm.h | 19 +++++++++++++++++++
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 5763f6f..1e416d7 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm.h"
-#include "hw/tpm/tpm_int.h"
 #include "qemu/thread.h"
=20
 static void tpm_backend_worker_thread(gpointer data, gpointer user_data)
diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index 9c045b6..1df5883 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -13,28 +13,8 @@
 #define TPM_TPM_INT_H
=20
 #include "qemu/osdep.h"
-#include "qom/object.h"
=20
-#define TYPE_TPM_IF "tpm-if"
-#define TPM_IF_CLASS(klass) \
-    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
-#define TPM_IF_GET_CLASS(obj) \
-    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
-#define TPM_IF(obj) \
-    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
-
-typedef struct TPMIf {
-    Object parent_obj;
-} TPMIf;
-
-typedef struct TPMIfClass {
-    InterfaceClass parent_class;
-
-    /* run in thread pool by backend */
-    void (*request_completed)(TPMIf *obj);
-} TPMIfClass;
-
-#define TPM_STANDARD_CMDLINE_OPTS               \
+#define TPM_STANDARD_CMDLINE_OPTS \
     { \
         .name =3D "type", \
         .type =3D QEMU_OPT_STRING, \
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index d7a2bd8..452cdb9 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -27,6 +27,25 @@ typedef enum  TPMVersion {
     TPM_VERSION_2_0 =3D 2,
 } TPMVersion;
=20
+#define TYPE_TPM_IF "tpm-if"
+#define TPM_IF_CLASS(klass)                                 \
+    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
+#define TPM_IF_GET_CLASS(obj)                           \
+    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
+#define TPM_IF(obj)                             \
+    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
+
+typedef struct TPMIf {
+    Object parent_obj;
+} TPMIf;
+
+typedef struct TPMIfClass {
+    InterfaceClass parent_class;
+
+    /* run in thread pool by backend */
+    void (*request_completed)(TPMIf *obj);
+} TPMIfClass;
+
 TPMVersion tpm_tis_get_tpm_version(Object *obj);
=20
 #define TYPE_TPM_TIS                "tpm-tis"
--=20
2.5.5
