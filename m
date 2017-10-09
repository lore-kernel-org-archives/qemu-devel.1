Received: from eggs.gnu.org ([2001:4830:134:3::10]:54958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzT-0006G6-TG
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gzQ-0005Eu-OM
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gzQ-0005Ef-G4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:36 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:56:02 +0200
Message-Id: <20171009225623.29232-22-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/42] tpm: move recv_data_callback to TPM
 interface
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

Simplify the TPM backend setup, move callback to TPM interface.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_int.h             |  3 +++
 include/sysemu/tpm_backend.h |  6 +-----
 backends/tpm.c               |  4 +---
 hw/tpm/tpm_emulator.c        |  3 ++-
 hw/tpm/tpm_passthrough.c     |  3 ++-
 hw/tpm/tpm_tis.c             | 11 ++++++-----
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index eb02e7760c..9c045b6691 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -29,6 +29,9 @@ typedef struct TPMIf {
=20
 typedef struct TPMIfClass {
     InterfaceClass parent_class;
+
+    /* run in thread pool by backend */
+    void (*request_completed)(TPMIf *obj);
 } TPMIfClass;
=20
 #define TPM_STANDARD_CMDLINE_OPTS               \
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 3bb90be3de..03ea5a3400 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -30,8 +30,6 @@
 typedef struct TPMBackendClass TPMBackendClass;
 typedef struct TPMBackend TPMBackend;
=20
-typedef void (TPMRecvDataCB)(TPMState *);
-
 typedef struct TPMBackendCmd {
     uint8_t locty;
     const uint8_t *in;
@@ -48,7 +46,6 @@ struct TPMBackend {
     bool opened;
     TPMState *tpm_state;
     GThreadPool *thread_pool;
-    TPMRecvDataCB *recv_data_callback;
     bool had_startup_error;
=20
     /* <public> */
@@ -106,8 +103,7 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
  *
  * Returns 0 on success.
  */
-int tpm_backend_init(TPMBackend *s, TPMState *state,
-                     TPMRecvDataCB *datacb);
+int tpm_backend_init(TPMBackend *s, TPMState *state);
=20
 /**
  * tpm_backend_startup_tpm:
diff --git a/backends/tpm.c b/backends/tpm.c
index 87c5c09179..5763f6f369 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -44,11 +44,9 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
     return k->type;
 }
=20
-int tpm_backend_init(TPMBackend *s, TPMState *state,
-                     TPMRecvDataCB *datacb)
+int tpm_backend_init(TPMBackend *s, TPMState *state)
 {
     s->tpm_state =3D state;
-    s->recv_data_callback =3D datacb;
     s->had_startup_error =3D false;
=20
     return 0;
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 407ac97651..f04f4e0830 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -176,6 +176,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm=
_emu, uint8_t locty_number,
 static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *c=
md)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
+    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
     Error *err =3D NULL;
=20
     DPRINTF("processing TPM command");
@@ -190,7 +191,7 @@ static void tpm_emulator_handle_request(TPMBackend *t=
b, TPMBackendCmd *cmd)
         goto error;
     }
=20
-    tb->recv_data_callback(tb->tpm_state);
+    tic->request_completed(TPM_IF(tb->tpm_state));
     return;
=20
 error:
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 4274164a61..c440aff4b2 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -139,13 +139,14 @@ err_exit:
 static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
+    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpm_state);
=20
     DPRINTF("tpm_passthrough: processing command %p\n", cmd);
=20
     tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
                                  cmd->out, cmd->out_len, &cmd->selftest_=
done);
=20
-    tb->recv_data_callback(tb->tpm_state);
+    tic->request_completed(TPM_IF(tb->tpm_state));
 }
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index dbb50043ac..8c5cac5fa5 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -430,11 +430,10 @@ static void tpm_tis_receive_bh(void *opaque)
                       TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VALID=
);
 }
=20
-/*
- * Callback from the TPM to indicate that the response was received.
- */
-static void tpm_tis_receive_cb(TPMState *s)
+static void tpm_tis_request_completed(TPMIf *ti)
 {
+    TPMState *s =3D TPM(ti);
+
     bool is_selftest_done =3D s->cmd.selftest_done;
     uint8_t locty =3D s->cmd.locty;
     uint8_t l;
@@ -1078,7 +1077,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
=20
     s->be_driver->fe_model =3D TPM_MODEL_TPM_TIS;
=20
-    if (tpm_backend_init(s->be_driver, s, tpm_tis_receive_cb)) {
+    if (tpm_backend_init(s->be_driver, s)) {
         error_setg(errp, "tpm_tis: backend driver with id %s could not b=
e "
                    "initialized", s->backend);
         return;
@@ -1110,11 +1109,13 @@ static void tpm_tis_initfn(Object *obj)
 static void tpm_tis_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
=20
     dc->realize =3D tpm_tis_realizefn;
     dc->props =3D tpm_tis_properties;
     dc->reset =3D tpm_tis_reset;
     dc->vmsd  =3D &vmstate_tpm_tis;
+    tc->request_completed =3D tpm_tis_request_completed;
 }
=20
 static const TypeInfo tpm_tis_info =3D {
--=20
2.14.1.146.gd35faa819
