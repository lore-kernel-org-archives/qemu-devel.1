Received: from eggs.gnu.org ([2001:4830:134:3::10]:40942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwJu-0003lD-1l
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1ctwJp-0000Xd-BA
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:16468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1ctwJp-0000WJ-0Q
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 09:10:21 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Fri, 31 Mar 2017 16:10:14 +0300
Message-Id: <1490965817-16913-6-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH 5/7] tmp backend: Add new api to read backend
 tpm options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, Amarnath Valluri <amarnath.valluri@intel.com>

TPM configuration options are backend implementation details and shall not be
part of base TPMBackend object, and these shall not be accessed directly outside
of the class, hence added a new tpm backend api, tpm_backend_get_tpm_options()
to read the backend configured options.

Added new method, get_tpm_options() to TPMDriverOps., which shall be implemented
by the derived classes to return configured tpm options.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c               | 12 ++++++----
 hw/tpm/tpm_passthrough.c     | 55 +++++++++++++++++++++++++++++++++++---------
 include/sysemu/tpm_backend.h | 15 ++++++++++--
 qapi-schema.json             | 12 ++++++++--
 tpm.c                        | 13 ++---------
 5 files changed, 76 insertions(+), 31 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 0bdc5af..98aafd8 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -153,6 +153,13 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
     return k->ops->get_tpm_version(s);
 }
 
+TPMOptions *tpm_backend_get_tpm_options(TPMBackend *s)
+{
+    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+
+    return k->ops->get_tpm_options ? k->ops->get_tpm_options(s) : NULL;
+}
+
 static bool tpm_backend_prop_get_opened(Object *obj, Error **errp)
 {
     TPMBackend *s = TPM_BACKEND(obj);
@@ -205,9 +212,6 @@ static void tpm_backend_instance_init(Object *obj)
     s->tpm_state = NULL;
     s->thread_pool = NULL;
     s->recv_data_callback = NULL;
-    s->path = NULL;
-    s->cancel_path = NULL;
-
 }
 
 static void tpm_backend_instance_finalize(Object *obj)
@@ -215,8 +219,6 @@ static void tpm_backend_instance_finalize(Object *obj)
     TPMBackend *s = TPM_BACKEND(obj);
 
     g_free(s->id);
-    g_free(s->path);
-    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
 
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index 5b3bf1c..fce1163 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -50,6 +50,7 @@
 struct TPMPassthruState {
     TPMBackend parent;
 
+    TPMPassthroughOptions ops;
     char *tpm_dev;
     int tpm_fd;
     bool tpm_executing;
@@ -314,15 +315,14 @@ static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
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
+    if (tpm_pt->ops.cancel_path) {
+        fd = qemu_open(tpm_pt->ops.cancel_path, O_WRONLY);
         if (fd < 0) {
             error_report("Could not open TPM cancel path : %s",
                          strerror(errno));
@@ -337,7 +337,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
                      dev) < sizeof(path)) {
             fd = qemu_open(path, O_WRONLY);
             if (fd >= 0) {
-                tb->cancel_path = g_strdup(path);
+                tpm_pt->ops.cancel_path = g_strdup(path);
             } else {
                 error_report("tpm_passthrough: Could not open TPM cancel "
                              "path %s : %s", path, strerror(errno));
@@ -357,17 +357,24 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
     const char *value;
 
     value = qemu_opt_get(opts, "cancel-path");
-    tb->cancel_path = g_strdup(value);
+    if (value) {
+        tpm_pt->ops.cancel_path = g_strdup(value);
+        tpm_pt->ops.has_cancel_path = true;
+    } else {
+        tpm_pt->ops.has_cancel_path = false;
+    }
 
     value = qemu_opt_get(opts, "path");
     if (!value) {
         value = TPM_PASSTHROUGH_DEFAULT_DEVICE;
+        tpm_pt->ops.has_path = false;
+    } else {
+        tpm_pt->ops.has_path = true;
     }
 
+    tpm_pt->ops.path = g_strdup(value);
     tpm_pt->tpm_dev = g_strdup(value);
 
-    tb->path = g_strdup(tpm_pt->tpm_dev);
-
     tpm_pt->tpm_fd = qemu_open(tpm_pt->tpm_dev, O_RDWR);
     if (tpm_pt->tpm_fd < 0) {
         error_report("Cannot access TPM device using '%s': %s",
@@ -388,8 +395,8 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
     tpm_pt->tpm_fd = -1;
 
  err_free_parameters:
-    g_free(tb->path);
-    tb->path = NULL;
+    g_free(tpm_pt->ops.path);
+    tpm_pt->ops.path = NULL;
 
     g_free(tpm_pt->tpm_dev);
     tpm_pt->tpm_dev = NULL;
@@ -409,7 +416,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
         goto err_exit;
     }
 
-    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tb);
+    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tpm_pt);
     if (tpm_pt->cancel_fd < 0) {
         goto err_exit;
     }
@@ -430,9 +437,34 @@ static void tpm_passthrough_destroy(TPMBackend *tb)
 
     qemu_close(tpm_pt->tpm_fd);
     qemu_close(tpm_pt->cancel_fd);
+
+    g_free(tpm_pt->ops.path);
+    g_free(tpm_pt->ops.cancel_path);
     g_free(tpm_pt->tpm_dev);
 }
 
+static TPMOptions *tpm_passthrough_get_tpm_options(TPMBackend *tb)
+{
+    TPMPassthruState *tpm_pt = TPM_PASSTHROUGH(tb);
+    TPMPassthroughOptions *ops = g_new0(TPMPassthroughOptions, 1);
+
+    if (!ops) {
+        return NULL;
+    }
+
+    if (tpm_pt->ops.has_path) {
+        ops->has_path = true;
+        ops->path = g_strdup(tpm_pt->ops.path);
+    }
+
+    if (tpm_pt->ops.has_cancel_path) {
+        ops->has_cancel_path = true;
+        ops->cancel_path = g_strdup(tpm_pt->ops.cancel_path);
+    }
+
+    return (TPMOptions *)ops;
+}
+
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] = {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -461,6 +493,7 @@ static const TPMDriverOps tpm_passthrough_driver = {
     .get_tpm_established_flag = tpm_passthrough_get_tpm_established_flag,
     .reset_tpm_established_flag = tpm_passthrough_reset_tpm_established_flag,
     .get_tpm_version          = tpm_passthrough_get_tpm_version,
+    .get_tpm_options          = tpm_passthrough_get_tpm_options,
 };
 
 static void tpm_passthrough_inst_init(Object *obj)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index 98b6112..82348a3 100644
--- a/include/sysemu/tpm_backend.h
+++ b/include/sysemu/tpm_backend.h
@@ -41,10 +41,9 @@ struct TPMBackend {
     GThreadPool *thread_pool;
     TPMRecvDataCB *recv_data_callback;
 
+    /* <public> */
     char *id;
     enum TpmModel fe_model;
-    char *path;
-    char *cancel_path;
 
     QLIST_ENTRY(TPMBackend) list;
 };
@@ -81,6 +80,8 @@ struct TPMDriverOps {
     int (*reset_tpm_established_flag)(TPMBackend *t, uint8_t locty);
 
     TPMVersion (*get_tpm_version)(TPMBackend *t);
+
+    TPMOptions* (*get_tpm_options)(TPMBackend *t);
 };
 
 
@@ -213,6 +214,16 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
  */
 TPMVersion tpm_backend_get_tpm_version(TPMBackend *s);
 
+/**
+ * tpm_backend_get_tpm_options:
+ * @s: the backend
+ *
+ * Get the backend configuration options
+ *
+ * Returns newly allocated TPMOptions
+ */
+TPMOptions *tpm_backend_get_tpm_options(TPMBackend *s);
+
 TPMBackend *qemu_find_tpm(const char *id);
 
 const TPMDriverOps *tpm_get_backend_driver(const char *type);
diff --git a/qapi-schema.json b/qapi-schema.json
index b921994..5faf1ac 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5140,6 +5140,14 @@
 { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
 
 ##
+# @TPMOptions:
+#
+# Base type for TPM options
+##
+{ 'struct': 'TPMOptions',
+  'data': { } }
+
+##
 # @TPMPassthroughOptions:
 #
 # Information about the TPM passthrough type
@@ -5151,8 +5159,8 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
-                                             '*cancel-path' : 'str'} }
+{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
+  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
 
 ##
 # @TpmTypeOptions:
diff --git a/tpm.c b/tpm.c
index 0ee021a..c221000 100644
--- a/tpm.c
+++ b/tpm.c
@@ -252,7 +252,6 @@ static const TPMDriverOps *tpm_driver_find_by_type(enum TpmType type)
 static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
 {
     TPMInfo *res = g_new0(TPMInfo, 1);
-    TPMPassthroughOptions *tpo;
 
     res->id = g_strdup(drv->id);
     res->model = drv->fe_model;
@@ -261,16 +260,8 @@ static TPMInfo *qmp_query_tpm_inst(TPMBackend *drv)
     switch (tpm_backend_get_type(drv)) {
     case TPM_TYPE_PASSTHROUGH:
         res->options->type = TPM_TYPE_OPTIONS_KIND_PASSTHROUGH;
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
+        res->options->u.passthrough.data =
+            (TPMPassthroughOptions *)tpm_backend_get_tpm_options(drv);
         break;
     case TPM_TYPE__MAX:
         break;
-- 
2.7.4
