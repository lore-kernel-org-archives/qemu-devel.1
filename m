Received: from eggs.gnu.org ([2001:4830:134:3::10]:54740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gz7-0005xR-34
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gz5-000559-R4
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gz5-00054p-IV
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:15 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:55 +0200
Message-Id: <20171009225623.29232-15-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 14/42] tpm: add TPMBackendCmd to hold the
 request state
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

This simplifies a bit locality handling, and argument passing, and
could pave the way to queuing requests (if that makes sense).

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_int.h             |  1 +
 include/sysemu/tpm_backend.h | 16 +++++++++++++---
 backends/tpm.c               |  6 +++---
 hw/tpm/tpm_emulator.c        | 29 +++++++++++++++--------------
 hw/tpm/tpm_passthrough.c     | 24 +++++-------------------
 hw/tpm/tpm_tis.c             | 18 +++++++++++++-----
 6 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/hw/tpm/tpm_int.h b/hw/tpm/tpm_int.h
index f2f285b3cc..6d7b3dc850 100644
--- a/hw/tpm/tpm_int.h
+++ b/hw/tpm/tpm_int.h
@@ -26,6 +26,7 @@ struct TPMState {
=20
     uint8_t     locty_number;
     TPMLocality *locty_data;
+    TPMBackendCmd cmd;
=20
     char *backend;
     TPMBackend *be_driver;
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 9c83a512e1..3bb90be3de 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -30,7 +30,16 @@
 typedef struct TPMBackendClass TPMBackendClass;
 typedef struct TPMBackend TPMBackend;
=20
-typedef void (TPMRecvDataCB)(TPMState *, bool selftest_done);
+typedef void (TPMRecvDataCB)(TPMState *);
+
+typedef struct TPMBackendCmd {
+    uint8_t locty;
+    const uint8_t *in;
+    uint32_t in_len;
+    uint8_t *out;
+    uint32_t out_len;
+    bool selftest_done;
+} TPMBackendCmd;
=20
 struct TPMBackend {
     Object parent;
@@ -76,7 +85,7 @@ struct TPMBackendClass {
=20
     void (*opened)(TPMBackend *s, Error **errp);
=20
-    void (*handle_request)(TPMBackend *s);
+    void (*handle_request)(TPMBackend *s, TPMBackendCmd *cmd);
 };
=20
 /**
@@ -121,11 +130,12 @@ bool tpm_backend_had_startup_error(TPMBackend *s);
 /**
  * tpm_backend_deliver_request:
  * @s: the backend to send the request to
+ * @cmd: the command to deliver
  *
  * Send a request to the backend. The backend will then send the request
  * to the TPM implementation.
  */
-void tpm_backend_deliver_request(TPMBackend *s);
+void tpm_backend_deliver_request(TPMBackend *s, TPMBackendCmd *cmd);
=20
 /**
  * tpm_backend_reset:
diff --git a/backends/tpm.c b/backends/tpm.c
index 34e82085ec..dc7c831ff8 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -25,7 +25,7 @@ static void tpm_backend_worker_thread(gpointer data, gp=
ointer user_data)
     TPMBackendClass *k  =3D TPM_BACKEND_GET_CLASS(s);
=20
     assert(k->handle_request !=3D NULL);
-    k->handle_request(s);
+    k->handle_request(s, (TPMBackendCmd *)data);
 }
=20
 static void tpm_backend_thread_end(TPMBackend *s)
@@ -76,9 +76,9 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
     return s->had_startup_error;
 }
=20
-void tpm_backend_deliver_request(TPMBackend *s)
+void tpm_backend_deliver_request(TPMBackend *s, TPMBackendCmd *cmd)
 {
-    g_thread_pool_push(s->thread_pool, NULL, NULL);
+    g_thread_pool_push(s->thread_pool, cmd, NULL);
 }
=20
 void tpm_backend_reset(TPMBackend *s)
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 4fe405353a..788ab9876d 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -172,28 +172,29 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number)
     return 0;
 }
=20
-static void tpm_emulator_handle_request(TPMBackend *tb)
+static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *c=
md)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
-    TPMLocality *locty =3D NULL;
-    bool selftest_done =3D false;
     Error *err =3D NULL;
=20
     DPRINTF("processing TPM command");
=20
-    locty =3D tb->tpm_state->locty_data;
-    if (tpm_emulator_set_locality(tpm_emu,
-                                  tb->tpm_state->locty_number) < 0 ||
-        tpm_emulator_unix_tx_bufs(tpm_emu, locty->w_buffer.buffer,
-                                  locty->w_offset, locty->r_buffer.buffe=
r,
-                                  locty->r_buffer.size, &selftest_done,
-                                  &err) < 0) {
-        tpm_util_write_fatal_error_response(locty->r_buffer.buffer,
-                                            locty->r_buffer.size);
-        error_report_err(err);
+    if (tpm_emulator_set_locality(tpm_emu, tb->tpm_state->locty_number) =
< 0) {
+        goto error;
+    }
+
+    if (tpm_emulator_unix_tx_bufs(tpm_emu, cmd->in, cmd->in_len,
+                                  cmd->out, cmd->out_len,
+                                  &cmd->selftest_done, &err) < 0) {
+        goto error;
     }
=20
-    tb->recv_data_callback(tb->tpm_state, selftest_done);
+    tb->recv_data_callback(tb->tpm_state);
+    return;
+
+error:
+    tpm_util_write_fatal_error_response(cmd->out, cmd->out_len);
+    error_report_err(err);
 }
=20
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 0ae4596932..93d72b8e9e 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -137,30 +137,16 @@ err_exit:
     return ret;
 }
=20
-static int tpm_passthrough_unix_transfer(TPMPassthruState *tpm_pt,
-                                         const TPMLocality *locty_data,
-                                         bool *selftest_done)
-{
-    return tpm_passthrough_unix_tx_bufs(tpm_pt,
-                                        locty_data->w_buffer.buffer,
-                                        locty_data->w_offset,
-                                        locty_data->r_buffer.buffer,
-                                        locty_data->r_buffer.size,
-                                        selftest_done);
-}
-
-static void tpm_passthrough_handle_request(TPMBackend *tb)
+static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
-    bool selftest_done =3D false;
=20
-    DPRINTF("tpm_passthrough: processing command\n");
+    DPRINTF("tpm_passthrough: processing command %p\n", cmd);
=20
-    tpm_passthrough_unix_transfer(tpm_pt,
-                                  tb->tpm_state->locty_data,
-                                  &selftest_done);
+    tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
+                                 cmd->out, cmd->out_len, &cmd->selftest_=
done);
=20
-    tb->recv_data_callback(tb->tpm_state, selftest_done);
+    tb->recv_data_callback(tb->tpm_state);
 }
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 345a4fbee5..ffed7bfaf9 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -215,7 +215,15 @@ static void tpm_tis_tpm_send(TPMState *s, uint8_t lo=
cty)
      */
     tis->loc[locty].state =3D TPM_TIS_STATE_EXECUTION;
=20
-    tpm_backend_deliver_request(s->be_driver);
+    s->cmd =3D (TPMBackendCmd) {
+        .locty =3D locty,
+        .in =3D s->locty_data->w_buffer.buffer,
+        .in_len =3D s->locty_data->w_offset,
+        .out =3D s->locty_data->r_buffer.buffer,
+        .out_len =3D s->locty_data->r_buffer.size
+    };
+
+    tpm_backend_deliver_request(s->be_driver, &s->cmd);
 }
=20
 /* raise an interrupt if allowed */
@@ -352,7 +360,7 @@ static void tpm_tis_receive_bh(void *opaque)
 {
     TPMState *s =3D opaque;
     TPMTISEmuState *tis =3D &s->s.tis;
-    uint8_t locty =3D s->locty_number;
+    uint8_t locty =3D s->cmd.locty;
=20
     tpm_tis_sts_set(&tis->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
@@ -371,11 +379,11 @@ static void tpm_tis_receive_bh(void *opaque)
 /*
  * Callback from the TPM to indicate that the response was received.
  */
-static void tpm_tis_receive_cb(TPMState *s,
-                               bool is_selftest_done)
+static void tpm_tis_receive_cb(TPMState *s)
 {
     TPMTISEmuState *tis =3D &s->s.tis;
-    uint8_t locty =3D s->locty_number;
+    bool is_selftest_done =3D s->cmd.selftest_done;
+    uint8_t locty =3D s->cmd.locty;
     uint8_t l;
=20
     if (is_selftest_done) {
--=20
2.14.1.146.gd35faa819
