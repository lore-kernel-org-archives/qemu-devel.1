Received: from eggs.gnu.org ([2001:4830:134:3::10]:46023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsT-000488-9j
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckxsR-0004kd-OY
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 14:01:01 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  6 Mar 2017 20:00:46 +0100
Message-Id: <1488826849-32384-13-git-send-email-armbru@redhat.com>
In-Reply-To: <1488826849-32384-1-git-send-email-armbru@redhat.com>
References: <1488826849-32384-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/15] gluster: Plug memory leaks in
 qemu_gluster_parse_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, ndevos@redhat.com, eblake@redhat.com, f4bug@amsat.org

To reproduce, run

    $ valgrind qemu-system-x86_64 --nodefaults -S --drive driver=gluster,volume=testvol,path=/a/b/c,server.0.type=xxx

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Niels de Vos <ndevos@redhat.com>
---
 block/gluster.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 6fbcf9e..991f18f 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -480,7 +480,7 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
                                   QDict *options, Error **errp)
 {
     QemuOpts *opts;
-    GlusterServer *gsconf;
+    GlusterServer *gsconf = NULL;
     GlusterServerList *curr = NULL;
     QDict *backing_options = NULL;
     Error *local_err = NULL;
@@ -529,17 +529,16 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
         }
 
         ptr = qemu_opt_get(opts, GLUSTER_OPT_TYPE);
+        if (!ptr) {
+            error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_TYPE);
+            error_append_hint(&local_err, GERR_INDEX_HINT, i);
+            goto out;
+
+        }
         gsconf = g_new0(GlusterServer, 1);
         gsconf->type = qapi_enum_parse(GlusterTransport_lookup, ptr,
-                                       GLUSTER_TRANSPORT__MAX,
-                                       GLUSTER_TRANSPORT__MAX,
+                                       GLUSTER_TRANSPORT__MAX, -1,
                                        &local_err);
-        if (!ptr) {
-            error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_TYPE);
-            error_append_hint(&local_err, GERR_INDEX_HINT, i);
-            goto out;
-
-        }
         if (local_err) {
             error_append_hint(&local_err,
                               "Parameter '%s' may be 'tcp' or 'unix'\n",
@@ -626,8 +625,10 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
             curr->next->value = gsconf;
             curr = curr->next;
         }
+        gsconf = NULL;
 
-        qdict_del(backing_options, str);
+        QDECREF(backing_options);
+        backing_options = NULL;
         g_free(str);
         str = NULL;
     }
@@ -636,11 +637,10 @@ static int qemu_gluster_parse_json(BlockdevOptionsGluster *gconf,
 
 out:
     error_propagate(errp, local_err);
+    qapi_free_GlusterServer(gsconf);
     qemu_opts_del(opts);
-    if (str) {
-        qdict_del(backing_options, str);
-        g_free(str);
-    }
+    g_free(str);
+    QDECREF(backing_options);
     errno = EINVAL;
     return -errno;
 }
-- 
2.7.4
