Received: from eggs.gnu.org ([2001:4830:134:3::10]:58011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd4-0000q8-54
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAd2-00005W-Qc
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAd2-00005L-Hs
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:32 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 992588553F
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:32 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGV0001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:31 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:57 +0100
Message-Id: <20170116165916.8575-14-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/32] event_notifier: cleanups around
 event_notifier_set_handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Remove the useless is_external argument.  Since the iohandler
AioContext is never used for block devices, aio_disable_external
is never called on it.  This lets us remove stubs/iohandler.c.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/usb/ccid-card-emulated.c   |  2 +-
 hw/virtio/virtio.c            | 10 +++++-----
 include/qemu/event_notifier.h |  3 ---
 include/qemu/main-loop.h      | 15 +++++++++++++++
 iohandler.c                   |  8 ++++++++
 stubs/Makefile.objs           |  1 -
 stubs/iohandler.c             |  8 --------
 target/i386/hyperv.c          |  7 ++++---
 util/event_notifier-posix.c   |  9 ---------
 util/event_notifier-win32.c   | 12 ------------
 10 files changed, 33 insertions(+), 42 deletions(-)
 delete mode 100644 stubs/iohandler.c

diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index eceb5f3..9962786 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -407,7 +407,7 @@ static int init_event_notifier(EmulatedState *card)
         DPRINTF(card, 2, "event notifier creation failed\n");
         return -1;
     }
-    event_notifier_set_handler(&card->notifier, false, card_event_handler);
+    event_notifier_set_handler(&card->notifier, card_event_handler);
     return 0;
 }
 
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index aa4f38f..a181514 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2090,10 +2090,10 @@ void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
                                                 bool with_irqfd)
 {
     if (assign && !with_irqfd) {
-        event_notifier_set_handler(&vq->guest_notifier, false,
+        event_notifier_set_handler(&vq->guest_notifier,
                                    virtio_queue_guest_notifier_read);
     } else {
-        event_notifier_set_handler(&vq->guest_notifier, false, NULL);
+        event_notifier_set_handler(&vq->guest_notifier, NULL);
     }
     if (!assign) {
         /* Test and clear notifier before closing it,
@@ -2262,7 +2262,7 @@ static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
             err = r;
             goto assign_error;
         }
-        event_notifier_set_handler(&vq->host_notifier, true,
+        event_notifier_set_handler(&vq->host_notifier,
                                    virtio_queue_host_notifier_read);
     }
 
@@ -2283,7 +2283,7 @@ assign_error:
             continue;
         }
 
-        event_notifier_set_handler(&vq->host_notifier, true, NULL);
+        event_notifier_set_handler(&vq->host_notifier, NULL);
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
     }
@@ -2309,7 +2309,7 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
         if (!virtio_queue_get_num(vdev, n)) {
             continue;
         }
-        event_notifier_set_handler(&vq->host_notifier, true, NULL);
+        event_notifier_set_handler(&vq->host_notifier, NULL);
         r = virtio_bus_set_host_notifier(qbus, n, false);
         assert(r >= 0);
     }
diff --git a/include/qemu/event_notifier.h b/include/qemu/event_notifier.h
index e326990..599c99f 100644
--- a/include/qemu/event_notifier.h
+++ b/include/qemu/event_notifier.h
@@ -34,9 +34,6 @@ int event_notifier_init(EventNotifier *, int active);
 void event_notifier_cleanup(EventNotifier *);
 int event_notifier_set(EventNotifier *);
 int event_notifier_test_and_clear(EventNotifier *);
-int event_notifier_set_handler(EventNotifier *,
-                               bool is_external,
-                               EventNotifierHandler *);
 
 #ifdef CONFIG_POSIX
 void event_notifier_init_fd(EventNotifier *, int fd);
diff --git a/include/qemu/main-loop.h b/include/qemu/main-loop.h
index a9d4f23..d7e24af 100644
--- a/include/qemu/main-loop.h
+++ b/include/qemu/main-loop.h
@@ -203,6 +203,21 @@ void qemu_set_fd_handler(int fd,
                          IOHandler *fd_write,
                          void *opaque);
 
+
+/**
+ * event_notifier_set_handler: Register an EventNotifier with the main loop
+ *
+ * This function tells the main loop to wake up whenever the
+ * #EventNotifier was set.
+ *
+ * @e: The #EventNotifier to be observed.
+ *
+ * @handler: A level-triggered callback that is fired when @e
+ * has been set.  @e is passed to it as a parameter.
+ */
+void event_notifier_set_handler(EventNotifier *e,
+                                EventNotifierHandler *handler);
+
 GSource *iohandler_get_g_source(void);
 AioContext *iohandler_get_aio_context(void);
 #ifdef CONFIG_POSIX
diff --git a/iohandler.c b/iohandler.c
index eb625d9..623b55b 100644
--- a/iohandler.c
+++ b/iohandler.c
@@ -66,6 +66,14 @@ void qemu_set_fd_handler(int fd,
                        fd_read, fd_write, NULL, opaque);
 }
 
+void event_notifier_set_handler(EventNotifier *e,
+                                EventNotifierHandler *handler)
+{
+    iohandler_init();
+    aio_set_event_notifier(iohandler_ctx, e, false,
+                           handler, NULL);
+}
+
 /* reaping of zombies.  right now we're not passing the status to
    anyone, but it would be possible to add a callback.  */
 #ifndef _WIN32
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 0b642d7..e863d9a 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -35,6 +35,5 @@ stub-obj-y += kvm.o
 stub-obj-y += qmp_pc_dimm_device_list.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
-stub-obj-y += iohandler.o
 stub-obj-y += pc_madt_cpu_entry.o
 stub-obj-y += migration-colo.o
diff --git a/stubs/iohandler.c b/stubs/iohandler.c
deleted file mode 100644
index 22b0ee5..0000000
--- a/stubs/iohandler.c
+++ /dev/null
@@ -1,8 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "qemu/main-loop.h"
-
-AioContext *iohandler_get_aio_context(void)
-{
-    abort();
-}
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 39a230f..8545574 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "hyperv.h"
 #include "standard-headers/asm-x86/hyperv.h"
 
@@ -88,7 +89,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
         goto err_sint_set_notifier;
     }
 
-    event_notifier_set_handler(&sint_route->sint_ack_notifier, false,
+    event_notifier_set_handler(&sint_route->sint_ack_notifier,
                                kvm_hv_sint_ack_handler);
 
     gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vcpu_id, sint);
@@ -112,7 +113,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vcpu_id, uint32_t sint,
 err_irqfd:
     kvm_irqchip_release_virq(kvm_state, gsi);
 err_gsi:
-    event_notifier_set_handler(&sint_route->sint_ack_notifier, false, NULL);
+    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
     event_notifier_cleanup(&sint_route->sint_ack_notifier);
 err_sint_set_notifier:
     event_notifier_cleanup(&sint_route->sint_set_notifier);
@@ -128,7 +129,7 @@ void kvm_hv_sint_route_destroy(HvSintRoute *sint_route)
                                           &sint_route->sint_set_notifier,
                                           sint_route->gsi);
     kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
-    event_notifier_set_handler(&sint_route->sint_ack_notifier, false, NULL);
+    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
     event_notifier_cleanup(&sint_route->sint_ack_notifier);
     event_notifier_cleanup(&sint_route->sint_set_notifier);
     g_free(sint_route);
diff --git a/util/event_notifier-posix.c b/util/event_notifier-posix.c
index f2aacfc..7e40252 100644
--- a/util/event_notifier-posix.c
+++ b/util/event_notifier-posix.c
@@ -90,15 +90,6 @@ int event_notifier_get_fd(const EventNotifier *e)
     return e->rfd;
 }
 
-int event_notifier_set_handler(EventNotifier *e,
-                               bool is_external,
-                               EventNotifierHandler *handler)
-{
-    aio_set_fd_handler(iohandler_get_aio_context(), e->rfd, is_external,
-                       (IOHandler *)handler, NULL, NULL, e);
-    return 0;
-}
-
 int event_notifier_set(EventNotifier *e)
 {
     static const uint64_t value = 1;
diff --git a/util/event_notifier-win32.c b/util/event_notifier-win32.c
index de87df0..519fb59 100644
--- a/util/event_notifier-win32.c
+++ b/util/event_notifier-win32.c
@@ -32,18 +32,6 @@ HANDLE event_notifier_get_handle(EventNotifier *e)
     return e->event;
 }
 
-int event_notifier_set_handler(EventNotifier *e,
-                               bool is_external,
-                               EventNotifierHandler *handler)
-{
-    if (handler) {
-        return qemu_add_wait_object(e->event, (IOHandler *)handler, e);
-    } else {
-        qemu_del_wait_object(e->event, (IOHandler *)handler, e);
-        return 0;
-    }
-}
-
 int event_notifier_set(EventNotifier *e)
 {
     SetEvent(e->event);
-- 
2.9.3
