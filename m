Received: from eggs.gnu.org ([209.51.188.92]:45688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gz2Y2-00011P-SN
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1gz2Y1-0008Pj-TH
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 11:59:10 -0500
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 27 Feb 2019 17:52:12 +0100
Message-Id: <20190227165212.34901-1-slp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] virtio-blk: dataplane: release AioContext
 before blk_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, mreitz@redhat.com, Sergio Lopez <slp@redhat.com>

Stopping the dataplane requires calling to blk_set_aio_context, which
may need to wait for a running job to be completed or paused.

As stopping the dataplane is something that can be triggered from a vcpu
thread (due to the Guest requesting to stop the device), while the job
itself may be managed by an iothread, holding the AioContext will lead
to a deadlock, where the first one is waiting for the job to pause or
finish, while the second can't make any progress as it's waiting for the
AioContext to be released:

 Thread 6 (LWP 90472)
 #0  0x000055a6f8497aee in blk_root_drained_end
 #1  0x000055a6f84a7926 in bdrv_parent_drained_end
 #2  0x000055a6f84a799f in bdrv_do_drained_end
 #3  0x000055a6f84a82ab in bdrv_drained_end
 #4  0x000055a6f8498be8 in blk_drain
 #5  0x000055a6f84a22cd in mirror_drain
 #6  0x000055a6f8457708 in block_job_detach_aio_context
 #7  0x000055a6f84538f1 in bdrv_detach_aio_context
 #8  0x000055a6f8453a96 in bdrv_set_aio_context
 #9  0x000055a6f84999f8 in blk_set_aio_context
 #10 0x000055a6f81802c8 in virtio_blk_data_plane_stop
 #11 0x000055a6f83cfc95 in virtio_bus_stop_ioeventfd
 #12 0x000055a6f83d1f81 in virtio_pci_common_write
 #13 0x000055a6f83d1f81 in virtio_pci_common_write
 #14 0x000055a6f8148d62 in memory_region_write_accessor
 #15 0x000055a6f81459c9 in access_with_adjusted_size
 #16 0x000055a6f814a608 in memory_region_dispatch_write
 #17 0x000055a6f80f1f98 in flatview_write_continue
 #18 0x000055a6f80f214f in flatview_write
 #19 0x000055a6f80f6a7b in address_space_write
 #20 0x000055a6f80f6b15 in address_space_rw
 #21 0x000055a6f815da08 in kvm_cpu_exec
 #22 0x000055a6f8132fee in qemu_kvm_cpu_thread_fn
 #23 0x000055a6f8551306 in qemu_thread_start
 #24 0x00007f9bdf5b9dd5 in start_thread
 #25 0x00007f9bdf2e2ead in clone

 Thread 8 (LWP 90467)
 #0  0x00007f9bdf5c04ed in __lll_lock_wait
 #1  0x00007f9bdf5bbde6 in _L_lock_941
 #2  0x00007f9bdf5bbcdf in __GI___pthread_mutex_lock
 #3  0x000055a6f8551447 in qemu_mutex_lock_impl
 #4  0x000055a6f854be77 in co_schedule_bh_cb
 #5  0x000055a6f854b781 in aio_bh_poll
 #6  0x000055a6f854b781 in aio_bh_poll
 #7  0x000055a6f854f01b in aio_poll
 #8  0x000055a6f825a488 in iothread_run
 #9  0x000055a6f8551306 in qemu_thread_start
 #10 0x00007f9bdf5b9dd5 in start_thread
 #11 0x00007f9bdf2e2ead in clone

 (gdb) thread 8
 [Switching to thread 8 (Thread 0x7f9bd6dae700 (LWP 90467))]
 #3  0x000055a6f8551447 in qemu_mutex_lock_impl (mutex=3D0x55a6fac8fea0,
     file=3D0x55a6f8730c3f "util/async.c", line=3D511) at util/qemu-threa=
d-posix.c:66
 66	    err =3D pthread_mutex_lock(&mutex->lock);
 (gdb) up 3
 #3  0x000055a6f8551447 in qemu_mutex_lock_impl (mutex=3D0x55a6fac8fea0,
     file=3D0x55a6f8730c3f "util/async.c", line=3D511) at util/qemu-threa=
d-posix.c:66
 66	    err =3D pthread_mutex_lock(&mutex->lock);
 (gdb) p mutex.lock.__data.__owner
 $6 =3D 90472

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-=
blk.c
index 8c37bd314a..358e6ae89b 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -280,12 +280,11 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
=20
     aio_context_acquire(s->ctx);
     aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
+    aio_context_release(s->ctx);
=20
     /* Drain and switch bs back to the QEMU main loop */
     blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
=20
-    aio_context_release(s->ctx);
-
     for (i =3D 0; i < nvqs; i++) {
         virtio_bus_set_host_notifier(VIRTIO_BUS(qbus), i, false);
         virtio_bus_cleanup_host_notifier(VIRTIO_BUS(qbus), i);
--=20
2.20.1
