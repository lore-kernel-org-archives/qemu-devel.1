Received: from eggs.gnu.org ([2001:4830:134:3::10]:53141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2T9-0003VE-UI
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2T6-00082W-Lv
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:31 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:54 +0200
Message-Id: <20180813022006.7216-6-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 05/17] mirror: Remove bytes_handled, part 2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, Fam Zheng <famz@redhat.com>

Remove mirror_perform()'s return value, instead aligning the @offset and
@bytes it receives.  We needed the return value for two reasons:

(1) So that "offset += io_bytes" would result in an aligned offset, and
(2) so that io_bytes_acct is kind of aligned (the tail is aligned, but
    the head is not).

(2) does not make sense.  If we want to account for the bytes we have to
copy, we should not have used the returned io_bytes as the basis but its
original value before the mirror_perform() call.  If we want to account
for the bytes we have actually copied, we should not disregard the
potential alignment head, but bytes_handled only includes the tail, so
that was wrong, too.
Let's go for the fully aligned value (the number of bytes actually
copied), because apparently we do want some alignment (or we would have
just added io_bytes before this patch instead of bytes_handled).

(1) can be achieved by simply letting mirror_perform() return the
aligned values to its callers, which is what this patch does.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 56 +++++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 3234b8b687..f05404e557 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -89,7 +89,7 @@ struct MirrorOp {
     MirrorBlockJob *s;
     QEMUIOVector qiov;
     int64_t offset;
-    uint64_t bytes;
+    int64_t bytes;
 
     bool is_pseudo_op;
     bool is_active_write;
@@ -239,13 +239,10 @@ static inline int64_t mirror_clip_bytes(MirrorBlockJob *s,
     return MIN(bytes, s->bdev_length - offset);
 }
 
-/* Round offset and/or bytes to target cluster if COW is needed, and
- * return the offset of the adjusted tail against original. */
-static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
-                            uint64_t *bytes)
+/* Round offset and/or bytes to target cluster if COW is needed */
+static void mirror_cow_align(MirrorBlockJob *s, int64_t *offset, int64_t *bytes)
 {
     bool need_cow;
-    int ret = 0;
     int64_t align_offset = *offset;
     int64_t align_bytes = *bytes;
     int max_bytes = s->granularity * s->max_iov;
@@ -268,11 +265,8 @@ static int mirror_cow_align(MirrorBlockJob *s, int64_t *offset,
      * that doesn't matter because it's already the end of source image. */
     align_bytes = mirror_clip_bytes(s, align_offset, align_bytes);
 
-    ret = align_offset + align_bytes - (*offset + *bytes);
     *offset = align_offset;
     *bytes = align_bytes;
-    assert(ret >= 0);
-    return ret;
 }
 
 static inline void coroutine_fn
@@ -304,16 +298,9 @@ static inline void coroutine_fn
 /*
  * Restrict *bytes to how much we can actually handle, and align the
  * [*offset, *bytes] range to clusters if COW is needed.
- *
- * *bytes_handled is set to the number of bytes copied after and
- * including offset, excluding any bytes copied prior to offset due
- * to alignment.  This will be *bytes if no alignment is necessary, or
- * (new_end - *offset) if the tail is rounded up or down due to
- * alignment or buffer limit.
  */
 static void mirror_align_for_copy(MirrorBlockJob *s,
-                                  int64_t *offset, uint64_t *bytes,
-                                  int64_t *bytes_handled)
+                                  int64_t *offset, int64_t *bytes)
 {
     uint64_t max_bytes;
 
@@ -323,13 +310,11 @@ static void mirror_align_for_copy(MirrorBlockJob *s,
     *bytes = MIN(s->buf_size, MIN(max_bytes, *bytes));
     assert(*bytes);
     assert(*bytes < BDRV_REQUEST_MAX_BYTES);
-    *bytes_handled = *bytes;
 
     if (s->cow_bitmap) {
-        *bytes_handled += mirror_cow_align(s, offset, bytes);
+        mirror_cow_align(s, offset, bytes);
     }
-    /* Cannot exceed BDRV_REQUEST_MAX_BYTES + INT_MAX */
-    assert(*bytes_handled <= UINT_MAX);
+
     assert(*bytes <= s->buf_size);
     /* The offset is granularity-aligned because:
      * 1) Caller passes in aligned values;
@@ -402,28 +387,23 @@ static void coroutine_fn mirror_co_discard(void *opaque)
     mirror_write_complete(op, ret);
 }
 
-static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
-                               uint64_t bytes, MirrorMethod mirror_method)
+/* If mirror_method == MIRROR_METHOD_COPY, *offset and *bytes will be
+ * aligned as necessary */
+static void mirror_perform(MirrorBlockJob *s, int64_t *offset, int64_t *bytes,
+                           MirrorMethod mirror_method)
 {
     MirrorOp *op;
     Coroutine *co;
-    int64_t bytes_handled;
-
-    /* FIXME: Drop this assertion */
-    assert(bytes <= UINT_MAX);
 
     if (mirror_method == MIRROR_METHOD_COPY) {
-        mirror_align_for_copy(s, &offset, &bytes, &bytes_handled);
-        assert(bytes_handled <= UINT_MAX);
-    } else {
-        bytes_handled = bytes;
+        mirror_align_for_copy(s, offset, bytes);
     }
 
     op = g_new(MirrorOp, 1);
     *op = (MirrorOp){
         .s              = s,
-        .offset         = offset,
-        .bytes          = bytes,
+        .offset         = *offset,
+        .bytes          = *bytes,
     };
     qemu_co_queue_init(&op->waiting_requests);
 
@@ -443,8 +423,6 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
 
     QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
     qemu_coroutine_enter(co);
-
-    return bytes_handled;
 }
 
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
@@ -564,7 +542,7 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
         }
 
         io_bytes = mirror_clip_bytes(s, offset, io_bytes);
-        io_bytes = mirror_perform(s, offset, io_bytes, mirror_method);
+        mirror_perform(s, &offset, &io_bytes, mirror_method);
         if (mirror_method != MIRROR_METHOD_COPY && write_zeroes_ok) {
             io_bytes_acct = 0;
         } else {
@@ -755,8 +733,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 
         s->initial_zeroing_ongoing = true;
         for (offset = 0; offset < s->bdev_length; ) {
-            int bytes = MIN(s->bdev_length - offset,
-                            QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
+            int64_t bytes = MIN(s->bdev_length - offset,
+                                QEMU_ALIGN_DOWN(INT_MAX, s->granularity));
 
             mirror_throttle(s);
 
@@ -772,7 +750,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
                 continue;
             }
 
-            mirror_perform(s, offset, bytes, MIRROR_METHOD_ZERO);
+            mirror_perform(s, &offset, &bytes, MIRROR_METHOD_ZERO);
             offset += bytes;
         }
 
-- 
2.17.1
