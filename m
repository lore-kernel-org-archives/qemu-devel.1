Received: from eggs.gnu.org ([2001:4830:134:3::10]:55269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYw-0005vg-9m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYu-0004NB-Ff
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:10 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:49 -0500
Message-Id: <20170221154057.20313-2-jcody@redhat.com>
In-Reply-To: <20170221154057.20313-1-jcody@redhat.com>
References: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] iscsi: Split URL into individual options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Kevin Wolf <kwolf@redhat.com>

This introduces a .bdrv_parse_filename handler for iscsi which parses an
URL if given and translates it to individual options.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/iscsi.c | 193 ++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 140 insertions(+), 53 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 2561be9..d61d3d8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1483,20 +1483,6 @@ static void iscsi_readcapacity_sync(IscsiLun *iscsilun, Error **errp)
     }
 }
 
-/* TODO Convert to fine grained options */
-static QemuOptsList runtime_opts = {
-    .name = "iscsi",
-    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
-    .desc = {
-        {
-            .name = "filename",
-            .type = QEMU_OPT_STRING,
-            .help = "URL to the iscsi image",
-        },
-        { /* end of list */ }
-    },
-};
-
 static struct scsi_task *iscsi_do_inquiry(struct iscsi_context *iscsi, int lun,
                                           int evpd, int pc, void **inq, Error **errp)
 {
@@ -1618,20 +1604,102 @@ out:
  * We support iscsi url's on the form
  * iscsi://[<username>%<password>@]<host>[:<port>]/<targetname>/<lun>
  */
+static void iscsi_parse_filename(const char *filename, QDict *options,
+                                 Error **errp)
+{
+    struct iscsi_url *iscsi_url;
+    const char *transport_name;
+    char *lun_str;
+
+    iscsi_url = iscsi_parse_full_url(NULL, filename);
+    if (iscsi_url == NULL) {
+        error_setg(errp, "Failed to parse URL : %s", filename);
+        return;
+    }
+
+#if LIBISCSI_API_VERSION >= (20160603)
+    switch (iscsi_url->transport) {
+    case TCP_TRANSPORT:
+        transport_name = "tcp";
+        break;
+    case ISER_TRANSPORT:
+        transport_name = "iser";
+        break;
+    default:
+        error_setg(errp, "Unknown transport type (%d)",
+                   iscsi_url->transport);
+        return;
+    }
+#else
+    transport_name = "tcp";
+#endif
+
+    qdict_set_default_str(options, "transport", transport_name);
+    qdict_set_default_str(options, "portal", iscsi_url->portal);
+    qdict_set_default_str(options, "target", iscsi_url->target);
+
+    lun_str = g_strdup_printf("%d", iscsi_url->lun);
+    qdict_set_default_str(options, "lun", lun_str);
+    g_free(lun_str);
+
+    if (iscsi_url->user[0] != '\0') {
+        qdict_set_default_str(options, "user", iscsi_url->user);
+        qdict_set_default_str(options, "password", iscsi_url->passwd);
+    }
+
+    iscsi_destroy_url(iscsi_url);
+}
+
+/* TODO Add -iscsi options */
+static QemuOptsList runtime_opts = {
+    .name = "iscsi",
+    .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
+    .desc = {
+        {
+            .name = "transport",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "portal",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "target",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "user",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "password",
+            .type = QEMU_OPT_STRING,
+        },
+        {
+            .name = "lun",
+            .type = QEMU_OPT_NUMBER,
+        },
+        { /* end of list */ }
+    },
+};
+
 static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
                       Error **errp)
 {
     IscsiLun *iscsilun = bs->opaque;
     struct iscsi_context *iscsi = NULL;
-    struct iscsi_url *iscsi_url = NULL;
     struct scsi_task *task = NULL;
     struct scsi_inquiry_standard *inq = NULL;
     struct scsi_inquiry_supported_pages *inq_vpd;
     char *initiator_name = NULL;
     QemuOpts *opts;
     Error *local_err = NULL;
-    const char *filename;
-    int i, ret = 0, timeout = 0;
+    const char *transport_name, *portal, *target;
+    const char *user, *password;
+#if LIBISCSI_API_VERSION >= (20160603)
+    enum iscsi_transport_type transport;
+#endif
+    int i, ret = 0, timeout = 0, lun;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
@@ -1641,18 +1709,41 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    filename = qemu_opt_get(opts, "filename");
+    transport_name = qemu_opt_get(opts, "transport");
+    portal = qemu_opt_get(opts, "portal");
+    target = qemu_opt_get(opts, "target");
+    user = qemu_opt_get(opts, "user");
+    password = qemu_opt_get(opts, "password");
+    lun = qemu_opt_get_number(opts, "lun", 0);
 
-    iscsi_url = iscsi_parse_full_url(iscsi, filename);
-    if (iscsi_url == NULL) {
-        error_setg(errp, "Failed to parse URL : %s", filename);
+    if (!transport_name || !portal || !target) {
+        error_setg(errp, "Need all of transport, portal and target options");
+        ret = -EINVAL;
+        goto out;
+    }
+    if (user && !password) {
+        error_setg(errp, "If a user name is given, a password is required");
+        ret = -EINVAL;
+        goto out;
+    }
+
+    if (!strcmp(transport_name, "tcp")) {
+#if LIBISCSI_API_VERSION >= (20160603)
+        transport = TCP_TRANSPORT;
+    } else if (!strcmp(transport_name, "iser")) {
+        transport = ISER_TRANSPORT;
+#else
+        /* TCP is what older libiscsi versions always use */
+#endif
+    } else {
+        error_setg(errp, "Unknown transport: %s", transport_name);
         ret = -EINVAL;
         goto out;
     }
 
     memset(iscsilun, 0, sizeof(IscsiLun));
 
-    initiator_name = parse_initiator_name(iscsi_url->target);
+    initiator_name = parse_initiator_name(target);
 
     iscsi = iscsi_create_context(initiator_name);
     if (iscsi == NULL) {
@@ -1661,21 +1752,20 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 #if LIBISCSI_API_VERSION >= (20160603)
-    if (iscsi_init_transport(iscsi, iscsi_url->transport)) {
+    if (iscsi_init_transport(iscsi, transport)) {
         error_setg(errp, ("Error initializing transport."));
         ret = -EINVAL;
         goto out;
     }
 #endif
-    if (iscsi_set_targetname(iscsi, iscsi_url->target)) {
+    if (iscsi_set_targetname(iscsi, target)) {
         error_setg(errp, "iSCSI: Failed to set target name.");
         ret = -EINVAL;
         goto out;
     }
 
-    if (iscsi_url->user[0] != '\0') {
-        ret = iscsi_set_initiator_username_pwd(iscsi, iscsi_url->user,
-                                              iscsi_url->passwd);
+    if (user) {
+        ret = iscsi_set_initiator_username_pwd(iscsi, user, password);
         if (ret != 0) {
             error_setg(errp, "Failed to set initiator username and password");
             ret = -EINVAL;
@@ -1684,7 +1774,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* check if we got CHAP username/password via the options */
-    parse_chap(iscsi, iscsi_url->target, &local_err);
+    parse_chap(iscsi, target, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1700,7 +1790,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
 
     /* check if we got HEADER_DIGEST via the options */
-    parse_header_digest(iscsi, iscsi_url->target, &local_err);
+    parse_header_digest(iscsi, target, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1708,7 +1798,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* timeout handling is broken in libiscsi before 1.15.0 */
-    timeout = parse_timeout(iscsi_url->target);
+    timeout = parse_timeout(target);
 #if LIBISCSI_API_VERSION >= 20150621
     iscsi_set_timeout(iscsi, timeout);
 #else
@@ -1717,7 +1807,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 #endif
 
-    if (iscsi_full_connect_sync(iscsi, iscsi_url->portal, iscsi_url->lun) != 0) {
+    if (iscsi_full_connect_sync(iscsi, portal, lun) != 0) {
         error_setg(errp, "iSCSI: Failed to connect to LUN : %s",
             iscsi_get_error(iscsi));
         ret = -EINVAL;
@@ -1726,7 +1816,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
 
     iscsilun->iscsi = iscsi;
     iscsilun->aio_context = bdrv_get_aio_context(bs);
-    iscsilun->lun   = iscsi_url->lun;
+    iscsilun->lun = lun;
     iscsilun->has_write_same = true;
 
     task = iscsi_do_inquiry(iscsilun->iscsi, iscsilun->lun, 0, 0,
@@ -1829,9 +1919,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
 out:
     qemu_opts_del(opts);
     g_free(initiator_name);
-    if (iscsi_url != NULL) {
-        iscsi_destroy_url(iscsi_url);
-    }
     if (task != NULL) {
         scsi_free_scsi_task(task);
     }
@@ -2040,15 +2127,15 @@ static BlockDriver bdrv_iscsi = {
     .format_name     = "iscsi",
     .protocol_name   = "iscsi",
 
-    .instance_size   = sizeof(IscsiLun),
-    .bdrv_needs_filename = true,
-    .bdrv_file_open  = iscsi_open,
-    .bdrv_close      = iscsi_close,
-    .bdrv_create     = iscsi_create,
-    .create_opts     = &iscsi_create_opts,
-    .bdrv_reopen_prepare   = iscsi_reopen_prepare,
-    .bdrv_reopen_commit    = iscsi_reopen_commit,
-    .bdrv_invalidate_cache = iscsi_invalidate_cache,
+    .instance_size          = sizeof(IscsiLun),
+    .bdrv_parse_filename    = iscsi_parse_filename,
+    .bdrv_file_open         = iscsi_open,
+    .bdrv_close             = iscsi_close,
+    .bdrv_create            = iscsi_create,
+    .create_opts            = &iscsi_create_opts,
+    .bdrv_reopen_prepare    = iscsi_reopen_prepare,
+    .bdrv_reopen_commit     = iscsi_reopen_commit,
+    .bdrv_invalidate_cache  = iscsi_invalidate_cache,
 
     .bdrv_getlength  = iscsi_getlength,
     .bdrv_get_info   = iscsi_get_info,
@@ -2075,15 +2162,15 @@ static BlockDriver bdrv_iser = {
     .format_name     = "iser",
     .protocol_name   = "iser",
 
-    .instance_size   = sizeof(IscsiLun),
-    .bdrv_needs_filename = true,
-    .bdrv_file_open  = iscsi_open,
-    .bdrv_close      = iscsi_close,
-    .bdrv_create     = iscsi_create,
-    .create_opts     = &iscsi_create_opts,
-    .bdrv_reopen_prepare   = iscsi_reopen_prepare,
-    .bdrv_reopen_commit    = iscsi_reopen_commit,
-    .bdrv_invalidate_cache = iscsi_invalidate_cache,
+    .instance_size          = sizeof(IscsiLun),
+    .bdrv_parse_filename    = iscsi_parse_filename,
+    .bdrv_file_open         = iscsi_open,
+    .bdrv_close             = iscsi_close,
+    .bdrv_create            = iscsi_create,
+    .create_opts            = &iscsi_create_opts,
+    .bdrv_reopen_prepare    = iscsi_reopen_prepare,
+    .bdrv_reopen_commit     = iscsi_reopen_commit,
+    .bdrv_invalidate_cache  = iscsi_invalidate_cache,
 
     .bdrv_getlength  = iscsi_getlength,
     .bdrv_get_info   = iscsi_get_info,
-- 
2.9.3
