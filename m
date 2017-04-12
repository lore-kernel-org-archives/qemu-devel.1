Received: from eggs.gnu.org ([2001:4830:134:3::10]:60353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyIi5-00079V-4x
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cyIi4-0004d0-8q
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:53:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cyIi3-0004ca-VQ
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:53:24 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed, 12 Apr 2017 15:53:12 +0200
Message-Id: <20170412135312.1686-3-lvivier@redhat.com>
In-Reply-To: <20170412135312.1686-1-lvivier@redhat.com>
References: <20170412135312.1686-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] virtio-rng: stop virtqueue while the
 CPU is stopped
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
 hw/virtio/trace-events         |  3 +++
 hw/virtio/virtio-rng.c         | 29 +++++++++++++++++++++++------
 include/hw/virtio/virtio-rng.h |  2 ++
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index 6926eed..1f7a7c1 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -11,8 +11,11 @@ virtio_set_status(void *vdev, uint8_t val) "vdev %p val %u"
 
 # hw/virtio/virtio-rng.c
 virtio_rng_guest_not_ready(void *rng) "rng %p: guest not ready"
+virtio_rng_cpu_is_stopped(void *rng, int size) "rng %p: cpu is stopped, dropping %d bytes"
+virtio_rng_popped(void *rng) "rng %p: elem popped"
 virtio_rng_pushed(void *rng, size_t len) "rng %p: %zd bytes pushed"
 virtio_rng_request(void *rng, size_t size, unsigned quota) "rng %p: %zd bytes requested, %u bytes quota left"
+virtio_rng_vm_state_change(void *rng, int running, int state) "rng %p: state change to running %d state %d"
 
 # hw/virtio/virtio-balloon.c
 #
diff --git a/hw/virtio/virtio-rng.c b/hw/virtio/virtio-rng.c
index 9639f4e..a6ee501 100644
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
+        trace_virtio_rng_cpu_is_stopped(vrng, size);
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
@@ -120,17 +130,21 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
     return f;
 }
 
-static int virtio_rng_post_load(void *opaque, int version_id)
+static void virtio_rng_vm_state_change(void *opaque, int running,
+                                       RunState state)
 {
     VirtIORNG *vrng = opaque;
 
+    trace_virtio_rng_vm_state_change(vrng, running, state);
+
     /* We may have an element ready but couldn't process it due to a quota
-     * limit.  Make sure to try again after live migration when the quota may
-     * have been reset.
+     * limit or because CPU was stopped.  Make sure to try again when the
+     * CPU restart.
      */
-    virtio_rng_process(vrng);
 
-    return 0;
+    if (running && is_guest_ready(vrng)) {
+        virtio_rng_process(vrng);
+    }
 }
 
 static void check_rate_limit(void *opaque)
@@ -198,6 +212,9 @@ static void virtio_rng_device_realize(DeviceState *dev, Error **errp)
     vrng->rate_limit_timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                                check_rate_limit, vrng);
     vrng->activate_timer = true;
+
+    vrng->vmstate = qemu_add_vm_change_state_handler(virtio_rng_vm_state_change,
+                                                     vrng);
 }
 
 static void virtio_rng_device_unrealize(DeviceState *dev, Error **errp)
@@ -205,6 +222,7 @@ static void virtio_rng_device_unrealize(DeviceState *dev, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     VirtIORNG *vrng = VIRTIO_RNG(dev);
 
+    qemu_del_vm_change_state_handler(vrng->vmstate);
     timer_del(vrng->rate_limit_timer);
     timer_free(vrng->rate_limit_timer);
     virtio_cleanup(vdev);
@@ -218,7 +236,6 @@ static const VMStateDescription vmstate_virtio_rng = {
         VMSTATE_VIRTIO_DEVICE,
         VMSTATE_END_OF_LIST()
     },
-    .post_load =  virtio_rng_post_load,
 };
 
 static Property virtio_rng_properties[] = {
diff --git a/include/hw/virtio/virtio-rng.h b/include/hw/virtio/virtio-rng.h
index 2d40abd..922dce7 100644
--- a/include/hw/virtio/virtio-rng.h
+++ b/include/hw/virtio/virtio-rng.h
@@ -45,6 +45,8 @@ typedef struct VirtIORNG {
     QEMUTimer *rate_limit_timer;
     int64_t quota_remaining;
     bool activate_timer;
+
+    VMChangeStateEntry *vmstate;
 } VirtIORNG;
 
 #endif
-- 
2.9.3
