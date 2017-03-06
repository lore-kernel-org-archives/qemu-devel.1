Received: from eggs.gnu.org ([2001:4830:134:3::10]:54509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP2-0002S3-EF
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP1-00018V-Hy
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:28 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Mar 2017 17:21:54 +0100
Message-Id: <1488817322-11397-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 02/10] mirror: Fix permission problem with
 'replaces'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The 'replaces' option of drive-mirror can be used to mirror a Quorum
node to a new image and then let the target image replace one of the
Quorum children. In order for this graph modification to succeed, the
mirror job needs to lift its restrictions on the target node first
before actually replacing the child.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 57f26c3..c9185b3 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -509,6 +509,13 @@ static void mirror_exit(BlockJob *job, void *opaque)
      * block_job_completed(). */
     bdrv_ref(src);
     bdrv_ref(mirror_top_bs);
+    bdrv_ref(target_bs);
+
+    /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE before
+     * inserting target_bs at s->to_replace, where we might not be able to get
+     * these permissions. */
+    blk_unref(s->target);
+    s->target = NULL;
 
     /* We don't access the source any more. Dropping any WRITE/RESIZE is
      * required before it could become a backing file of target_bs. */
@@ -555,8 +562,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
         aio_context_release(replace_aio_context);
     }
     g_free(s->replaces);
-    blk_unref(s->target);
-    s->target = NULL;
+    bdrv_unref(target_bs);
 
     /* Remove the mirror filter driver from the graph. Before this, get rid of
      * the blockers on the intermediate nodes so that the resulting state is
-- 
1.8.3.1
