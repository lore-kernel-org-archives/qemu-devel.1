Received: from eggs.gnu.org ([2001:4830:134:3::10]:60463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cwUuP-0005Dr-2t
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cwUuO-0002ch-39
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:30:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:63385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1cwUuN-0002ZL-Ju
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 10:30:39 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri,  7 Apr 2017 17:30:28 +0300
Message-Id: <1491575431-32170-7-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v2 6/9] tpm-backend: Remove unneeded destroy()
 method from TpmDriverOps interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@gmail.com, berrange@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

As TPMBackend is a Qemu Object, we can use object_unref() inplace of
tpm_backend_destroy() to free the backend object, hence removed destroy() from
TPMDriverOps interface.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c               | 11 -----------
 hw/tpm/tpm_passthrough.c     | 14 --------------
 include/sysemu/tpm_backend.h |  7 -------
 tpm.c                        |  2 +-
 4 files changed, 1 insertion(+), 33 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index c96f462..3493df6 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -51,17 +51,6 @@ const char *tpm_backend_get_desc(TPMBackend *s)
     return k->ops->desc ? k->ops->desc() : "";
 }
 
-void tpm_backend_destroy(TPMBackend *s)
-{
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
-
-    if (k->ops->destroy) {
-        k->ops->destroy(s);
-    }
-
-    object_unref(OBJECT(s));
-}
-
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 71bdf25..8e11ed3 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -428,19 +428,6 @@ err_exit:
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
-    g_free(tpm_pt->tpm_dev);
-
-    qapi_free_TPMPassthroughOptions(tpm_pt->ops);
-}
-
 static TPMOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
@@ -483,7 +470,6 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .opts                     = tpm_passthrough_cmdline_opts,
     .desc                     = tpm_passthrough_create_desc,
     .create                   = tpm_passthrough_create,
-    .destroy                  = tpm_passthrough_destroy,
     .realloc_buffer           = tpm_passthrough_realloc_buffer,
     .reset                    = tpm_passthrough_reset,
     .had_startup_error        = tpm_passthrough_get_startup_error,
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 7f4d621..8f8f133 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -77,7 +77,6 @@ struct TPMDriverOps {
     const char *(*desc)(void);
 
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
-    void (*destroy)(TPMBackend *t);
 
     /* initialize the backend */
     int (*init)(TPMBackend *t);
@@ -119,12 +118,6 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
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
index 1b6b550..43d980e 100644
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
