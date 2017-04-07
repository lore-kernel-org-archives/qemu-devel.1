Received: from eggs.gnu.org ([2001:4830:134:3::10]:44818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF7-0005n1-7J
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cwUF6-0003Pl-9m
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 09:48:01 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Apr 2017 15:47:39 +0200
Message-Id: <1491572865-8549-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
References: <1491572865-8549-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/10] block/mirror: Fix use-after-free
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

From: Max Reitz <mreitz@redhat.com>

If @bs does not have any parents, the only reference to @mirror_top_bs
will be held by the BlockJob object after the bdrv_unref() following
block_job_create(). However, if block_job_create() fails, this reference
will not exist and @mirror_top_bs will have been deleted when we
goto fail.

The issue comes back at all later entries to the fail label: We delete
the BlockJob object before rolling back our changes to the node graph.
This means that we will delete @mirror_top_bs in the process.

All in all, whenever @bs does not have any parents and we go down the
fail path we will dereference @mirror_top_bs after it has been deleted.

Fix this by invoking bdrv_unref() only when block_job_create() was
successful and by bdrv_ref()'ing @mirror_top_bs in the fail path before
deleting the BlockJob object. Finally, bdrv_unref() it at the end of the
fail path after we actually no longer need it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 9e2fecc..46ecd38 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1150,7 +1150,7 @@ static void mirror_start_job(const char *job_id, Bl=
ockDriverState *bs,
     mirror_top_bs->total_sectors =3D bs->total_sectors;
=20
     /* bdrv_append takes ownership of the mirror_top_bs reference, need =
to keep
-     * it alive until block_job_create() even if bs has no parent. */
+     * it alive until block_job_create() succeeds even if bs has no pare=
nt. */
     bdrv_ref(mirror_top_bs);
     bdrv_drained_begin(bs);
     bdrv_append(mirror_top_bs, bs, &local_err);
@@ -1168,10 +1168,12 @@ static void mirror_start_job(const char *job_id, =
BlockDriverState *bs,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHA=
NGED |
                          BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
                          creation_flags, cb, opaque, errp);
-    bdrv_unref(mirror_top_bs);
     if (!s) {
         goto fail;
     }
+    /* The block job now has a reference to this node */
+    bdrv_unref(mirror_top_bs);
+
     s->source =3D bs;
     s->mirror_top_bs =3D mirror_top_bs;
=20
@@ -1242,6 +1244,10 @@ static void mirror_start_job(const char *job_id, B=
lockDriverState *bs,
=20
 fail:
     if (s) {
+        /* Make sure this BDS does not go away until we have completed t=
he graph
+         * changes below */
+        bdrv_ref(mirror_top_bs);
+
         g_free(s->replaces);
         blk_unref(s->target);
         block_job_unref(&s->common);
@@ -1250,6 +1256,8 @@ fail:
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_a=
bort);
+
+    bdrv_unref(mirror_top_bs);
 }
=20
 void mirror_start(const char *job_id, BlockDriverState *bs,
--=20
1.8.3.1
