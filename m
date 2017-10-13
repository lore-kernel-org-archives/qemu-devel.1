Received: from eggs.gnu.org ([2001:4830:134:3::10]:50571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yP9-0007Lp-R4
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2yP5-0002rd-Qy
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44778
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2yP5-0002r0-Fd
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 07:45:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9DBhtpX088153
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:20 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2djth60kh9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:45:20 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 13 Oct 2017 07:45:19 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 13 Oct 2017 07:44:55 -0400
In-Reply-To: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507895100-26457-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1507895100-26457-7-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v3 06/11] tpm-backend: Add new API to read
 backend TpmInfo
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

TPM configuration options are backend implementation details and shall no=
t be
part of base TPMBackend object, and these shall not be accessed directly =
outside
of the class, hence added a new interface method, get_tpm_options() to
TPMDriverOps., which shall be implemented by the derived classes to retur=
n
configured tpm options.

A new tpm backend api - tpm_backend_query_tpm() which uses _get_tpm_optio=
ns() to
prepare TpmInfo.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 15 +++++++++++--
 hw/tpm/tpm_passthrough.c     | 51 +++++++++++++++++++++++++++-----------=
------
 include/sysemu/tpm_backend.h | 15 +++++++++++--
 tpm.c                        | 32 +--------------------------
 4 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 8911597..de313c9 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -142,6 +142,19 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s=
)
     return k->ops->get_tpm_version(s);
 }
=20
+TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
+{
+    TPMInfo *info =3D g_new0(TPMInfo, 1);
+    TPMBackendClass *k =3D TPM_BACKEND_GET_CLASS(s);
+
+    info->id =3D g_strdup(s->id);
+    info->model =3D s->fe_model;
+    info->options =3D k->ops->get_tpm_options ?
+                    k->ops->get_tpm_options(s) : NULL;
+
+    return info;
+}
+
 static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
 {
     TPMBackend *s =3D TPM_BACKEND(obj);
@@ -196,8 +209,6 @@ static void tpm_backend_instance_finalize(Object *obj=
)
     TPMBackend *s =3D TPM_BACKEND(obj);
=20
     g_free(s->id);
-    g_free(s->path);
-    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
=20
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 4c21e52..84fc49a 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -30,6 +30,7 @@
 #include "tpm_int.h"
 #include "hw/hw.h"
 #include "hw/i386/pc.h"
+#include "qapi/clone-visitor.h"
 #include "tpm_tis.h"
 #include "tpm_util.h"
=20
@@ -49,7 +50,8 @@
 struct TPMPassthruState {
     TPMBackend parent;
=20
-    char *tpm_dev;
+    TPMPassthroughOptions *options;
+    const char *tpm_dev;
     int tpm_fd;
     bool tpm_executing;
     bool tpm_op_canceled;
@@ -296,15 +298,14 @@ static TPMVersion tpm_passthrough_get_tpm_version(T=
PMBackend *tb)
  * in Documentation/ABI/stable/sysfs-class-tpm.
  * From /dev/tpm0 create /sys/class/misc/tpm0/device/cancel
  */
-static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
+static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
 {
-    TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(tb);
     int fd =3D -1;
     char *dev;
     char path[PATH_MAX];
=20
-    if (tb->cancel_path) {
-        fd =3D qemu_open(tb->cancel_path, O_WRONLY);
+    if (tpm_pt->options->cancel_path) {
+        fd =3D qemu_open(tpm_pt->options->cancel_path, O_WRONLY);
         if (fd < 0) {
             error_report("Could not open TPM cancel path : %s",
                          strerror(errno));
@@ -319,7 +320,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMBacke=
nd *tb)
                      dev) < sizeof(path)) {
             fd =3D qemu_open(path, O_WRONLY);
             if (fd >=3D 0) {
-                tb->cancel_path =3D g_strdup(path);
+                tpm_pt->options->cancel_path =3D g_strdup(path);
             } else {
                 error_report("tpm_passthrough: Could not open TPM cancel=
 "
                              "path %s : %s", path, strerror(errno));
@@ -339,17 +340,18 @@ static int tpm_passthrough_handle_device_opts(QemuO=
pts *opts, TPMBackend *tb)
     const char *value;
=20
     value =3D qemu_opt_get(opts, "cancel-path");
-    tb->cancel_path =3D g_strdup(value);
+    if (value) {
+        tpm_pt->options->cancel_path =3D g_strdup(value);
+        tpm_pt->options->has_cancel_path =3D true;
+    }
=20
     value =3D qemu_opt_get(opts, "path");
-    if (!value) {
-        value =3D TPM_PASSTHROUGH_DEFAULT_DEVICE;
+    if (value) {
+        tpm_pt->options->has_path =3D true;
+        tpm_pt->options->path =3D g_strdup(value);
     }
=20
-    tpm_pt->tpm_dev =3D g_strdup(value);
-
-    tb->path =3D g_strdup(tpm_pt->tpm_dev);
-
+    tpm_pt->tpm_dev =3D value ? value : TPM_PASSTHROUGH_DEFAULT_DEVICE;
     tpm_pt->tpm_fd =3D qemu_open(tpm_pt->tpm_dev, O_RDWR);
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
@@ -370,10 +372,8 @@ static int tpm_passthrough_handle_device_opts(QemuOp=
ts *opts, TPMBackend *tb)
     tpm_pt->tpm_fd =3D -1;
=20
  err_free_parameters:
-    g_free(tb->path);
-    tb->path =3D NULL;
-
-    g_free(tpm_pt->tpm_dev);
+    qapi_free_TPMPassthroughOptions(tpm_pt->options);
+    tpm_pt->options =3D NULL;
     tpm_pt->tpm_dev =3D NULL;
=20
     return 1;
@@ -391,7 +391,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *o=
pts, const char *id)
         goto err_exit;
     }
=20
-    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tb);
+    tpm_pt->cancel_fd =3D tpm_passthrough_open_sysfs_cancel(tpm_pt);
     if (tpm_pt->cancel_fd < 0) {
         goto err_exit;
     }
@@ -404,6 +404,17 @@ err_exit:
     return NULL;
 }
=20
+static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
+{
+    TpmTypeOptions *options =3D g_new0(TpmTypeOptions, 1);
+
+    options->type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
+    options->u.passthrough.data =3D QAPI_CLONE(TPMPassthroughOptions,
+                                             TPM_PASSTHROUGH(tb)->option=
s);
+
+    return options;
+}
+
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] =3D {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -430,12 +441,14 @@ static const TPMDriverOps tpm_passthrough_driver =3D=
 {
     .get_tpm_established_flag =3D tpm_passthrough_get_tpm_established_fl=
ag,
     .reset_tpm_established_flag =3D tpm_passthrough_reset_tpm_establishe=
d_flag,
     .get_tpm_version          =3D tpm_passthrough_get_tpm_version,
+    .get_tpm_options          =3D tpm_passthrough_get_tpm_options,
 };
=20
 static void tpm_passthrough_inst_init(Object *obj)
 {
     TPMPassthruState *tpm_pt =3D TPM_PASSTHROUGH(obj);
=20
+    tpm_pt->options =3D g_new0(TPMPassthroughOptions, 1);
     tpm_pt->tpm_fd =3D -1;
     tpm_pt->cancel_fd =3D -1;
 }
@@ -448,7 +461,7 @@ static void tpm_passthrough_inst_finalize(Object *obj=
)
=20
     qemu_close(tpm_pt->tpm_fd);
     qemu_close(tpm_pt->cancel_fd);
-    g_free(tpm_pt->tpm_dev);
+    qapi_free_TPMPassthroughOptions(tpm_pt->options);
 }
=20
 static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 9ea7072..e96c191 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -49,10 +49,9 @@ struct TPMBackend {
     TPMRecvDataCB *recv_data_callback;
     bool had_startup_error;
=20
+    /* <public> */
     char *id;
     enum TpmModel fe_model;
-    char *path;
-    char *cancel_path;
=20
     QLIST_ENTRY(TPMBackend) list;
 };
@@ -96,6 +95,8 @@ struct TPMDriverOps {
     int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
=20
     TPMVersion (*get_tpm_version)(TPMBackend *t);
+
+    TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
 };
=20
=20
@@ -214,6 +215,16 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
  */
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
=20
+/**
+ * tpm_backend_query_tpm:
+ * @s: the backend
+ *
+ * Query backend tpm info
+ *
+ * Returns newly allocated TPMInfo
+ */
+TPMInfo *tpm_backend_query_tpm(TPMBackend *s);
+
 TPMBackend *qemu_find_tpm(const char *id);
=20
 const TPMDriverOps *tpm_get_backend_driver(const char *type);
diff --git a/tpm.c b/tpm.c
index db14849..3b8c7ed 100644
--- a/tpm.c
+++ b/tpm.c
@@ -202,36 +202,6 @@ static const TPMDriverOps *tpm_driver_find_by_type(e=
num TpmType type)
     return be_drivers[type];
 }
=20
-static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
-{
-    TPMInfo *res =3D g_new0(TPMInfo, 1);
-    TPMPassthroughOptions *tpo;
-
-    res->id =3D g_strdup(drv->id);
-    res->model =3D drv->fe_model;
-    res->options =3D g_new0(TpmTypeOptions, 1);
-
-    switch (tpm_backend_get_type(drv)) {
-    case TPM_TYPE_PASSTHROUGH:
-        res->options->type =3D TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
-        tpo =3D g_new0(TPMPassthroughOptions, 1);
-        res->options->u.passthrough.data =3D tpo;
-        if (drv->path) {
-            tpo->path =3D g_strdup(drv->path);
-            tpo->has_path =3D true;
-        }
-        if (drv->cancel_path) {
-            tpo->cancel_path =3D g_strdup(drv->cancel_path);
-            tpo->has_cancel_path =3D true;
-        }
-        break;
-    case TPM_TYPE__MAX:
-        break;
-    }
-
-    return res;
-}
-
 /*
  * Walk the list of active TPM backends and collect information about th=
em
  * following the schema description in qapi-schema.json.
@@ -246,7 +216,7 @@ TPMInfoList *qmp_query_tpm(Error **errp)
             continue;
         }
         info =3D g_new0(TPMInfoList, 1);
-        info->value =3D qmp_query_tpm_inst(drv);
+        info->value =3D tpm_backend_query_tpm(drv);
=20
         if (!cur_item) {
             head =3D cur_item =3D info;
--=20
2.5.5
