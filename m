Received: from eggs.gnu.org ([2001:4830:134:3::10]:57216)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGQYw-0004tI-OZ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dGQYs-0006OR-R1
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 09:54:54 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 15:54:47 +0200
Message-Id: <20170601135447.2674-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] virtio: add virtqueue_alloc_element tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com

This tracepoint can help diagnosing failures due to memory
fragmentation in the guest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/virtio/trace-events | 1 +
 hw/virtio/virtio.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 1f7a7c1ae1..e24d8fa997 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,7 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/virtio/virtio.c
+virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
 virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned int idx) "vq %p elem %p len %u idx %u"
 virtqueue_flush(void *vq, unsigned int count) "vq %p count %u"
 virtqueue_pop(void *vq, void *elem, unsigned int in_num, unsigned int out_num) "vq %p elem %p in_num %u out_num %u"
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 890b4d7eb7..286446b261 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -816,6 +816,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 
     assert(sz >= sizeof(VirtQueueElement));
     elem = g_malloc(out_sg_end);
+    trace_virtqueue_alloc_element(elem, sz, in_num, out_num);
     elem->out_num = out_num;
     elem->in_num = in_num;
     elem->in_addr = (void *)elem + in_addr_ofs;
-- 
2.13.0
