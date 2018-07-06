Received: from eggs.gnu.org ([2001:4830:134:3::10]:33711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fbPhm-00028n-EI
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:19:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1fbPhl-0007Hc-O2
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 08:19:18 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 6 Jul 2018 15:00:38 +0300
Message-ID: <1530878438-16980-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] block/blklogwrites: Make sure the log sector
 size is not too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ari Sundholm <ari@tuxera.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:blklogwrites" <qemu-block@nongnu.org>

The sector size needs to be large enough to accommodate the data
structures for the log super block and log write entries. This was
previously not properly checked, which made it possible to cause
QEMU to badly misbehave.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/blklogwrites.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 63bf6b3..efa2c7a 100644
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
2.7.4
