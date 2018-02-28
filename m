Received: from eggs.gnu.org ([2001:4830:134:3::10]:41608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66j-0004Fp-VH
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1er66j-0004AW-2D
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:05:37 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 28 Feb 2018 19:04:55 +0100
Message-Id: <20180228180507.3964-5-mreitz@redhat.com>
In-Reply-To: <20180228180507.3964-1-mreitz@redhat.com>
References: <20180228180507.3964-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 04/16] block/mirror: Pull out
 mirror_perform()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

When converting mirror's I/O to coroutines, we are going to need a point
where these coroutines are created.  mirror_perform() is going to be
that point.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/mirror.c | 51 +++++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index f5bf620942..d197c8936e 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -82,6 +82,12 @@ typedef struct MirrorOp {
     uint64_t bytes;
 } MirrorOp;
 
+typedef enum MirrorMethod {
+    MIRROR_METHOD_COPY,
+    MIRROR_METHOD_ZERO,
+    MIRROR_METHOD_DISCARD,
+} MirrorMethod;
+
 static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
                                             int error)
 {
@@ -321,6 +327,22 @@ static void mirror_do_zero_or_discard(MirrorBlockJob *s,
     }
 }
 
+static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
+                               unsigned bytes, MirrorMethod mirror_method)
+{
+    switch (mirror_method) {
+    case MIRROR_METHOD_COPY:
+        return mirror_do_read(s, offset, bytes);
+    case MIRROR_METHOD_ZERO:
+    case MIRROR_METHOD_DISCARD:
+        mirror_do_zero_or_discard(s, offset, bytes,
+                                  mirror_method == MIRROR_METHOD_DISCARD);
+        return bytes;
+    default:
+        abort();
+    }
+}
+
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
     BlockDriverState *source = s->source;
@@ -387,11 +409,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         int ret;
         int64_t io_bytes;
         int64_t io_bytes_acct;
-        enum MirrorMethod {
-            MIRROR_METHOD_COPY,
-            MIRROR_METHOD_ZERO,
-            MIRROR_METHOD_DISCARD
-        } mirror_method = MIRROR_METHOD_COPY;
+        MirrorMethod mirror_method = MIRROR_METHOD_COPY;
 
         assert(!(offset % s->granularity));
         ret = bdrv_block_status_above(source, NULL, offset,
@@ -429,22 +447,11 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         }
 
         io_bytes = mirror_clip_bytes(s, offset, io_bytes);
-        switch (mirror_method) {
-        case MIRROR_METHOD_COPY:
-            io_bytes = io_bytes_acct = mirror_do_read(s, offset, io_bytes);
-            break;
-        case MIRROR_METHOD_ZERO:
-        case MIRROR_METHOD_DISCARD:
-            mirror_do_zero_or_discard(s, offset, io_bytes,
-                                      mirror_method == MIRROR_METHOD_DISCARD);
-            if (write_zeroes_ok) {
-                io_bytes_acct = 0;
-            } else {
-                io_bytes_acct = io_bytes;
-            }
-            break;
-        default:
-            abort();
+        io_bytes = mirror_perform(s, offset, io_bytes, mirror_method);
+        if (mirror_method != MIRROR_METHOD_COPY && write_zeroes_ok) {
+            io_bytes_acct = 0;
+        } else {
+            io_bytes_acct = io_bytes;
         }
         assert(io_bytes);
         offset += io_bytes;
@@ -638,7 +645,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
                 continue;
             }
 
-            mirror_do_zero_or_discard(s, offset, bytes, false);
+            mirror_perform(s, offset, bytes, MIRROR_METHOD_ZERO);
             offset += bytes;
         }
 
-- 
2.14.3
