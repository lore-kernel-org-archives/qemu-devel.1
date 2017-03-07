Received: from eggs.gnu.org ([2001:4830:134:3::10]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clEzf-0007DL-GV
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1clEzc-00040l-6M
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:17:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1clEzb-00040E-Sf
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 08:17:32 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v27DDZBi145024
	for <qemu-devel@nongnu.org>; Tue, 7 Mar 2017 08:17:30 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 291w62he03-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 08:17:30 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Tue, 7 Mar 2017 13:17:27 -0000
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue,  7 Mar 2017 14:16:50 +0100
Message-Id: <20170307131650.90167-1-pasic@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] virtio-blk: fix race on guest notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-stable@nongnu.org

The commits 03de2f527 "virtio-blk: do not use vring in dataplane"  and
9ffe337c08 "virtio-blk: always use dataplane path if ioeventfd is active"
changed how notifications are done for virtio-blk substantially. Due to a
race condition, interrupts are lost when irqfd behind the guest notifier
is torn down after notify_guest_bh was scheduled but before it actually
runs.

Let's fix this by forcing guest notifications before cleaning up the
irqfd's. Let's also add some explanatory comments.

Cc: qemu-stable@nongnu.org
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reported-by: Michael A. Tebolt <miket@us.ibm.com>
Tested-by: Michael A. Tebolt <miket@us.ibm.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
---

This patch withstood the test case which discovered the problem
for several days (as reported by Michale Tebolt).

v1 --> v2:
* Fixed typo pointed out by Connie
* Added Tested-by

---
 hw/block/dataplane/virtio-blk.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index 5556f0e..045a580 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -258,9 +258,16 @@ void virtio_blk_data_plane_stop(VirtIODevice *vdev)
         virtio_queue_aio_set_host_notifier_handler(vq, s->ctx, NULL);
     }
 
-    /* Drain and switch bs back to the QEMU main loop */
+    /* Drain and switch bs back to the QEMU main loop. After drain, the
+     * device will not submit (nor complete) any requests until dataplane
+     * starts again.
+     */
     blk_set_aio_context(s->conf->conf.blk, qemu_get_aio_context());
 
+    /* Notify guest before the guest notifiers get cleaned up */
+    qemu_bh_cancel(s->bh);
+    notify_guest_bh(s);
+
     aio_context_release(s->ctx);
 
     for (i = 0; i < nvqs; i++) {
-- 
2.8.4
