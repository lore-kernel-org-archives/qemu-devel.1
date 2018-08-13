Received: from eggs.gnu.org ([2001:4830:134:3::10]:53168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TB-0003WJ-5C
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fp2TA-0008BQ-1m
	for qemu-devel@nongnu.org; Sun, 12 Aug 2018 22:20:33 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 13 Aug 2018 04:19:55 +0200
Message-Id: <20180813022006.7216-7-mreitz@redhat.com>
In-Reply-To: <20180813022006.7216-1-mreitz@redhat.com>
References: <20180813022006.7216-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 06/17] mirror: Create mirror_co_perform()
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

While very simple now, this function will be fattened in future patches.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index f05404e557..89452ad371 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -85,8 +85,16 @@ typedef struct MirrorBDSOpaque {
     MirrorBlockJob *job;
 } MirrorBDSOpaque;
 
+typedef enum MirrorMethod {
+    MIRROR_METHOD_COPY,
+    MIRROR_METHOD_ZERO,
+    MIRROR_METHOD_DISCARD,
+} MirrorMethod;
+
 struct MirrorOp {
     MirrorBlockJob *s;
+    MirrorMethod mirror_method;
+
     QEMUIOVector qiov;
     int64_t offset;
     int64_t bytes;
@@ -98,12 +106,6 @@ struct MirrorOp {
     QTAILQ_ENTRY(MirrorOp) next;
 };
 
-typedef enum MirrorMethod {
-    MIRROR_METHOD_COPY,
-    MIRROR_METHOD_ZERO,
-    MIRROR_METHOD_DISCARD,
-} MirrorMethod;
-
 static BlockErrorAction mirror_error_action(MirrorBlockJob *s, bool read,
                                             int error)
 {
@@ -387,6 +389,25 @@ static void coroutine_fn mirror_co_discard(void *opaque)
     mirror_write_complete(op, ret);
 }
 
+static void coroutine_fn mirror_co_perform(void *opaque)
+{
+    MirrorOp *op = opaque;
+
+    switch (op->mirror_method) {
+    case MIRROR_METHOD_COPY:
+        mirror_co_read(opaque);
+        return;
+    case MIRROR_METHOD_ZERO:
+        mirror_co_zero(opaque);
+        return;
+    case MIRROR_METHOD_DISCARD:
+        mirror_co_discard(opaque);
+        return;
+    default:
+        abort();
+    }
+}
+
 /* If mirror_method == MIRROR_METHOD_COPY, *offset and *bytes will be
  * aligned as necessary */
 static void mirror_perform(MirrorBlockJob *s, int64_t *offset, int64_t *bytes,
@@ -402,24 +423,13 @@ static void mirror_perform(MirrorBlockJob *s, int64_t *offset, int64_t *bytes,
     op = g_new(MirrorOp, 1);
     *op = (MirrorOp){
         .s              = s,
+        .mirror_method  = mirror_method,
         .offset         = *offset,
         .bytes          = *bytes,
     };
     qemu_co_queue_init(&op->waiting_requests);
 
-    switch (mirror_method) {
-    case MIRROR_METHOD_COPY:
-        co = qemu_coroutine_create(mirror_co_read, op);
-        break;
-    case MIRROR_METHOD_ZERO:
-        co = qemu_coroutine_create(mirror_co_zero, op);
-        break;
-    case MIRROR_METHOD_DISCARD:
-        co = qemu_coroutine_create(mirror_co_discard, op);
-        break;
-    default:
-        abort();
-    }
+    co = qemu_coroutine_create(mirror_co_perform, op);
 
     QTAILQ_INSERT_TAIL(&s->ops_in_flight, op, next);
     qemu_coroutine_enter(co);
-- 
2.17.1
