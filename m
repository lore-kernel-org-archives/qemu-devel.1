Received: from eggs.gnu.org ([2001:4830:134:3::10]:36147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewJw5-0000Ai-6N
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 23:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewJw4-00079H-Gy
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 23:52:13 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 15 Mar 2018 11:51:57 +0800
Message-Id: <20180315035157.6929-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] block: Fix leak of ignore_children in error
 path
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

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 75a9fd49de..c1fda9fd57 100644
--- a/block.c
+++ b/block.c
@@ -3671,12 +3671,12 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         GSList *ignore_children = g_slist_prepend(NULL, c);
         bdrv_check_update_perm(base, NULL, c->perm, c->shared_perm,
                                ignore_children, &local_err);
+        g_slist_free(ignore_children);
         if (local_err) {
             ret = -EPERM;
             error_report_err(local_err);
             goto exit;
         }
-        g_slist_free(ignore_children);
 
         /* If so, update the backing file path in the image file */
         if (c->role->update_filename) {
-- 
2.14.3
