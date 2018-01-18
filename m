Received: from eggs.gnu.org ([2001:4830:134:3::10]:46405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH3Q-0003RM-Il
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:44:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ecH3N-0003Pd-Sf
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:44:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42066)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ecH3N-0003Od-MA
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:44:53 -0500
Date: Thu, 18 Jan 2018 22:44:51 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516308132-10272-8-git-send-email-mst@redhat.com>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516308132-10272-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 07/29] virtio: postpone the execution of
 event_notifier_cleanup function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gal Hammer <ghammer@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

From: Gal Hammer <ghammer@redhat.com>

Use the EventNotifier's cleanup callback function to execute the
event_notifier_cleanup function after kvm unregistered the eventfd.

This change supports running the virtio_bus_set_host_notifier
function inside a memory region transaction. Otherwise, a closed
fd is sent to kvm, which results in a failure.

Signed-off-by: Gal Hammer <ghammer@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 accel/kvm/kvm-all.c    |  4 ++++
 hw/virtio/virtio-bus.c | 19 +++++++++++--------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f290f48..071f4f5 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -812,6 +812,10 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
     if (r < 0) {
         abort();
     }
+
+    if (e->cleanup) {
+        e->cleanup(e);
+    }
 }
 
 static void kvm_io_ioeventfd_add(MemoryListener *listener,
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 3042232..8106346 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -256,6 +256,15 @@ bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus)
     return k->ioeventfd_assign && k->ioeventfd_enabled(proxy);
 }
 
+static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
+{
+    /* Test and clear notifier after disabling event,
+     * in case poll callback didn't have time to run.
+     */
+    virtio_queue_host_notifier_read(notifier);
+    event_notifier_cleanup(notifier);
+}
+
 /*
  * This function switches ioeventfd on/off in the device.
  * The caller must set or clear the handlers for the EventNotifier.
@@ -283,19 +292,13 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
         r = k->ioeventfd_assign(proxy, notifier, n, true);
         if (r < 0) {
             error_report("%s: unable to assign ioeventfd: %d", __func__, r);
-            goto cleanup_event_notifier;
+            virtio_bus_cleanup_event_notifier(notifier);
         }
-        return 0;
     } else {
+        notifier->cleanup = virtio_bus_cleanup_event_notifier;
         k->ioeventfd_assign(proxy, notifier, n, false);
     }
 
-cleanup_event_notifier:
-    /* Test and clear notifier after disabling event,
-     * in case poll callback didn't have time to run.
-     */
-    virtio_queue_host_notifier_read(notifier);
-    event_notifier_cleanup(notifier);
     return r;
 }
 
-- 
MST
