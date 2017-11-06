Received: from eggs.gnu.org ([2001:4830:134:3::10]:39172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJZ-0006YG-Dv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJY-0004Mb-IA
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJY-0004ML-9X
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:04 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:04 +0100
Message-Id: <20171106183925.16747-8-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/28] tpm-be: ask model to the TPM interface
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

No need to store the mode in the backend, or to let the frontend set
it itself.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm.h         | 1 +
 include/sysemu/tpm_backend.h | 1 -
 backends/tpm.c               | 4 ++--
 hw/tpm/tpm_tis.c             | 3 +--
 tpm.c                        | 3 ++-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index e0879620e7..7b407caf25 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -40,6 +40,7 @@ typedef struct TPMIf {
 typedef struct TPMIfClass {
     InterfaceClass parent_class;
=20
+    enum TpmModel model;
     void (*request_completed)(TPMIf *obj);
 } TPMIfClass;
=20
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index df9ebd0e81..665e807a73 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -51,7 +51,6 @@ struct TPMBackend {
=20
     /* <public> */
     char *id;
-    enum TpmModel fe_model;
=20
     QLIST_ENTRY(TPMBackend) list;
 };
diff --git a/backends/tpm.c b/backends/tpm.c
index 7b108bd5d8..0c48d18775 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -148,9 +148,10 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
 {
     TPMInfo *info =3D g_new0(TPMInfo, 1);
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
+    TPMIfClass *tic =3D TPM_IF_GET_CLASS(s->tpmif);
=20
     info->id =3D g_strdup(s->id);
-    info->model =3D s->fe_model;
+    info->model =3D tic->model;
     if (k->get_tpm_options) {
         info->options =3D k->get_tpm_options(s);
     }
@@ -204,7 +205,6 @@ static void tpm_backend_instance_init(Object *obj)
                              tpm_backend_prop_get_opened,
                              tpm_backend_prop_set_opened,
                              NULL);
-    s->fe_model =3D -1;
     s->bh =3D qemu_bh_new(tpm_backend_request_completed_bh, s);
 }
=20
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 2febc8bd08..c1b738c29f 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1068,8 +1068,6 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
         return;
     }
=20
-    s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
-
     if (tpm_backend_init(s->be_driver, TPM_IF(s), errp)) {
         return;
     }
@@ -1104,6 +1102,7 @@ static void tpm_tis_class_init(ObjectClass *klass, =
void *data)
     dc->props =3D tpm_tis_properties;
     dc->reset =3D tpm_tis_reset;
     dc->vmsd  =3D &vmstate_tpm_tis;
+    tc->model =3D TPM_MODEL_TPM_TIS;
     tc->request_completed =3D tpm_tis_request_completed;
 }
=20
diff --git a/tpm.c b/tpm.c
index ab5d29e91e..4320f44c9f 100644
--- a/tpm.c
+++ b/tpm.c
@@ -200,9 +200,10 @@ TPMInfoList *qmp_query_tpm(Error **errp)
     TPMInfoList *info, *head =3D NULL, *cur_item =3D NULL;
=20
     QLIST_FOREACH(drv, &tpm_backends, list) {
-        if (!tpm_models[drv->fe_model]) {
+        if (!drv->tpmif) {
             continue;
         }
+
         info =3D g_new0(TPMInfoList, 1);
         info->value =3D tpm_backend_query_tpm(drv);
=20
--=20
2.15.0.rc0.40.gaefcc5f6f
