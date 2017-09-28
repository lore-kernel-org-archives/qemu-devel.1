Received: from eggs.gnu.org ([2001:4830:134:3::10]:59219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxUyL-0000sW-P7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dxUyI-0000q4-Gg
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:19:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:13925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dxUyI-0000bz-5R
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 05:19:06 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Thu, 28 Sep 2017 12:20:06 +0300
Message-Id: <1506590409-28857-6-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1506590409-28857-1-git-send-email-amarnath.valluri@intel.com>
References: <1506590409-28857-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v9 5/8] tmp backend: Add new api to read
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>

TPM configuration options are backend implementation details and shall not be
part of base TPMBackend object, and these shall not be accessed directly outside
of the class, hence added a new interface method, get_tpm_options() to
TPMDriverOps., which shall be implemented by the derived classes to return
configured tpm options.

A new tpm backend api - tpm_backend_query_tpm() which uses _get_tpm_options() to
prepare TpmInfo.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 backends/tpm.c               | 15 +++++++++++--
 hw/tpm/tpm_passthrough.c     | 51 +++++++++++++++++++++++++++-----------------
 include/sysemu/tpm_backend.h | 15 +++++++++++--
 tpm.c                        | 32 +--------------------------
 4 files changed, 59 insertions(+), 54 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 8911597..de313c9 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -142,6 +142,19 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
     return k->ops->get_tpm_version(s);
 }
 
+TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
+{
+    TPMInfo *info = g_new0(TPMInfo, 1);
+    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+
+    info->id = g_strdup(s->id);
+    info->model = s->fe_model;
+    info->options = k->ops->get_tpm_options ?
+                    k->ops->get_tpm_options(s) : NULL;
+
+    return info;
+}
+
 static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
 {
     TPMBackend *s = TPM_BACKEND(obj);
@@ -196,8 +209,6 @@ static void tpm_backend_instance_finalize(Object *obj)
     TPMBackend *s = TPM_BACKEND(obj);
 
     g_free(s->id);
-    g_free(s->path);
-    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
 
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
 
@@ -49,7 +50,8 @@
 struct TPMPassthruState {
     TPMBackend parent;
 
-    char *tpm_dev;
+    TPMPassthroughOptions *options;
+    const char *tpm_dev;
     int tpm_fd;
     bool tpm_executing;
     bool tpm_op_canceled;
@@ -296,15 +298,14 @@ static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
  * in Documentation/ABI/stable/sysfs-class-tpm.
  * From /dev/tpm0 create /sys/class/misc/tpm0/device/cancel
  */
-static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
+static int tpm_passthrough_open_sysfs_cancel(TPMPassthruState *tpm_pt)
 {
-    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
     int fd = -1;
     char *dev;
     char path[PATH_MAX];
 
-    if (tb->cancel_path) {
-        fd = qemu_open(tb->cancel_path, O_WRONLY);
+    if (tpm_pt->options->cancel_path) {
+        fd = qemu_open(tpm_pt->options->cancel_path, O_WRONLY);
         if (fd < 0) {
             error_report("Could not open TPM cancel path : %s",
                          strerror(errno));
@@ -319,7 +320,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
                      dev) < sizeof(path)) {
             fd = qemu_open(path, O_WRONLY);
             if (fd >= 0) {
-                tb->cancel_path = g_strdup(path);
+                tpm_pt->options->cancel_path = g_strdup(path);
             } else {
                 error_report("tpm_passthrough: Could not open TPM cancel "
                              "path %s : %s", path, strerror(errno));
@@ -339,17 +340,18 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
     const char *value;
 
     value = qemu_opt_get(opts, "cancel-path");
-    tb->cancel_path = g_strdup(value);
+    if (value) {
+        tpm_pt->options->cancel_path = g_strdup(value);
+        tpm_pt->options->has_cancel_path = true;
+    }
 
     value = qemu_opt_get(opts, "path");
-    if (!value) {
-        value = TPM_PASSTHROUGH_DEFAULT_DEVICE;
+    if (value) {
+        tpm_pt->options->has_path = true;
+        tpm_pt->options->path = g_strdup(value);
     }
 
-    tpm_pt->tpm_dev = g_strdup(value);
-
-    tb->path = g_strdup(tpm_pt->tpm_dev);
-
+    tpm_pt->tpm_dev = value ? value : TPM_PASSTHROUGH_DEFAULT_DEVICE;
     tpm_pt->tpm_fd = qemu_open(tpm_pt->tpm_dev, O_RDWR);
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
@@ -370,10 +372,8 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
     tpm_pt->tpm_fd = -1;
 
  err_free_parameters:
-    g_free(tb->path);
-    tb->path = NULL;
-
-    g_free(tpm_pt->tpm_dev);
+    qapi_free_TPMPassthroughOptions(tpm_pt->options);
+    tpm_pt->options = NULL;
     tpm_pt->tpm_dev = NULL;
 
     return 1;
@@ -391,7 +391,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
         goto err_exit;
     }
 
-    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tb);
+    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tpm_pt);
     if (tpm_pt->cancel_fd < 0) {
         goto err_exit;
     }
@@ -404,6 +404,17 @@ err_exit:
     return NULL;
 }
 
+static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
+{
+    TpmTypeOptions *options = g_new0(TpmTypeOptions, 1);
+
+    options->type = TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
+    options->u.passthrough.data = QAPI_CLONE(TPMPassthroughOptions,
+                                             TPM_PASSTHROUGH(tb)->options);
+
+    return options;
+}
+
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] = {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -430,12 +441,14 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .get_tpm_established_flag = tpm_passthrough_get_tpm_established_flag,
     .reset_tpm_established_flag = tpm_passthrough_reset_tpm_established_flag,
     .get_tpm_version          = tpm_passthrough_get_tpm_version,
+    .get_tpm_options          = tpm_passthrough_get_tpm_options,
 };
 
 static void tpm_passthrough_inst_init(Object *obj)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(obj);
 
+    tpm_pt->options = g_new0(TPMPassthroughOptions, 1);
     tpm_pt->tpm_fd = -1;
     tpm_pt->cancel_fd = -1;
 }
@@ -448,7 +461,7 @@ static void tpm_passthrough_inst_finalize(Object *obj)
 
     qemu_close(tpm_pt->tpm_fd);
     qemu_close(tpm_pt->cancel_fd);
-    g_free(tpm_pt->tpm_dev);
+    qapi_free_TPMPassthroughOptions(tpm_pt->options);
 }
 
 static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 9ea7072..e96c191 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -49,10 +49,9 @@ struct TPMBackend {
     TPMRecvDataCB *recv_data_callback;
     bool had_startup_error;
 
+    /* <public> */
     char *id;
     enum TpmModel fe_model;
-    char *path;
-    char *cancel_path;
 
     QLIST_ENTRY(TPMBackend) list;
 };
@@ -96,6 +95,8 @@ struct TPMDriverOps {
     int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
 
     TPMVersion (*get_tpm_version)(TPMBackend *t);
+
+    TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
 };
 
 
@@ -214,6 +215,16 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
  */
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
 
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
 
 const TPMDriverOps *tpm_get_backend_driver(const char *type);
diff --git a/tpm.c b/tpm.c
index db14849..3b8c7ed 100644
--- a/tpm.c
+++ b/tpm.c
@@ -202,36 +202,6 @@ static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
     return be_drivers[type];
 }
 
-static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
-{
-    TPMInfo *res = g_new0(TPMInfo, 1);
-    TPMPassthroughOptions *tpo;
-
-    res->id = g_strdup(drv->id);
-    res->model = drv->fe_model;
-    res->options = g_new0(TpmTypeOptions, 1);
-
-    switch (tpm_backend_get_type(drv)) {
-    case TPM_TYPE_PASSTHROUGH:
-        res->options->type = TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
-        tpo = g_new0(TPMPassthroughOptions, 1);
-        res->options->u.passthrough.data = tpo;
-        if (drv->path) {
-            tpo->path = g_strdup(drv->path);
-            tpo->has_path = true;
-        }
-        if (drv->cancel_path) {
-            tpo->cancel_path = g_strdup(drv->cancel_path);
-            tpo->has_cancel_path = true;
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
  * Walk the list of active TPM backends and collect information about them
  * following the schema description in qapi-schema.json.
@@ -246,7 +216,7 @@ TPMInfoList *qmp_query_tpm(Error **errp)
             continue;
         }
         info = g_new0(TPMInfoList, 1);
-        info->value = qmp_query_tpm_inst(drv);
+        info->value = tpm_backend_query_tpm(drv);
 
         if (!cur_item) {
             head = cur_item = info;
-- 
2.7.4
