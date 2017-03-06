Received: from eggs.gnu.org ([2001:4830:134:3::10]:54546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP4-0002U1-FD
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ckvP3-0001A0-HR
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 11:22:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  6 Mar 2017 17:21:55 +0100
Message-Id: <1488817322-11397-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 03/10] mirror: Fix permissions for removing
 mirror_top_bs
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

mirror_top_bs takes write permissions on its backing file, which can
make it impossible to attach that backing file node to another parent.
However, this is exactly what needs to be done in order to remove
mirror_top_bs from the backing chain. So give up the write permission
first.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/mirror.c b/block/mirror.c
index c9185b3..001b5f0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -566,8 +566,10 @@ static void mirror_exit(BlockJob *job, void *opaque)
 
     /* Remove the mirror filter driver from the graph. Before this, get rid of
      * the blockers on the intermediate nodes so that the resulting state is
-     * valid. */
+     * valid. Also give up permissions on mirror_top_bs->backing, which might
+     * block the removal. */
     block_job_remove_all_bdrv(job);
+    bdrv_child_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL);
     bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top_bs));
 
     /* We just changed the BDS the job BB refers to (with either or both of the
@@ -1234,6 +1236,7 @@ fail:
         block_job_unref(&s->common);
     }
 
+    bdrv_child_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL);
     bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top_bs));
 }
 
-- 
1.8.3.1
