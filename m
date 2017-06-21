Received: from eggs.gnu.org ([2001:4830:134:3::10]:35313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSE-0007An-2m
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSB-0004c8-Fv
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:06 -0400
Received: from mail-ve1eur01on0123.outbound.protection.outlook.com
	([104.47.1.123]:21376
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiSB-0004bf-2N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:03 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:14 +0300
Message-Id: <20170621162424.10462-14-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 13/23] hyperv: make HvSintRoute
 reference-counted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>, Igor Mammedov <imammedo@redhat.com>

Multiple entities (e.g. VMBus devices) can use the same SINT route.  To
make their lives easier in maintaining SINT route ownership, make it
reference-counted.  Adjust the respective API names accordingly.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h     | 10 +++++-----
 hw/misc/hyperv_testdev.c |  4 ++--
 target/i386/hyperv.c     | 25 +++++++++++++++++++++----
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 93f7300..af5fc05 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -23,11 +23,11 @@ typedef void (*HvSintAckClb)(void *data);
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb,
-                                      void *sint_ack_clb_data);
-
-void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
+HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data);
+void hyperv_sint_route_ref(HvSintRoute *sint_route);
+void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
 int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 827a8b1..fa435ab 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -55,7 +55,7 @@ static void sint_route_create(HypervTestDev *dev, uint8_t vpidx, uint8_t sint)
     sint_route->vpidx = vpidx;
     sint_route->sint = sint;
 
-    sint_route->sint_route = kvm_hv_sint_route_create(vpidx, sint, NULL, NULL);
+    sint_route->sint_route = hyperv_sint_route_new(vpidx, sint, NULL, NULL);
     assert(sint_route->sint_route);
 
     QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
@@ -81,7 +81,7 @@ static void sint_route_destroy(HypervTestDev *dev, uint8_t vpidx, uint8_t sint)
 
     sint_route = sint_route_find(dev, vpidx, sint);
     QLIST_REMOVE(sint_route, le);
-    kvm_hv_sint_route_destroy(sint_route->sint_route);
+    hyperv_sint_route_unref(sint_route->sint_route);
     g_free(sint_route);
 }
 
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index b5831bf..012c79d 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -24,6 +24,7 @@ struct HvSintRoute {
     EventNotifier sint_ack_notifier;
     HvSintAckClb sint_ack_clb;
     void *sint_ack_clb_data;
+    unsigned refcount;
 };
 
 uint32_t hyperv_vp_index(X86CPU *cpu)
@@ -90,9 +91,9 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
 }
 
-HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb,
-                                      void *sint_ack_clb_data)
+HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data)
 {
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
@@ -136,6 +137,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     sint_route->sint_ack_clb_data = sint_ack_clb_data;
     sint_route->cpu = cpu;
     sint_route->sint = sint;
+    sint_route->refcount = 1;
 
     return sint_route;
 
@@ -154,8 +156,23 @@ err:
     return NULL;
 }
 
-void kvm_hv_sint_route_destroy(HvSintRoute *sint_route)
+void hyperv_sint_route_ref(HvSintRoute *sint_route)
 {
+    sint_route->refcount++;
+}
+
+void hyperv_sint_route_unref(HvSintRoute *sint_route)
+{
+    if (!sint_route) {
+        return;
+    }
+
+    assert(sint_route->refcount > 0);
+
+    if (--sint_route->refcount) {
+        return;
+    }
+
     kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
                                           &sint_route->sint_set_notifier,
                                           sint_route->gsi);
-- 
2.9.4
