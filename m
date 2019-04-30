Received: from eggs.gnu.org ([209.51.188.92]:50743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUzd-0003s3-KL
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUzb-0005S7-FY
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:48:29 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:19 +0200
Message-Id: <20190430154244.30083-3-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/27] block: Fix AioContext switch for bs->drv
 == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Even for block nodes with bs->drv =3D=3D NULL, we can't just ignore a
bdrv_set_aio_context() call. Leaving the node in its old context can
mean that it's still in an iothread context in bdrv_close_all() during
shutdown, resulting in an attempted unlock of the AioContext lock which
we don't hold.

This is an example stack trace of a related crash:

 #0  0x00007ffff59da57f in raise () at /lib64/libc.so.6
 #1  0x00007ffff59c4895 in abort () at /lib64/libc.so.6
 #2  0x0000555555b97b1e in error_exit (err=3D<optimized out>, msg=3Dmsg@e=
ntry=3D0x555555d386d0 <__func__.19059> "qemu_mutex_unlock_impl") at util/=
qemu-thread-posix.c:36
 #3  0x0000555555b97f7f in qemu_mutex_unlock_impl (mutex=3Dmutex@entry=3D=
0x5555568002f0, file=3Dfile@entry=3D0x555555d378df "util/async.c", line=3D=
line@entry=3D507) at util/qemu-thread-posix.c:97
 #4  0x0000555555b92f55 in aio_context_release (ctx=3Dctx@entry=3D0x55555=
6800290) at util/async.c:507
 #5  0x0000555555b05cf8 in bdrv_prwv_co (child=3Dchild@entry=3D0x7fffc800=
12f0, offset=3Doffset@entry=3D131072, qiov=3Dqiov@entry=3D0x7fffffffd4f0,=
 is_write=3Dis_write@entry=3Dtrue, flags=3Dflags@entry=3D0)
         at block/io.c:833
 #6  0x0000555555b060a9 in bdrv_pwritev (qiov=3D0x7fffffffd4f0, offset=3D=
131072, child=3D0x7fffc80012f0) at block/io.c:990
 #7  0x0000555555b060a9 in bdrv_pwrite (child=3D0x7fffc80012f0, offset=3D=
131072, buf=3D<optimized out>, bytes=3D<optimized out>) at block/io.c:990
 #8  0x0000555555ae172b in qcow2_cache_entry_flush (bs=3Dbs@entry=3D0x555=
556810680, c=3Dc@entry=3D0x5555568cc740, i=3Di@entry=3D0) at block/qcow2-=
cache.c:51
 #9  0x0000555555ae18dd in qcow2_cache_write (bs=3Dbs@entry=3D0x555556810=
680, c=3D0x5555568cc740) at block/qcow2-cache.c:248
 #10 0x0000555555ae15de in qcow2_cache_flush (bs=3D0x555556810680, c=3D<o=
ptimized out>) at block/qcow2-cache.c:259
 #11 0x0000555555ae16b1 in qcow2_cache_flush_dependency (c=3D0x5555568a17=
00, c=3D0x5555568a1700, bs=3D0x555556810680) at block/qcow2-cache.c:194
 #12 0x0000555555ae16b1 in qcow2_cache_entry_flush (bs=3Dbs@entry=3D0x555=
556810680, c=3Dc@entry=3D0x5555568a1700, i=3Di@entry=3D0) at block/qcow2-=
cache.c:194
 #13 0x0000555555ae18dd in qcow2_cache_write (bs=3Dbs@entry=3D0x555556810=
680, c=3D0x5555568a1700) at block/qcow2-cache.c:248
 #14 0x0000555555ae15de in qcow2_cache_flush (bs=3Dbs@entry=3D0x555556810=
680, c=3D<optimized out>) at block/qcow2-cache.c:259
 #15 0x0000555555ad242c in qcow2_inactivate (bs=3Dbs@entry=3D0x5555568106=
80) at block/qcow2.c:2124
 #16 0x0000555555ad2590 in qcow2_close (bs=3D0x555556810680) at block/qco=
w2.c:2153
 #17 0x0000555555ab0c62 in bdrv_close (bs=3D0x555556810680) at block.c:33=
58
 #18 0x0000555555ab0c62 in bdrv_delete (bs=3D0x555556810680) at block.c:3=
542
 #19 0x0000555555ab0c62 in bdrv_unref (bs=3D0x555556810680) at block.c:45=
98
 #20 0x0000555555af4d72 in blk_remove_bs (blk=3Dblk@entry=3D0x5555568103d=
0) at block/block-backend.c:785
 #21 0x0000555555af4dbb in blk_remove_all_bs () at block/block-backend.c:=
483
 #22 0x0000555555aae02f in bdrv_close_all () at block.c:3412
 #23 0x00005555557f9796 in main (argc=3D<optimized out>, argv=3D<optimize=
d out>, envp=3D<optimized out>) at vl.c:4776

The reproducer I used is a qcow2 image on gluster volume, where the
virtual disk size (4 GB) is larger than the gluster volume size (64M),
so we can easily trigger an ENOSPC. This backend is assigned to a
virtio-blk device using an iothread, and then from the guest a
'dd if=3D/dev/zero of=3D/dev/vda bs=3D1G count=3D1' causes the VM to stop
because of an I/O error. qemu_gluster_co_flush_to_disk() sets
bs->drv =3D NULL on error, so when virtio-blk stops the dataplane, the
block nodes stay in the iothread AioContext. A 'quit' monitor command
issued from this paused state crashes the process.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1631227
Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/block.c b/block.c
index 16615bc876..9ae5c0ed2f 100644
--- a/block.c
+++ b/block.c
@@ -5672,10 +5672,6 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
     BdrvAioNotifier *baf, *baf_tmp;
     BdrvChild *child;
=20
-    if (!bs->drv) {
-        return;
-    }
-
     assert(!bs->walking_aio_notifiers);
     bs->walking_aio_notifiers =3D true;
     QLIST_FOREACH_SAFE(baf, &bs->aio_notifiers, list, baf_tmp) {
@@ -5690,7 +5686,7 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
      */
     bs->walking_aio_notifiers =3D false;
=20
-    if (bs->drv->bdrv_detach_aio_context) {
+    if (bs->drv && bs->drv->bdrv_detach_aio_context) {
         bs->drv->bdrv_detach_aio_context(bs);
     }
     QLIST_FOREACH(child, &bs->children, next) {
@@ -5709,10 +5705,6 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
     BdrvAioNotifier *ban, *ban_tmp;
     BdrvChild *child;
=20
-    if (!bs->drv) {
-        return;
-    }
-
     if (bs->quiesce_counter) {
         aio_disable_external(new_context);
     }
@@ -5722,7 +5714,7 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
     QLIST_FOREACH(child, &bs->children, next) {
         bdrv_attach_aio_context(child->bs, new_context);
     }
-    if (bs->drv->bdrv_attach_aio_context) {
+    if (bs->drv && bs->drv->bdrv_attach_aio_context) {
         bs->drv->bdrv_attach_aio_context(bs, new_context);
     }
=20
--=20
2.20.1
