Received: from eggs.gnu.org ([2001:4830:134:3::10]:52282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1i-0002v9-2x
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ele1h-0005K1-8t
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 12:05:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Feb 2018 18:04:49 +0100
Message-Id: <20180213170529.10858-16-kwolf@redhat.com>
In-Reply-To: <20180213170529.10858-1-kwolf@redhat.com>
References: <20180213170529.10858-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 15/55] sheepdog: Allow fully preallocated
 truncation
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/sheepdog.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/sheepdog.c b/block/sheepdog.c
index d300fb69c0..ac02b10fe0 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2180,15 +2180,16 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset,
     int ret, fd;
     unsigned int datalen;
     uint64_t max_vdi_size;
+    int64_t old_size = s->inode.vdi_size;
 
-    if (prealloc != PREALLOC_MODE_OFF) {
+    if (prealloc != PREALLOC_MODE_OFF && prealloc != PREALLOC_MODE_FULL) {
         error_setg(errp, "Unsupported preallocation mode '%s'",
                    PreallocMode_str(prealloc));
         return -ENOTSUP;
     }
 
     max_vdi_size = (UINT64_C(1) << s->inode.block_size_shift) * MAX_DATA_OBJS;
-    if (offset < s->inode.vdi_size) {
+    if (offset < old_size) {
         error_setg(errp, "shrinking is not supported");
         return -EINVAL;
     } else if (offset > max_vdi_size) {
@@ -2211,9 +2212,17 @@ static int sd_truncate(BlockDriverState *bs, int64_t offset,
 
     if (ret < 0) {
         error_setg_errno(errp, -ret, "failed to update an inode");
+        return ret;
     }
 
-    return ret;
+    if (prealloc == PREALLOC_MODE_FULL) {
+        ret = sd_prealloc(bs, old_size, offset, errp);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
+    return 0;
 }
 
 /*
-- 
2.13.6
