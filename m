Received: from eggs.gnu.org ([2001:4830:134:3::10]:51393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncEo-0008Bw-IK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cncEn-0003t8-Cy
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 22:31:02 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 10:30:50 +0800
Message-Id: <20170314023050.32756-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Always call bdrv_child_check_perm first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

bdrv_child_set_perm alone is not very usable because the caller must
call bdrv_child_check_perm first. This is already encapsulated
conveniently in bdrv_child_try_set_perm, so remove the other prototypes
from the header and fix the one wrong caller, block/mirror.c.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c                   | 13 +++++++++----
 block/mirror.c            |  6 ++++--
 include/block/block_int.h |  4 ----
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index cb57370..a77e8a0 100644
--- a/block.c
+++ b/block.c
@@ -1393,6 +1393,11 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     return 0;
 }
 
+static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                                 GSList *ignore_children, Error **errp);
+static void bdrv_child_abort_perm_update(BdrvChild *c);
+static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
+
 /*
  * Check whether permissions on this node can be changed in a way that
  * @cumulative_perms and @cumulative_shared_perms are the new cumulative
@@ -1615,8 +1620,8 @@ static int bdrv_check_update_perm(BlockDriverState *bs, uint64_t new_used_perm,
 
 /* Needs to be followed by a call to either bdrv_child_set_perm() or
  * bdrv_child_abort_perm_update(). */
-int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
-                          GSList *ignore_children, Error **errp)
+static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
+                                 GSList *ignore_children, Error **errp)
 {
     int ret;
 
@@ -1627,7 +1632,7 @@ int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
     return ret;
 }
 
-void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
+static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
 {
     uint64_t cumulative_perms, cumulative_shared_perms;
 
@@ -1639,7 +1644,7 @@ void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared)
     bdrv_set_perm(c->bs, cumulative_perms, cumulative_shared_perms);
 }
 
-void bdrv_child_abort_perm_update(BdrvChild *c)
+static void bdrv_child_abort_perm_update(BdrvChild *c)
 {
     bdrv_abort_perm_update(c->bs);
 }
diff --git a/block/mirror.c b/block/mirror.c
index 4f3a5cb..ca4baa5 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -574,7 +574,8 @@ static void mirror_exit(BlockJob *job, void *opaque)
      * valid. Also give up permissions on mirror_top_bs->backing, which might
      * block the removal. */
     block_job_remove_all_bdrv(job);
-    bdrv_child_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL);
+    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
+                            &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
 
     /* We just changed the BDS the job BB refers to (with either or both of the
@@ -1245,7 +1246,8 @@ fail:
         block_job_unref(&s->common);
     }
 
-    bdrv_child_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL);
+    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
+                            &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
 }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 6c699ac..59400bd 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -889,10 +889,6 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
                                   void *opaque, Error **errp);
 void bdrv_root_unref_child(BdrvChild *child);
 
-int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
-                          GSList *ignore_children, Error **errp);
-void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
-void bdrv_child_abort_perm_update(BdrvChild *c);
 int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
                             Error **errp);
 
-- 
2.9.3
