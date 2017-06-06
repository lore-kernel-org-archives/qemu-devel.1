Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5R-0005tl-D3
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dIJ5N-0007Lq-2e
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:13 -0400
Received: from mail-eopbgr30096.outbound.protection.outlook.com
	([40.107.3.96]:6976
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dIJ5M-0007IW-Rh
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 14:20:09 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Jun 2017 21:19:37 +0300
Message-Id: <20170606181948.16238-13-rkagan@virtuozzo.com>
In-Reply-To: <20170606181948.16238-1-rkagan@virtuozzo.com>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 12/23] hyperv: make HvSintRoute
 reference-counted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

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
index bc071da..ca5a32d 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -23,11 +23,11 @@ typedef void (*HvSintAckClb)(void *data);
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
-HvSintRoute *kvm_hv_sint_route_create(X86CPU *cpu, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb,
-                                      void *sint_ack_clb_data);
-
-void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
+HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data);
+void hyperv_sint_route_ref(HvSintRoute *sint_route);
+void hyperv_sint_route_unref(HvSintRoute *sint_route);
 
 int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 1b12295..929bf4f 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -55,7 +55,7 @@ static void sint_route_create(HypervTestDev *dev, X86CPU *cpu, uint8_t sint)
     sint_route->cpu = cpu;
     sint_route->sint = sint;
 
-    sint_route->sint_route = kvm_hv_sint_route_create(cpu, sint, NULL, NULL);
+    sint_route->sint_route = hyperv_sint_route_new(cpu, sint, NULL, NULL);
     assert(sint_route->sint_route);
 
     QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
@@ -81,7 +81,7 @@ static void sint_route_destroy(HypervTestDev *dev, X86CPU *cpu, uint8_t sint)
 
     sint_route = sint_route_find(dev, cpu, sint);
     QLIST_REMOVE(sint_route, le);
-    kvm_hv_sint_route_destroy(sint_route->sint_route);
+    hyperv_sint_route_unref(sint_route->sint_route);
     g_free(sint_route);
 }
 
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index a150401..ae67f82 100644
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
 
-HvSintRoute *kvm_hv_sint_route_create(X86CPU *cpu, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb,
-                                      void *sint_ack_clb_data)
+HvSintRoute *hyperv_sint_route_new(X86CPU *cpu, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data)
 {
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
@@ -130,6 +131,7 @@ HvSintRoute *kvm_hv_sint_route_create(X86CPU *cpu, uint32_t sint,
     sint_route->sint_ack_clb_data = sint_ack_clb_data;
     sint_route->cpu = cpu;
     sint_route->sint = sint;
+    sint_route->refcount = 1;
 
     return sint_route;
 
@@ -148,8 +150,23 @@ err:
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
