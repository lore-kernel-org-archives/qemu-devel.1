Received: from eggs.gnu.org ([2001:4830:134:3::10]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzP-0006BO-KF
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzO-0005E7-PQ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzO-0005Do-Jd
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:01 +0200
Message-Id: <20171009225623.29232-21-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/42] tpm: add a QOM TPM interface
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

This will simplify backend / interface objects relationship, so the
frontend interface will simply have to implement the TPM QOM interface.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_int.h | 17 +++++++++++++++++
 backends/tpm.c   |  8 ++++++++
 hw/tpm/tpm_tis.c |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index e231d0eb4f..eb02e7760c 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -13,6 +13,23 @@
 #define TPM_TPM_INT_H
=20
 #include "qemu/osdep.h"
+#include "qom/object.h"
+
+#define TYPE_TPM_IF "tpm-if"
+#define TPM_IF_CLASS(klass) \
+    OBJECT_CLASS_CHECK(TPMIfClass, (klass), TYPE_TPM_IF)
+#define TPM_IF_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(TPMIfClass, (obj), TYPE_TPM_IF)
+#define TPM_IF(obj) \
+    INTERFACE_CHECK(TPMIf, (obj), TYPE_TPM_IF)
+
+typedef struct TPMIf {
+    Object parent_obj;
+} TPMIf;
+
+typedef struct TPMIfClass {
+    InterfaceClass parent_class;
+} TPMIfClass;
=20
 #define TPM_STANDARD_CMDLINE_OPTS               \
     { \
diff --git a/backends/tpm.c b/backends/tpm.c
index dc7c831ff8..87c5c09179 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm.h"
+#include "hw/tpm/tpm_int.h"
 #include "qemu/thread.h"
=20
 static void tpm_backend_worker_thread(gpointer data, gpointer user_data)
@@ -209,9 +210,16 @@ static const TypeInfo tpm_backend_info =3D {
     .abstract =3D true,
 };
=20
+static const TypeInfo tpm_if_info =3D {
+    .name =3D TYPE_TPM_IF,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(TPMIfClass),
+};
+
 static void register_types(void)
 {
     type_register_static(&tpm_backend_info);
+    type_register_static(&tpm_if_info);
 }
=20
 type_init(register_types);
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d84eec48b4..dbb50043ac 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1123,6 +1123,10 @@ static const TypeInfo tpm_tis_info =3D {
     .instance_size =3D sizeof(TPMState),
     .instance_init =3D tpm_tis_initfn,
     .class_init  =3D tpm_tis_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { TYPE_TPM_IF },
+        { }
+    }
 };
=20
 static void tpm_tis_register(void)
--=20
2.14.1.146.gd35faa819
