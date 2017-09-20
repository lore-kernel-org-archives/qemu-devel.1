Received: from eggs.gnu.org ([2001:4830:134:3::10]:41757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAW-00024b-Qe
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dufAS-00011k-Sx
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:36:00 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Wed, 20 Sep 2017 14:43:09 +0300
Message-Id: <20170920114310.13080-2-el13635@mail.ntua.gr>
In-Reply-To: <20170920114310.13080-1-el13635@mail.ntua.gr>
References: <20170920114310.13080-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 1/2] block/block-backend.c: add
 blk_check_byte_request call to blk_pread/blk_pwrite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>

blk_check_byte_request() is called from the blk_co_pwritev/blk_co_preadv to
check if the request offset and request bytes parameters are valid for the
given Blockbackend. Let's do that in blk_pread/blk_pwrite too.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block/block-backend.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 45d9101be3..110a52d5b1 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1288,22 +1288,23 @@ BlockAIOCB *blk_aio_pwrite_zeroes(BlockBackend *blk, int64_t offset,
 
 int blk_pread(BlockBackend *blk, int64_t offset, void *buf, int count)
 {
-    int ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
+    int ret = blk_check_byte_request(blk, offset, count);
     if (ret < 0) {
         return ret;
     }
-    return count;
+    ret = blk_prw(blk, offset, buf, count, blk_read_entry, 0);
+    return ret < 0 ? ret : count;
 }
 
 int blk_pwrite(BlockBackend *blk, int64_t offset, const void *buf, int count,
                BdrvRequestFlags flags)
 {
-    int ret = blk_prw(blk, offset, (void *) buf, count, blk_write_entry,
-                      flags);
+    int ret = blk_check_byte_request(blk, offset, count);
     if (ret < 0) {
         return ret;
     }
-    return count;
+    ret = blk_prw(blk, offset, (void *) buf, count, blk_write_entry, flags);
+    return ret < 0 ? ret : count;
 }
 
 int64_t blk_getlength(BlockBackend *blk)
-- 
2.11.0
