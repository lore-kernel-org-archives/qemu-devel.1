Received: from eggs.gnu.org ([2001:4830:134:3::10]:56588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXOA-00088l-Ss
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1ecXO7-0004mC-JR
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1ecXO7-0004lU-AX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 09:11:23 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 19 Jan 2018 15:11:02 +0100
Message-Id: <20180119141105.29095-4-marcandre.lureau@redhat.com>
In-Reply-To: <20180119141105.29095-1-marcandre.lureau@redhat.com>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 3/5] tpm: report backend request error
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

Use an Error** for request to let the caller handle error reporting.

This will also allow to inform the frontend of a backend error.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm.h         |  2 +-
 include/sysemu/tpm_backend.h |  3 ++-
 backends/tpm.c               |  9 +++++++--
 hw/tpm/tpm_emulator.c        | 21 ++++++---------------
 hw/tpm/tpm_passthrough.c     | 31 +++++++++++++++----------------
 hw/tpm/tpm_tis.c             |  3 ++-
 6 files changed, 33 insertions(+), 36 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 852e02687c..ac04a9d4a2 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -41,7 +41,7 @@ typedef struct TPMIfClass {
     InterfaceClass parent_class;
=20
     enum TpmModel model;
-    void (*request_completed)(TPMIf *obj);
+    void (*request_completed)(TPMIf *obj, int ret);
     enum TPMVersion (*get_version)(TPMIf *obj);
 } TPMIfClass;
=20
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index a69593e0cd..7e166ef954 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -18,6 +18,7 @@
 #include "qapi-types.h"
 #include "qemu/option.h"
 #include "sysemu/tpm.h"
+#include "qapi/error.h"
=20
 #define TYPE_TPM_BACKEND "tpm-backend"
 #define TPM_BACKEND(obj) \
@@ -84,7 +85,7 @@ struct TPMBackendClass {
=20
     TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
=20
-    void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd);
+    void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd, Error **er=
rp);
 };
=20
 /**
diff --git a/backends/tpm.c b/backends/tpm.c
index 143807aa37..d617ba7c52 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -27,7 +27,7 @@ static void tpm_backend_request_completed(void *opaque,=
 int ret)
     TPMBackend *s =3D TPM_BACKEND(opaque);
     TPMIfClass *tic =3D TPM_IF_GET_CLASS(s->tpmif);
=20
-    tic->request_completed(s->tpmif);
+    tic->request_completed(s->tpmif, ret);
=20
     /* no need for atomic, as long the BQL is taken */
     s->cmd =3D NULL;
@@ -38,8 +38,13 @@ static int tpm_backend_worker_thread(gpointer data)
 {
     TPMBackend *s =3D TPM_BACKEND(data);
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
+    Error *err =3D NULL;
=20
-    k->handle_request(s, s->cmd);
+    k->handle_request(s, s->cmd, &err);
+    if (err) {
+        error_report_err(err);
+        return -1;
+    }
=20
     return 0;
 }
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 35c78de5a9..52552af9f9 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -185,28 +185,19 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number,
     return 0;
 }
=20
-static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *c=
md)
+static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *c=
md,
+                                        Error **errp)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
-    Error *err =3D NULL;
=20
     DPRINTF("processing TPM command");
=20
-    if (tpm_emulator_set_locality(tpm_emu, cmd->locty, &err) < 0) {
-        goto error;
-    }
-
-    if (tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
+    if (tpm_emulator_set_locality(tpm_emu, cmd->locty, errp) < 0 ||
+        tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
                                   cmd->out, cmd->out_len,
-                                  &cmd->selftest_done, &err) < 0) {
-        goto error;
+                                  &cmd->selftest_done, errp) < 0) {
+        tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
     }
-
-    return;
-
-error:
-    tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
-    error_report_err(err);
 }
=20
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index f2563ac668..37dce15801 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -80,10 +80,11 @@ static int tpm_passthrough_unix_read(int fd, uint8_t =
*buf, uint32_t len)
     }
     return ret;
 }
-static int tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
-                                        const uint8_t *in, uint32_t in_l=
en,
-                                        uint8_t *out, uint32_t out_len,
-                                        bool *selftest_done)
+
+static void tpm_passthrough_unix_tx_bufs(TPMPassthruState *tpm_pt,
+                                         const uint8_t *in, uint32_t in_=
len,
+                                         uint8_t *out, uint32_t out_len,
+                                         bool *selftest_done, Error **er=
rp)
 {
     ssize_t ret;
     bool is_selftest;
@@ -99,9 +100,8 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthruSta=
te *tpm_pt,
     ret =3D qemu_write_full(tpm_pt->tpm_fd, in, in_len);
     if (ret !=3D in_len) {
         if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
-            error_report("tpm_passthrough: error while transmitting data=
 "
-                         "to TPM: %s (%i)",
-                         strerror(errno), errno);
+            error_setg_errno(errp, errno, "tpm_passthrough: error while =
"
+                             "transmitting data to TPM");
         }
         goto err_exit;
     }
@@ -111,15 +111,14 @@ static int tpm_passthrough_unix_tx_bufs(TPMPassthru=
State *tpm_pt,
     ret =3D tpm_passthrough_unix_read(tpm_pt->tpm_fd, out, out_len);
     if (ret < 0) {
         if (!tpm_pt->tpm_op_canceled || errno !=3D ECANCELED) {
-            error_report("tpm_passthrough: error while reading data from=
 "
-                         "TPM: %s (%i)",
-                         strerror(errno), errno);
+            error_setg_errno(errp, errno, "tpm_passthrough: error while =
"
+                             "reading data from TPM");
         }
     } else if (ret < sizeof(struct tpm_resp_hdr) ||
                be32_to_cpu(((struct tpm_resp_hdr *)out)->len) !=3D ret) =
{
         ret =3D -1;
-        error_report("tpm_passthrough: received invalid response "
-                     "packet from TPM");
+        error_setg_errno(errp, errno, "tpm_passthrough: received invalid=
 "
+                     "response packet from TPM");
     }
=20
     if (is_selftest && (ret >=3D sizeof(struct tpm_resp_hdr))) {
@@ -133,18 +132,18 @@ err_exit:
     }
=20
     tpm_pt->tpm_executing =3D false;
-
-    return ret;
 }
=20
-static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
+static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd,
+                                           Error **errp)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
=20
     DPRINTF("tpm_passthrough: processing command %p\n", cmd);
=20
     tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
-                                 cmd->out, cmd->out_len, &cmd->selftest_=
done);
+                                 cmd->out, cmd->out_len, &cmd->selftest_=
done,
+                                 errp);
 }
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 8b5eb01a2c..08f41d2707 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -393,7 +393,7 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t l=
octy, uint8_t newlocty)
 /*
  * Callback from the TPM to indicate that the response was received.
  */
-static void tpm_tis_request_completed(TPMIf *ti)
+static void tpm_tis_request_completed(TPMIf *ti, int ret)
 {
     TPMState *s =3D TPM(ti);
     uint8_t locty =3D s->cmd.locty;
@@ -405,6 +405,7 @@ static void tpm_tis_request_completed(TPMIf *ti)
         }
     }
=20
+    /* FIXME: report error if ret !=3D 0 */
     tpm_tis_sts_set(&s->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
     s->loc[locty].state =3D TPM_TIS_STATE_COMPLETION;
--=20
2.16.0.rc1.1.gef27df75a1
