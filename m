Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYCmS-0005Yo-1Y
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:18:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cYCmO-0001IL-37
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:18:04 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:25869 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cYCmN-0001Hx-N9
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:18:00 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 30 Jan 2017 17:17:54 +0300
Message-Id: <20170130141754.93075-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block: bdrv_invalidate_cache_all: invalidate
 children first
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Current implementation iterates by bdrv_next, and, for example, will
invalidate firstly parent bds and then its children. This leads to the
following bug:

after incoming migration, in bdrv_invalidate_cache_all:
1. invalidate parent bds - reopen it with BDRV_O_INACTIVE cleared
2. child is not yet invalidated
3. parent check that its BDRV_O_INACTIVE is cleared
4. parent writes to child
5. assert in bdrv_co_pwritev, as BDRV_O_INACTIVE is set for child

This patch fixes it by just changing invalidate sequence: invalidate
children first.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

There is a bug, which was found during testing of my qcow2-bitmap series. Actually,
we run into this assert when reopen qcow2 with dirty bitmap after incoming migration.

How to test:

1. apply the following change (force qcow2 driver write to child on open):
diff --git a/block/qcow2.c b/block/qcow2.c
index 96fb8a8f16..96d803e593 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1152,6 +1152,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* Clear unknown autoclear feature bits */
+    s->autoclear_features = 1;
     if (!bs->read_only && !(flags & BDRV_O_INACTIVE) && s->autoclear_features) {
         s->autoclear_features = 0;
         ret = qcow2_update_header(bs);

2. run iotest 091
It will fail, because of:
Program received signal SIGABRT, Aborted.
0x00007f56340925f7 in raise () from /lib64/libc.so.6
(gdb) bt
#0  0x00007f56340925f7 in raise () from /lib64/libc.so.6
#1  0x00007f5634093ce8 in abort () from /lib64/libc.so.6
#2  0x00007f563408b566 in __assert_fail_base () from /lib64/libc.so.6
#3  0x00007f563408b612 in __assert_fail () from /lib64/libc.so.6
#4  0x00007f563bd5e2b7 in bdrv_co_pwritev (child=0x7f563dd8b990, offset=0, bytes=65536, 
    qiov=0x7ffec2c87120, flags=0) at block/io.c:1510
#5  0x00007f563bd5bbf4 in bdrv_rw_co_entry (opaque=0x7ffec2c87060) at block/io.c:591
#6  0x00007f563bdfb9e3 in coroutine_trampoline (i0=1056362256, i1=32598) at util/coroutine-ucontext.c:79
#7  0x00007f56340a4110 in ?? () from /lib64/libc.so.6
#8  0x00007ffec2c86870 in ?? ()
#9  0x0000000000000000 in ?? ()
(gdb) frame 4
#4  0x00007f563bd5e2b7 in bdrv_co_pwritev (child=0x7f563dd8b990, offset=0, bytes=65536, 
    qiov=0x7ffec2c87120, flags=0) at block/io.c:1510
1510        assert(!(bs->open_flags & BDRV_O_INACTIVE));

3. with both applied change (1.) and the following bugfix test doesn't fail.

 block.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index a0346c80c6..d9e2ba9b5a 100644
--- a/block.c
+++ b/block.c
@@ -3263,6 +3263,29 @@ void bdrv_invalidate_cache(BlockDriverState *bs, Error **errp)
     }
 }
 
+static void bdrv_invalidate_cache_recurse(BlockDriverState *bs, Error **errp)
+{
+    Error *local_err = NULL;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
+    BdrvChild *child;
+
+    if (!(bs->open_flags & BDRV_O_INACTIVE)) {
+        return;
+    }
+
+    QLIST_FOREACH(child, &bs->children, next) {
+        bdrv_invalidate_cache_recurse(child->bs, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    aio_context_acquire(aio_context);
+    bdrv_invalidate_cache(bs, errp);
+    aio_context_release(aio_context);
+}
+
 void bdrv_invalidate_cache_all(Error **errp)
 {
     BlockDriverState *bs;
@@ -3270,11 +3293,7 @@ void bdrv_invalidate_cache_all(Error **errp)
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *aio_context = bdrv_get_aio_context(bs);
-
-        aio_context_acquire(aio_context);
-        bdrv_invalidate_cache(bs, &local_err);
-        aio_context_release(aio_context);
+        bdrv_invalidate_cache_recurse(bs, &local_err);
         if (local_err) {
             error_propagate(errp, local_err);
             return;
-- 
2.11.0
