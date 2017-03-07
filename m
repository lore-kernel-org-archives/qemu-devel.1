Received: from eggs.gnu.org ([2001:4830:134:3::10]:51219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCxs-0000zG-JW
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:07:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1clCxr-0006kH-Rs
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 06:07:36 -0500
From: Fam Zheng <famz@redhat.com>
Date: Tue,  7 Mar 2017 19:07:21 +0800
Message-Id: <20170307110722.12583-2-famz@redhat.com>
In-Reply-To: <20170307110722.12583-1-famz@redhat.com>
References: <20170307110722.12583-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] block: Don't use error_abort in
 blk_new_open
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

We have an errp and bdrv_root_attach_child can fail permission check,
error_abort is not the best choice here.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
2.9.3
