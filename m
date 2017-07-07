Received: from eggs.gnu.org ([2001:4830:134:3::10]:45445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdd-0000kx-6H
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdZ-0000dT-CH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:37 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 07:44:47 -0500
Message-Id: <20170707124459.10269-10-eblake@redhat.com>
In-Reply-To: <20170707124459.10269-1-eblake@redhat.com>
References: <20170707124459.10269-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/21] mirror: Switch
 mirror_do_zero_or_discard() to byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

---
v2-v4: no change
---
 block/mirror.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 10f4e9b..60eefbd 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -305,8 +305,8 @@ static int mirror_do_read(MirrorBlockJob *s, int64_t sector_num,
 }

 static void mirror_do_zero_or_discard(MirrorBlockJob *s,
-                                      int64_t sector_num,
-                                      int nb_sectors,
+                                      int64_t offset,
+                                      uint64_t bytes,
                                       bool is_discard)
 {
     MirrorOp *op;
@@ -315,16 +315,16 @@ static void mirror_do_zero_or_discard(MirrorBlockJob *s,
      * so the freeing in mirror_iteration_done is nop. */
     op = g_new0(MirrorOp, 1);
     op->s = s;
-    op->offset = sector_num * BDRV_SECTOR_SIZE;
-    op->bytes = nb_sectors * BDRV_SECTOR_SIZE;
+    op->offset = offset;
+    op->bytes = bytes;

     s->in_flight++;
-    s->bytes_in_flight += nb_sectors * BDRV_SECTOR_SIZE;
+    s->bytes_in_flight += bytes;
     if (is_discard) {
-        blk_aio_pdiscard(s->target, sector_num << BDRV_SECTOR_BITS,
+        blk_aio_pdiscard(s->target, offset,
                          op->bytes, mirror_write_complete, op);
     } else {
-        blk_aio_pwrite_zeroes(s->target, sector_num * BDRV_SECTOR_SIZE,
+        blk_aio_pwrite_zeroes(s->target, offset,
                               op->bytes, s->unmap ? BDRV_REQ_MAY_UNMAP : 0,
                               mirror_write_complete, op);
     }
@@ -453,7 +453,8 @@ static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
             break;
         case MIRROR_METHOD_ZERO:
         case MIRROR_METHOD_DISCARD:
-            mirror_do_zero_or_discard(s, sector_num, io_sectors,
+            mirror_do_zero_or_discard(s, sector_num * BDRV_SECTOR_SIZE,
+                                      io_sectors * BDRV_SECTOR_SIZE,
                                       mirror_method == MIRROR_METHOD_DISCARD);
             if (write_zeroes_ok) {
                 io_bytes_acct = 0;
@@ -657,7 +658,8 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
                 continue;
             }

-            mirror_do_zero_or_discard(s, sector_num, nb_sectors, false);
+            mirror_do_zero_or_discard(s, sector_num * BDRV_SECTOR_SIZE,
+                                      nb_sectors * BDRV_SECTOR_SIZE, false);
             sector_num += nb_sectors;
         }

-- 
2.9.4
