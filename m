Received: from eggs.gnu.org ([2001:4830:134:3::10]:43052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHFA-0002eq-2h
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHF9-0002zr-Ec
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:50 +0100
Message-Id: <1488901251-16214-27-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
References: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/27] block: Don't use error_abort in
 blk_new_open
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

From: Fam Zheng <famz@redhat.com>

We have an errp and bdrv_root_attach_child can fail permission check,
error_abort is not the best choice here.

Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/block-backend.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index daa7908..5742c09 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -213,7 +213,12 @@ BlockBackend *blk_new_open(const char *filename, const char *reference,
     }
 
     blk->root = bdrv_root_attach_child(bs, "root", &child_root,
-                                       perm, BLK_PERM_ALL, blk, &error_abort);
+                                       perm, BLK_PERM_ALL, blk, errp);
+    if (!blk->root) {
+        bdrv_unref(bs);
+        blk_unref(blk);
+        return NULL;
+    }
 
     return blk;
 }
-- 
1.8.3.1
