Received: from eggs.gnu.org ([2001:4830:134:3::10]:46689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5WMa-0000jo-7T
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1d5WMX-00063Z-3H
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:53:04 -0400
Received: from mga03.intel.com ([134.134.136.65]:28100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1d5WMW-0005ug-MY
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:53:01 -0400
From: Amarnath Valluri <amarnath.valluri@intel.com>
Date: Tue,  2 May 2017 14:52:46 +0300
Message-Id: <1493725969-19518-6-git-send-email-amarnath.valluri@intel.com>
In-Reply-To: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
References: <1493725969-19518-1-git-send-email-amarnath.valluri@intel.com>
Subject: [Qemu-devel] [PATCH v3 5/8] tmp backend: Add new api to read
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
Cc: stefanb@linux.vnet.ibm.com, patrick.ohly@intel.com, marcandre.lureau@gmail.com, berrange@redhat.com, Amarnath Valluri <amarnath.valluri@intel.com>

TPM configuration options are backend implementation details and shall not be
part of base TPMBackend object, and these shall not be accessed directly outside
of the class, hence added a new interface method, get_tpm_options() to
TPMDriverOps., which shall be implemented by the derived classes to return
configured tpm options.

A new tpm backend api - tpm_backend_query_tpm() which uses _get_tpm_options() to
prepare TpmInfo.

Made TPMPassthroughOptions type inherited from newly defined TPMOptions base type.
The TPMOptions base type is intentionally left empty and supposed to be
inherited by all backend implementations to define their tpm configuration
options.

Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>
---
 backends/tpm.c               | 24 ++++++++++++++++++--
 hmp.c                        | 10 ++++----
 hw/tpm/tpm_passthrough.c     | 54 +++++++++++++++++++++++++++++++++++---------
 include/sysemu/tpm_backend.h | 25 ++++++++++++++++++--
 qapi-schema.json             | 41 +++++++++++++++++----------------
 tpm.c                        | 32 +-------------------------
 6 files changed, 115 insertions(+), 71 deletions(-)

diff --git a/backends/tpm.c b/backends/tpm.c
index 8245426..4a6358e 100644
--- a/backends/tpm.c
+++ b/backends/tpm.c
@@ -145,6 +145,28 @@ TPMVersion tpm_backend_get_tpm_version(TPMBackend *s)
     return k->ops->get_tpm_version(s);
 }
 
+TPMOptions *tpm_backend_get_tpm_options(TPMBackend *s)
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
+    TPMBackendClass *k = TPM_BACKEND_GET_CLASS(s);
+    TPMInfo *info = g_new0(TPMInfo, 1);
+
+    info->type = k->ops->type;
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
@@ -199,8 +221,6 @@ static void tpm_backend_instance_finalize(Object *obj)
     TPMBackend *s = TPM_BACKEND(obj);
 
     g_free(s->id);
-    g_free(s->path);
-    g_free(s->cancel_path);
     tpm_backend_thread_end(s);
 }
 
diff --git a/hmp.c b/hmp.c
index edb8970..9caf7c8 100644
--- a/hmp.c
+++ b/hmp.c
@@ -955,18 +955,18 @@ void hmp_info_tpm(Monitor *mon, const QDict *qdict)
                        c, TpmModel_lookup[ti->model]);
 
         monitor_printf(mon, "  \\ %s: type=%s",
-                       ti->id, TpmTypeOptionsKind_lookup[ti->options->type]);
+                       ti->id, TpmType_lookup[ti->type]);
 
-        switch (ti->options->type) {
-        case TPM_TYPE_OPTIONS_KIND_PASSTHROUGH:
-            tpo = ti->options->u.passthrough.data;
+        switch (ti->type) {
+        case TPM_TYPE_PASSTHROUGH:
+            tpo = (TPMPassthroughOptions *)ti->options;
             monitor_printf(mon, "%s%s%s%s",
                            tpo->has_path ? ",path=" : "",
                            tpo->has_path ? tpo->path : "",
                            tpo->has_cancel_path ? ",cancel-path=" : "",
                            tpo->has_cancel_path ? tpo->cancel_path : "");
             break;
-        case TPM_TYPE_OPTIONS_KIND__MAX:
+        default:
             break;
         }
         monitor_printf(mon, "\n");
diff --git a/hw/tpm/tpm_passthrough.c b/hw/tpm/tpm_passthrough.c
index bbe9e5a..2efced1 100644
--- a/hw/tpm/tpm_passthrough.c
+++ b/hw/tpm/tpm_passthrough.c
@@ -49,6 +49,7 @@
 struct TPMPassthruState {
     TPMBackend parent;
 
+    TPMPassthroughOptions *ops;
     char *tpm_dev;
     int tpm_fd;
     bool tpm_executing;
@@ -313,15 +314,14 @@ static TPMVersion tpm_passthrough_get_tpm_version(TPMBackend *tb)
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
@@ -336,7 +336,7 @@ static int tpm_passthrough_open_sysfs_cancel(TPMBackend *tb)
                      dev) < sizeof(path)) {
             fd = qemu_open(path, O_WRONLY);
             if (fd >= 0) {
-                tb->cancel_path = g_strdup(path);
+                tpm_pt->ops->cancel_path = g_strdup(path);
             } else {
                 error_report("tpm_passthrough: Could not open TPM cancel "
                              "path %s : %s", path, strerror(errno));
@@ -356,17 +356,24 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
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
@@ -387,8 +394,8 @@ static int tpm_passthrough_handle_device_opts(QemuOpts *opts, TPMBackend *tb)
     tpm_pt->tpm_fd = -1;
 
  err_free_parameters:
-    g_free(tb->path);
-    tb->path = NULL;
+    g_free(tpm_pt->ops->path);
+    tpm_pt->ops->path = NULL;
 
     g_free(tpm_pt->tpm_dev);
     tpm_pt->tpm_dev = NULL;
@@ -408,7 +415,7 @@ static TPMBackend *tpm_passthrough_create(QemuOpts *opts, const char *id)
         goto err_exit;
     }
 
-    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tb);
+    tpm_pt->cancel_fd = tpm_passthrough_open_sysfs_cancel(tpm_pt);
     if (tpm_pt->cancel_fd < 0) {
         goto err_exit;
     }
@@ -421,6 +428,28 @@ err_exit:
     return NULL;
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
+    if (tpm_pt->ops->has_path) {
+        ops->has_path = true;
+        ops->path = g_strdup(tpm_pt->ops->path);
+    }
+
+    if (tpm_pt->ops->has_cancel_path) {
+        ops->has_cancel_path = true;
+        ops->cancel_path = g_strdup(tpm_pt->ops->cancel_path);
+    }
+
+    return (TPMOptions *)ops;
+}
+
 static const QemuOptDesc tpm_passthrough_cmdline_opts[] = {
     TPM_STANDARD_CMDLINE_OPTS,
     {
@@ -448,12 +477,14 @@ static const TPMDriverOps tpm_passthrough_driver = {
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
@@ -467,6 +498,7 @@ static void tpm_passthrough_inst_finalize(Object *obj)
     qemu_close(tpm_pt->tpm_fd);
     qemu_close(tpm_pt->cancel_fd);
     g_free(tpm_pt->tpm_dev);
+    qapi_free_TPMPassthroughOptions(tpm_pt->ops);
 }
 
 static void tpm_passthrough_class_init(ObjectClass *klass, void *data)
diff --git a/include/sysemu/tpm_backend.h b/include/sysemu/tpm_backend.h
index f61bcfe..8f8f133 100644
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
+    TPMOptions *(*get_tpm_options)(TPMBackend *t);
 };
 
 
@@ -223,6 +224,26 @@ void tpm_backend_open(TPMBackend *s, Error **errp);
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
diff --git a/qapi-schema.json b/qapi-schema.json
index 250e4dc..764f731 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -5137,6 +5137,16 @@
 { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
 
 ##
+# @TPMOptions:
+#
+# Base type for TPM options
+#
+# Since: 2.10
+##
+{ 'struct': 'TPMOptions',
+  'data': { } }
+
+##
 # @TPMPassthroughOptions:
 #
 # Information about the TPM passthrough type
@@ -5148,20 +5158,9 @@
 #
 # Since: 1.5
 ##
-{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
-                                             '*cancel-path' : 'str'} }
+{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
+  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
 
-##
-# @TpmTypeOptions:
-#
-# A union referencing different TPM backend types' configuration options
-#
-# @type: 'passthrough' The configuration options for the TPM passthrough type
-#
-# Since: 1.5
-##
-{ 'union': 'TpmTypeOptions',
-   'data': { 'passthrough' : 'TPMPassthroughOptions' } }
 
 ##
 # @TPMInfo:
@@ -5170,6 +5169,8 @@
 #
 # @id: The Id of the TPM
 #
+# @type: The TPM backend type
+#
 # @model: The TPM frontend model
 #
 # @options: The TPM (backend) type configuration options
@@ -5178,8 +5179,9 @@
 ##
 { 'struct': 'TPMInfo',
   'data': {'id': 'str',
+           'type': 'TpmType',
            'model': 'TpmModel',
-           'options': 'TpmTypeOptions' } }
+           'options': 'TPMOptions' } }
 
 ##
 # @query-tpm:
@@ -5196,13 +5198,12 @@
 # <- { "return":
 #      [
 #        { "model": "tpm-tis",
+#          "type": "passthrough",
 #          "options":
-#            { "type": "passthrough",
-#              "data":
-#                { "cancel-path": "/sys/class/misc/tpm0/device/cancel",
-#                  "path": "/dev/tpm0"
-#                }
-#            },
+#          {
+#            "cancel-path": "/sys/class/misc/tpm0/device/cancel",
+#            "path": "/dev/tpm0"
+#          },
 #          "id": "tpm0"
 #        }
 #      ]
diff --git a/tpm.c b/tpm.c
index 70f74fa..43d980e 100644
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
