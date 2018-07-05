Received: from eggs.gnu.org ([2001:4830:134:3::10]:58475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T1-0006zU-GF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fb1T0-0004vr-Fe
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:26:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  5 Jul 2018 12:26:00 +0200
Message-Id: <20180705102604.4986-9-kwolf@redhat.com>
In-Reply-To: <20180705102604.4986-1-kwolf@redhat.com>
References: <20180705102604.4986-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/12] block/blklogwrites: Change
 log_sector_size from int64_t to uint64_t
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

This was a simple oversight when working on intermediate versions
of the original patch which introduced blklogwrites.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/blklogwrites.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/block/blklogwrites.c b/block/blklogwrites.c
index 47093fadd6..272e11a021 100644
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
2.13.6
