Received: from eggs.gnu.org ([2001:4830:134:3::10]:52335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005ID-7Y
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006Y0-3a
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:21 +0300
Message-Id: <c36f5e05c0db570f273df8ab39deb9cf9e269398.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 05/14] block: Use
 bdrv_reopen_set_read_only() in bdrv_commit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch replaces the bdrv_reopen() calls that set and remove the
BDRV_O_RDWR flag with the new bdrv_reopen_set_read_only() function.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/commit.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index a53c2d04b0..53148e610b 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -391,7 +391,7 @@ int bdrv_commit(BlockDriverState *bs)
     BlockDriverState *commit_top_bs = NULL;
     BlockDriver *drv = bs->drv;
     int64_t offset, length, backing_length;
-    int ro, open_flags;
+    int ro;
     int64_t n;
     int ret = 0;
     uint8_t *buf = NULL;
@@ -410,10 +410,9 @@ int bdrv_commit(BlockDriverState *bs)
     }
 
     ro = bs->backing->bs->read_only;
-    open_flags =  bs->backing->bs->open_flags;
 
     if (ro) {
-        if (bdrv_reopen(bs->backing->bs, open_flags | BDRV_O_RDWR, NULL)) {
+        if (bdrv_reopen_set_read_only(bs->backing->bs, false, NULL)) {
             return -EACCES;
         }
     }
@@ -523,7 +522,7 @@ ro_cleanup:
 
     if (ro) {
         /* ignoring error return here */
-        bdrv_reopen(bs->backing->bs, open_flags & ~BDRV_O_RDWR, NULL);
+        bdrv_reopen_set_read_only(bs->backing->bs, true, NULL);
     }
 
     return ret;
-- 
2.11.0
