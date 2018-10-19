Received: from eggs.gnu.org ([2001:4830:134:3::10]:54659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXv-0007sO-2I
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1gDbXu-0002T0-8J
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 16:38:59 -0400
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 19 Oct 2018 21:39:01 +0100
Message-Id: <1539981546-10596-4-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
References: <1539981546-10596-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v4 3/8] block: Null pointer dereference in
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
 block/block-backend.c | 6 +++++-
 dtc                   | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index dc0cd5772413..e628920f3cd8 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -909,6 +909,7 @@ void *blk_get_attached_dev(BlockBackend *blk)
 char *blk_get_attached_dev_id(BlockBackend *blk)
 {
     DeviceState *dev;
+    char *dev_id;
 
     assert(!blk->legacy_dev);
     dev = blk->dev;
@@ -918,7 +919,10 @@ char *blk_get_attached_dev_id(BlockBackend *blk)
     } else if (dev->id) {
         return g_strdup(dev->id);
     }
-    return object_get_canonical_path(OBJECT(dev));
+
+    dev_id = object_get_canonical_path(OBJECT(dev));
+
+    return dev_id ? dev_id : g_strdup("");
 }
 
 /*
diff --git a/dtc b/dtc
index 88f18909db73..e54388015af1 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit 88f18909db731a627456f26d779445f84e449536
+Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
-- 
1.8.3.1
