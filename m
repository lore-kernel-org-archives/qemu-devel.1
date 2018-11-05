Received: from eggs.gnu.org ([2001:4830:134:3::10]:36222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gJmaP-0007IB-M5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:39:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gJmaK-0003FZ-W5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 16:39:04 -0500
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Mon,  5 Nov 2018 21:38:36 +0000
Message-Id: <1541453919-25973-3-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
References: <1541453919-25973-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v5 2/5] block: Null pointer dereference in
 blk_root_get_parent_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, berrange@redhat.com, mreitz@redhat.com

The dev_id returned by the call to blk_get_attached_dev_id() in
blk_root_get_parent_desc() can be NULL (an internal call to
object_get_canonical_path may have returned NULL).

Instead of just checking this case before before dereferencing,
adjust blk_get_attached_dev_id() to return the empty string if no
object path can be found (similar to the case when blk->dev is NULL
and an empty string is returned).

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
---
 block/block-backend.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index dc0cd5772413..a2061a565024 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -918,7 +918,8 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
     } else if (dev->id) {
         return g_strdup(dev->id);
     }
-    return object_get_canonical_path(OBJECT(dev));
+
+    return object_get_canonical_path(OBJECT(dev)) ?: g_strdup("");
 }
 
 /*
-- 
1.8.3.1
