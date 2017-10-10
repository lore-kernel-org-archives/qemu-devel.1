Received: from eggs.gnu.org ([2001:4830:134:3::10]:41675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1jRD-0003mJ-0p
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e1jR9-0000G1-Sv
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e1jR9-0000FP-Ke
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 21:34:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9A1YAfG142661
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 21:34:18 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dgd11d16e-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 21:34:18 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 19:34:17 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon,  9 Oct 2017 21:33:48 -0400
In-Reply-To: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507599235-25123-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507599235-25123-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 03/10] tpm-backend: Initialize and free data
 members in it's own methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Amarnath Valluri <amarnath.valluri@intel.com>

Initialize and free TPMBackend data members in it's own instance_init() a=
nd
instance_finalize methods.

Took the opportunity to remove unneeded destroy() method from TpmDriverOp=
s
interface as TPMBackend is a Qemu Object, we can use object_unref() inpla=
ce of
tpm_backend_destroy() to free the backend object, hence removed destroy()=
 from
TPMDriverOps interface.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 16 ++++++----------
 hw/tpm/tpm_passthrough.c     | 31 ++++++++++++-------------------
 include/sysemu/tpm_backend.h |  7 -------
 tpm.c                        |  2 +-
 4 files changed, 19 insertions(+), 37 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index ce56c3b..cf5abf1 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -51,15 +51,6 @@ const char *tpm_backend_get_desc(TPMBackend *s)
     return k->ops->desc();
 }
=20
-void tpm_backend_destroy(TPMBackend *s)
-{
-    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
-
-    k->ops->destroy(s);
-
-    tpm_backend_thread_end(s);
-}
-
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
@@ -182,17 +173,22 @@ static void tpm_backend_prop_set_opened(Object *obj=
, bool value, Error **errp)
=20
 static void tpm_backend_instance_init(Object *obj)
 {
+    TPMBackend *s =3D TPM_BACKEND(obj);
+
     object_property_add_bool(obj, "opened",
                              tpm_backend_prop_get_opened,
                              tpm_backend_prop_set_opened,
                              NULL);
-
+    s->fe_model =3D -1;
 }
=20
 static void tpm_backend_instance_finalize(Object *obj)
 {
     TPMBackend *s =3D TPM_BACKEND(obj);
=20
+    g_free(s->id);
+    g_free(s->path);
+    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
=20
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index f50d9cf..815a72e 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -417,8 +417,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *o=
pts, const char *id)
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
=20
     tb->id =3D g_strdup(id);
-    /* let frontend set the fe_model to proper value */
-    tb->fe_model =3D -1;
=20
     if (tpm_passthrough_handle_device_opts(opts, tb)) {
         goto err_exit;
@@ -432,26 +430,11 @@ static TPMBackend *tpm_passthrough_create(QemuOpts =
*opts, const char *id)
     return tb;
=20
 err_exit:
-    g_free(tb->id);
+    object_unref(obj);
=20
     return NULL;
 }
=20
-static void tpm_passthrough_destroy(TPMBackend *tb)
-{
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
-
-    tpm_passthrough_cancel_cmd(tb);
-
-    qemu_close(tpm_pt->tpm_fd);
-    qemu_close(tpm_pt->cancel_fd);
-
-    g_free(tb->id);
-    g_free(tb->path);
-    g_free(tb->cancel_path);
-    g_free(tpm_pt->tpm_dev);
-}
-
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] =3D {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -472,7 +455,6 @@ static const TPMDriverOps tpm_passthrough_driver =3D =
{
     .opts                     =3D tpm_passthrough_cmdline_opts,
     .desc                     =3D tpm_passthrough_create_desc,
     .create                   =3D tpm_passthrough_create,
-    .destroy                  =3D tpm_passthrough_destroy,
     .init                     =3D tpm_passthrough_init,
     .startup_tpm              =3D tpm_passthrough_startup_tpm,
     .realloc_buffer           =3D tpm_passthrough_realloc_buffer,
@@ -486,10 +468,21 @@ static const TPMDriverOps tpm_passthrough_driver =3D=
 {
=20
 static void tpm_passthrough_inst_init(Object *obj)
 {
+    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
+
+    tpm_pt->tpm_fd =3D -1;
+    tpm_pt->cancel_fd =3D -1;
 }
=20
 static void tpm_passthrough_inst_finalize(Object *obj)
 {
+    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
+
+    tpm_passthrough_cancel_cmd(TPM_BACKEND(obj));
+
+    qemu_close(tpm_pt->tpm_fd);
+    qemu_close(tpm_pt->cancel_fd);
+    g_free(tpm_pt->tpm_dev);
 }
=20
 static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 58308b3..202ec8d 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -78,7 +78,6 @@ struct TPMDriverOps {
     const char *(*desc)(void);
=20
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
-    void (*destroy)(TPMBackend *t);
=20
     /* initialize the backend */
     int (*init)(TPMBackend *t);
@@ -118,12 +117,6 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
 const char *tpm_backend_get_desc(TPMBackend *s);
=20
 /**
- * tpm_backend_destroy:
- * @s: the backend to destroy
- */
-void tpm_backend_destroy(TPMBackend *s);
-
-/**
  * tpm_backend_init:
  * @s: the backend to initialized
  * @state: TPMState
diff --git a/tpm.c b/tpm.c
index abedf3f..b19b1a3 100644
--- a/tpm.c
+++ b/tpm.c
@@ -157,7 +157,7 @@ void tpm_cleanup(void)
=20
     QLIST_FOREACH_SAFE(drv, &tpm_backends, list, next) {
         QLIST_REMOVE(drv, list);
-        tpm_backend_destroy(drv);
+        object_unref(OBJECT(drv));
     }
 }
=20
--=20
2.5.5
