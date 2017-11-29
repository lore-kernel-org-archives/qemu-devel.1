Received: from eggs.gnu.org ([2001:4830:134:3::10]:41511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iI-0005hF-Q2
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iI-00067C-2t
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:50 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:51 +0800
Message-Id: <20171129144956.11409-5-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 4/9] throttle: Implement AioContext drain
 ops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/throttle.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/block/throttle.c b/block/throttle.c
index 833175ac77..35b740e3de 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -70,6 +70,25 @@ fin:
     return ret;
 }
 
+static void throttle_drained_begin(void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    ThrottleGroupMember *tgm = bs->opaque;
+
+    if (atomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
+        throttle_group_restart_tgm(tgm);
+    }
+}
+
+static void throttle_drained_end(void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    ThrottleGroupMember *tgm = bs->opaque;
+
+    assert(tgm->io_limits_disabled);
+    atomic_dec(&tgm->io_limits_disabled);
+}
+
 static int throttle_open(BlockDriverState *bs, QDict *options,
                          int flags, Error **errp)
 {
@@ -146,6 +165,9 @@ static int throttle_co_flush(BlockDriverState *bs)
 static void throttle_detach_aio_context(BlockDriverState *bs)
 {
     ThrottleGroupMember *tgm = bs->opaque;
+    aio_context_del_drain_ops(bdrv_get_aio_context(bs),
+                              throttle_drained_begin, throttle_drained_end,
+                              bs);
     throttle_group_detach_aio_context(tgm);
 }
 
@@ -153,6 +175,9 @@ static void throttle_attach_aio_context(BlockDriverState *bs,
                                         AioContext *new_context)
 {
     ThrottleGroupMember *tgm = bs->opaque;
+    aio_context_add_drain_ops(new_context,
+                              throttle_drained_begin, throttle_drained_end,
+                              bs);
     throttle_group_attach_aio_context(tgm, new_context);
 }
 
@@ -199,17 +224,12 @@ static bool throttle_recurse_is_first_non_filter(BlockDriverState *bs,
 
 static void coroutine_fn throttle_co_drain_begin(BlockDriverState *bs)
 {
-    ThrottleGroupMember *tgm = bs->opaque;
-    if (atomic_fetch_inc(&tgm->io_limits_disabled) == 0) {
-        throttle_group_restart_tgm(tgm);
-    }
+    throttle_drained_begin(bs);
 }
 
 static void coroutine_fn throttle_co_drain_end(BlockDriverState *bs)
 {
-    ThrottleGroupMember *tgm = bs->opaque;
-    assert(tgm->io_limits_disabled);
-    atomic_dec(&tgm->io_limits_disabled);
+    throttle_drained_end(bs);
 }
 
 static BlockDriver bdrv_throttle = {
-- 
2.14.3
