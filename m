Received: from eggs.gnu.org ([2001:4830:134:3::10]:37897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXs-0004v0-D2
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dSrXn-0002f8-HV
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 17:09:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed,  5 Jul 2017 16:08:28 -0500
Message-Id: <20170705210842.960-8-eblake@redhat.com>
In-Reply-To: <20170705210842.960-1-eblake@redhat.com>
References: <20170705210842.960-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 07/21] commit: Switch commit_run() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, jcody@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Change the internal
loop iteration of committing to track by bytes instead of sectors
(although we are still guaranteed that we iterate by steps that
are sector-aligned).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

---
v2: no change
---
 block/commit.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index 6f67d78..c3a7bca 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -143,17 +143,16 @@ static void coroutine_fn commit_run(void *opaque)
 {
     CommitBlockJob *s = opaque;
     CommitCompleteData *data;
-    int64_t sector_num, end;
+    int64_t offset;
     uint64_t delay_ns = 0;
     int ret = 0;
-    int n = 0;
+    int n = 0; /* sectors */
     void *buf = NULL;
     int bytes_written = 0;
     int64_t base_len;

     ret = s->common.len = blk_getlength(s->top);

-
     if (s->common.len < 0) {
         goto out;
     }
@@ -170,10 +169,9 @@ static void coroutine_fn commit_run(void *opaque)
         }
     }

-    end = s->common.len >> BDRV_SECTOR_BITS;
     buf = blk_blockalign(s->top, COMMIT_BUFFER_SIZE);

-    for (sector_num = 0; sector_num < end; sector_num += n) {
+    for (offset = 0; offset < s->common.len; offset += n * BDRV_SECTOR_SIZE) {
         bool copy;

         /* Note that even when no rate limit is applied we need to yield
@@ -185,15 +183,13 @@ static void coroutine_fn commit_run(void *opaque)
         }
         /* Copy if allocated above the base */
         ret = bdrv_is_allocated_above(blk_bs(s->top), blk_bs(s->base),
-                                      sector_num,
+                                      offset / BDRV_SECTOR_SIZE,
                                       COMMIT_BUFFER_SIZE / BDRV_SECTOR_SIZE,
                                       &n);
         copy = (ret == 1);
-        trace_commit_one_iteration(s, sector_num * BDRV_SECTOR_SIZE,
-                                   n * BDRV_SECTOR_SIZE, ret);
+        trace_commit_one_iteration(s, offset, n * BDRV_SECTOR_SIZE, ret);
         if (copy) {
-            ret = commit_populate(s->top, s->base,
-                                  sector_num * BDRV_SECTOR_SIZE,
+            ret = commit_populate(s->top, s->base, offset,
                                   n * BDRV_SECTOR_SIZE, buf);
             bytes_written += n * BDRV_SECTOR_SIZE;
         }
-- 
2.9.4
