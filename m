Received: from eggs.gnu.org ([2001:4830:134:3::10]:55363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzNi1-0005sT-3Z
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:02:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fzNhw-000174-Ee
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:02:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 10 Sep 2018 22:56:16 +0800
Message-Id: <20180910145616.8598-3-famz@redhat.com>
In-Reply-To: <20180910145616.8598-1-famz@redhat.com>
References: <20180910145616.8598-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio-scsi/virtio-blk: Disable poll
 handlers when stopping vq handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

We have this unwanted call stack:

  > ...
  > #13 0x00005586602b7793 in virtio_scsi_handle_cmd_vq
  > #14 0x00005586602b8d66 in virtio_scsi_data_plane_handle_cmd
  > #15 0x00005586602ddab7 in virtio_queue_notify_aio_vq
  > #16 0x00005586602dfc9f in virtio_queue_host_notifier_aio_poll
  > #17 0x00005586607885da in run_poll_handlers_once
  > #18 0x000055866078880e in try_poll_mode
  > #19 0x00005586607888eb in aio_poll
  > #20 0x0000558660784561 in aio_wait_bh_oneshot
  > #21 0x00005586602b9582 in virtio_scsi_dataplane_stop
  > #22 0x00005586605a7110 in virtio_bus_stop_ioeventfd
  > #23 0x00005586605a9426 in virtio_pci_stop_ioeventfd
  > #24 0x00005586605ab808 in virtio_pci_common_write
  > #25 0x0000558660242396 in memory_region_write_accessor
  > #26 0x00005586602425ab in access_with_adjusted_size
  > #27 0x0000558660245281 in memory_region_dispatch_write
  > #28 0x00005586601e008e in flatview_write_continue
  > #29 0x00005586601e01d8 in flatview_write
  > #30 0x00005586601e04de in address_space_write
  > #31 0x00005586601e052f in address_space_rw
  > #32 0x00005586602607f2 in kvm_cpu_exec
  > #33 0x0000558660227148 in qemu_kvm_cpu_thread_fn
  > #34 0x000055866078bde7 in qemu_thread_start
  > #35 0x00007f5784906594 in start_thread
  > #36 0x00007f5784639e6f in clone

Avoid it with the aio_disable_external/aio_enable_external pair, so that
no vq poll handlers can be called in aio_wait_bh_oneshot.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/block/dataplane/virtio-blk.c | 2 ++
 hw/scsi/virtio-scsi-dataplane.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 8c37bd314a..8ab54218c1 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -279,7 +279,9 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
     trace_virtio_blk_data_plane_stop(s);
 
     aio_context_acquire(s->ctx);
+    aio_disable_external(s->ctx);
     aio_wait_bh_oneshot(s->ctx, virtio_blk_data_plane_stop_bh, s);
+    aio_enable_external(s->ctx);
 
     /* Drain and switch bs back to the QEMU main loop */
     blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index b995bab3a2..1452398491 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -208,7 +208,9 @@ void virtio_scsi_dataplane_stop(VirtIODevice *vdev)
     s->dataplane_stopping = true;
 
     aio_context_acquire(s->ctx);
+    aio_disable_external(s->ctx);
     aio_wait_bh_oneshot(s->ctx, virtio_scsi_dataplane_stop_bh, s);
+    aio_enable_external(s->ctx);
     aio_context_release(s->ctx);
 
     blk_drain_all(); /* ensure there are no in-flight requests */
-- 
2.17.1
