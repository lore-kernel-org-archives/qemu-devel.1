Received: from eggs.gnu.org ([2001:4830:134:3::10]:54991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzW-0006IK-ED
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzV-0005Gr-Dl
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42592)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzV-0005GR-5y
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:41 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:03 +0200
Message-Id: <20171009225623.29232-23-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 22/42] tpm-backend: store TPMIf interface,
 improve backend_init()
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

Store the TPM interface, the actual object may be different from
TPMState. Keep a reference on the interface, and check the backend
wasn't already initialized.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h |  7 ++++---
 backends/tpm.c               | 12 +++++++++---
 hw/tpm/tpm_emulator.c        |  4 ++--
 hw/tpm/tpm_passthrough.c     |  4 ++--
 hw/tpm/tpm_tis.c             |  2 +-
 5 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 03ea5a3400..8d08765b3c 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -18,6 +18,7 @@
 #include "qapi-types.h"
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
+#include "hw/tpm/tpm_int.h"
=20
 #define TYPE_TPM_BACKEND "tpm-backend"
 #define TPM_BACKEND(obj) \
@@ -43,8 +44,8 @@ struct TPMBackend {
     Object parent;
=20
     /*< protected >*/
+    TPMIf *tpmif;
     bool opened;
-    TPMState *tpm_state;
     GThreadPool *thread_pool;
     bool had_startup_error;
=20
@@ -96,14 +97,14 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
 /**
  * tpm_backend_init:
  * @s: the backend to initialized
- * @state: TPMState
+ * @tpmif: TPM interface
  * @datacb: callback for sending data to frontend
  *
  * Initialize the backend with the given variables.
  *
  * Returns 0 on success.
  */
-int tpm_backend_init(TPMBackend *s, TPMState *state);
+int tpm_backend_init(TPMBackend *s, TPMIf *tpmif);
=20
 /**
  * tpm_backend_startup_tpm:
diff --git a/backends/tpm.c b/backends/tpm.c
index 5763f6f369..86f0e7e915 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm.h"
-#include "hw/tpm/tpm_int.h"
 #include "qemu/thread.h"
=20
 static void tpm_backend_worker_thread(gpointer data, gpointer user_data)
@@ -44,9 +43,15 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
     return k->type;
 }
=20
-int tpm_backend_init(TPMBackend *s, TPMState *state)
+int tpm_backend_init(TPMBackend *s, TPMIf *tpmif)
 {
-    s->tpm_state =3D state;
+    if (s->tpmif) {
+        return -1;
+    }
+
+    s->tpmif =3D tpmif;
+    object_ref(OBJECT(tpmif));
+
     s->had_startup_error =3D false;
=20
     return 0;
@@ -194,6 +199,7 @@ static void tpm_backend_instance_finalize(Object *obj=
)
 {
     TPMBackend *s =3D TPM_BACKEND(obj);
=20
+    object_unref(OBJECT(s->tpmif));
     g_free(s->id);
     tpm_backend_thread_end(s);
 }
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index f04f4e0830..07e7aa4abc 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -176,7 +176,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm=
_emu, uint8_t locty_number,
 static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *c=
md)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
-    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
+    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
     Error *err =3D NULL;
=20
     DPRINTF("processing TPM command");
@@ -191,7 +191,7 @@ static void tpm_emulator_handle_request(TPMBackend *t=
b, TPMBackendCmd *cmd)
         goto error;
     }
=20
-    tic->request_completed(TPM_IF(tb->tpm_state));
+    tic->request_completed(tb->tpmif);
     return;
=20
 error:
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index c440aff4b2..2ad74badca 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -139,14 +139,14 @@ err_exit:
 static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
-    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
+    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
=20
     DPRINTF("tpm_passthrough: processing command %p\n", cmd);
=20
     tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
                                  cmd->out, cmd->out_len, &cmd->selftest_=
done);
=20
-    tic->request_completed(TPM_IF(tb->tpm_state));
+    tic->request_completed(tb->tpmif);
 }
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 8c5cac5fa5..c24be57136 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1077,7 +1077,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
=20
     s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
=20
-    if (tpm_backend_init(s->be_driver, s)) {
+    if (tpm_backend_init(s->be_driver, TPM_IF(s))) {
         error_setg(errp, "tpm_tis: backend driver with id %s could not b=
e "
                    "initialized", s->backend);
         return;
--=20
2.14.1.146.gd35faa819
