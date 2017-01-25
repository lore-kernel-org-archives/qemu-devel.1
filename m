Received: from eggs.gnu.org ([2001:4830:134:3::10]:44686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRaN-0004UB-9o
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cWRaM-0005hI-2j
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:42:19 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 25 Jan 2017 12:42:03 -0500
Message-Id: <a252efad890c55d5d59e7fe77a9a9b994ee83074.1485365834.git.jcody@redhat.com>
In-Reply-To: <cover.1485365834.git.jcody@redhat.com>
References: <cover.1485365834.git.jcody@redhat.com>
In-Reply-To: <cover.1485365834.git.jcody@redhat.com>
References: <cover.1485365834.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/7] iscsi: Handle -iscsi user/password in
 bdrv_parse_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, berrange@redhat.com, pbonzini@redhat.com

From: Kevin Wolf <kwolf@redhat.com>

This splits the logic in the old parse_chap() function into a part that
parses the -iscsi options into the new driver-specific options, and
another part that actually applies those options (called apply_chap()
now).

Note that this means that username and password specified with -iscsi
only take effect when a URL is provided. This is intentional, -iscsi is
a legacy interface only supported for compatibility, new users should
use the proper driver-specific options.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/iscsi.c | 78 +++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 97cff30..fc91d0f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1236,29 +1236,14 @@ retry:
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
@@ -1587,6 +1572,41 @@ out:
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
@@ -1625,6 +1645,9 @@ static void iscsi_parse_filename(const char *filename, QDict *options,
     qdict_set_default_str(options, "lun", lun_str);
     g_free(lun_str);
 
+    /* User/password from -iscsi take precedence over those from the URL */
+    iscsi_parse_iscsi_option(iscsi_url->target, options);
+
     if (iscsi_url->user[0] != '\0') {
         qdict_set_default_str(options, "user", iscsi_url->user);
         qdict_set_default_str(options, "password", iscsi_url->passwd);
@@ -1659,6 +1682,10 @@ static QemuOptsList runtime_opts = {
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
@@ -1678,7 +1705,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     Error *local_err = NULL;
     const char *transport_name, *portal, *target;
-    const char *user, *password;
 #if LIBISCSI_API_VERSION >= (20160603)
     enum iscsi_transport_type transport;
 #endif
@@ -1695,8 +1721,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     transport_name = qemu_opt_get(opts, "transport");
     portal = qemu_opt_get(opts, "portal");
     target = qemu_opt_get(opts, "target");
-    user = qemu_opt_get(opts, "user");
-    password = qemu_opt_get(opts, "password");
     lun = qemu_opt_get_number(opts, "lun", 0);
 
     if (!transport_name || !portal || !target) {
@@ -1704,11 +1728,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1747,17 +1766,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
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
