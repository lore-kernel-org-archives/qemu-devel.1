Received: from eggs.gnu.org ([2001:4830:134:3::10]:59766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfV-0005TH-Ko
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfU-0002wu-Iu
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:25 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Dec 2016 14:23:07 +0100
Message-Id: <1481203391-9523-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 2/6] iscsi: Handle -iscsi user/password in
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
Cc: kwolf@redhat.com, jcody@redhat.com, berrange@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This splits the logic in the old parse_chap() function into a part that
parses the -iscsi options into the new driver-specific options, and
another part that actually applies those options (called apply_chap()
now).

Note that this means that username and password specified with -iscsi
only take effect when a URL is provided. This is intentional, -iscsi is
a legacy interface only supported for compatibility, new users should
use the proper driver-specific options.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 72 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 7a6664e..c5106c1 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1235,29 +1235,14 @@ retry:
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
@@ -1586,6 +1571,35 @@ out:
     }
 }
 
+static void iscsi_parse_iscsi_option(const char *target, QDict *options)
+{
+    QemuOptsList *list;
+    QemuOpts *opts;
+    const char *user;
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
+        qdict_set_default_str(options, "password",
+                              qemu_opt_get(opts, "password"));
+        qdict_set_default_str(options, "password-secret",
+                              qemu_opt_get(opts, "password-secret"));
+    }
+}
+
 /*
  * We support iscsi url's on the form
  * iscsi://[<username>%<password>@]<host>[:<port>]/<targetname>/<lun>
@@ -1624,6 +1638,9 @@ static void iscsi_parse_filename(const char *filename, QDict *options,
     qdict_set_default_str(options, "lun", lun_str);
     g_free(lun_str);
 
+    /* User/password from -iscsi take precedence over those from the URL */
+    iscsi_parse_iscsi_option(iscsi_url->target, options);
+
     if (iscsi_url->user[0] != '\0') {
         qdict_set_default_str(options, "user", iscsi_url->user);
         qdict_set_default_str(options, "password", iscsi_url->passwd);
@@ -1658,6 +1675,10 @@ static QemuOptsList runtime_opts = {
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
@@ -1677,7 +1698,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     Error *local_err = NULL;
     const char *transport_name, *portal, *target;
-    const char *user, *password;
 #if LIBISCSI_API_VERSION >= (20160603)
     enum iscsi_transport_type transport;
 #endif
@@ -1694,8 +1714,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     transport_name = qemu_opt_get(opts, "transport");
     portal = qemu_opt_get(opts, "portal");
     target = qemu_opt_get(opts, "target");
-    user = qemu_opt_get(opts, "user");
-    password = qemu_opt_get(opts, "password");
     lun = qemu_opt_get_number(opts, "lun", 0);
 
     if (!transport_name || !portal || !target) {
@@ -1703,11 +1721,6 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1746,17 +1759,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
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
1.8.3.1
