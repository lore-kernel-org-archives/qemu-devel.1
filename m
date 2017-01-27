Received: from eggs.gnu.org ([2001:4830:134:3::10]:33286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dg-0002Wx-DE
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cX8dd-0007nI-JN
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:36 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cX8dd-0007mq-7A
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 10:40:33 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so58897765wmi.1
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 07:40:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 27 Jan 2017 16:40:19 +0100
Message-Id: <1485531620-121182-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
References: <1485531620-121182-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 8/9] virtio: check for vring setup in
 virtio_queue_update_used_idx
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com

If the vring has not been set up, it is not necessary for vring_used_idx
to do anything (as is already the case when the caller is virtio_load).
This is harmless for now, but it will be a problem when the
MemoryRegionCache has not been set up.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/virtio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 32bf364..23fac1e 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2154,7 +2154,9 @@ void virtio_queue_set_last_avail_idx(VirtIODevice *vdev, int n, uint16_t idx)
 
 void virtio_queue_update_used_idx(VirtIODevice *vdev, int n)
 {
-    vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
+    if (vdev->vq[n].vring.desc) {
+        vdev->vq[n].used_idx = vring_used_idx(&vdev->vq[n]);
+    }
 }
 
 void virtio_queue_invalidate_signalled_used(VirtIODevice *vdev, int n)
-- 
1.8.3.1
