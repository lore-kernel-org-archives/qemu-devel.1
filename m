Received: from eggs.gnu.org ([2001:4830:134:3::10]:50648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxvg4-00016U-Qg
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cxvg3-0006x0-Vz
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:17:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cxvg3-0006wi-Pw
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:17:47 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue, 11 Apr 2017 15:17:33 +0200
Message-Id: <20170411131733.27542-3-lvivier@redhat.com>
In-Reply-To: <20170411131733.27542-1-lvivier@redhat.com>
References: <20170411131733.27542-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] virtio-rng: stop virtqueue while the CPU
 is stopped
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org

If we modify the virtio-rng virqueue while the
vmstate is already migrated we can have some
inconsistencies between the virtqueue state and
the memory content.

To avoid this, stop the virtqueue while the CPU
is stopped.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/virtio/trace-events |  2 ++
 hw/virtio/virtio-rng.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 6926eed..564a4b8 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -11,6 +11,8 @@ virtio_set_status(void *vdev, uint8_t val) "vdev %p val %u"
 
 # hw/virtio/virtio-rng.c
 virtio_rng_guest_not_ready(void *rng) "rng %p: guest not ready"
+virtio_rng_cpu_is_stopped(void *rng) "rng %p: cpu is stopped"
+virtio_rng_popped(void *rng) "rng %p: elem popped"
 virtio_rng_pushed(void *rng, size_t len) "rng %p: %zd bytes pushed"
 virtio_rng_request(void *rng, size_t size, unsigned quota) "rng %p: %zd bytes requested, %u bytes quota left"
 
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 9639f4e..d270d56 100644
--- a/hw/virtio/virtio-rng.c
+++ b/hw/virtio/virtio-rng.c
@@ -53,6 +53,15 @@ static void chr_read(void *opaque, const void *buf, size_t size)
         return;
     }
 
+    /* we can't modify the virtqueue until
+     * our state is fully synced
+     */
+
+    if (!runstate_check(RUN_STATE_RUNNING)) {
+        trace_virtio_rng_cpu_is_stopped(vrng);
+        return;
+    }
+
     vrng->quota_remaining -= size;
 
     offset = 0;
@@ -61,6 +70,7 @@ static void chr_read(void *opaque, const void *buf, size_t size)
         if (!elem) {
             break;
         }
+        trace_virtio_rng_popped(vrng);
         len = iov_from_buf(elem->in_sg, elem->in_num,
                            0, buf + offset, size - offset);
         offset += len;
-- 
2.9.3
