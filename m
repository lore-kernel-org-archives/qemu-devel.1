Received: from eggs.gnu.org ([2001:4830:134:3::10]:58820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zmz-0007Sn-Un
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g8Zmt-0005QY-2B
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 19:45:44 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Sat,  6 Oct 2018 01:39:55 +0200
Message-Id: <20181005234023.8104-4-mreitz@redhat.com>
In-Reply-To: <20181005234023.8104-1-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v11 03/31] block: Skip implicit nodes for
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

bdrv_refresh_filename() should simply skip all implicit nodes.  They are
supposed to be invisible to the user, so they should not appear in
filename information.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/block.c b/block.c
index fd5e18081a..4bbb278659 100644
--- a/block.c
+++ b/block.c
@@ -5237,6 +5237,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
