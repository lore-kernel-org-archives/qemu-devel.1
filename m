Received: from eggs.gnu.org ([2001:4830:134:3::10]:45794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTW-0005r0-Iq
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTS-0008DY-Kt
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:14 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57128
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTS-0008DQ-G6
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:10 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHdjqC041747
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:10 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ew08mumbv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:09 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:09 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:24 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-8-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 07/32] tpm-be: ask model to the TPM interface
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

No need to store the mode in the backend, or to let the frontend set
it itself.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 4 ++--
 hw/tpm/tpm_tis.c             | 3 +--
 include/sysemu/tpm.h         | 1 +
 include/sysemu/tpm_backend.h | 1 -
 tpm.c                        | 3 ++-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 7b108bd..0c48d18 100644
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
index bf291e6..a780167 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1072,8 +1072,6 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
         return;
     }
=20
-    s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
-
     if (tpm_backend_init(s->be_driver, TPM_IF(s), errp)) {
         return;
     }
@@ -1108,6 +1106,7 @@ static void tpm_tis_class_init(ObjectClass *klass, =
void *data)
     dc->props =3D tpm_tis_properties;
     dc->reset =3D tpm_tis_reset;
     dc->vmsd  =3D &vmstate_tpm_tis;
+    tc->model =3D TPM_MODEL_TPM_TIS;
     tc->request_completed =3D tpm_tis_request_completed;
 }
=20
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index e087962..7b407ca 100644
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
index df9ebd0..665e807 100644
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
diff --git a/tpm.c b/tpm.c
index ab5d29e..4320f44 100644
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
2.5.5
