Received: from eggs.gnu.org ([2001:4830:134:3::10]:52593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPe-0005cO-6A
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPc-0007ol-Va
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:57 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:28 +0300
Message-Id: <0e1d74777717cac492cd68bc88cf4ec29936e403.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 12/14] block: Clean up reopen_backing_file()
 in block/replication.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

This function is used to put the hidden and secondary disks in
read-write mode before launching the backup job, and back in read-only
mode afterwards.

This patch does the following changes:

  - Use an options QDict with the "read-only" option instead of
    passing the changes as flags only.

  - Simplify the code (it was unnecessarily complicated and verbose).

  - Fix a bug due to which the secondary disk was not being put back
    in read-only mode when writable=false (because in this case
    orig_secondary_flags always had the BDRV_O_RDWR flag set).

  - Stop clearing the BDRV_O_INACTIVE flag.

The flags parameter to bdrv_reopen_queue() becomes redundant and we'll
be able to get rid of it in a subsequent patch.

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/replication.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 6349d6958e..481a225924 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -20,6 +20,7 @@
 #include "block/block_backup.h"
 #include "sysemu/block-backend.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qdict.h"
 #include "replication.h"
 
 typedef enum {
@@ -39,8 +40,8 @@ typedef struct BDRVReplicationState {
     char *top_id;
     ReplicationState *rs;
     Error *blocker;
-    int orig_hidden_flags;
-    int orig_secondary_flags;
+    bool orig_hidden_read_only;
+    bool orig_secondary_read_only;
     int error;
 } BDRVReplicationState;
 
@@ -371,44 +372,40 @@ static void secondary_do_checkpoint(BDRVReplicationState *s, Error **errp)
     }
 }
 
+/* This function is supposed to be called twice:
+ * first with writable = true, then with writable = false.
+ * The first call puts s->hidden_disk and s->secondary_disk in
+ * r/w mode, and the second puts them back in their original state.
+ */
 static void reopen_backing_file(BlockDriverState *bs, bool writable,
                                 Error **errp)
 {
     BDRVReplicationState *s = bs->opaque;
     BlockReopenQueue *reopen_queue = NULL;
-    int orig_hidden_flags, orig_secondary_flags;
-    int new_hidden_flags, new_secondary_flags;
     Error *local_err = NULL;
 
     if (writable) {
-        orig_hidden_flags = s->orig_hidden_flags =
-                                bdrv_get_flags(s->hidden_disk->bs);
-        new_hidden_flags = (orig_hidden_flags | BDRV_O_RDWR) &
-                                                    ~BDRV_O_INACTIVE;
-        orig_secondary_flags = s->orig_secondary_flags =
-                                bdrv_get_flags(s->secondary_disk->bs);
-        new_secondary_flags = (orig_secondary_flags | BDRV_O_RDWR) &
-                                                     ~BDRV_O_INACTIVE;
-    } else {
-        orig_hidden_flags = (s->orig_hidden_flags | BDRV_O_RDWR) &
-                                                    ~BDRV_O_INACTIVE;
-        new_hidden_flags = s->orig_hidden_flags;
-        orig_secondary_flags = (s->orig_secondary_flags | BDRV_O_RDWR) &
-                                                    ~BDRV_O_INACTIVE;
-        new_secondary_flags = s->orig_secondary_flags;
+        s->orig_hidden_read_only = bdrv_is_read_only(s->hidden_disk->bs);
+        s->orig_secondary_read_only = bdrv_is_read_only(s->secondary_disk->bs);
     }
 
     bdrv_subtree_drained_begin(s->hidden_disk->bs);
     bdrv_subtree_drained_begin(s->secondary_disk->bs);
 
-    if (orig_hidden_flags != new_hidden_flags) {
-        reopen_queue = bdrv_reopen_queue(reopen_queue, s->hidden_disk->bs, NULL,
-                                         new_hidden_flags);
+    if (s->orig_hidden_read_only) {
+        int flags = bdrv_get_flags(s->hidden_disk->bs);
+        QDict *opts = qdict_new();
+        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
+        reopen_queue = bdrv_reopen_queue(reopen_queue, s->hidden_disk->bs,
+                                         opts, flags);
     }
 
-    if (!(orig_secondary_flags & BDRV_O_RDWR)) {
+    if (s->orig_secondary_read_only) {
+        int flags = bdrv_get_flags(s->secondary_disk->bs);
+        QDict *opts = qdict_new();
+        qdict_put_bool(opts, BDRV_OPT_READ_ONLY, !writable);
         reopen_queue = bdrv_reopen_queue(reopen_queue, s->secondary_disk->bs,
-                                         NULL, new_secondary_flags);
+                                         opts, flags);
     }
 
     if (reopen_queue) {
-- 
2.11.0
