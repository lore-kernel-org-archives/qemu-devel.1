Received: from eggs.gnu.org ([2001:4830:134:3::10]:58808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0rq-0007VT-WE
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cE0rp-0005oi-Qz
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:32:11 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon,  5 Dec 2016 16:31:59 -0500
Message-Id: <1480973521-28945-2-git-send-email-jcody@redhat.com>
In-Reply-To: <1480973521-28945-1-git-send-email-jcody@redhat.com>
References: <1480973521-28945-1-git-send-email-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.8 1/3] block/gluster: fix QMP to match
 debug option
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

From: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>

The QMP definition of BlockdevOptionsGluster:
{ 'struct': 'BlockdevOptionsGluster',
  'data': { 'volume': 'str',
            'path': 'str',
            'server': ['GlusterServer'],
            '*debug-level': 'int',
            '*logfile': 'str' } }

But instead of 'debug-level we have exported 'debug' as the option for choosing
debug level of gluster protocol driver.

This patch fix QMP definition BlockdevOptionsGluster
s/debug-level/debug/

Suggested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Prasanna Kumar Kalever <prasanna.kalever@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/gluster.c      | 38 +++++++++++++++++++-------------------
 qapi/block-core.json |  4 ++--
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/block/gluster.c b/block/gluster.c
index 891c13b..a0a74e4 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -48,7 +48,7 @@ typedef struct BDRVGlusterState {
     struct glfs_fd *fd;
     char *logfile;
     bool supports_seek_data;
-    int debug_level;
+    int debug;
 } BDRVGlusterState;
 
 typedef struct BDRVGlusterReopenState {
@@ -434,7 +434,7 @@ static struct glfs *qemu_gluster_glfs_init(BlockdevOptionsGluster *gconf,
         }
     }
 
-    ret = glfs_set_logging(glfs, gconf->logfile, gconf->debug_level);
+    ret = glfs_set_logging(glfs, gconf->logfile, gconf->debug);
     if (ret < 0) {
         goto out;
     }
@@ -788,17 +788,17 @@ static int qemu_gluster_open(BlockDriverState *bs,  QDict *options,
 
     filename = qemu_opt_get(opts, GLUSTER_OPT_FILENAME);
 
-    s->debug_level = qemu_opt_get_number(opts, GLUSTER_OPT_DEBUG,
-                                         GLUSTER_DEBUG_DEFAULT);
-    if (s->debug_level < 0) {
-        s->debug_level = 0;
-    } else if (s->debug_level > GLUSTER_DEBUG_MAX) {
-        s->debug_level = GLUSTER_DEBUG_MAX;
+    s->debug = qemu_opt_get_number(opts, GLUSTER_OPT_DEBUG,
+                                   GLUSTER_DEBUG_DEFAULT);
+    if (s->debug < 0) {
+        s->debug = 0;
+    } else if (s->debug > GLUSTER_DEBUG_MAX) {
+        s->debug = GLUSTER_DEBUG_MAX;
     }
 
     gconf = g_new0(BlockdevOptionsGluster, 1);
-    gconf->debug_level = s->debug_level;
-    gconf->has_debug_level = true;
+    gconf->debug = s->debug;
+    gconf->has_debug = true;
 
     logfile = qemu_opt_get(opts, GLUSTER_OPT_LOGFILE);
     s->logfile = g_strdup(logfile ? logfile : GLUSTER_LOGFILE_DEFAULT);
@@ -874,8 +874,8 @@ static int qemu_gluster_reopen_prepare(BDRVReopenState *state,
     qemu_gluster_parse_flags(state->flags, &open_flags);
 
     gconf = g_new0(BlockdevOptionsGluster, 1);
-    gconf->debug_level = s->debug_level;
-    gconf->has_debug_level = true;
+    gconf->debug = s->debug;
+    gconf->has_debug = true;
     gconf->logfile = g_strdup(s->logfile);
     gconf->has_logfile = true;
     reop_s->glfs = qemu_gluster_init(gconf, state->bs->filename, NULL, errp);
@@ -1011,14 +1011,14 @@ static int qemu_gluster_create(const char *filename,
     char *tmp = NULL;
 
     gconf = g_new0(BlockdevOptionsGluster, 1);
-    gconf->debug_level = qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
-                                                 GLUSTER_DEBUG_DEFAULT);
-    if (gconf->debug_level < 0) {
-        gconf->debug_level = 0;
-    } else if (gconf->debug_level > GLUSTER_DEBUG_MAX) {
-        gconf->debug_level = GLUSTER_DEBUG_MAX;
+    gconf->debug = qemu_opt_get_number_del(opts, GLUSTER_OPT_DEBUG,
+                                           GLUSTER_DEBUG_DEFAULT);
+    if (gconf->debug < 0) {
+        gconf->debug = 0;
+    } else if (gconf->debug > GLUSTER_DEBUG_MAX) {
+        gconf->debug = GLUSTER_DEBUG_MAX;
     }
-    gconf->has_debug_level = true;
+    gconf->has_debug = true;
 
     gconf->logfile = qemu_opt_get_del(opts, GLUSTER_OPT_LOGFILE);
     if (!gconf->logfile) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c29bef7..03b19f1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2195,7 +2195,7 @@
 #
 # @server:      gluster servers description
 #
-# @debug-level: #optional libgfapi log level (default '4' which is Error)
+# @debug:       #optional libgfapi log level (default '4' which is Error)
 #
 # @logfile:     #optional libgfapi log file (default /dev/stderr) (Since 2.8)
 #
@@ -2205,7 +2205,7 @@
   'data': { 'volume': 'str',
             'path': 'str',
             'server': ['GlusterServer'],
-            '*debug-level': 'int',
+            '*debug': 'int',
             '*logfile': 'str' } }
 
 ##
-- 
2.7.4
