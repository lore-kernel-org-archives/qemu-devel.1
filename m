Received: from eggs.gnu.org ([2001:4830:134:3::10]:55210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYu-0005tl-PR
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYt-0004MK-FN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:08 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:50 -0500
Message-Id: <20170221154057.20313-3-jcody@redhat.com>
In-Reply-To: <20170221154057.20313-1-jcody@redhat.com>
References: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 2/9] iscsi: Handle -iscsi user/password in
 bdrv_parse_filename()
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

This splits the logic in the old parse_chap() function into a part that
parses the -iscsi options into the new driver-specific options, and
another part that actually applies those options (called apply_chap()
now).

Note that this means that username and password specified with -iscsi
only take effect when a URL is provided. This is intentional, -iscsi is
a legacy interface only supported for compatibility, new users should
use the proper driver-specific options.

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/iscsi.c | 78 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index d61d3d8..ec26fc6 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1245,29 +1245,14 @@ retry:
     return 0;
 }
 
-static void parse_chap(struct iscsi_context *iscsi, const char *target,
+static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
                        Error **errp)
 {
-    QemuOptsList *list;
-    QemuOpts *opts;
     const char *user = NULL;
     const char *password = NULL;
     const char *secretid;
     char *secret = NULL;
 
-    list = qemu_find_opts("iscsi");
-    if (!list) {
-        return;
-    }
-
-    opts = qemu_opts_find(list, target);
-    if (opts == NULL) {
-        opts = QTAILQ_FIRST(&list->head);
-        if (!opts) {
-            return;
-        }
-    }
-
     user = qemu_opt_get(opts, "user");
     if (!user) {
         return;
@@ -1600,6 +1585,41 @@ out:
     }
 }
 
+static void iscsi_parse_iscsi_option(const char *target, QDict *options)
+{
+    QemuOptsList *list;
+    QemuOpts *opts;
+    const char *user, *password, *password_secret;
+
+    list = qemu_find_opts("iscsi");
+    if (!list) {
+        return;
+    }
+
+    opts = qemu_opts_find(list, target);
+    if (opts == NULL) {
+        opts = QTAILQ_FIRST(&list->head);
+        if (!opts) {
+            return;
+        }
+    }
+
+    user = qemu_opt_get(opts, "user");
+    if (user) {
+        qdict_set_default_str(options, "user", user);
+    }
+
+    password = qemu_opt_get(opts, "password");
+    if (password) {
+        qdict_set_default_str(options, "password", password);
+    }
+
+    password_secret = qemu_opt_get(opts, "password-secret");
+    if (password_secret) {
+        qdict_set_default_str(options, "password-secret", password_secret);
+    }
+}
+
 /*
  * We support iscsi url's on the form
  * iscsi://[<username>%<password>@]<host>[:<port>]/<targetname>/<lun>
@@ -1642,6 +1662,9 @@ static void iscsi_parse_filename(const char *filename, QDict *options,
     qdict_set_default_str(options, "lun", lun_str);
     g_free(lun_str);
 
+    /* User/password from -iscsi take precedence over those from the URL */
+    iscsi_parse_iscsi_option(iscsi_url->target, options);
+
     if (iscsi_url->user[0] != '\0') {
         qdict_set_default_str(options, "user", iscsi_url->user);
         qdict_set_default_str(options, "password", iscsi_url->passwd);
@@ -1676,6 +1699,10 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
         },
         {
+            .name = "password-secret",
+            .type = QEMU_OPT_STRING,
+        },
+        {
             .name = "lun",
             .type = QEMU_OPT_NUMBER,
         },
@@ -1695,7 +1722,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     Error *local_err = NULL;
     const char *transport_name, *portal, *target;
-    const char *user, *password;
 #if LIBISCSI_API_VERSION >= (20160603)
     enum iscsi_transport_type transport;
 #endif
@@ -1712,8 +1738,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     transport_name = qemu_opt_get(opts, "transport");
     portal = qemu_opt_get(opts, "portal");
     target = qemu_opt_get(opts, "target");
-    user = qemu_opt_get(opts, "user");
-    password = qemu_opt_get(opts, "password");
     lun = qemu_opt_get_number(opts, "lun", 0);
 
     if (!transport_name || !portal || !target) {
@@ -1721,11 +1745,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -EINVAL;
         goto out;
     }
-    if (user && !password) {
-        error_setg(errp, "If a user name is given, a password is required");
-        ret = -EINVAL;
-        goto out;
-    }
 
     if (!strcmp(transport_name, "tcp")) {
 #if LIBISCSI_API_VERSION >= (20160603)
@@ -1764,17 +1783,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    if (user) {
-        ret = iscsi_set_initiator_username_pwd(iscsi, user, password);
-        if (ret != 0) {
-            error_setg(errp, "Failed to set initiator username and password");
-            ret = -EINVAL;
-            goto out;
-        }
-    }
-
     /* check if we got CHAP username/password via the options */
-    parse_chap(iscsi, target, &local_err);
+    apply_chap(iscsi, opts, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
-- 
2.9.3
