Received: from eggs.gnu.org ([2001:4830:134:3::10]:43017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF9-0002e5-7m
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF8-0002z6-AB
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:46 +0100
Message-Id: <1488901251-16214-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 22/27] gluster: Plug memory leaks in
 qemu_gluster_parse_json()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Markus Armbruster <armbru@redhat.com>

To reproduce, run

    $ valgrind qemu-system-x86_64 --nodefaults -S --drive driver=gluster,volume=testvol,path=/a/b/c,server.0.type=xxx

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Niels de Vos <ndevos@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/gluster.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

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
-        gsconf = g_new0(GlusterServer, 1);
-        gsconf->type = qapi_enum_parse(GlusterTransport_lookup, ptr,
-                                       GLUSTER_TRANSPORT__MAX,
-                                       GLUSTER_TRANSPORT__MAX,
-                                       &local_err);
         if (!ptr) {
             error_setg(&local_err, QERR_MISSING_PARAMETER, GLUSTER_OPT_TYPE);
             error_append_hint(&local_err, GERR_INDEX_HINT, i);
             goto out;
 
         }
+        gsconf = g_new0(GlusterServer, 1);
+        gsconf->type = qapi_enum_parse(GlusterTransport_lookup, ptr,
+                                       GLUSTER_TRANSPORT__MAX, -1,
+                                       &local_err);
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
1.8.3.1
