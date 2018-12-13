Received: from eggs.gnu.org ([2001:4830:134:3::10]:42421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG97-0002N4-Qm
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gXG92-0001Fi-4Z
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 20:50:34 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 12 Dec 2018 20:50:07 -0500
Message-Id: <20181213015013.15350-2-jsnow@redhat.com>
In-Reply-To: <20181213015013.15350-1-jsnow@redhat.com>
References: <20181213015013.15350-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/7] blockdev: abort transactions in reverse
 order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>

Presently, we abort transactions in the same order they were processed in.
Bitmap commands, though, attempt to restore backup data structures on abort.
To that end, though, they need to be aborted in reverse chronological order.

Replace the QSIMPLEQ data structure with a QTAILQ one, so we can iterate
in reverse for the abort phase of the transaction.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 blockdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 81f95d920b..1ba706df8b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1341,7 +1341,7 @@ struct BlkActionState {
     const BlkActionOps *ops;
     JobTxn *block_job_txn;
     TransactionProperties *txn_props;
-    QSIMPLEQ_ENTRY(BlkActionState) entry;
+    QTAILQ_ENTRY(BlkActionState) entry;
 };
 
 /* internal snapshot private data */
@@ -2269,8 +2269,8 @@ void qmp_transaction(TransactionActionList *dev_list,
     BlkActionState *state, *next;
     Error *local_err = NULL;
 
-    QSIMPLEQ_HEAD(snap_bdrv_states, BlkActionState) snap_bdrv_states;
-    QSIMPLEQ_INIT(&snap_bdrv_states);
+    QTAILQ_HEAD(snap_bdrv_states, BlkActionState) snap_bdrv_states;
+    QTAILQ_INIT(&snap_bdrv_states);
 
     /* Does this transaction get canceled as a group on failure?
      * If not, we don't really need to make a JobTxn.
@@ -2301,7 +2301,7 @@ void qmp_transaction(TransactionActionList *dev_list,
         state->action = dev_info;
         state->block_job_txn = block_job_txn;
         state->txn_props = props;
-        QSIMPLEQ_INSERT_TAIL(&snap_bdrv_states, state, entry);
+        QTAILQ_INSERT_TAIL(&snap_bdrv_states, state, entry);
 
         state->ops->prepare(state, &local_err);
         if (local_err) {
@@ -2310,7 +2310,7 @@ void qmp_transaction(TransactionActionList *dev_list,
         }
     }
 
-    QSIMPLEQ_FOREACH(state, &snap_bdrv_states, entry) {
+    QTAILQ_FOREACH(state, &snap_bdrv_states, entry) {
         if (state->ops->commit) {
             state->ops->commit(state);
         }
@@ -2321,13 +2321,13 @@ void qmp_transaction(TransactionActionList *dev_list,
 
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
