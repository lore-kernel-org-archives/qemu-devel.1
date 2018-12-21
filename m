Received: from eggs.gnu.org ([2001:4830:134:3::10]:48893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gaHDi-0008Mq-BQ
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:35:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gaHDh-00074G-Ex
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:35:50 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 21 Dec 2018 04:35:19 -0500
Message-Id: <20181221093529.23855-2-jsnow@redhat.com>
In-Reply-To: <20181221093529.23855-1-jsnow@redhat.com>
References: <20181221093529.23855-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v6 01/11] blockdev: abort transactions in
 reverse order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>

Presently, we abort transactions in the same order they were processed in.
Bitmap commands, though, attempt to restore backup data structures on abort.

That's not valid, they need to be aborted in reverse chronological order.

Replace the QSIMPLEQ data structure with a QTAILQ one, so we can iterate
in reverse for the abort phase of the transaction.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index a6f71f9d83..43e4c22da5 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1339,7 +1339,7 @@ struct BlkActionState {
     const BlkActionOps *ops;
     JobTxn *block_job_txn;
     TransactionProperties *txn_props;
-    QSIMPLEQ_ENTRY(BlkActionState) entry;
+    QTAILQ_ENTRY(BlkActionState) entry;
 };
 
 /* internal snapshot private data */
@@ -2266,8 +2266,8 @@ void qmp_transaction(TransactionActionList *dev_list,
     BlkActionState *state, *next;
     Error *local_err = NULL;
 
-    QSIMPLEQ_HEAD(snap_bdrv_states, BlkActionState) snap_bdrv_states;
-    QSIMPLEQ_INIT(&snap_bdrv_states);
+    QTAILQ_HEAD(snap_bdrv_states, BlkActionState) snap_bdrv_states;
+    QTAILQ_INIT(&snap_bdrv_states);
 
     /* Does this transaction get canceled as a group on failure?
      * If not, we don't really need to make a JobTxn.
@@ -2298,7 +2298,7 @@ void qmp_transaction(TransactionActionList *dev_list,
         state->action = dev_info;
         state->block_job_txn = block_job_txn;
         state->txn_props = props;
-        QSIMPLEQ_INSERT_TAIL(&snap_bdrv_states, state, entry);
+        QTAILQ_INSERT_TAIL(&snap_bdrv_states, state, entry);
 
         state->ops->prepare(state, &local_err);
         if (local_err) {
@@ -2307,7 +2307,7 @@ void qmp_transaction(TransactionActionList *dev_list,
         }
     }
 
-    QSIMPLEQ_FOREACH(state, &snap_bdrv_states, entry) {
+    QTAILQ_FOREACH(state, &snap_bdrv_states, entry) {
         if (state->ops->commit) {
             state->ops->commit(state);
         }
@@ -2318,13 +2318,13 @@ void qmp_transaction(TransactionActionList *dev_list,
 
 delete_and_fail:
     /* failure, and it is all-or-none; roll back all operations */
-    QSIMPLEQ_FOREACH(state, &snap_bdrv_states, entry) {
+    QTAILQ_FOREACH_REVERSE(state, &snap_bdrv_states, snap_bdrv_states, entry) {
         if (state->ops->abort) {
             state->ops->abort(state);
         }
     }
 exit:
-    QSIMPLEQ_FOREACH_SAFE(state, &snap_bdrv_states, entry, next) {
+    QTAILQ_FOREACH_SAFE(state, &snap_bdrv_states, entry, next) {
         if (state->ops->clean) {
             state->ops->clean(state);
         }
-- 
2.17.2
