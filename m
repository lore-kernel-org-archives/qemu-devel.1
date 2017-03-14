Received: from eggs.gnu.org ([2001:4830:134:3::10]:53903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cnpyv-0000eH-Fn
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:11:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cnpyq-0000Nc-J3
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:11:33 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:37918 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cnpyq-0000Mz-7G
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 13:11:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 14 Mar 2017 20:11:20 +0300
Message-Id: <20170314171120.80741-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] blk: fix aio context loss on media change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, stefanha@redhat.com

If we have separate iothread for cdrom, we lose connection to it on
qmp_blockdev_change_medium, as aio_context is on bds which is dropped
and switched with new one.

As an example result, after such media change we have crash on
virtio_scsi_ctx_check: Assertion `blk_get_aio_context(d->conf.blk) == s->ctx' failed.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

We've faced into this assert, and there some kind of fix. I don't sure that
such fix doesn't break some conceptions, in this case, I hope, someone will
propose a true-way solution.

======
Also, on master branch I can't reproduce it as vm crashed earlier, without any
eject/change, on assert(s->ctx && s->dataplane_started) in
virtio_scsi_data_plane_handle_ctrl(). It looks like race with
virtio_scsi_dataplane_start(), and for test (to reproduce assert described above),
I've "fixed" it with just:

@@ -63,6 +63,7 @@ static bool virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
 {
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
+    sleep(10);
     assert(s->ctx && s->dataplane_started);
     return virtio_scsi_handle_ctrl_vq(s, vq);
 }

This race is not reproduced for me in our 2.6 based branch.

 block/block-backend.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5742c09c2c..6d5044228e 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -65,6 +65,8 @@ struct BlockBackend {
     bool allow_write_beyond_eof;
 
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
+
+    AioContext *aio_context;
 };
 
 typedef struct BlockBackendAIOCB {
@@ -559,6 +561,10 @@ int blk_insert_bs(BlockBackend *blk, BlockDriverState *bs, Error **errp)
     }
     bdrv_ref(bs);
 
+    if (blk->aio_context != NULL) {
+        bdrv_set_aio_context(bs, blk->aio_context);
+    }
+
     notifier_list_notify(&blk->insert_bs_notifiers, blk);
     if (blk->public.throttle_state) {
         throttle_timers_attach_aio_context(
@@ -1607,6 +1613,7 @@ void blk_set_aio_context(BlockBackend *blk, AioContext *new_context)
 {
     BlockDriverState *bs = blk_bs(blk);
 
+    blk->aio_context = new_context;
     if (bs) {
         if (blk->public.throttle_state) {
             throttle_timers_detach_aio_context(&blk->public.throttle_timers);
-- 
2.11.1
