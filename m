Received: from eggs.gnu.org ([2001:4830:134:3::10]:57589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnmTe-0004RO-3j
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cnmTa-0006Bk-SS
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:27:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cnmTa-0006BI-Mg
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 09:26:58 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC1B93D941
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 13:26:58 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue, 14 Mar 2017 21:26:54 +0800
Message-Id: <20170314132654.6751-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9] virtio-scsi: Fix assertion failure on
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

After the AioContext lock push down, there is a race between
virtio_scsi_dataplane_start and those "assert(s->ctx &&
s->dataplane_started)", because the latter doesn't isn't wrapped in
aio_context_acquire.

Reproducer is simply booting a Fedora guest with an empty
virtio-scsi-dataplane controller:

    qemu-system-x86_64 \
      -drive if=none,id=root,format=raw,file=Fedora-Cloud-Base-25-1.3.x86_64.raw \
      -device virtio-scsi \
      -device scsi-disk,drive=root,bootindex=1 \
      -object iothread,id=io \
      -device virtio-scsi-pci,iothread=io \
      -net user,hostfwd=tcp::10022-:22 -net nic,model=virtio -m 2048 \
      --enable-kvm

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 74c95e0..12b44b7 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -52,28 +52,40 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
 static bool virtio_scsi_data_plane_handle_cmd(VirtIODevice *vdev,
                                               VirtQueue *vq)
 {
-    VirtIOSCSI *s = (VirtIOSCSI *)vdev;
+    bool progress;
+    VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
+    aio_context_acquire(s->ctx);
     assert(s->ctx && s->dataplane_started);
-    return virtio_scsi_handle_cmd_vq(s, vq);
+    progress = virtio_scsi_handle_cmd_vq(s, vq);
+    aio_context_release(s->ctx);
+    return progress;
 }
 
 static bool virtio_scsi_data_plane_handle_ctrl(VirtIODevice *vdev,
                                                VirtQueue *vq)
 {
+    bool progress;
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
+    aio_context_acquire(s->ctx);
     assert(s->ctx && s->dataplane_started);
-    return virtio_scsi_handle_ctrl_vq(s, vq);
+    progress = virtio_scsi_handle_ctrl_vq(s, vq);
+    aio_context_release(s->ctx);
+    return progress;
 }
 
 static bool virtio_scsi_data_plane_handle_event(VirtIODevice *vdev,
                                                 VirtQueue *vq)
 {
+    bool progress;
     VirtIOSCSI *s = VIRTIO_SCSI(vdev);
 
+    aio_context_acquire(s->ctx);
     assert(s->ctx && s->dataplane_started);
-    return virtio_scsi_handle_event_vq(s, vq);
+    progress = virtio_scsi_handle_event_vq(s, vq);
+    aio_context_release(s->ctx);
+    return progress;
 }
 
 static int virtio_scsi_vring_init(VirtIOSCSI *s, VirtQueue *vq, int n,
-- 
2.9.3
