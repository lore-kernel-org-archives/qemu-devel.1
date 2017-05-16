Received: from eggs.gnu.org ([2001:4830:134:3::10]:51101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dAXNK-0002ps-31
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dAXNH-00051y-Nn
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:58:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dAXNH-00051V-GN
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:58:31 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Tue, 16 May 2017 10:58:10 +0300
Message-Id: <1494921494-33717-5-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
References: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v4 4/8] tpm-backend: Made few interface methods
 optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Amarnath Valluri <amarnath.valluri@intel.com>

This allows backend implementations left optional interface methods.
For mandatory methods assertion checks added.

Took the opportunity to remove unused methods:
  tpm_backend_get_type()
  tpm_backend_get_desc()

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c               | 36 +++++++++++++++++-------------------
 hw/tpm/tpm_passthrough.c     | 23 +----------------------
 include/sysemu/tpm_backend.h | 19 +------------------
 tpm.c                        |  2 +-
 4 files changed, 20 insertions(+), 60 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index cf5abf1..05002e6 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -37,20 +37,6 @@ static void tpm_backend_thread_end(TPMBackend *s)
     }
 }
 
-enum TpmType tpm_backend_get_type(TPMBackend *s)
-{
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
-
-    return k->ops->type;
-}
-
-const char *tpm_backend_get_desc(TPMBackend *s)
-{
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
-
-    return k->ops->desc();
-}
-
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
@@ -59,7 +45,7 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
     s->tpm_state = state;
     s->recv_data_callback = datacb;
 
-    return k->ops->init(s);
+    return k->ops->init ? k->ops->init(s) : 0;
 }
 
 int tpm_backend_startup_tpm(TPMBackend *s)
@@ -73,13 +59,15 @@ int tpm_backend_startup_tpm(TPMBackend *s)
                                        NULL);
     g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_INIT, NULL);
 
-    return k->ops->startup_tpm(s);
+    return k->ops->startup_tpm ? k->ops->startup_tpm(s) : 0;
 }
 
 bool tpm_backend_had_startup_error(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
+    assert(k->ops->had_startup_error);
+
     return k->ops->had_startup_error(s);
 }
 
@@ -87,6 +75,8 @@ size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
+    assert(k->ops->realloc_buffer);
+
     return k->ops->realloc_buffer(sb);
 }
 
@@ -100,7 +90,9 @@ void tpm_backend_reset(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    k->ops->reset(s);
+    if (k->ops->reset) {
+        k->ops->reset(s);
+    }
 
     tpm_backend_thread_end(s);
 }
@@ -109,6 +101,8 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
+    assert(k->ops->cancel_cmd);
+
     k->ops->cancel_cmd(s);
 }
 
@@ -116,20 +110,24 @@ bool tpm_backend_get_tpm_established_flag(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    return k->ops->get_tpm_established_flag(s);
+    return k->ops->get_tpm_established_flag ?
+           k->ops->get_tpm_established_flag(s) : false;
 }
 
 int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t locty)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
-    return k->ops->reset_tpm_established_flag(s, locty);
+    return k->ops->reset_tpm_established_flag ?
+           k->ops->reset_tpm_established_flag(s, locty) : 0;
 }
 
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
 {
     TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
 
+    assert(k->ops->get_tpm_version);
+
     return k->ops->get_tpm_version(s);
 }
 
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 815a72e..a0459a6 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -227,15 +227,6 @@ static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd cmd)
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
@@ -247,11 +238,6 @@ static void tpm_passthrough_reset(TPMBackend *tb)
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
@@ -309,11 +295,6 @@ static void tpm_passthrough_cancel_cmd(TPMBackend *tb)
     }
 }
 
-static const char *tpm_passthrough_create_desc(void)
-{
-    return "Passthrough TPM backend driver";
-}
-
 static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
@@ -453,10 +434,8 @@ static const QemuOptDesc tpm_passthrough_cmdline_opts[] = {
 static const TPMDriverOps tpm_passthrough_driver = {
     .type                     = TPM_TYPE_PASSTHROUGH,
     .opts                     = tpm_passthrough_cmdline_opts,
-    .desc                     = tpm_passthrough_create_desc,
+    .desc                     = "Passthrough TPM backend driver",
     .create                   = tpm_passthrough_create,
-    .init                     = tpm_passthrough_init,
-    .startup_tpm              = tpm_passthrough_startup_tpm,
     .realloc_buffer           = tpm_passthrough_realloc_buffer,
     .reset                    = tpm_passthrough_reset,
     .had_startup_error        = tpm_passthrough_get_startup_error,
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index f61bcfe..d6ae463 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -75,7 +75,7 @@ struct TPMDriverOps {
     enum TpmType type;
     const QemuOptDesc *opts;
     /* get a descriptive text of the backend to display to the user */
-    const char *(*desc)(void);
+    const char *desc;
 
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
 
@@ -99,23 +99,6 @@ struct TPMDriverOps {
     TPMVersion (*get_tpm_version)(TPMBackend *t);
 };
 
-
-/**
- * tpm_backend_get_type:
- * @s: the backend
- *
- * Returns the TpmType of the backend.
- */
-enum TpmType tpm_backend_get_type(TPMBackend *s);
-
-/**
- * tpm_backend_get_desc:
- * @s: the backend
- *
- * Returns a human readable description of the backend.
- */
-const char *tpm_backend_get_desc(TPMBackend *s);
-
 /**
  * tpm_backend_init:
  * @s: the backend to initialized
diff --git a/tpm.c b/tpm.c
index 70f74fa..2979508 100644
--- a/tpm.c
+++ b/tpm.c
@@ -102,7 +102,7 @@ static void tpm_display_backend_drivers(void)
 
     for (i = 0; i < TPM_MAX_DRIVERS && be_drivers[i] != NULL; i++) {
         fprintf(stderr, "%12s   %s\n",
-                TpmType_lookup[be_drivers[i]->type], be_drivers[i]->desc());
+                TpmType_lookup[be_drivers[i]->type], be_drivers[i]->desc);
     }
     fprintf(stderr, "\n");
 }
-- 
2.7.4
