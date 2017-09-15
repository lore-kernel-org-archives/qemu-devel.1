Received: from eggs.gnu.org ([2001:4830:134:3::10]:37388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsna3-0002Iu-HC
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZz-0004Uj-Hq
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:39 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Sep 2017 12:10:07 +0200
Message-Id: <20170915101008.16646-6-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-1-kwolf@redhat.com>
References: <20170915101008.16646-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 5/6] block: reopen: Queue children after their
 parents
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

We will calculate the required new permissions in the prepare stage of a
reopen. Required permissions of children can be influenced by the
changes made to their parents, but parents are independent from their
children. This means that permissions need to be calculated top-down. In
order to achieve this, queue parents before their children rather than
queuing the children first.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/block.c b/block.c
index ed8d51dd42..204cbb46c7 100644
--- a/block.c
+++ b/block.c
@@ -2768,6 +2768,19 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
         flags |= BDRV_O_ALLOW_RDWR;
     }
 
+    if (!bs_entry) {
+        bs_entry = g_new0(BlockReopenQueueEntry, 1);
+        QSIMPLEQ_INSERT_TAIL(bs_queue, bs_entry, entry);
+    } else {
+        QDECREF(bs_entry->state.options);
+        QDECREF(bs_entry->state.explicit_options);
+    }
+
+    bs_entry->state.bs = bs;
+    bs_entry->state.options = options;
+    bs_entry->state.explicit_options = explicit_options;
+    bs_entry->state.flags = flags;
+
     QLIST_FOREACH(child, &bs->children, next) {
         QDict *new_child_options;
         char *child_key_dot;
@@ -2787,19 +2800,6 @@ static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_queue,
                                 child->role, options, flags);
     }
 
-    if (!bs_entry) {
-        bs_entry = g_new0(BlockReopenQueueEntry, 1);
-        QSIMPLEQ_INSERT_TAIL(bs_queue, bs_entry, entry);
-    } else {
-        QDECREF(bs_entry->state.options);
-        QDECREF(bs_entry->state.explicit_options);
-    }
-
-    bs_entry->state.bs = bs;
-    bs_entry->state.options = options;
-    bs_entry->state.explicit_options = explicit_options;
-    bs_entry->state.flags = flags;
-
     return bs_queue;
 }
 
-- 
2.13.5
