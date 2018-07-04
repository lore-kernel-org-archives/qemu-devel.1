Received: from eggs.gnu.org ([2001:4830:134:3::10]:43779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1faj3U-0001UH-4K
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ari@tuxera.com>) id 1faj3T-0007jl-9m
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:46:52 -0400
From: Ari Sundholm <ari@tuxera.com>
Date: Wed, 4 Jul 2018 17:46:35 +0300
Message-ID: <1530715597-30975-2-git-send-email-ari@tuxera.com>
In-Reply-To: <1530715597-30975-1-git-send-email-ari@tuxera.com>
References: <1530715597-30975-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/3] block/blklogwrites: Change log_sector_size
 from int64_t to uint64_t
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

This was a simple oversight when working on intermediate versions
of the original patch which introduced blklogwrites.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 block/blklogwrites.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 47093fa..272e11a 100644
--- a/block/blklogwrites.c
+++ b/block/blklogwrites.c
@@ -79,7 +79,7 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     QemuOpts *opts;
     Error *local_err = NULL;
     int ret;
-    int64_t log_sector_size;
+    uint64_t log_sector_size;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
@@ -101,11 +101,9 @@ static int blk_log_writes_open(BlockDriverState *bs, QDict *options, int flags,
     log_sector_size = qemu_opt_get_size(opts, "log-sector-size",
                                         BDRV_SECTOR_SIZE);
 
-    if (log_sector_size < 0 || log_sector_size > (1ull << 23) ||
-        !is_power_of_2(log_sector_size))
-    {
+    if (log_sector_size > (1ull << 23) || !is_power_of_2(log_sector_size)) {
         ret = -EINVAL;
-        error_setg(errp, "Invalid log sector size %"PRId64, log_sector_size);
+        error_setg(errp, "Invalid log sector size %"PRIu64, log_sector_size);
         goto fail;
     }
 
-- 
2.7.4
