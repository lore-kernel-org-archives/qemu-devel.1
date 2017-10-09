Received: from eggs.gnu.org ([2001:4830:134:3::10]:54662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyx-0005jj-Rj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyw-0004zp-RB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyw-0004zJ-Im
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:57:06 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:52 +0200
Message-Id: <20171009225623.29232-12-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 11/42] tpm: remove unused TPMBackendCmd
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

There is only handling of request so far in both backends.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h |  9 +--------
 backends/tpm.c               |  7 ++-----
 hw/tpm/tpm_emulator.c        | 42 ++++++++++++++++----------------------=
----
 hw/tpm/tpm_passthrough.c     | 29 ++++++++++-------------------
 4 files changed, 29 insertions(+), 58 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index b08f985500..7d7ebfc21d 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -32,13 +32,6 @@ typedef struct TPMBackend TPMBackend;
=20
 typedef void (TPMRecvDataCB)(TPMState *, uint8_t locty, bool selftest_do=
ne);
=20
-typedef enum TPMBackendCmd {
-    TPM_BACKEND_CMD_INIT =3D 1,
-    TPM_BACKEND_CMD_PROCESS_CMD,
-    TPM_BACKEND_CMD_END,
-    TPM_BACKEND_CMD_TPM_RESET,
-} TPMBackendCmd;
-
 struct TPMBackend {
     Object parent;
=20
@@ -83,7 +76,7 @@ struct TPMBackendClass {
=20
     void (*opened)(TPMBackend *s, Error **errp);
=20
-    void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
+    void (*handle_request)(TPMBackend *s);
 };
=20
 /**
diff --git a/backends/tpm.c b/backends/tpm.c
index dc750d48c9..34e82085ec 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -25,13 +25,12 @@ static void tpm_backend_worker_thread(gpointer data, =
gpointer user_data)
     TPMBackendClass *k  =3D TPM_BACKEND_GET_CLASS(s);
=20
     assert(k->handle_request !=3D NULL);
-    k->handle_request(s, (TPMBackendCmd)data);
+    k->handle_request(s);
 }
=20
 static void tpm_backend_thread_end(TPMBackend *s)
 {
     if (s->thread_pool) {
-        g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_END=
, NULL);
         g_thread_pool_free(s->thread_pool, FALSE, TRUE);
         s->thread_pool =3D NULL;
     }
@@ -64,7 +63,6 @@ int tpm_backend_startup_tpm(TPMBackend *s)
=20
     s->thread_pool =3D g_thread_pool_new(tpm_backend_worker_thread, s, 1=
, TRUE,
                                        NULL);
-    g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_INIT, N=
ULL);
=20
     res =3D k->startup_tpm ? k->startup_tpm(s) : 0;
=20
@@ -80,8 +78,7 @@ bool tpm_backend_had_startup_error(TPMBackend *s)
=20
 void tpm_backend_deliver_request(TPMBackend *s)
 {
-    g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_PROCESS=
_CMD,
-                       NULL);
+    g_thread_pool_push(s->thread_pool, NULL, NULL);
 }
=20
 void tpm_backend_reset(TPMBackend *s)
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index bb5a65b492..dadc264182 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -172,39 +172,29 @@ static int tpm_emulator_set_locality(TPMEmulator *t=
pm_emu, uint8_t locty_number)
     return 0;
 }
=20
-static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd cm=
d)
+static void tpm_emulator_handle_request(TPMBackend *tb)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
     TPMLocality *locty =3D NULL;
     bool selftest_done =3D false;
     Error *err =3D NULL;
=20
-    DPRINTF("processing command type %d", cmd);
-
-    switch (cmd) {
-    case TPM_BACKEND_CMD_PROCESS_CMD:
-        locty =3D tb->tpm_state->locty_data;
-        if (tpm_emulator_set_locality(tpm_emu,
-                                      tb->tpm_state->locty_number) < 0 |=
|
-            tpm_emulator_unix_tx_bufs(tpm_emu, locty->w_buffer.buffer,
-                                      locty->w_offset, locty->r_buffer.b=
uffer,
-                                      locty->r_buffer.size, &selftest_do=
ne,
-                                      &err) < 0) {
-            tpm_util_write_fatal_error_response(locty->r_buffer.buffer,
-                                                locty->r_buffer.size);
-            error_report_err(err);
-        }
-
-        tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_numbe=
r,
-                               selftest_done);
-
-        break;
-    case TPM_BACKEND_CMD_INIT:
-    case TPM_BACKEND_CMD_END:
-    case TPM_BACKEND_CMD_TPM_RESET:
-        /* nothing to do */
-        break;
+    DPRINTF("processing TPM command");
+
+    locty =3D tb->tpm_state->locty_data;
+    if (tpm_emulator_set_locality(tpm_emu,
+                                  tb->tpm_state->locty_number) < 0 ||
+        tpm_emulator_unix_tx_bufs(tpm_emu, locty->w_buffer.buffer,
+                                  locty->w_offset, locty->r_buffer.buffe=
r,
+                                  locty->r_buffer.size, &selftest_done,
+                                  &err) < 0) {
+        tpm_util_write_fatal_error_response(locty->r_buffer.buffer,
+                                            locty->r_buffer.size);
+        error_report_err(err);
     }
+
+    tb->recv_data_callback(tb->tpm_state, tb->tpm_state->locty_number,
+                           selftest_done);
 }
=20
 static int tpm_emulator_probe_caps(TPMEmulator *tpm_emu)
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index d9da99bc8e..5cd988e8a4 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -149,29 +149,20 @@ static int tpm_passthrough_unix_transfer(TPMPassthr=
uState *tpm_pt,
                                         selftest_done);
 }
=20
-static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd=
 cmd)
+static void tpm_passthrough_handle_request(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
     bool selftest_done =3D false;
=20
-    DPRINTF("tpm_passthrough: processing command type %d\n", cmd);
-
-    switch (cmd) {
-    case TPM_BACKEND_CMD_PROCESS_CMD:
-        tpm_passthrough_unix_transfer(tpm_pt,
-                                      tb->tpm_state->locty_data,
-                                      &selftest_done);
-
-        tb->recv_data_callback(tb->tpm_state,
-                               tb->tpm_state->locty_number,
-                               selftest_done);
-        break;
-    case TPM_BACKEND_CMD_INIT:
-    case TPM_BACKEND_CMD_END:
-    case TPM_BACKEND_CMD_TPM_RESET:
-        /* nothing to do */
-        break;
-    }
+    DPRINTF("tpm_passthrough: processing command\n");
+
+    tpm_passthrough_unix_transfer(tpm_pt,
+                                  tb->tpm_state->locty_data,
+                                  &selftest_done);
+
+    tb->recv_data_callback(tb->tpm_state,
+                           tb->tpm_state->locty_number,
+                           selftest_done);
 }
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
--=20
2.14.1.146.gd35faa819
