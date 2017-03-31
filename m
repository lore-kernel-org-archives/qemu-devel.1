Received: from eggs.gnu.org ([2001:4830:134:3::10]:40891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwJq-0003kn-Ni
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwJo-0000X0-9C
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:16468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1ctwJn-0000WJ-TE
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:20 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 31 Mar 2017 16:10:13 +0300
Message-Id: <1490965817-16913-5-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH 4/7] tpm-backend: Call interface methods only
 if backend implements them
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, Amarnath Valluri <amarnath.valluri@intel.com>

This allows backend implementations left optional interface methods.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c           | 22 ++++++++++++++--------
 hw/tpm/tpm_passthrough.c | 16 ----------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 00c82d7..0bdc5af 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -50,14 +50,16 @@ const char *tpm_backend_get_desc(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    return k->ops->desc();
+    return k->ops->desc ? k->ops->desc() : "";
 }
 
 void tpm_backend_destroy(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    k->ops->destroy(s);
+    if (k->ops->destroy) {
+        k->ops->destroy(s);
+    }
 
     object_unref(OBJECT(s));
 }
@@ -70,7 +72,7 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
     s->tpm_state = state;
     s->recv_data_callback = datacb;
 
-    return k->ops->init(s);
+    return k->ops->init ? k->ops->init(s) : 0;
 }
 
 int tpm_backend_startup_tpm(TPMBackend *s)
@@ -87,21 +89,21 @@ int tpm_backend_startup_tpm(TPMBackend *s)
                            NULL);
     }
 
-    return k->ops->startup_tpm(s);
+    return k->ops->startup_tpm ? k->ops->startup_tpm(s) : 0;
 }
 
 bool tpm_backend_had_startup_error(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    return k->ops->had_startup_error(s);
+    return k->ops->had_startup_error ? k->ops->had_startup_error(s) : 0;
 }
 
 size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    return k->ops->realloc_buffer(sb);
+    return k->ops->realloc_buffer ? k->ops->realloc_buffer(sb) : (size_t)0;
 }
 
 void tpm_backend_deliver_request(TPMBackend *s)
@@ -114,7 +116,9 @@ void tpm_backend_reset(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    k->ops->reset(s);
+    if (k->ops->reset) {
+        k->ops->reset(s);
+    }
 
     tpm_backend_thread_end(s);
 }
@@ -123,7 +127,9 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    k->ops->cancel_cmd(s);
+    if (k->ops->cancel_cmd) {
+        k->ops->cancel_cmd(s);
+    }
 }
 
 bool tpm_backend_get_tpm_established_flag(TPMBackend *s)
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index cb63079..5b3bf1c 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -228,15 +228,6 @@ static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd cmd)
     }
 }
 
-/*
- * Start the TPM (thread). If it had been started before, then terminate
- * and start it again.
- */
-static int tpm_passthrough_startup_tpm(TPMBackend *tb)
-{
-    return 0;
-}
-
 static void tpm_passthrough_reset(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
@@ -248,11 +239,6 @@ static void tpm_passthrough_reset(TPMBackend *tb)
     tpm_pt->had_startup_error = false;
 }
 
-static int tpm_passthrough_init(TPMBackend *tb)
-{
-    return 0;
-}
-
 static bool tpm_passthrough_get_tpm_established_flag(TPMBackend *tb)
 {
     return false;
@@ -468,8 +454,6 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .desc                     = tpm_passthrough_create_desc,
     .create                   = tpm_passthrough_create,
     .destroy                  = tpm_passthrough_destroy,
-    .init                     = tpm_passthrough_init,
-    .startup_tpm              = tpm_passthrough_startup_tpm,
     .realloc_buffer           = tpm_passthrough_realloc_buffer,
     .reset                    = tpm_passthrough_reset,
     .had_startup_error        = tpm_passthrough_get_startup_error,
-- 
2.7.4
