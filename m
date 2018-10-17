Received: from eggs.gnu.org ([2001:4830:134:3::10]:52334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPL-0005IC-7W
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gClPH-0006Yq-8W
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:58:39 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed, 17 Oct 2018 15:57:22 +0300
Message-Id: <06146e6783e39fe6a3a5a4e18d379abf01216fb0.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
In-Reply-To: <cover.1539780785.git.berto@igalia.com>
References: <cover.1539780785.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v2 06/14] block: Use
 bdrv_reopen_set_read_only() in stream_start/complete()
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
 block/stream.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 81a7ec8ece..262d280ccd 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -34,7 +34,7 @@ typedef struct StreamBlockJob {
     BlockDriverState *base;
     BlockdevOnError on_error;
     char *backing_file_str;
-    int bs_flags;
+    bool bs_read_only;
 } StreamBlockJob;
 
 static int coroutine_fn stream_populate(BlockBackend *blk,
@@ -89,10 +89,10 @@ static void stream_clean(Job *job)
     BlockDriverState *bs = blk_bs(bjob->blk);
 
     /* Reopen the image back in read-only mode if necessary */
-    if (s->bs_flags != bdrv_get_flags(bs)) {
+    if (s->bs_read_only) {
         /* Give up write permissions before making it read-only */
         blk_set_perm(bjob->blk, 0, BLK_PERM_ALL, &error_abort);
-        bdrv_reopen(bs, s->bs_flags, NULL);
+        bdrv_reopen_set_read_only(bs, true, NULL);
     }
 
     g_free(s->backing_file_str);
@@ -226,12 +226,12 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 {
     StreamBlockJob *s;
     BlockDriverState *iter;
-    int orig_bs_flags;
+    int bs_read_only;
 
     /* Make sure that the image is opened in read-write mode */
-    orig_bs_flags = bdrv_get_flags(bs);
-    if (!(orig_bs_flags & BDRV_O_RDWR)) {
-        if (bdrv_reopen(bs, orig_bs_flags | BDRV_O_RDWR, errp) != 0) {
+    bs_read_only = bdrv_is_read_only(bs);
+    if (bs_read_only) {
+        if (bdrv_reopen_set_read_only(bs, false, errp) != 0) {
             return;
         }
     }
@@ -261,7 +261,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
 
     s->base = base;
     s->backing_file_str = g_strdup(backing_file_str);
-    s->bs_flags = orig_bs_flags;
+    s->bs_read_only = bs_read_only;
 
     s->on_error = on_error;
     trace_stream_start(bs, base, s);
@@ -269,7 +269,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     return;
 
 fail:
-    if (orig_bs_flags != bdrv_get_flags(bs)) {
-        bdrv_reopen(bs, orig_bs_flags, NULL);
+    if (bs_read_only) {
+        bdrv_reopen_set_read_only(bs, true, NULL);
     }
 }
-- 
2.11.0
