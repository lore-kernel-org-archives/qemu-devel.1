Received: from eggs.gnu.org ([2001:4830:134:3::10]:33297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1f0ogQ-00075B-RO
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1f0ogM-0006Bi-Q2
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 09:30:38 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Tue, 27 Mar 2018 16:30:18 +0300
Message-Id: <1522157418-8954-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH for 2.12 1/1] block: allow recursive calling of
 bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

We have received the following assert on QEMU 2.9:

(gdb) bt
0  0x00007f6f67d281f7 in __GI_raise ()
1  0x00007f6f67d298e8 in __GI_abort ()
2  0x00007f6f67d21266 in __assert_fail_base ()
3  0x00007f6f67d21312 in __GI___assert_fail ()
4  0x000055a8faf76f9f in bdrv_detach_aio_context ()
5  0x000055a8faf76f68 in bdrv_detach_aio_context ()
6  0x000055a8faf770c6 in bdrv_set_aio_context ()
7  0x000055a8fafb780d in blk_set_aio_context ()
8  0x000055a8faf7af08 in block_job_attached_aio_context ()
9  0x000055a8faf77043 in bdrv_attach_aio_context ()
10 0x000055a8faf770d9 in bdrv_set_aio_context ()
11 0x000055a8fafb780d in blk_set_aio_context ()
12 0x000055a8fad580e7 in virtio_blk_data_plane_stop ()
13 0x000055a8faf11da5 in virtio_bus_stop_ioeventfd ()
14 0x000055a8fad85604 in virtio_vmstate_change ()
15 0x000055a8fae1ba52 in vm_state_notify ()
16 0x000055a8fad273e5 in do_vm_stop ()
17 vm_stop ()
18 0x000055a8face8f28 in main_loop_should_exit ()
19 main_loop ()
20 main ()
(gdb)

It does not look, that the code is fundumentally different in 2.12.

block_job_attached_aio_context() calls backup_attached_aio_context(),
which in turn calls bdrv_detach_aio_context() again. This results in
assert(!bs->walking_aio_notifiers).

The code in mirror is basically the same. The patch replaces boolean
condition with incremental counter, which should solve the problem.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h |  2 +-
 block.c                   | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 29cafa4..a290711 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -613,7 +613,7 @@ struct BlockDriverState {
      * BDS may register themselves in this list to be notified of changes
      * regarding this BDS's context */
     QLIST_HEAD(, BdrvAioNotifier) aio_notifiers;
-    bool walking_aio_notifiers; /* to make removal during iteration safe */
+    int walking_aio_notifiers; /* to make removal during iteration safe */
 
     char filename[PATH_MAX];
     char backing_file[PATH_MAX]; /* if non zero, the image is a diff of
diff --git a/block.c b/block.c
index a8da4f2..82cc07b 100644
--- a/block.c
+++ b/block.c
@@ -4739,8 +4739,7 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
         return;
     }
 
-    assert(!bs->walking_aio_notifiers);
-    bs->walking_aio_notifiers = true;
+    bs->walking_aio_notifiers++;
     QLIST_FOREACH_SAFE(baf, &bs->aio_notifiers, list, baf_tmp) {
         if (baf->deleted) {
             bdrv_do_remove_aio_context_notifier(baf);
@@ -4751,7 +4750,8 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
     /* Never mind iterating again to check for ->deleted.  bdrv_close() will
      * remove remaining aio notifiers if we aren't called again.
      */
-    bs->walking_aio_notifiers = false;
+    bs->walking_aio_notifiers--;
+    assert(bs->walking_aio_notifiers >= 0);
 
     if (bs->drv->bdrv_detach_aio_context) {
         bs->drv->bdrv_detach_aio_context(bs);
@@ -4782,8 +4782,7 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
         bs->drv->bdrv_attach_aio_context(bs, new_context);
     }
 
-    assert(!bs->walking_aio_notifiers);
-    bs->walking_aio_notifiers = true;
+    bs->walking_aio_notifiers++;
     QLIST_FOREACH_SAFE(ban, &bs->aio_notifiers, list, ban_tmp) {
         if (ban->deleted) {
             bdrv_do_remove_aio_context_notifier(ban);
@@ -4791,7 +4790,8 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
             ban->attached_aio_context(new_context, ban->opaque);
         }
     }
-    bs->walking_aio_notifiers = false;
+    bs->walking_aio_notifiers--;
+    assert(bs->walking_aio_notifiers >= 0);
 }
 
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
-- 
2.7.4
