Received: from eggs.gnu.org ([2001:4830:134:3::10]:45751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTU-0005p9-FJ
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTQ-0008C8-GX
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTQ-0008BU-6r
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:08 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHfvKv057146
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:03 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2evxpte586-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:03 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:02 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:20 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 03/32] tpm-backend: store TPMIf interface,
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
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Store the TPM interface, the actual object may be different from
TPMState. Keep a reference on the interface, and check the backend
wasn't already initialized.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 11 +++++++++--
 hw/tpm/tpm_emulator.c        |  4 ++--
 hw/tpm/tpm_passthrough.c     |  4 ++--
 hw/tpm/tpm_tis.c             |  2 +-
 include/sysemu/tpm.h         |  2 +-
 include/sysemu/tpm_backend.h |  6 +++---
 6 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 1e416d7..86f0e7e 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -43,9 +43,15 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
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
@@ -193,6 +199,7 @@ static void tpm_backend_instance_finalize(Object *obj=
)
 {
     TPMBackend *s =3D TPM_BACKEND(obj);
=20
+    object_unref(OBJECT(s->tpmif));
     g_free(s->id);
     tpm_backend_thread_end(s);
 }
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index e1a6810..5f88975 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -186,7 +186,7 @@ static int tpm_emulator_set_locality(TPMEmulator *tpm=
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
@@ -201,7 +201,7 @@ static void tpm_emulator_handle_request(TPMBackend *t=
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
index c440aff..2ad74ba 100644
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
index 880ca1a..9a2360e 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -1082,7 +1082,7 @@ static void tpm_tis_realizefn(DeviceState *dev, Err=
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
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 452cdb9..fb1719e 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -12,8 +12,8 @@
 #ifndef QEMU_TPM_H
 #define QEMU_TPM_H
=20
-#include "qemu/option.h"
 #include "qom/object.h"
+#include "qapi-types.h"
=20
 typedef struct TPMState TPMState;
=20
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 03ea5a3..b5f21ed 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -43,8 +43,8 @@ struct TPMBackend {
     Object parent;
=20
     /*< protected >*/
+    TPMIf *tpmif;
     bool opened;
-    TPMState *tpm_state;
     GThreadPool *thread_pool;
     bool had_startup_error;
=20
@@ -96,14 +96,14 @@ enum TpmType tpm_backend_get_type(TPMBackend *s);
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
--=20
2.5.5
