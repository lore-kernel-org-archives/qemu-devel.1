Received: from eggs.gnu.org ([2001:4830:134:3::10]:48157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl4-0007z5-Vn
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeOl3-0006aj-WB
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeOl3-0006Zi-Pz
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:22:45 -0500
Date: Wed, 24 Jan 2018 19:22:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516814467-25906-3-git-send-email-mst@redhat.com>
References: <1516814467-25906-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516814467-25906-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v2 2/3] Revert "virtio: postpone the execution
 of event_notifier_cleanup function"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Gal Hammer <ghammer@redhat.com>, Sitong Liu <siliu@redhat.com>, Xiaoling Gao <xiagao@redhat.com>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, kvm@vger.kernel.org

This reverts commit 4fe6d78b2e241f41208dfb07605aace4becfc747 as it is
reported to break cleanup and migration.

Cc: Gal Hammer <ghammer@redhat.com>
Cc: Sitong Liu <siliu@redhat.com>
Cc: Xiaoling Gao <xiagao@redhat.com>
Suggested-by: Greg Kurz <groug@kaod.org>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reported-by: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
Reported-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 accel/kvm/kvm-all.c    |  4 ----
 hw/virtio/virtio-bus.c | 19 ++++++++-----------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 071f4f5..f290f48 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -812,10 +812,6 @@ static void kvm_mem_ioeventfd_del(MemoryListener *listener,
     if (r < 0) {
         abort();
     }
-
-    if (e->cleanup) {
-        e->cleanup(e);
-    }
 }
 
 static void kvm_io_ioeventfd_add(MemoryListener *listener,
diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index 8106346..3042232 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -256,15 +256,6 @@ bool virtio_bus_ioeventfd_enabled(VirtioBusState *bus)
     return k->ioeventfd_assign && k->ioeventfd_enabled(proxy);
 }
 
-static void virtio_bus_cleanup_event_notifier(EventNotifier *notifier)
-{
-    /* Test and clear notifier after disabling event,
-     * in case poll callback didn't have time to run.
-     */
-    virtio_queue_host_notifier_read(notifier);
-    event_notifier_cleanup(notifier);
-}
-
 /*
  * This function switches ioeventfd on/off in the device.
  * The caller must set or clear the handlers for the EventNotifier.
@@ -292,13 +283,19 @@ int virtio_bus_set_host_notifier(VirtioBusState *bus, int n, bool assign)
         r = k->ioeventfd_assign(proxy, notifier, n, true);
         if (r < 0) {
             error_report("%s: unable to assign ioeventfd: %d", __func__, r);
-            virtio_bus_cleanup_event_notifier(notifier);
+            goto cleanup_event_notifier;
         }
+        return 0;
     } else {
-        notifier->cleanup = virtio_bus_cleanup_event_notifier;
         k->ioeventfd_assign(proxy, notifier, n, false);
     }
 
+cleanup_event_notifier:
+    /* Test and clear notifier after disabling event,
+     * in case poll callback didn't have time to run.
+     */
+    virtio_queue_host_notifier_read(notifier);
+    event_notifier_cleanup(notifier);
     return r;
 }
 
-- 
MST
