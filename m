Received: from eggs.gnu.org ([2001:4830:134:3::10]:36253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAP-0007QD-1j
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e5FAK-0007PE-Um
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e5FAK-0007Ny-JE
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 14:03:32 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9JI1Hw7134348
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:29 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpws2453s-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 14:03:28 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 14:03:27 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 14:02:54 -0400
In-Reply-To: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1508436175-1596-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1508436175-1596-21-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 20/21] tpm: add a QOM TPM interface
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

This will simplify backend / interface objects relationship, so the
frontend interface will simply have to implement the TPM QOM interface.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c   |  8 ++++++++
 hw/tpm/tpm_int.h | 17 +++++++++++++++++
 hw/tpm/tpm_tis.c |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/backends/tpm.c b/backends/tpm.c
index dc7c831..87c5c09 100644
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
diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index e231d0e..eb02e77 100644
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
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index d84eec4..dbb5004 100644
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
2.5.5
