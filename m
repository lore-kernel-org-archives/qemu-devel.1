Received: from eggs.gnu.org ([2001:4830:134:3::10]:40894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwJq-0003kp-OZ
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwJm-0000Vs-7Q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:48955)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1ctwJl-0000UK-Te
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:18 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 31 Mar 2017 16:10:12 +0300
Message-Id: <1490965817-16913-4-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH 3/7] tpm-backend: Initialize and free data
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
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, Amarnath Valluri <amarnath.valluri@intel.com>

Initialize and free TPMBackend data members in it's own instance_init() and
instance_finalize methods.

Took the opportunity to fix object cleanup in tpm_backend_destroy() method

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c           | 14 +++++++++++++-
 hw/tpm/tpm_passthrough.c |  8 +-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 50a7809..00c82d7 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -59,7 +59,7 @@ void tpm_backend_destroy(TPMBackend *s)
 
     k->ops->destroy(s);
 
-    tpm_backend_thread_end(s);
+    object_unref(OBJECT(s));
 }
 
 int tpm_backend_init(TPMBackend *s, TPMState *state,
@@ -187,10 +187,20 @@ static void tpm_backend_prop_set_opened(Object *obj, bool value, Error **errp)
 
 static void tpm_backend_instance_init(Object *obj)
 {
+    TPMBackend *s = TPM_BACKEND(obj);
+
     object_property_add_bool(obj, "opened",
                              tpm_backend_prop_get_opened,
                              tpm_backend_prop_set_opened,
                              NULL);
+    s->id = NULL;
+    s->fe_model = -1;
+    s->opened = false;
+    s->tpm_state = NULL;
+    s->thread_pool = NULL;
+    s->recv_data_callback = NULL;
+    s->path = NULL;
+    s->cancel_path = NULL;
 
 }
 
@@ -199,6 +209,8 @@ static void tpm_backend_instance_finalize(Object *obj)
     TPMBackend *s = TPM_BACKEND(obj);
 
     g_free(s->id);
+    g_free(s->path);
+    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
 
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 606e064..cb63079 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -418,8 +418,6 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
 
     tb->id = g_strdup(id);
-    /* let frontend set the fe_model to proper value */
-    tb->fe_model = -1;
 
     if (tpm_passthrough_handle_device_opts(opts, tb)) {
         goto err_exit;
@@ -433,7 +431,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
     return tb;
 
 err_exit:
-    g_free(tb->id);
+    object_unref(obj);
 
     return NULL;
 }
@@ -446,10 +444,6 @@ static void tpm_passthrough_destroy(TPMBackend *tb)
 
     qemu_close(tpm_pt->tpm_fd);
     qemu_close(tpm_pt->cancel_fd);
-
-    g_free(tb->id);
-    g_free(tb->path);
-    g_free(tb->cancel_path);
     g_free(tpm_pt->tpm_dev);
 }
 
-- 
2.7.4
