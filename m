Received: from eggs.gnu.org ([2001:4830:134:3::10]:38823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2be-0007zU-Mg
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dz2bc-0007y5-0w
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dz2bb-0007wZ-L4
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 11:26:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Oct 2017 17:25:51 +0200
Message-Id: <20171002152552.27999-32-armbru@redhat.com>
In-Reply-To: <20171002152552.27999-1-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 31/32] qapi/options: QAPIfy --blockdev
 argument type
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/options.json |  2 +-
 vl.c              | 42 +++++++-----------------------------------
 2 files changed, 8 insertions(+), 36 deletions(-)

diff --git a/qapi/options.json b/qapi/options.json
index eb1a3e2dde..d55c6bfa81 100644
--- a/qapi/options.json
+++ b/qapi/options.json
@@ -877,7 +877,7 @@
 # !end texinfo
 ##
 { 'option': '--blockdev',
-  'data': 'str',                # FIXME BlockdevOptions
+  'data': 'BlockdevOptions', 'boxed': true,
   'help': [
 "-blockdev [driver=]driver[,node-name=N][,discard=ignore|unmap]",
 "          [,cache.direct=on|off][,cache.no-flush=on|off]",
diff --git a/vl.c b/vl.c
index 1814a53337..32f4b5fef3 100644
--- a/vl.c
+++ b/vl.c
@@ -3083,13 +3083,6 @@ int main(int argc, char **argv, char **envp)
     Error *err = NULL;
     bool list_data_dirs = false;
     char **dirs;
-    typedef struct BlockdevOptions_queue {
-        BlockdevOptions *bdo;
-        Location loc;
-        QSIMPLEQ_ENTRY(BlockdevOptions_queue) entry;
-    } BlockdevOptions_queue;
-    QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
-        = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
     QAPIOption *qopt;
 
     module_call_init(MODULE_INIT_TRACE);
@@ -3233,25 +3226,8 @@ int main(int argc, char **argv, char **envp)
                 drive_add(IF_DEFAULT, 3, qopt[i].u.hdb.data, HD_OPTS);
                 break;
             case QAPI_OPTION_KIND_BLOCKDEV:
-                {
-                    Visitor *v;
-                    BlockdevOptions_queue *bdo;
-
-                    v = qobject_input_visitor_new_str(qopt[i].u.blockdev.data,
-                                                      "driver", &err);
-                    if (!v) {
-                        error_report_err(err);
-                        exit(1);
-                    }
-
-                    bdo = g_new(BlockdevOptions_queue, 1);
-                    visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
-                                               &error_fatal);
-                    visit_free(v);
-                    loc_save(&bdo->loc);
-                    QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
-                    break;
-                }
+                /* nothing to do */
+                break;
             case QAPI_OPTION_KIND_DRIVE:
                 if (drive_def(qopt[i].u.drive.data) == NULL) {
                     exit(1);
@@ -4651,15 +4627,11 @@ int main(int argc, char **argv, char **envp)
     }
 
     /* open the virtual block devices */
-    while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
-        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
-
-        QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
-        loc_push_restore(&bdo->loc);
-        qmp_blockdev_add(bdo->bdo, &error_fatal);
-        loc_pop(&bdo->loc);
-        qapi_free_BlockdevOptions(bdo->bdo);
-        g_free(bdo);
+    for (i = 0; qopt[i].cnt; i++) {
+        if (qopt[i].type == QAPI_OPTION_KIND_BLOCKDEV) {
+            loc_set_cmdline(argv, qopt[i].idx, qopt[i].cnt);
+            qmp_blockdev_add(&qopt[i].u.blockdev, &error_fatal);
+        }
     }
     if (snapshot || replay_mode != REPLAY_MODE_NONE) {
         qemu_opts_foreach(qemu_find_opts("drive"), drive_enable_snapshot,
-- 
2.13.6
