Received: from eggs.gnu.org ([2001:4830:134:3::10]:36628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGb-0006se-MM
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGZ-0001ht-Bl
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crTGZ-0001hM-3G
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 157FB624DF
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:44:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Mar 2017 18:44:41 +0100
Message-Id: <1490377482-13337-9-git-send-email-armbru@redhat.com>
In-Reply-To: <1490377482-13337-1-git-send-email-armbru@redhat.com>
References: <1490377482-13337-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 8/9] rbd: Rewrite the code to extract
 list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

We have two list-values options:

* "server" is a list of InetSocketAddress.  We use members "host" and
  "port", and silently ignore the rest.

* "auth-supported" is a list of RbdAuthMethod.  We use its only member
  "auth".

Since qemu_rbd_open() takes options as a flattened QDict, options has
keys of the form server.%d.host, server.%d.port and
auth-supported.%d.auth, where %d counts up from zero.

qemu_rbd_array_opts() extracts these values as follows.  First, it
calls qdict_array_entries() to find the list's length.  For each list
element, it first formats the list's key prefix (e.g. "server.0."),
then creates a new QDict holding the options with that key prefix,
then converts that to a QemuOpts, so it can finally get the member
values from there.

If there's one surefire way to make code using QDict more awkward,
it's creating more of them and mixing in QemuOpts for good measure.

The conversion to QemuOpts abuses runtime_opts, as described in the
commit before previous.

Rewrite to simply get the values straight from the options QDict.

Fixes -drive not to crash when server.*.* are present, but
server.*.host is absent.

Permits cleaning up runtime_opts, which fixes -drive to reject several
bogus parameters instead of silently ignoring them: host, port, auth;
server.*.P where P isn't host; port auth-supported.*.P where P isn't
auth.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/rbd.c | 150 +++++++++++++++++++++---------------------------------------
 1 file changed, 52 insertions(+), 98 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 6397626..e962641 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 
+#include <rbd/librbd.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
@@ -20,8 +21,6 @@
 #include "qemu/cutils.h"
 #include "qapi/qmp/qstring.h"
 
-#include <rbd/librbd.h>
-
 /*
  * When specifying the image filename use:
  *
@@ -341,25 +340,6 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "Legacy rados key/value option parameters",
         },
-        /*
-         * The remainder aren't option keys, but option sub-sub-keys,
-         * so that qemu_rbd_array_opts() can abuse runtime_opts for
-         * its own purposes
-         * TODO clean this up
-         */
-        {
-            .name = "host",
-            .type = QEMU_OPT_STRING,
-        },
-        {
-            .name = "port",
-            .type = QEMU_OPT_STRING,
-        },
-        {
-            .name = "auth",
-            .type = QEMU_OPT_STRING,
-            .help = "Supported authentication method, either cephx or none",
-        },
         { /* end of list */ }
     },
 };
@@ -510,91 +490,68 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     qemu_aio_unref(acb);
 }
 
-#define RBD_MON_HOST          0
-#define RBD_AUTH_SUPPORTED    1
-
-static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
-                                 Error **errp)
+static char *qemu_rbd_auth(QDict *options, Error **errp)
 {
-    int num_entries;
-    QemuOpts *opts = NULL;
-    QDict *sub_options;
-    const char *host;
-    const char *port;
-    char *str;
-    char *rados_str = NULL;
-    Error *local_err = NULL;
+    const char **vals = g_new(const char *, qdict_size(options) + 1);
+    char keybuf[32];
+    QObject *val;
+    char *rados_str;
     int i;
 
-    assert(type == RBD_MON_HOST || type == RBD_AUTH_SUPPORTED);
+    for (i = 0;; i++) {
+        sprintf(keybuf, "auth-supported.%d.auth", i);
+        val = qdict_get(options, keybuf);
+        if (!val) {
+            break;
+        }
 
-    num_entries = qdict_array_entries(options, prefix);
-
-    if (num_entries < 0) {
-        error_setg(errp, "Parse error on RBD QDict array");
-        return NULL;
+        vals[i] = qstring_get_str(qobject_to_qstring(val));
+        qdict_del(options, keybuf);
     }
+    vals[i] = NULL;
 
-    for (i = 0; i < num_entries; i++) {
-        char *strbuf = NULL;
-        const char *value;
-        char *rados_str_tmp;
+    rados_str = i ? g_strjoinv(";", (char **)vals) : NULL;
+    g_free(vals);
+    return rados_str;
+}
 
-        str = g_strdup_printf("%s%d.", prefix, i);
-        qdict_extract_subqdict(options, &sub_options, str);
-        g_free(str);
+static char *qemu_mon_host(QDict *options, Error **errp)
+{
+    const char **vals = g_new(const char *, qdict_size(options) + 1);
+    char keybuf[32];
+    const char *host, *port;
+    char *rados_str;
+    int i;
 
-        opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
-        qemu_opts_absorb_qdict(opts, sub_options, &local_err);
-        QDECREF(sub_options);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            g_free(rados_str);
+    for (i = 0;; i++) {
+        sprintf(keybuf, "server.%d.host", i);
+        host = qdict_get_try_str(options, keybuf);
+        qdict_del(options, keybuf);
+        sprintf(keybuf, "server.%d.port", i);
+        port = qdict_get_try_str(options, keybuf);
+        qdict_del(options, keybuf);
+        if (!host && !port) {
+            break;
+        }
+        if (!host) {
+            error_setg(errp, "Parameter server.%d.host is missing", i);
             rados_str = NULL;
-            goto exit;
+            goto out;
         }
 
-        if (type == RBD_MON_HOST) {
-            host = qemu_opt_get(opts, "host");
-            port = qemu_opt_get(opts, "port");
-
-            value = host;
-            if (port) {
-                /* check for ipv6 */
-                if (strchr(host, ':')) {
-                    strbuf = g_strdup_printf("[%s]:%s", host, port);
-                } else {
-                    strbuf = g_strdup_printf("%s:%s", host, port);
-                }
-                value = strbuf;
-            } else if (strchr(host, ':')) {
-                strbuf = g_strdup_printf("[%s]", host);
-                value = strbuf;
-            }
-        } else {
-            value = qemu_opt_get(opts, "auth");
-        }
-
-
-        /* each iteration in the for loop will build upon the string, and if
-         * rados_str is NULL then it is our first pass */
-        if (rados_str) {
-            /* separate options with ';', as that  is what rados_conf_set()
-             * requires */
-            rados_str_tmp = rados_str;
-            rados_str = g_strdup_printf("%s;%s", rados_str_tmp, value);
-            g_free(rados_str_tmp);
+        if (strchr(host, ':')) {
+            vals[i] = port ? g_strdup_printf("[%s]:%s", host, port)
+                : g_strdup_printf("[%s]", host);
         } else {
-            rados_str = g_strdup(value);
+            vals[i] = port ? g_strdup_printf("%s:%s", host, port)
+                : g_strdup(host);
         }
-
-        g_free(strbuf);
-        qemu_opts_del(opts);
-        opts = NULL;
     }
+    vals[i] = NULL;
 
-exit:
-    qemu_opts_del(opts);
+    rados_str = i ? g_strjoinv(";", (char **)vals) : NULL;
+out:
+    g_strfreev((char **)vals);
     return rados_str;
 }
 
@@ -614,20 +571,18 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        qemu_opts_del(opts);
-        return -EINVAL;
+        r = -EINVAL;
+        goto failed_opts;
     }
 
-    auth_supported = qemu_rbd_array_opts(options, "auth-supported.",
-                                         RBD_AUTH_SUPPORTED, &local_err);
+    auth_supported = qemu_rbd_auth(options, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         r = -EINVAL;
         goto failed_opts;
     }
 
-    mon_host = qemu_rbd_array_opts(options, "server.",
-                                   RBD_MON_HOST, &local_err);
+    mon_host = qemu_mon_host(options, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         r = -EINVAL;
@@ -635,7 +590,6 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     secretid = qemu_opt_get(opts, "password-secret");
-
     pool           = qemu_opt_get(opts, "pool");
     conf           = qemu_opt_get(opts, "conf");
     snap           = qemu_opt_get(opts, "snapshot");
-- 
2.7.4
