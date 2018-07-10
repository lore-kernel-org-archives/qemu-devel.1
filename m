Received: from eggs.gnu.org ([2001:4830:134:3::10]:44382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcund-0005BJ-Oy
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunc-0001g9-Fr
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:33 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:50 +0200
Message-Id: <20180710154304.18304-11-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 10/24] block/blklogwrites: Make sure the log
 sector size is not too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Ari Sundholm <ari@tuxera.com>

The sector size needs to be large enough to accommodate the data
structures for the log super block and log write entries. This was
previously not properly checked, which made it possible to cause
QEMU to badly misbehave.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blklogwrites.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 63bf6b34a9..efa2c7a66a 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -89,7 +89,10 @@ static inline uint32_t blk_log_writes_log2(uint32_t value)
 
 static inline bool blk_log_writes_sector_size_valid(uint32_t sector_size)
 {
-    return sector_size < (1ull << 24) && is_power_of_2(sector_size);
+    return is_power_of_2(sector_size) &&
+        sector_size >= sizeof(struct log_write_super) &&
+        sector_size >= sizeof(struct log_write_entry) &&
+        sector_size < (1ull << 24);
 }
 
 static uint64_t blk_log_writes_find_cur_log_sector(BdrvChild *log,
-- 
2.13.6
