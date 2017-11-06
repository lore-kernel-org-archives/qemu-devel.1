Received: from eggs.gnu.org ([2001:4830:134:3::10]:40434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmLB-0008Gm-WC
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmLB-0005wk-6N
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmLB-0005wD-0H
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:45 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:25 +0100
Message-Id: <20171106183925.16747-29-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 28/28] tpm: remove tpm_register_model()
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

Query object classes that implements TPMIf instead.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h |  2 --
 hw/tpm/tpm_tis.c             |  1 -
 tpm.c                        | 20 ++++++--------------
 3 files changed, 6 insertions(+), 17 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index c42d83aaef..590e8b42de 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -194,6 +194,4 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
=20
 TPMBackend *qemu_find_tpm_be(const char *id);
=20
-void tpm_register_model(enum TpmModel model);
-
 #endif
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index a00779f3aa..cc32fcde36 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1115,7 +1115,6 @@ static const TypeInfo tpm_tis_info =3D {
 static void tpm_tis_register(void)
 {
     type_register_static(&tpm_tis_info);
-    tpm_register_model(TPM_MODEL_TPM_TIS);
 }
=20
 type_init(tpm_tis_register)
diff --git a/tpm.c b/tpm.c
index 4661dfc46e..61a434185a 100644
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
2.15.0.rc0.40.gaefcc5f6f
