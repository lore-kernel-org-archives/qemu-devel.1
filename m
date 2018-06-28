Received: from eggs.gnu.org ([2001:4830:134:3::10]:57477)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTc-0004M5-8B
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:07:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fYKTb-0003kL-Dr
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 20:07:56 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu, 28 Jun 2018 02:07:17 +0200
Message-Id: <20180628000745.4477-4-mreitz@redhat.com>
In-Reply-To: <20180628000745.4477-1-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v9 03/31] block: Skip implicit nodes for
 filename info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

bdrv_refresh_filename() should simply skip all implicit nodes.  They are
supposed to be invisible to the user, so they should not appear in
filename information.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block.c b/block.c
index 52247062d5..3b07060385 100644
--- a/block.c
+++ b/block.c
@@ -5187,6 +5187,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
         bdrv_refresh_filename(child->bs);
     }
 
+    if (bs->implicit) {
+        /* For implicit nodes, just copy everything from the single child */
+        child = QLIST_FIRST(&bs->children);
+        assert(QLIST_NEXT(child, next) == NULL);
+
+        pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
+                child->bs->exact_filename);
+        pstrcpy(bs->filename, sizeof(bs->filename), child->bs->filename);
+
+        bs->full_open_options = qobject_ref(child->bs->full_open_options);
+
+        return;
+    }
+
     if (drv->bdrv_refresh_filename) {
         /* Obsolete information is of no use here, so drop the old file name
          * information before refreshing it */
-- 
2.17.1
