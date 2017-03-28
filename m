Received: from eggs.gnu.org ([2001:4830:134:3::10]:39948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvM-0000F5-HH
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvL-0008QO-6T
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:20 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:56:08 +0200
Message-Id: <1490691368-32099-11-git-send-email-armbru@redhat.com>
In-Reply-To: <1490691368-32099-1-git-send-email-armbru@redhat.com>
References: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 10/10] rbd: Fix bugs around -drive
 parameter "server"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

qemu_rbd_open() takes option parameters as a flattened QDict, with
keys of the form server.%d.host, server.%d.port, where %d counts up
from zero.

qemu_rbd_array_opts() extracts these values as follows.  First, it
calls qdict_array_entries() to find the list's length.  For each list
element, it formats the list's key prefix (e.g. "server.0."), then
creates a new QDict holding the options with that key prefix, then
converts that to a QemuOpts, so it can finally get the member values
from there.

If there's one surefire way to make code using QDict more awkward,
it's creating more of them and mixing in QemuOpts for good measure.

The extraction of keys starting with server.%d into another QDict
makes us ignore parameters like server.0.neither-host-nor-port
silently.

The conversion to QemuOpts abuses runtime_opts, as described a few
commits ago.

Rewrite to simply get the values straight from the options QDict.

Fixes -drive not to crash when server.*.* are present, but
server.*.host is absent.

Fixes -drive to reject invalid server.*.*.

Permits cleaning up runtime_opts.  Do that, and fix -drive to reject
bogus parameters host and port instead of silently ignoring them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/rbd.c | 127 +++++++++++++++---------------------------------------------
 1 file changed, 32 insertions(+), 95 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 485cef4..498322b 100644
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
@@ -320,7 +319,7 @@ static QemuOptsList runtime_opts = {
             .help = "Rados id name",
         },
         /*
-         * server.* extracted manually, see qemu_rbd_array_opts()
+         * server.* extracted manually, see qemu_rbd_mon_host()
          */
         {
             .name = "password-secret",
@@ -340,21 +339,6 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "Legacy rados key/value option parameters",
         },
-
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
         { /* end of list */ }
     },
 };
@@ -505,89 +489,43 @@ static void qemu_rbd_complete_aio(RADOSCB *rcb)
     qemu_aio_unref(acb);
 }
 
-#define RBD_MON_HOST          0
-
-static char *qemu_rbd_array_opts(QDict *options, const char *prefix, int type,
-                                 Error **errp)
+static char *qemu_rbd_mon_host(QDict *options, Error **errp)
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
+    const char *host, *port;
+    char *rados_str;
     int i;
 
-    assert(type == RBD_MON_HOST);
-
-    num_entries = qdict_array_entries(options, prefix);
-
-    if (num_entries < 0) {
-        error_setg(errp, "Parse error on RBD QDict array");
-        return NULL;
-    }
-
-    for (i = 0; i < num_entries; i++) {
-        char *strbuf = NULL;
-        const char *value;
-        char *rados_str_tmp;
-
-        str = g_strdup_printf("%s%d.", prefix, i);
-        qdict_extract_subqdict(options, &sub_options, str);
-        g_free(str);
-
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
+        if (strchr(host, ':')) {
+            vals[i] = port ? g_strdup_printf("[%s]:%s", host, port)
+                : g_strdup_printf("[%s]", host);
         } else {
-            abort();
+            vals[i] = port ? g_strdup_printf("%s:%s", host, port)
+                : g_strdup(host);
         }
-
-        /* each iteration in the for loop will build upon the string, and if
-         * rados_str is NULL then it is our first pass */
-        if (rados_str) {
-            /* separate options with ';', as that  is what rados_conf_set()
-             * requires */
-            rados_str_tmp = rados_str;
-            rados_str = g_strdup_printf("%s;%s", rados_str_tmp, value);
-            g_free(rados_str_tmp);
-        } else {
-            rados_str = g_strdup(value);
-        }
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
 
@@ -606,12 +544,11 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        qemu_opts_del(opts);
-        return -EINVAL;
+        r = -EINVAL;
+        goto failed_opts;
     }
 
-    mon_host = qemu_rbd_array_opts(options, "server.",
-                                   RBD_MON_HOST, &local_err);
+    mon_host = qemu_rbd_mon_host(options, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         r = -EINVAL;
-- 
2.7.4
