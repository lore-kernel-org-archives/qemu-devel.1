Received: from eggs.gnu.org ([2001:4830:134:3::10]:34426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpX3-0007rz-5i
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dGpX2-0006ID-8M
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dGpX2-0006Gk-2R
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:34:36 -0400
Date: Fri, 2 Jun 2017 19:34:34 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496421247-857-3-git-send-email-mst@redhat.com>
References: <1496421247-857-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496421247-857-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 2/8] virtio: add virtqueue_alloc_element
 tracepoint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

This tracepoint can help diagnosing failures due to memory
fragmentation in the guest.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c     | 1 +
 hw/virtio/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index f99d99f..464947f 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -815,6 +815,7 @@ static void *virtqueue_alloc_element(size_t sz, unsigned out_num, unsigned in_nu
 
     assert(sz >= sizeof(VirtQueueElement));
     elem = g_malloc(out_sg_end);
+    trace_virtqueue_alloc_element(elem, sz, in_num, out_num);
     elem->out_num = out_num;
     elem->in_num = in_num;
     elem->in_addr = (void *)elem + in_addr_ofs;
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 1f7a7c1..e24d8fa 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -1,6 +1,7 @@
 # See docs/tracing.txt for syntax documentation.
 
 # hw/virtio/virtio.c
+virtqueue_alloc_element(void *elem, size_t sz, unsigned in_num, unsigned out_num) "elem %p size %zd in_num %u out_num %u"
 virtqueue_fill(void *vq, const void *elem, unsigned int len, unsigned int idx) "vq %p elem %p len %u idx %u"
 virtqueue_flush(void *vq, unsigned int count) "vq %p count %u"
 virtqueue_pop(void *vq, void *elem, unsigned int in_num, unsigned int out_num) "vq %p elem %p in_num %u out_num %u"
-- 
MST
