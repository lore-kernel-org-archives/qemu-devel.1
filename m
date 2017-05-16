Received: from eggs.gnu.org ([2001:4830:134:3::10]:51102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dAXNK-0002pt-3L
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dAXNI-00052E-7X
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:58:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:39578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dAXNH-00051V-UD
	for qemu-devel@nongnu.org; Tue, 16 May 2017 03:58:32 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Tue, 16 May 2017 10:58:11 +0300
Message-Id: <1494921494-33717-6-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
References: <1494921494-33717-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v4 5/8] tmp backend: Add new api to read
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
Cc: Amarnath Valluri <amarnath.valluri@intel.com>

TPM configuration options are backend implementation details and shall not be
part of base TPMBackend object, and these shall not be accessed directly outside
of the class, hence added a new interface method, get_tpm_options() to
TPMDriverOps., which shall be implemented by the derived classes to return
configured tpm options.

A new tpm backend api - tpm_backend_query_tpm() which uses _get_tpm_options() to
prepare TpmInfo.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c               | 22 +++++++++++++--
 hmp.c                        |  6 ++---
 hw/tpm/tpm_passthrough.c     | 64 ++++++++++++++++++++++++++++++++++++--------
 include/sysemu/tpm_backend.h | 25 +++++++++++++++--
 tpm.c                        | 32 +---------------------
 5 files changed, 100 insertions(+), 49 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 05002e6..4ae6129 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -131,6 +131,26 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
     return k->ops->get_tpm_version(s);
 }
 
+TpmTypeOptions *tpm_backend_get_tpm_options(TPMBackend *s)
+{
+    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+
+    assert(k->ops->get_tpm_options);
+
+    return k->ops->get_tpm_options(s);
+}
+
+TPMInfo *tpm_backend_query_tpm(TPMBackend *s)
+{
+    TPMInfo *info = g_new0(TPMInfo, 1);
+
+    info->id = g_strdup(s->id);
+    info->model = s->fe_model;
+    info->options = tpm_backend_get_tpm_options(s);
+
+    return info;
+}
+
 static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
 {
     TPMBackend *s = TPM_BACKEND(obj);
@@ -185,8 +205,6 @@ static void tpm_backend_instance_finalize(Object *obj)
     TPMBackend *s = TPM_BACKEND(obj);
 
     g_free(s->id);
-    g_free(s->path);
-    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
 
diff --git a/hmp.c b/hmp.c
index 524e589..9338938 100644
--- a/hmp.c
+++ b/hmp.c
@@ -956,10 +956,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
                        c, TpmModel_lookup[ti->model]);
 
         monitor_printf(mon, "  \\ %s: type=%s",
-                       ti->id, TpmTypeOptionsKind_lookup[ti->options->type]);
+                       ti->id, TpmType_lookup[ti->options->type]);
 
         switch (ti->options->type) {
-        case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
+        case TPM_TYPE_PASSTHROUGH:
             tpo = ti->options->u.passthrough.data;
             monitor_printf(mon, "%s%s%s%s",
                            tpo->has_path ? ",path=" : "",
@@ -967,7 +967,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
                            tpo->has_cancel_path ? ",cancel-path=" : "",
                            tpo->has_cancel_path ? tpo->cancel_path : "");
             break;
-        case TPM_TYPE_OPTIONS_KIND__MAX:
+        default:
             break;
         }
         monitor_printf(mon, "\n");
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index a0459a6..c7706e4 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -49,6 +49,7 @@
 struct TPMPassthruState {
     TPMBackend parent;
 
+    TPMPassthroughOptions *ops;
     char *tpm_dev;
     int tpm_fd;
     bool tpm_executing;
@@ -308,15 +309,14 @@ static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
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
+    if (tpm_pt->ops->cancel_path) {
+        fd = qemu_open(tpm_pt->ops->cancel_path, O_WRONLY);
         if (fd < 0) {
             error_report("Could not open TPM cancel path : %s",
                          strerror(errno));
@@ -331,7 +331,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
                      dev) < sizeof(path)) {
             fd = qemu_open(path, O_WRONLY);
             if (fd >= 0) {
-                tb->cancel_path = g_strdup(path);
+                tpm_pt->ops->cancel_path = g_strdup(path);
             } else {
                 error_report("tpm_passthrough: Could not open TPM cancel "
                              "path %s : %s", path, strerror(errno));
@@ -351,17 +351,24 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
     const char *value;
 
     value = qemu_opt_get(opts, "cancel-path");
-    tb->cancel_path = g_strdup(value);
+    if (value) {
+        tpm_pt->ops->cancel_path = g_strdup(value);
+        tpm_pt->ops->has_cancel_path = true;
+    } else {
+        tpm_pt->ops->has_cancel_path = false;
+    }
 
     value = qemu_opt_get(opts, "path");
     if (!value) {
         value = TPM_PASSTHROUGH_DEFAULT_DEVICE;
+        tpm_pt->ops->has_path = false;
+    } else {
+        tpm_pt->ops->has_path = true;
     }
 
+    tpm_pt->ops->path = g_strdup(value);
     tpm_pt->tpm_dev = g_strdup(value);
 
-    tb->path = g_strdup(tpm_pt->tpm_dev);
-
     tpm_pt->tpm_fd = qemu_open(tpm_pt->tpm_dev, O_RDWR);
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
@@ -382,8 +389,8 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
     tpm_pt->tpm_fd = -1;
 
  err_free_parameters:
-    g_free(tb->path);
-    tb->path = NULL;
+    g_free(tpm_pt->ops->path);
+    tpm_pt->ops->path = NULL;
 
     g_free(tpm_pt->tpm_dev);
     tpm_pt->tpm_dev = NULL;
@@ -403,7 +410,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
         goto err_exit;
     }
 
-    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tb);
+    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tpm_pt);
     if (tpm_pt->cancel_fd < 0) {
         goto err_exit;
     }
@@ -416,6 +423,38 @@ err_exit:
     return NULL;
 }
 
+static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
+{
+    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
+    TpmTypeOptions *ops = NULL;
+    TPMPassthroughOptions *pops = NULL;
+
+    pops = g_new0(TPMPassthroughOptions, 1);
+    if (!pops) {
+        return NULL;
+    }
+
+    if (tpm_pt->ops->has_path) {
+        pops->has_path = true;
+        pops->path = g_strdup(tpm_pt->ops->path);
+    }
+
+    if (tpm_pt->ops->has_cancel_path) {
+        pops->has_cancel_path = true;
+        pops->cancel_path = g_strdup(tpm_pt->ops->cancel_path);
+    }
+
+    ops = g_new0(TpmTypeOptions, 1);
+    if (!ops) {
+        qapi_free_TPMPassthroughOptions(pops);
+        return NULL;
+    }
+    ops->type = TPM_TYPE_PASSTHROUGH;
+    ops->u.passthrough.data = pops;
+
+    return ops;
+}
+
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] = {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -443,12 +482,14 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .get_tpm_established_flag = tpm_passthrough_get_tpm_established_flag,
     .reset_tpm_established_flag = tpm_passthrough_reset_tpm_established_flag,
     .get_tpm_version          = tpm_passthrough_get_tpm_version,
+    .get_tpm_options          = tpm_passthrough_get_tpm_options,
 };
 
 static void tpm_passthrough_inst_init(Object *obj)
 {
     TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(obj);
 
+    tpm_pt->ops = g_new0(TPMPassthroughOptions, 1);
     tpm_pt->tpm_fd = -1;
     tpm_pt->cancel_fd = -1;
 }
@@ -462,6 +503,7 @@ static void tpm_passthrough_inst_finalize(Object *obj)
     qemu_close(tpm_pt->tpm_fd);
     qemu_close(tpm_pt->cancel_fd);
     g_free(tpm_pt->tpm_dev);
+    qapi_free_TPMPassthroughOptions(tpm_pt->ops);
 }
 
 static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index d6ae463..6e5bb8d 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -48,10 +48,9 @@ struct TPMBackend {
     GThreadPool *thread_pool;
     TPMRecvDataCB *recv_data_callback;
 
+    /* <public> */
     char *id;
     enum TpmModel fe_model;
-    char *path;
-    char *cancel_path;
 
     QLIST_ENTRY(TPMBackend) list;
 };
@@ -97,6 +96,8 @@ struct TPMDriverOps {
     int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
 
     TPMVersion (*get_tpm_version)(TPMBackend *t);
+
+    TpmTypeOptions *(*get_tpm_options)(TPMBackend *t);
 };
 
 /**
@@ -206,6 +207,26 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
  */
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
 
+/**
+ * tpm_backend_get_tpm_options:
+ * @s: the backend
+ *
+ * Get the backend configuration options
+ *
+ * Returns newly allocated TpmTypeOptions
+ */
+TpmTypeOptions *tpm_backend_get_tpm_options(TPMBackend *s);
+
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
index 2979508..84e9667 100644
--- a/tpm.c
+++ b/tpm.c
@@ -249,36 +249,6 @@ static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
     return NULL;
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
@@ -293,7 +263,7 @@ TPMInfoList *qmp_query_tpm(Error **errp)
             continue;
         }
         info = g_new0(TPMInfoList, 1);
-        info->value = qmp_query_tpm_inst(drv);
+        info->value = tpm_backend_query_tpm(drv);
 
         if (!cur_item) {
             head = cur_item = info;
-- 
2.7.4
