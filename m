Received: from eggs.gnu.org ([209.51.188.92]:36544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FLI-00052h-C6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FLG-0007au-Dr
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 14:14:38 +0100
Message-Id: <20190308131445.17502-6-armbru@redhat.com>
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 05/12] vl: Improve legibility of
 BlockdevOptions queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

Give the queue head type a name: BlockdevOptionsQueue.

Rename the queue entry type from BlockdevOptions_queue to
BlockdevOptionsQueueEntry.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/vl.c b/vl.c
index c38739e34c..3045ab0df3 100644
--- a/vl.c
+++ b/vl.c
@@ -1193,6 +1193,14 @@ static void default_drive(int enable, int snapshot, BlockInterfaceType type,
 
 }
 
+typedef struct BlockdevOptionsQueueEntry {
+    BlockdevOptions *bdo;
+    Location loc;
+    QSIMPLEQ_ENTRY(BlockdevOptionsQueueEntry) entry;
+} BlockdevOptionsQueueEntry;
+
+typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
+
 static QemuOptsList qemu_smp_opts = {
     .name = "smp-opts",
     .implied_opt_name = "cpus",
@@ -2973,13 +2981,7 @@ int main(int argc, char **argv, char **envp)
     Error *err = NULL;
     bool list_data_dirs = false;
     char *dir, **dirs;
-    typedef struct BlockdevOptions_queue {
-        BlockdevOptions *bdo;
-        Location loc;
-        QSIMPLEQ_ENTRY(BlockdevOptions_queue) entry;
-    } BlockdevOptions_queue;
-    QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
-        = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
 
     module_call_init(MODULE_INIT_TRACE);
 
@@ -3103,12 +3105,12 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_blockdev:
                 {
                     Visitor *v;
-                    BlockdevOptions_queue *bdo;
+                    BlockdevOptionsQueueEntry *bdo;
 
                     v = qobject_input_visitor_new_str(optarg, "driver",
                                                       &error_fatal);
 
-                    bdo = g_new(BlockdevOptions_queue, 1);
+                    bdo = g_new(BlockdevOptionsQueueEntry, 1);
                     visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
                                                &error_fatal);
                     visit_free(v);
@@ -4368,7 +4370,7 @@ int main(int argc, char **argv, char **envp)
 
     /* open the virtual block devices */
     while (!QSIMPLEQ_EMPTY(&bdo_queue)) {
-        BlockdevOptions_queue *bdo = QSIMPLEQ_FIRST(&bdo_queue);
+        BlockdevOptionsQueueEntry *bdo = QSIMPLEQ_FIRST(&bdo_queue);
 
         QSIMPLEQ_REMOVE_HEAD(&bdo_queue, entry);
         loc_push_restore(&bdo->loc);
-- 
2.17.2
