Received: from eggs.gnu.org ([2001:4830:134:3::10]:56536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXO6-00085X-RH
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXO2-0004fU-Lm
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ecXO2-0004dY-D3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:18 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Jan 2018 15:11:01 +0100
Message-Id: <20180119141105.29095-3-marcandre.lureau@redhat.com>
In-Reply-To: <20180119141105.29095-1-marcandre.lureau@redhat.com>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/5] tpm: replace GThreadPool with AIO
 threadpool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

The TPM backend uses a GThreadPool to handle IO in a seperate
thread. However, GThreadPool isn't integrated with Qemu main loops,
making it unnecessarily complicated to deal with.

Qemu has a AIO threadpool, that is better integrated with loops and
various IO functions, provides completion BH by default etc.

Remove the only user of GThreadPool from qemu, use AIO threadpool.

Note that the backend:
- no longer accepts queing multiple requests (unneeded so far)
- increase ref to itself when handling a command, for extra safety
- tpm_backend_thread_end() is renamed tpm_backend_finish_sync() and
will wait for completion of BH (request_completed), which will help
migration handling.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h | 12 ++++++++--
 backends/tpm.c               | 52 +++++++++++++++++++++++---------------=
------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 0d6c994a62..a69593e0cd 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -45,9 +45,8 @@ struct TPMBackend {
     /*< protected >*/
     TPMIf *tpmif;
     bool opened;
-    GThreadPool *thread_pool;
     bool had_startup_error;
-    QEMUBH *bh;
+    TPMBackendCmd *cmd;
=20
     /* <public> */
     char *id;
@@ -196,6 +195,15 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s=
);
  */
 size_t tpm_backend_get_buffer_size(TPMBackend *s);
=20
+/**
+ * tpm_backend_finish_sync:
+ * @s: the backend to call into
+ *
+ * Finish the pending command synchronously (this will call aio_poll()
+ * on qemu main AIOContext until it ends)
+ */
+void tpm_backend_finish_sync(TPMBackend *s);
+
 /**
  * tpm_backend_query_tpm:
  * @s: the backend
diff --git a/backends/tpm.c b/backends/tpm.c
index 91222c5164..143807aa37 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -19,30 +19,35 @@
 #include "sysemu/tpm.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
+#include "block/thread-pool.h"
+#include "qemu/error-report.h"
=20
-static void tpm_backend_request_completed_bh(void *opaque)
+static void tpm_backend_request_completed(void *opaque, int ret)
 {
     TPMBackend *s =3D TPM_BACKEND(opaque);
     TPMIfClass *tic =3D TPM_IF_GET_CLASS(s->tpmif);
=20
     tic->request_completed(s->tpmif);
+
+    /* no need for atomic, as long the BQL is taken */
+    s->cmd =3D NULL;
+    object_unref(OBJECT(s));
 }
=20
-static void tpm_backend_worker_thread(gpointer data, gpointer user_data)
+static int tpm_backend_worker_thread(gpointer data)
 {
-    TPMBackend *s =3D TPM_BACKEND(user_data);
+    TPMBackend *s =3D TPM_BACKEND(data);
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    k->handle_request(s, (TPMBackendCmd *)data);
+    k->handle_request(s, s->cmd);
=20
-    qemu_bh_schedule(s->bh);
+    return 0;
 }
=20
-static void tpm_backend_thread_end(TPMBackend *s)
+void tpm_backend_finish_sync(TPMBackend *s)
 {
-    if (s->thread_pool) {
-        g_thread_pool_free(s->thread_pool, FALSE, TRUE);
-        s->thread_pool =3D NULL;
+    while (s->cmd) {
+        aio_poll(qemu_get_aio_context(), true);
     }
 }
=20
@@ -74,10 +79,7 @@ int tpm_backend_startup_tpm(TPMBackend *s, size_t buff=
ersize)
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
     /* terminate a running TPM */
-    tpm_backend_thread_end(s);
-
-    s->thread_pool =3D g_thread_pool_new(tpm_backend_worker_thread, s, 1=
, TRUE,
-                                       NULL);
+    tpm_backend_finish_sync(s);
=20
     res =3D k->startup_tpm ? k->startup_tpm(s, buffersize) : 0;
=20
@@ -93,7 +95,17 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
=20
 void tpm_backend_deliver_request(TPMBackend *s, TPMBackendCmd *cmd)
 {
-    g_thread_pool_push(s->thread_pool, cmd, NULL);
+    ThreadPool *pool =3D aio_get_thread_pool(qemu_get_aio_context());
+
+    if (s->cmd !=3D NULL) {
+        error_report("There is a TPM request pending");
+        return;
+    }
+
+    s->cmd =3D cmd;
+    object_ref(OBJECT(s));
+    thread_pool_submit_aio(pool, tpm_backend_worker_thread, s,
+                           tpm_backend_request_completed, s);
 }
=20
 void tpm_backend_reset(TPMBackend *s)
@@ -104,7 +116,7 @@ void tpm_backend_reset(TPMBackend *s)
         k->reset(s);
     }
=20
-    tpm_backend_thread_end(s);
+    tpm_backend_finish_sync(s);
=20
     s->had_startup_error =3D false;
 }
@@ -159,28 +171,18 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
     return info;
 }
=20
-static void tpm_backend_instance_init(Object *obj)
-{
-    TPMBackend *s =3D TPM_BACKEND(obj);
-
-    s->bh =3D qemu_bh_new(tpm_backend_request_completed_bh, s);
-}
-
 static void tpm_backend_instance_finalize(Object *obj)
 {
     TPMBackend *s =3D TPM_BACKEND(obj);
=20
     object_unref(OBJECT(s->tpmif));
     g_free(s->id);
-    tpm_backend_thread_end(s);
-    qemu_bh_delete(s->bh);
 }
=20
 static const TypeInfo tpm_backend_info =3D {
     .name =3D TYPE_TPM_BACKEND,
     .parent =3D TYPE_OBJECT,
     .instance_size =3D sizeof(TPMBackend),
-    .instance_init =3D tpm_backend_instance_init,
     .instance_finalize =3D tpm_backend_instance_finalize,
     .class_size =3D sizeof(TPMBackendClass),
     .abstract =3D true,
--=20
2.16.0.rc1.1.gef27df75a1
