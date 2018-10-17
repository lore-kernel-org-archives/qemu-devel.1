Received: from eggs.gnu.org ([2001:4830:134:3::10]:52333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005IB-7C
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006Wx-0j
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:19 +0300
Message-Id: <0d146a1d1c037c74e9d137d5147ff8ccf679e4a1.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 03/14] block: Use
 bdrv_reopen_set_read_only() in bdrv_backing_update_filename()
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
 block.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 40c3a3d30b..39d40f4556 100644
--- a/block.c
+++ b/block.c
@@ -1058,11 +1058,11 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
                                         const char *filename, Error **errp)
 {
     BlockDriverState *parent = c->opaque;
-    int orig_flags = bdrv_get_flags(parent);
+    bool read_only = bdrv_is_read_only(parent);
     int ret;
 
-    if (!(orig_flags & BDRV_O_RDWR)) {
-        ret = bdrv_reopen(parent, orig_flags | BDRV_O_RDWR, errp);
+    if (read_only) {
+        ret = bdrv_reopen_set_read_only(parent, false, errp);
         if (ret < 0) {
             return ret;
         }
@@ -1074,8 +1074,8 @@ static int bdrv_backing_update_filename(BdrvChild *c, BlockDriverState *base,
         error_setg_errno(errp, -ret, "Could not update backing file link");
     }
 
-    if (!(orig_flags & BDRV_O_RDWR)) {
-        bdrv_reopen(parent, orig_flags, NULL);
+    if (read_only) {
+        bdrv_reopen_set_read_only(parent, true, NULL);
     }
 
     return ret;
-- 
2.11.0
