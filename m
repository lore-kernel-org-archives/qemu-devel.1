Received: from eggs.gnu.org ([2001:4830:134:3::10]:56446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8c-0000fI-E7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1dvN8a-0005vS-L0
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:27337)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1dvN8a-0005pe-87
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:32:56 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 22 Sep 2017 15:33:41 +0300
Message-Id: <1506083624-20621-6-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
References: <1506083624-20621-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v7 5/8] tmp backend: Add new api to read
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
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Amarnath Valluri <amarnath.valluri@intel.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

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
 backends/tpm.c               | 22 +++++++++++++--
 hmp.c                        |  7 ++---
 hw/tpm/tpm_passthrough.c     | 64 +++++++++++++++++++++++++++++++-------------
 include/sysemu/tpm_backend.h | 25 +++++++++++++++--
 tpm.c                        | 32 +---------------------
 5 files changed, 93 insertions(+), 57 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index c409a46..6ade9e4 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -138,6 +138,26 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
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
@@ -192,8 +212,6 @@ static void tpm_backend_instance_finalize(Object *obj)
     TPMBackend *s = TPM_BACKEND(obj);
 
     g_free(s->id);
-    g_free(s->path);
-    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
 
diff --git a/hmp.c b/hmp.c
index 0fb2bc7..cf62b2e 100644
--- a/hmp.c
+++ b/hmp.c
@@ -31,6 +31,7 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
+#include "qapi/util.h"
 #include "qapi-visit.h"
 #include "qom/object_interfaces.h"
 #include "ui/console.h"
@@ -1012,10 +1013,10 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
                        c, TpmModel_str(ti->model));
 
         monitor_printf(mon, "  \\ %s: type=%s",
-                       ti->id, TpmTypeOptionsKind_str(ti->options->type));
+                       ti->id, TpmType_str(ti->options->type));
 
         switch (ti->options->type) {
-        case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
+        case TPM_TYPE_PASSTHROUGH:
             tpo = ti->options->u.passthrough.data;
             monitor_printf(mon, "%s%s%s%s",
                            tpo->has_path ? ",path=" : "",
@@ -1023,7 +1024,7 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
                            tpo->has_cancel_path ? ",cancel-path=" : "",
                            tpo->has_cancel_path ? tpo->cancel_path : "");
             break;
-        case TPM_TYPE_OPTIONS_KIND__MAX:
+        case TPM_TYPE__MAX:
             break;
         }
         monitor_printf(mon, "\n");
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index a0459a6..fb7dad8 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -49,7 +49,8 @@
 struct TPMPassthruState {
     TPMBackend parent;
 
-    char *tpm_dev;
+    TPMPassthroughOptions *options;
+    const char *tpm_dev;
     int tpm_fd;
     bool tpm_executing;
     bool tpm_op_canceled;
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
+    if (tpm_pt->options->cancel_path) {
+        fd = qemu_open(tpm_pt->options->cancel_path, O_WRONLY);
         if (fd < 0) {
             error_report("Could not open TPM cancel path : %s",
                          strerror(errno));
@@ -331,7 +331,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
                      dev) < sizeof(path)) {
             fd = qemu_open(path, O_WRONLY);
             if (fd >= 0) {
-                tb->cancel_path = g_strdup(path);
+                tpm_pt->options->cancel_path = g_strdup(path);
             } else {
                 error_report("tpm_passthrough: Could not open TPM cancel "
                              "path %s : %s", path, strerror(errno));
@@ -351,17 +351,18 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
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
@@ -382,10 +383,8 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
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
@@ -403,7 +402,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
         goto err_exit;
     }
 
-    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tb);
+    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tpm_pt);
     if (tpm_pt->cancel_fd < 0) {
         goto err_exit;
     }
@@ -416,6 +415,31 @@ err_exit:
     return NULL;
 }
 
+static TpmTypeOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
+{
+    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
+    TpmTypeOptions *options = NULL;
+    TPMPassthroughOptions *poptions = NULL;
+
+    poptions = g_new0(TPMPassthroughOptions, 1);
+
+    if (tpm_pt->options->has_path) {
+        poptions->has_path = true;
+        poptions->path = g_strdup(tpm_pt->options->path);
+    }
+
+    if (tpm_pt->options->has_cancel_path) {
+        poptions->has_cancel_path = true;
+        poptions->cancel_path = g_strdup(tpm_pt->options->cancel_path);
+    }
+
+    options = g_new0(TpmTypeOptions, 1);
+    options->type = TPM_TYPE_PASSTHROUGH;
+    options->u.passthrough.data = poptions;
+
+    return options;
+}
+
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] = {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -443,12 +467,14 @@ static const TPMDriverOps tpm_passthrough_driver = {
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
@@ -461,7 +487,7 @@ static void tpm_passthrough_inst_finalize(Object *obj)
 
     qemu_close(tpm_pt->tpm_fd);
     qemu_close(tpm_pt->cancel_fd);
-    g_free(tpm_pt->tpm_dev);
+    qapi_free_TPMPassthroughOptions(tpm_pt->options);
 }
 
 static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 13311cf..809eec2 100644
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
 
 
@@ -215,6 +216,26 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
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
