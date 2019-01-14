Received: from eggs.gnu.org ([209.51.188.92]:57442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54K-0003dU-T1
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54H-0005EK-IZ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:31 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:46 -0600
Message-Id: <20190114162605.5330-2-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 01/20] blockdev: abort transactions in reverse
 order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

Presently, we abort transactions in the same order they were processed in=
.
Bitmap commands, though, attempt to restore backup data structures on abo=
rt.

That's not valid, they need to be aborted in reverse chronological order.

Replace the QSIMPLEQ data structure with a QTAILQ one, so we can iterate
in reverse for the abort phase of the transaction.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181221093529.23855-2-jsnow@redhat.com>
[eblake: rebase]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 1cc893fe617..3d46f8191f5 100644
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
@@ -2266,8 +2266,8 @@ void qmp_transaction(TransactionActionList *dev_lis=
t,
     BlkActionState *state, *next;
     Error *local_err =3D NULL;

-    QSIMPLEQ_HEAD(, BlkActionState) snap_bdrv_states;
-    QSIMPLEQ_INIT(&snap_bdrv_states);
+    QTAILQ_HEAD(, BlkActionState) snap_bdrv_states;
+    QTAILQ_INIT(&snap_bdrv_states);

     /* Does this transaction get canceled as a group on failure?
      * If not, we don't really need to make a JobTxn.
@@ -2298,7 +2298,7 @@ void qmp_transaction(TransactionActionList *dev_lis=
t,
         state->action =3D dev_info;
         state->block_job_txn =3D block_job_txn;
         state->txn_props =3D props;
-        QSIMPLEQ_INSERT_TAIL(&snap_bdrv_states, state, entry);
+        QTAILQ_INSERT_TAIL(&snap_bdrv_states, state, entry);

         state->ops->prepare(state, &local_err);
         if (local_err) {
@@ -2307,7 +2307,7 @@ void qmp_transaction(TransactionActionList *dev_lis=
t,
         }
     }

-    QSIMPLEQ_FOREACH(state, &snap_bdrv_states, entry) {
+    QTAILQ_FOREACH(state, &snap_bdrv_states, entry) {
         if (state->ops->commit) {
             state->ops->commit(state);
         }
@@ -2318,13 +2318,13 @@ void qmp_transaction(TransactionActionList *dev_l=
ist,

 delete_and_fail:
     /* failure, and it is all-or-none; roll back all operations */
-    QSIMPLEQ_FOREACH(state, &snap_bdrv_states, entry) {
+    QTAILQ_FOREACH_REVERSE(state, &snap_bdrv_states, entry) {
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
--=20
2.20.1
