Received: from eggs.gnu.org ([209.51.188.92]:59362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O9V-0003FI-VB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:51:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h3O8G-0007dg-6e
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:50:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 11 Mar 2019 17:50:11 +0100
Message-Id: <20190311165017.32247-5-kwolf@redhat.com>
In-Reply-To: <20190311165017.32247-1-kwolf@redhat.com>
References: <20190311165017.32247-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/10] block: Make permission changes in
 reopen less wrong
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, berto@igalia.com, qemu-devel@nongnu.org

The way that reopen interacts with permission changes has one big
problem: Both operations are recursive, and the permissions are changes
for each node in the reopen queue.

For a simple graph that consists just of parent and child,
.bdrv_check_perm will be called twice for the child, once recursively
when adjusting the permissions of parent, and once again when the child
itself is reopened.

Even worse, the first .bdrv_check_perm call happens before
.bdrv_reopen_prepare was called for the child and the second one is
called afterwards.

Making sure that .bdrv_check_perm (and the other permission callbacks)
are called only once is hard. We can cope with multiple calls right now,
but as soon as file-posix gets a dynamic auto-read-only that may need to
open a new file descriptor, we get the additional requirement that all
of them are after the .bdrv_reopen_prepare call.

So reorder things in bdrv_reopen_multiple() to first call
.bdrv_reopen_prepare for all involved nodes and only then adjust
permissions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/block.c b/block.c
index e18bd5eefd..9b9d25e843 100644
--- a/block.c
+++ b/block.c
@@ -1698,6 +1698,7 @@ static void bdrv_child_set_perm(BdrvChild *c, uint6=
4_t perm, uint64_t shared);
=20
 typedef struct BlockReopenQueueEntry {
      bool prepared;
+     bool perms_checked;
      BDRVReopenState state;
      QSIMPLEQ_ENTRY(BlockReopenQueueEntry) entry;
 } BlockReopenQueueEntry;
@@ -3166,6 +3167,16 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReo=
penQueue *bs_queue, Error **er
         bs_entry->prepared =3D true;
     }
=20
+    QSIMPLEQ_FOREACH(bs_entry, bs_queue, entry) {
+        BDRVReopenState *state =3D &bs_entry->state;
+        ret =3D bdrv_check_perm(state->bs, bs_queue, state->perm,
+                              state->shared_perm, NULL, errp);
+        if (ret < 0) {
+            goto cleanup_perm;
+        }
+        bs_entry->perms_checked =3D true;
+    }
+
     /* If we reach this point, we have success and just need to apply th=
e
      * changes
      */
@@ -3174,7 +3185,20 @@ int bdrv_reopen_multiple(AioContext *ctx, BlockReo=
penQueue *bs_queue, Error **er
     }
=20
     ret =3D 0;
+cleanup_perm:
+    QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
+        BDRVReopenState *state =3D &bs_entry->state;
+
+        if (!bs_entry->perms_checked) {
+            continue;
+        }
=20
+        if (ret =3D=3D 0) {
+            bdrv_set_perm(state->bs, state->perm, state->shared_perm);
+        } else {
+            bdrv_abort_perm_update(state->bs);
+        }
+    }
 cleanup:
     QSIMPLEQ_FOREACH_SAFE(bs_entry, bs_queue, entry, next) {
         if (ret) {
@@ -3428,12 +3452,6 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_st=
ate, BlockReopenQueue *queue,
         } while ((entry =3D qdict_next(reopen_state->options, entry)));
     }
=20
-    ret =3D bdrv_check_perm(reopen_state->bs, queue, reopen_state->perm,
-                          reopen_state->shared_perm, NULL, errp);
-    if (ret < 0) {
-        goto error;
-    }
-
     ret =3D 0;
=20
     /* Restore the original reopen_state->options QDict */
@@ -3500,9 +3518,6 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_sta=
te)
=20
     bdrv_refresh_limits(bs, NULL);
=20
-    bdrv_set_perm(reopen_state->bs, reopen_state->perm,
-                  reopen_state->shared_perm);
-
     new_can_write =3D
         !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTIVE=
);
     if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw) =
{
@@ -3534,8 +3549,6 @@ void bdrv_reopen_abort(BDRVReopenState *reopen_stat=
e)
     if (drv->bdrv_reopen_abort) {
         drv->bdrv_reopen_abort(reopen_state);
     }
-
-    bdrv_abort_perm_update(reopen_state->bs);
 }
=20
=20
--=20
2.20.1
