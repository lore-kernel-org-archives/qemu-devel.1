Received: from eggs.gnu.org ([2001:4830:134:3::10]:46604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5WMU-0000eo-0l
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5WMS-0005yy-Ql
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:52:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:28100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d5WMS-0005ug-Fv
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:52:56 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Tue,  2 May 2017 14:52:44 +0300
Message-Id: <1493725969-19518-4-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v3 3/8] tpm-backend: Initialize and free data
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
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, marcandre.lureau@gmail.com, berrange@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

Initialize and free TPMBackend data members in it's own instance_init() and
instance_finalize methods.

Took the opportunity to remove unneeded destroy() method from TpmDriverOps
interface as TPMBackend is a Qemu Object, we can use object_unref() inplace of
tpm_backend_destroy() to free the backend object, hence removed destroy() from
TPMDriverOps interface.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
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
 
-void tpm_backend_destroy(TPMBackend *s)
-{
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
-
-    k->ops->destroy(s);
-
-    tpm_backend_thread_end(s);
-}
-
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
@@ -182,17 +173,22 @@ static void tpm_backend_prop_set_opened(Object *obj, bool value, Error **errp)
 
 static void tpm_backend_instance_init(Object *obj)
 {
+    TPMBackend *s = TPM_BACKEND(obj);
+
     object_property_add_bool(obj, "opened",
                              tpm_backend_prop_get_opened,
                              tpm_backend_prop_set_opened,
                              NULL);
-
+    s->fe_model = -1;
 }
 
 static void tpm_backend_instance_finalize(Object *obj)
 {
     TPMBackend *s = TPM_BACKEND(obj);
 
+    g_free(s->id);
+    g_free(s->path);
+    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
 
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index f50d9cf..815a72e 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -417,8 +417,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
 
     tb->id = g_strdup(id);
-    /* let frontend set the fe_model to proper value */
-    tb->fe_model = -1;
 
     if (tpm_passthrough_handle_device_opts(opts, tb)) {
         goto err_exit;
@@ -432,26 +430,11 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
     return tb;
 
 err_exit:
-    g_free(tb->id);
+    object_unref(obj);
 
     return NULL;
 }
 
-static void tpm_passthrough_destroy(TPMBackend *tb)
-{
-    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
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
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] = {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -472,7 +455,6 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .opts                     = tpm_passthrough_cmdline_opts,
     .desc                     = tpm_passthrough_create_desc,
     .create                   = tpm_passthrough_create,
-    .destroy                  = tpm_passthrough_destroy,
     .init                     = tpm_passthrough_init,
     .startup_tpm              = tpm_passthrough_startup_tpm,
     .realloc_buffer           = tpm_passthrough_realloc_buffer,
@@ -486,10 +468,21 @@ static const TPMDriverOps tpm_passthrough_driver = {
 
 static void tpm_passthrough_inst_init(Object *obj)
 {
+    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(obj);
+
+    tpm_pt->tpm_fd = -1;
+    tpm_pt->cancel_fd = -1;
 }
 
 static void tpm_passthrough_inst_finalize(Object *obj)
 {
+    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(obj);
+
+    tpm_passthrough_cancel_cmd(TPM_BACKEND(obj));
+
+    qemu_close(tpm_pt->tpm_fd);
+    qemu_close(tpm_pt->cancel_fd);
+    g_free(tpm_pt->tpm_dev);
 }
 
 static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index a538a7f..f61bcfe 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -78,7 +78,6 @@ struct TPMDriverOps {
     const char *(*desc)(void);
 
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
-    void (*destroy)(TPMBackend *t);
 
     /* initialize the backend */
     int (*init)(TPMBackend *t);
@@ -118,12 +117,6 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
 const char *tpm_backend_get_desc(TPMBackend *s);
 
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
index 0ee021a..70f74fa 100644
--- a/tpm.c
+++ b/tpm.c
@@ -197,7 +197,7 @@ void tpm_cleanup(void)
 
     QLIST_FOREACH_SAFE(drv, &tpm_backends, list, next) {
         QLIST_REMOVE(drv, list);
-        tpm_backend_destroy(drv);
+        object_unref(OBJECT(drv));
     }
 }
 
-- 
2.7.4
