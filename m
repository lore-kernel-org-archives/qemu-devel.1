Received: from eggs.gnu.org ([2001:4830:134:3::10]:42971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6Ewz-0005dh-KY
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d6Eww-00058P-Fa
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:29:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:20034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d6Eww-00056t-5b
	for qemu-devel@nongnu.org; Thu, 04 May 2017 07:29:34 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Thu,  4 May 2017 14:31:38 +0300
Message-Id: <1493897498-27475-1-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <CAJ+F1CJJK6e6JDmvxzoVhZs-wT0ziGOO6_y62_zMXyUL6xjjSQ@mail.gmail.com>
References: <CAJ+F1CJJK6e6JDmvxzoVhZs-wT0ziGOO6_y62_zMXyUL6xjjSQ@mail.gmail.com>
Subject: [Qemu-devel] [PATCH v4 6/8] tpm-backend: Move realloc_buffer()
 implementation to tpm-tis model
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

buffer reallocation is very unlikely to be backend specific. Hence move inside
the tis.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c               |  9 ---------
 hw/tpm/tpm_passthrough.c     | 12 ------------
 hw/tpm/tpm_tis.c             | 14 ++++++++++++--
 include/sysemu/tpm_backend.h | 12 ------------
 4 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 4ae6129..3519570 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -71,15 +71,6 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
     return k->ops->had_startup_error(s);
 }
 
-size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
-{
-    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
-
-    assert(k->ops->realloc_buffer);
-
-    return k->ops->realloc_buffer(sb);
-}
-
 void tpm_backend_deliver_request(TPMBackend *s)
 {
     g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_PROCESS_CMD,
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index c7706e4..4ac47ed 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -258,17 +258,6 @@ static bool tpm_passthrough_get_startup_error(TPMBackend *tb)
     return tpm_pt->had_startup_error;
 }
 
-static size_t tpm_passthrough_realloc_buffer(TPMSizedBuffer *sb)
-{
-    size_t wanted_size = 4096; /* Linux tpm.c buffer size */
-
-    if (sb->size != wanted_size) {
-        sb->buffer = g_realloc(sb->buffer, wanted_size);
-        sb->size = wanted_size;
-    }
-    return sb->size;
-}
-
 static void tpm_passthrough_cancel_cmd(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
@@ -475,7 +464,6 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .opts                     = tpm_passthrough_cmdline_opts,
     .desc                     = "Passthrough TPM backend driver",
     .create                   = tpm_passthrough_create,
-    .realloc_buffer           = tpm_passthrough_realloc_buffer,
     .reset                    = tpm_passthrough_reset,
     .had_startup_error        = tpm_passthrough_get_startup_error,
     .cancel_cmd               = tpm_passthrough_cancel_cmd,
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index a6440fe..d5118e7 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -963,6 +963,16 @@ static int tpm_tis_do_startup_tpm(TPMState *s)
     return tpm_backend_startup_tpm(s->be_driver);
 }
 
+static void tpm_tis_realloc_buffer(TPMSizedBuffer *sb)
+{
+    size_t wanted_size = 4096; /* Linux tpm.c buffer size */
+
+    if (sb->size != wanted_size) {
+        sb->buffer = g_realloc(sb->buffer, wanted_size);
+        sb->size = wanted_size;
+    }
+}
+
 /*
  * Get the TPMVersion of the backend device being used
  */
@@ -1010,9 +1020,9 @@ static void tpm_tis_reset(DeviceState *dev)
         tis->loc[c].state = TPM_TIS_STATE_IDLE;
 
         tis->loc[c].w_offset = 0;
-        tpm_backend_realloc_buffer(s->be_driver, &tis->loc[c].w_buffer);
+        tpm_tis_realloc_buffer(&tis->loc[c].w_buffer);
         tis->loc[c].r_offset = 0;
-        tpm_backend_realloc_buffer(s->be_driver, &tis->loc[c].r_buffer);
+        tpm_tis_realloc_buffer(&tis->loc[c].r_buffer);
     }
 
     tpm_tis_do_startup_tpm(s);
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 6e5bb8d..bebfba3 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -85,8 +85,6 @@ struct TPMDriverOps {
     /* returns true if nothing will ever answer TPM requests */
     bool (*had_startup_error)(TPMBackend *t);
 
-    size_t (*realloc_buffer)(TPMSizedBuffer *sb);
-
     void (*reset)(TPMBackend *t);
 
     void (*cancel_cmd)(TPMBackend *t);
@@ -132,16 +130,6 @@ int tpm_backend_startup_tpm(TPMBackend *s);
 bool tpm_backend_had_startup_error(TPMBackend *s);
 
 /**
- * tpm_backend_realloc_buffer:
- * @s: the backend
- * @sb: the TPMSizedBuffer to re-allocated to the size suitable for the
- *      backend.
- *
- * This function returns the size of the allocated buffer
- */
-size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb);
-
-/**
  * tpm_backend_deliver_request:
  * @s: the backend to send the request to
  *
-- 
2.7.4
