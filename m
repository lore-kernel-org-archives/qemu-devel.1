Received: from eggs.gnu.org ([2001:4830:134:3::10]:39150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJT-0006TG-Q5
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:40:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmJN-0004J2-M0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46040)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmJN-0004Il-Cv
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:39:53 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:02 +0100
Message-Id: <20171106183925.16747-6-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 05/28] tpm-be: call request_completed() out
 of thread
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

Lift from the backend implementation the responsability to call the
request_completed() callback outside of thread context. This also
simplify frontend/interface work, as they no longer need to care
whether the callback is called from a different thread.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm.h         |  1 -
 include/sysemu/tpm_backend.h |  1 +
 backends/tpm.c               | 15 ++++++++++++++-
 hw/tpm/tpm_emulator.c        |  2 --
 hw/tpm/tpm_passthrough.c     |  3 ---
 hw/tpm/tpm_tis.c             | 34 ++++++++++++----------------------
 6 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 7a1713a81e..e0879620e7 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -40,7 +40,6 @@ typedef struct TPMIf {
 typedef struct TPMIfClass {
     InterfaceClass parent_class;
=20
-    /* run in thread pool by backend */
     void (*request_completed)(TPMIf *obj);
 } TPMIfClass;
=20
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index b5f21ed8f1..c5d1a6818a 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -47,6 +47,7 @@ struct TPMBackend {
     bool opened;
     GThreadPool *thread_pool;
     bool had_startup_error;
+    QEMUBH *bh;
=20
     /* <public> */
     char *id;
diff --git a/backends/tpm.c b/backends/tpm.c
index 86f0e7e915..58f823d54c 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -18,14 +18,25 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/tpm.h"
 #include "qemu/thread.h"
+#include "qemu/main-loop.h"
+
+static void tpm_backend_request_completed_bh(void *opaque)
+{
+    TPMBackend *s =3D TPM_BACKEND(opaque);
+    TPMIfClass *tic =3D TPM_IF_GET_CLASS(s->tpmif);
+
+    tic->request_completed(s->tpmif);
+}
=20
 static void tpm_backend_worker_thread(gpointer data, gpointer user_data)
 {
     TPMBackend *s =3D TPM_BACKEND(user_data);
-    TPMBackendClass *k  =3D TPM_BACKEND_GET_CLASS(s);
+    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
     assert(k->handle_request !=3D NULL);
     k->handle_request(s, (TPMBackendCmd *)data);
+
+    qemu_bh_schedule(s->bh);
 }
=20
 static void tpm_backend_thread_end(TPMBackend *s)
@@ -193,6 +204,7 @@ static void tpm_backend_instance_init(Object *obj)
                              tpm_backend_prop_set_opened,
                              NULL);
     s->fe_model =3D -1;
+    s->bh =3D qemu_bh_new(tpm_backend_request_completed_bh, s);
 }
=20
 static void tpm_backend_instance_finalize(Object *obj)
@@ -202,6 +214,7 @@ static void tpm_backend_instance_finalize(Object *obj=
)
     object_unref(OBJECT(s->tpmif));
     g_free(s->id);
     tpm_backend_thread_end(s);
+    qemu_bh_delete(s->bh);
 }
=20
 static const TypeInfo tpm_backend_info =3D {
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 6bf025c7e2..883e8c0c2d 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -176,7 +176,6 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm=
_emu, uint8_t locty_number,
 static void tpm_emulator_handle_request(TPMBackend *tb, TPMBackendCmd *c=
md)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(tb);
-    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
     Error *err =3D NULL;
=20
     DPRINTF("processing TPM command");
@@ -191,7 +190,6 @@ static void tpm_emulator_handle_request(TPMBackend *t=
b, TPMBackendCmd *cmd)
         goto error;
     }
=20
-    tic->request_completed(tb->tpmif);
     return;
=20
 error:
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 2ad74badca..8c002e4da6 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -139,14 +139,11 @@ err_exit:
 static void tpm_passthrough_handle_request(TPMBackend *tb, TPMBackendCmd=
 *cmd)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
-    TPMIfClass *tic =3D TPM_IF_GET_CLASS(tb->tpmif);
=20
     DPRINTF("tpm_passthrough: processing command %p\n", cmd);
=20
     tpm_passthrough_unix_tx_bufs(tpm_pt, cmd->in, cmd->in_len,
                                  cmd->out, cmd->out_len, &cmd->selftest_=
done);
-
-    tic->request_completed(tb->tpmif);
 }
=20
 static void tpm_passthrough_reset(TPMBackend *tb)
diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 4a8a2ffc79..f81aaf10c3 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -76,7 +76,6 @@ typedef struct TPMState {
     ISADevice busdev;
     MemoryRegion mmio;
=20
-    QEMUBH *bh;
     uint32_t offset;
     uint8_t buf[TPM_TIS_BUFFER_MAX];
=20
@@ -410,10 +409,20 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t=
 locty, uint8_t newlocty)
     tpm_tis_abort(s, locty);
 }
=20
-static void tpm_tis_receive_bh(void *opaque)
+/*
+ * Callback from the TPM to indicate that the response was received.
+ */
+static void tpm_tis_request_completed(TPMIf *ti)
 {
-    TPMState *s =3D opaque;
+    TPMState *s =3D TPM(ti);
     uint8_t locty =3D s->cmd.locty;
+    uint8_t l;
+
+    if (s->cmd.selftest_done) {
+        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
+            s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
+        }
+    }
=20
     tpm_tis_sts_set(&s->loc[locty],
                     TPM_TIS_STS_VALID | TPM_TIS_STS_DATA_AVAILABLE);
@@ -431,23 +440,6 @@ static void tpm_tis_receive_bh(void *opaque)
                       TPM_TIS_INT_DATA_AVAILABLE | TPM_TIS_INT_STS_VALID=
);
 }
=20
-static void tpm_tis_request_completed(TPMIf *ti)
-{
-    TPMState *s =3D TPM(ti);
-
-    bool is_selftest_done =3D s->cmd.selftest_done;
-    uint8_t locty =3D s->cmd.locty;
-    uint8_t l;
-
-    if (is_selftest_done) {
-        for (l =3D 0; l < TPM_TIS_NUM_LOCALITIES; l++) {
-            s->loc[locty].sts |=3D TPM_TIS_STS_SELFTEST_DONE;
-        }
-    }
-
-    qemu_bh_schedule(s->bh);
-}
-
 /*
  * Read a byte of response data
  */
@@ -1090,8 +1082,6 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
or **errp)
         return;
     }
=20
-    s->bh =3D qemu_bh_new(tpm_tis_receive_bh, s);
-
     isa_init_irq(&s->busdev, &s->irq, s->irq_num);
=20
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
--=20
2.15.0.rc0.40.gaefcc5f6f
