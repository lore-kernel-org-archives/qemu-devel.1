Received: from eggs.gnu.org ([2001:4830:134:3::10]:60972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09KO-0006dW-65
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e09KK-0001nG-1A
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e09KJ-0001mb-Od
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:48:47 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v95GlHlZ038454
	for <qemu-devel@nongnu.org>; Thu, 5 Oct 2017 12:48:45 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ddqq23be0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:48:45 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 5 Oct 2017 12:48:44 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  5 Oct 2017 12:48:26 -0400
In-Reply-To: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507222112-20315-5-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 04/10] tpm-backend: Made few interface
 methods optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Amarnath Valluri <amarnath.valluri@intel.com>

This allows backend implementations left optional interface methods.
For mandatory methods assertion checks added.

Took the opportunity to remove unused methods:
 - tpm_backend_get_desc()
 - TPMDriverOps->handle_startup_error

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger<stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 39 ++++++++++++++++++++++++--------------=
-
 hw/tpm/tpm_passthrough.c     | 36 +-----------------------------------
 include/sysemu/tpm_backend.h | 13 ++-----------
 tpm.c                        |  2 +-
 4 files changed, 28 insertions(+), 62 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index cf5abf1..8911597 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -44,13 +44,6 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
     return k->ops->type;
 }
=20
-const char *tpm_backend_get_desc(TPMBackend *s)
-{
-    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
-
-    return k->ops->desc();
-}
-
 int tpm_backend_init(TPMBackend *s, TPMState *state,
                      TPMRecvDataCB *datacb)
 {
@@ -58,12 +51,14 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
=20
     s->tpm_state =3D state;
     s->recv_data_callback =3D datacb;
+    s->had_startup_error =3D false;
=20
-    return k->ops->init(s);
+    return k->ops->init ? k->ops->init(s) : 0;
 }
=20
 int tpm_backend_startup_tpm(TPMBackend *s)
 {
+    int res =3D 0;
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
     /* terminate a running TPM */
@@ -73,20 +68,24 @@ int tpm_backend_startup_tpm(TPMBackend *s)
                                        NULL);
     g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_INIT, N=
ULL);
=20
-    return k->ops->startup_tpm(s);
+    res =3D k->ops->startup_tpm ? k->ops->startup_tpm(s) : 0;
+
+    s->had_startup_error =3D (res !=3D 0);
+
+    return res;
 }
=20
 bool tpm_backend_had_startup_error(TPMBackend *s)
 {
-    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
-
-    return k->ops->had_startup_error(s);
+    return s->had_startup_error;
 }
=20
 size_t tpm_backend_realloc_buffer(TPMBackend *s, TPMSizedBuffer *sb)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
+    assert(k->ops->realloc_buffer);
+
     return k->ops->realloc_buffer(sb);
 }
=20
@@ -100,15 +99,21 @@ void tpm_backend_reset(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    k->ops->reset(s);
+    if (k->ops->reset) {
+        k->ops->reset(s);
+    }
=20
     tpm_backend_thread_end(s);
+
+    s->had_startup_error =3D false;
 }
=20
 void tpm_backend_cancel_cmd(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
+    assert(k->ops->cancel_cmd);
+
     k->ops->cancel_cmd(s);
 }
=20
@@ -116,20 +121,24 @@ bool tpm_backend_get_tpm_established_flag(TPMBacken=
d *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    return k->ops->get_tpm_established_flag(s);
+    return k->ops->get_tpm_established_flag ?
+           k->ops->get_tpm_established_flag(s) : false;
 }
=20
 int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t locty)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    return k->ops->reset_tpm_established_flag(s, locty);
+    return k->ops->reset_tpm_established_flag ?
+           k->ops->reset_tpm_established_flag(s, locty) : 0;
 }
=20
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
+    assert(k->ops->get_tpm_version);
+
     return k->ops->get_tpm_version(s);
 }
=20
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 815a72e..4c21e52 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -54,7 +54,6 @@ struct TPMPassthruState {
     bool tpm_executing;
     bool tpm_op_canceled;
     int cancel_fd;
-    bool had_startup_error;
=20
     TPMVersion tpm_version;
 };
@@ -227,29 +226,11 @@ static void tpm_passthrough_handle_request(TPMBacke=
nd *tb, TPMBackendCmd cmd)
     }
 }
=20
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
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
-
     DPRINTF("tpm_passthrough: CALL TO TPM_RESET!\n");
=20
     tpm_passthrough_cancel_cmd(tb);
-
-    tpm_pt->had_startup_error =3D false;
-}
-
-static int tpm_passthrough_init(TPMBackend *tb)
-{
-    return 0;
 }
=20
 static bool tpm_passthrough_get_tpm_established_flag(TPMBackend *tb)
@@ -264,13 +245,6 @@ static int tpm_passthrough_reset_tpm_established_fla=
g(TPMBackend *tb,
     return 0;
 }
=20
-static bool tpm_passthrough_get_startup_error(TPMBackend *tb)
-{
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
-
-    return tpm_pt->had_startup_error;
-}
-
 static size_t tpm_passthrough_realloc_buffer(TPMSizedBuffer *sb)
 {
     size_t wanted_size =3D 4096; /* Linux tpm.c buffer size */
@@ -309,11 +283,6 @@ static void tpm_passthrough_cancel_cmd(TPMBackend *t=
b)
     }
 }
=20
-static const char *tpm_passthrough_create_desc(void)
-{
-    return "Passthrough TPM backend driver";
-}
-
 static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
@@ -453,13 +422,10 @@ static const QemuOptDesc tpm_passthrough_cmdline_op=
ts[] =3D {
 static const TPMDriverOps tpm_passthrough_driver =3D {
     .type                     =3D TPM_TYPE_PASSTHROUGH,
     .opts                     =3D tpm_passthrough_cmdline_opts,
-    .desc                     =3D tpm_passthrough_create_desc,
+    .desc                     =3D "Passthrough TPM backend driver",
     .create                   =3D tpm_passthrough_create,
-    .init                     =3D tpm_passthrough_init,
-    .startup_tpm              =3D tpm_passthrough_startup_tpm,
     .realloc_buffer           =3D tpm_passthrough_realloc_buffer,
     .reset                    =3D tpm_passthrough_reset,
-    .had_startup_error        =3D tpm_passthrough_get_startup_error,
     .cancel_cmd               =3D tpm_passthrough_cancel_cmd,
     .get_tpm_established_flag =3D tpm_passthrough_get_tpm_established_fl=
ag,
     .reset_tpm_established_flag =3D tpm_passthrough_reset_tpm_establishe=
d_flag,
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 202ec8d..9ea7072 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -47,6 +47,7 @@ struct TPMBackend {
     TPMState *tpm_state;
     GThreadPool *thread_pool;
     TPMRecvDataCB *recv_data_callback;
+    bool had_startup_error;
=20
     char *id;
     enum TpmModel fe_model;
@@ -75,7 +76,7 @@ struct TPMDriverOps {
     enum TpmType type;
     const QemuOptDesc *opts;
     /* get a descriptive text of the backend to display to the user */
-    const char *(*desc)(void);
+    const char *desc;
=20
     TPMBackend *(*create)(QemuOpts *opts, const char *id);
=20
@@ -83,8 +84,6 @@ struct TPMDriverOps {
     int (*init)(TPMBackend *t);
     /* start up the TPM on the backend */
     int (*startup_tpm)(TPMBackend *t);
-    /* returns true if nothing will ever answer TPM requests */
-    bool (*had_startup_error)(TPMBackend *t);
=20
     size_t (*realloc_buffer)(TPMSizedBuffer *sb);
=20
@@ -109,14 +108,6 @@ struct TPMDriverOps {
 enum TpmType tpm_backend_get_type(TPMBackend *s);
=20
 /**
- * tpm_backend_get_desc:
- * @s: the backend
- *
- * Returns a human readable description of the backend.
- */
-const char *tpm_backend_get_desc(TPMBackend *s);
-
-/**
  * tpm_backend_init:
  * @s: the backend to initialized
  * @state: TPMState
diff --git a/tpm.c b/tpm.c
index b19b1a3..db14849 100644
--- a/tpm.c
+++ b/tpm.c
@@ -62,7 +62,7 @@ static void tpm_display_backend_drivers(void)
             continue;
         }
         fprintf(stderr, "%12s   %s\n",
-                TpmType_str(i), be_drivers[i]->desc());
+                TpmType_str(i), be_drivers[i]->desc);
     }
     fprintf(stderr, "\n");
 }
--=20
2.5.5
