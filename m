Received: from eggs.gnu.org ([2001:4830:134:3::10]:54538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyn-0005a1-0z
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e1gyl-0004u9-Ch
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e1gyl-0004tx-3s
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 18:56:55 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Oct 2017 00:55:49 +0200
Message-Id: <20171009225623.29232-9-marcandre.lureau@redhat.com>
In-Reply-To: <20171009225623.29232-1-marcandre.lureau@redhat.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 08/42] tpm: remove TPMDriverOps
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

Use TPMBackendClass to hold class methods/fields.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/sysemu/tpm_backend.h | 15 +++++----------
 backends/tpm.c               | 31 ++++++++++++++++---------------
 hw/tpm/tpm_emulator.c        | 29 ++++++++++++-----------------
 hw/tpm/tpm_passthrough.c     | 25 +++++++++++--------------
 tpm.c                        | 20 +++++++++-----------
 scripts/checkpatch.pl        |  1 -
 6 files changed, 53 insertions(+), 68 deletions(-)

diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 63093551a1..a4288df038 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -29,7 +29,7 @@
=20
 typedef struct TPMBackendClass TPMBackendClass;
 typedef struct TPMBackend TPMBackend;
-typedef struct TPMDriverOps TPMDriverOps;
+
 typedef void (TPMRecvDataCB)(TPMState *, uint8_t locty, bool selftest_do=
ne);
=20
 typedef enum TPMBackendCmd {
@@ -59,14 +59,6 @@ struct TPMBackend {
 struct TPMBackendClass {
     ObjectClass parent_class;
=20
-    const TPMDriverOps *ops;
-
-    void (*opened)(TPMBackend *s, Error **errp);
-
-    void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
-};
-
-struct TPMDriverOps {
     enum TpmType type;
     const QemuOptDesc *opts;
     /* get a descriptive text of the backend to display to the user */
@@ -90,8 +82,11 @@ struct TPMDriverOps {
     TPMVersion (*get_tpm_version)(TPMBackend *t);
=20
     TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
-};
=20
+    void (*opened)(TPMBackend *s, Error **errp);
+
+    void (*handle_request)(TPMBackend *s, TPMBackendCmd cmd);
+};
=20
 /**
  * tpm_backend_get_type:
diff --git a/backends/tpm.c b/backends/tpm.c
index 37c84b7c66..ca3a78eea8 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -41,7 +41,7 @@ enum TpmType tpm_backend_get_type(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    return k->ops->type;
+    return k->type;
 }
=20
 int tpm_backend_init(TPMBackend *s, TPMState *state,
@@ -53,7 +53,7 @@ int tpm_backend_init(TPMBackend *s, TPMState *state,
     s->recv_data_callback =3D datacb;
     s->had_startup_error =3D false;
=20
-    return k->ops->init ? k->ops->init(s) : 0;
+    return k->init ? k->init(s) : 0;
 }
=20
 int tpm_backend_startup_tpm(TPMBackend *s)
@@ -68,7 +68,7 @@ int tpm_backend_startup_tpm(TPMBackend *s)
                                        NULL);
     g_thread_pool_push(s->thread_pool, (gpointer)TPM_BACKEND_CMD_INIT, N=
ULL);
=20
-    res =3D k->ops->startup_tpm ? k->ops->startup_tpm(s) : 0;
+    res =3D k->startup_tpm ? k->startup_tpm(s) : 0;
=20
     s->had_startup_error =3D (res !=3D 0);
=20
@@ -90,8 +90,8 @@ void tpm_backend_reset(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    if (k->ops->reset) {
-        k->ops->reset(s);
+    if (k->reset) {
+        k->reset(s);
     }
=20
     tpm_backend_thread_end(s);
@@ -103,34 +103,34 @@ void tpm_backend_cancel_cmd(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    assert(k->ops->cancel_cmd);
+    assert(k->cancel_cmd);
=20
-    k->ops->cancel_cmd(s);
+    k->cancel_cmd(s);
 }
=20
 bool tpm_backend_get_tpm_established_flag(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    return k->ops->get_tpm_established_flag ?
-           k->ops->get_tpm_established_flag(s) : false;
+    return k->get_tpm_established_flag ?
+           k->get_tpm_established_flag(s) : false;
 }
=20
 int tpm_backend_reset_tpm_established_flag(TPMBackend *s, uint8_t locty)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    return k->ops->reset_tpm_established_flag ?
-           k->ops->reset_tpm_established_flag(s, locty) : 0;
+    return k->reset_tpm_established_flag ?
+           k->reset_tpm_established_flag(s, locty) : 0;
 }
=20
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
 {
     TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
=20
-    assert(k->ops->get_tpm_version);
+    assert(k->get_tpm_version);
=20
-    return k->ops->get_tpm_version(s);
+    return k->get_tpm_version(s);
 }
=20
 TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
@@ -140,8 +140,9 @@ TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
=20
     info->id =3D g_strdup(s->id);
     info->model =3D s->fe_model;
-    info->options =3D k->ops->get_tpm_options ?
-                    k->ops->get_tpm_options(s) : NULL;
+    if (k->get_tpm_options) {
+        info->options =3D k->get_tpm_options(s);
+    }
=20
     return info;
 }
diff --git a/hw/tpm/tpm_emulator.c b/hw/tpm/tpm_emulator.c
index 9e24a5f30e..bb5a65b492 100644
--- a/hw/tpm/tpm_emulator.c
+++ b/hw/tpm/tpm_emulator.c
@@ -60,8 +60,6 @@
=20
 #define TPM_EMULATOR_IMPLEMENTS_ALL_CAPS(S, cap) (((S)->caps & (cap)) =3D=
=3D (cap))
=20
-static const TPMDriverOps tpm_emulator_driver;
-
 /* data structures */
 typedef struct TPMEmulator {
     TPMBackend parent;
@@ -504,20 +502,6 @@ static const QemuOptDesc tpm_emulator_cmdline_opts[]=
 =3D {
     { /* end of list */ },
 };
=20
-static const TPMDriverOps tpm_emulator_driver =3D {
-    .type                     =3D TPM_TYPE_EMULATOR,
-    .opts                     =3D tpm_emulator_cmdline_opts,
-    .desc                     =3D "TPM emulator backend driver",
-
-    .create                   =3D tpm_emulator_create,
-    .startup_tpm              =3D tpm_emulator_startup_tpm,
-    .cancel_cmd               =3D tpm_emulator_cancel_cmd,
-    .get_tpm_established_flag =3D tpm_emulator_get_tpm_established_flag,
-    .reset_tpm_established_flag =3D tpm_emulator_reset_tpm_established_f=
lag,
-    .get_tpm_version          =3D tpm_emulator_get_tpm_version,
-    .get_tpm_options          =3D tpm_emulator_get_tpm_options,
-};
-
 static void tpm_emulator_inst_init(Object *obj)
 {
     TPMEmulator *tpm_emu =3D TPM_EMULATOR(obj);
@@ -565,7 +549,18 @@ static void tpm_emulator_inst_finalize(Object *obj)
 static void tpm_emulator_class_init(ObjectClass *klass, void *data)
 {
     TPMBackendClass *tbc =3D TPM_BACKEND_CLASS(klass);
-    tbc->ops =3D &tpm_emulator_driver;
+
+    tbc->type =3D TPM_TYPE_EMULATOR;
+    tbc->opts =3D tpm_emulator_cmdline_opts;
+    tbc->desc =3D "TPM emulator backend driver";
+    tbc->create =3D tpm_emulator_create;
+    tbc->startup_tpm =3D tpm_emulator_startup_tpm;
+    tbc->cancel_cmd =3D tpm_emulator_cancel_cmd;
+    tbc->get_tpm_established_flag =3D tpm_emulator_get_tpm_established_f=
lag;
+    tbc->reset_tpm_established_flag =3D tpm_emulator_reset_tpm_establish=
ed_flag;
+    tbc->get_tpm_version =3D tpm_emulator_get_tpm_version;
+    tbc->get_tpm_options =3D tpm_emulator_get_tpm_options;
+
     tbc->handle_request =3D tpm_emulator_handle_request;
 }
=20
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index f04eab3e63..d9da99bc8e 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -365,19 +365,6 @@ static const QemuOptDesc tpm_passthrough_cmdline_opt=
s[] =3D {
     { /* end of list */ },
 };
=20
-static const TPMDriverOps tpm_passthrough_driver =3D {
-    .type                     =3D TPM_TYPE_PASSTHROUGH,
-    .opts                     =3D tpm_passthrough_cmdline_opts,
-    .desc                     =3D "Passthrough TPM backend driver",
-    .create                   =3D tpm_passthrough_create,
-    .reset                    =3D tpm_passthrough_reset,
-    .cancel_cmd               =3D tpm_passthrough_cancel_cmd,
-    .get_tpm_established_flag =3D tpm_passthrough_get_tpm_established_fl=
ag,
-    .reset_tpm_established_flag =3D tpm_passthrough_reset_tpm_establishe=
d_flag,
-    .get_tpm_version          =3D tpm_passthrough_get_tpm_version,
-    .get_tpm_options          =3D tpm_passthrough_get_tpm_options,
-};
-
 static void tpm_passthrough_inst_init(Object *obj)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
@@ -402,7 +389,17 @@ static void tpm_passthrough_class_init(ObjectClass *=
klass, void *data)
 {
     TPMBackendClass *tbc =3D TPM_BACKEND_CLASS(klass);
=20
-    tbc->ops =3D &tpm_passthrough_driver;
+    tbc->type =3D TPM_TYPE_PASSTHROUGH;
+    tbc->opts =3D tpm_passthrough_cmdline_opts;
+    tbc->desc =3D "Passthrough TPM backend driver";
+    tbc->create =3D tpm_passthrough_create;
+    tbc->reset =3D tpm_passthrough_reset;
+    tbc->cancel_cmd =3D tpm_passthrough_cancel_cmd;
+    tbc->get_tpm_established_flag =3D tpm_passthrough_get_tpm_establishe=
d_flag;
+    tbc->reset_tpm_established_flag =3D
+        tpm_passthrough_reset_tpm_established_flag;
+    tbc->get_tpm_version =3D tpm_passthrough_get_tpm_version;
+    tbc->get_tpm_options =3D tpm_passthrough_get_tpm_options;
     tbc->handle_request =3D tpm_passthrough_handle_request;
 }
=20
diff --git a/tpm.c b/tpm.c
index 75a589b837..4882501bd7 100644
--- a/tpm.c
+++ b/tpm.c
@@ -32,11 +32,10 @@ void tpm_register_model(enum TpmModel model)
=20
 #ifdef CONFIG_TPM
=20
-static const TPMDriverOps *
-tpm_driver_find_by_type(enum TpmType type)
+static const TPMBackendClass *
+tpm_be_find_by_type(enum TpmType type)
 {
     ObjectClass *oc;
-    TPMBackendClass *bc;
     char *typename =3D g_strdup_printf("tpm-%s", TpmType_str(type));
=20
     oc =3D object_class_by_name(typename);
@@ -46,8 +45,7 @@ tpm_driver_find_by_type(enum TpmType type)
         return NULL;
     }
=20
-    bc =3D TPM_BACKEND_CLASS(oc);
-    return bc->ops;
+    return TPM_BACKEND_CLASS(oc);
 }
=20
 /*
@@ -61,11 +59,11 @@ static void tpm_display_backend_drivers(void)
     fprintf(stderr, "Supported TPM types (choose only one):\n");
=20
     for (i =3D 0; i < TPM_TYPE__MAX; i++) {
-        const TPMDriverOps *ops =3D tpm_driver_find_by_type(i);
-        if (!ops) {
+        const TPMBackendClass *bc =3D tpm_be_find_by_type(i);
+        if (!bc) {
             continue;
         }
-        fprintf(stderr, "%12s   %s\n", TpmType_str(i), ops->desc);
+        fprintf(stderr, "%12s   %s\n", TpmType_str(i), bc->desc);
     }
     fprintf(stderr, "\n");
 }
@@ -92,7 +90,7 @@ static int configure_tpm(QemuOpts *opts)
 {
     const char *value;
     const char *id;
-    const TPMDriverOps *be;
+    const TPMBackendClass *be;
     TPMBackend *drv;
     Error *local_err =3D NULL;
     int i;
@@ -116,7 +114,7 @@ static int configure_tpm(QemuOpts *opts)
     }
=20
     i =3D qapi_enum_parse(&TpmType_lookup, value, -1, NULL);
-    be =3D i >=3D 0 ? tpm_driver_find_by_type(i) : NULL;
+    be =3D i >=3D 0 ? tpm_be_find_by_type(i) : NULL;
     if (be =3D=3D NULL) {
         error_report(QERR_INVALID_PARAMETER_VALUE,
                      "type", "a TPM backend type");
@@ -234,7 +232,7 @@ TpmTypeList *qmp_query_tpm_types(Error **errp)
     TpmTypeList *head =3D NULL, *prev =3D NULL, *cur_item;
=20
     for (i =3D 0; i < TPM_TYPE__MAX; i++) {
-        if (!tpm_driver_find_by_type(i)) {
+        if (!tpm_be_find_by_type(i)) {
             continue;
         }
         cur_item =3D g_new0(TpmTypeList, 1);
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0c41f1212f..c9529df67f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2602,7 +2602,6 @@ sub process {
 				SCSIBusInfo|
 				SCSIReqOps|
 				Spice[A-Z][a-zA-Z0-9]*Interface|
-				TPMDriverOps|
 				USBDesc[A-Z][a-zA-Z0-9]*|
 				VhostOps|
 				VMStateDescription|
--=20
2.14.1.146.gd35faa819
