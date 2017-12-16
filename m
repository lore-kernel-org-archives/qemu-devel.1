Received: from eggs.gnu.org ([2001:4830:134:3::10]:46117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGU2-0006ND-Hx
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTy-0000KA-Jg
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56288
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTy-0000Js-Dr
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdUWX110148
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:41 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evwa8qt4m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:41 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:41 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:44 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-28-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 27/32] tpm: remove tpm_register_model()
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

Query object classes that implements TPMIf instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c             |  1 -
 include/sysemu/tpm_backend.h |  2 --
 tpm.c                        | 20 ++++++--------------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 97cd7f5..98c11a4 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1119,7 +1119,6 @@ static const TypeInfo tpm_tis_info =3D {
 static void tpm_tis_register(void)
 {
     type_register_static(&tpm_tis_info);
-    tpm_register_model(TPM_MODEL_TPM_TIS);
 }
=20
 type_init(tpm_tis_register)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index c42d83a..590e8b4 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -194,6 +194,4 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
=20
 TPMBackend *qemu_find_tpm_be(const char *id);
=20
-void tpm_register_model(enum TpmModel model);
-
 #endif
diff --git a/tpm.c b/tpm.c
index 4661dfc..61a4341 100644
--- a/tpm.c
+++ b/tpm.c
@@ -23,13 +23,6 @@
 static QLIST_HEAD(, TPMBackend) tpm_backends =3D
     QLIST_HEAD_INITIALIZER(tpm_backends);
=20
-static bool tpm_models[TPM_MODEL__MAX];
-
-void tpm_register_model(enum TpmModel model)
-{
-    tpm_models[model] =3D true;
-}
-
 static const TPMBackendClass *
 tpm_be_find_by_type(enum TpmType type)
 {
@@ -236,18 +229,16 @@ TpmTypeList *qmp_query_tpm_types(Error **errp)
=20
     return head;
 }
-
 TpmModelList *qmp_query_tpm_models(Error **errp)
 {
-    unsigned int i =3D 0;
     TpmModelList *head =3D NULL, *prev =3D NULL, *cur_item;
+    GSList *e, *l =3D object_class_get_list(TYPE_TPM_IF, false);
+
+    for (e =3D l; e; e =3D e->next) {
+        TPMIfClass *c =3D TPM_IF_CLASS(e->data);
=20
-    for (i =3D 0; i < TPM_MODEL__MAX; i++) {
-        if (!tpm_models[i]) {
-            continue;
-        }
         cur_item =3D g_new0(TpmModelList, 1);
-        cur_item->value =3D i;
+        cur_item->value =3D c->model;
=20
         if (prev) {
             prev->next =3D cur_item;
@@ -257,6 +248,7 @@ TpmModelList *qmp_query_tpm_models(Error **errp)
         }
         prev =3D cur_item;
     }
+    g_slist_free(l);
=20
     return head;
 }
--=20
2.5.5
