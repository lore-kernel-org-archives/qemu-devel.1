Received: from eggs.gnu.org ([2001:4830:134:3::10]:35237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiS3-00070j-8N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiS0-0004YR-KW
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:55 -0400
Received: from mail-ve1eur01on0107.outbound.protection.outlook.com
	([104.47.1.107]:60724
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiS0-0004Y1-7b
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:52 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:12 +0300
Message-Id: <20170621162424.10462-12-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 11/23] hyperv: allow passing arbitrary data
 to sint ack callback
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

Make sint ack callback accept an opaque pointer, that is stored on
sint_route at creation time.

This allows for more convenient interaction with the callback.

Besides, nothing outside hyperv.c should need to know the layout of
HvSintRoute fields any more so its declaration can be removed from the
header.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h     | 14 +++-----------
 hw/misc/hyperv_testdev.c |  2 +-
 target/i386/hyperv.c     | 16 ++++++++++++++--
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 82f4757..93f7300 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -19,21 +19,13 @@
 #include "qemu/event_notifier.h"
 
 typedef struct HvSintRoute HvSintRoute;
-typedef void (*HvSintAckClb)(HvSintRoute *sint_route);
-
-struct HvSintRoute {
-    uint32_t sint;
-    uint32_t vcpu_id;
-    int gsi;
-    EventNotifier sint_set_notifier;
-    EventNotifier sint_ack_notifier;
-    HvSintAckClb sint_ack_clb;
-};
+typedef void (*HvSintAckClb)(void *data);
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
 HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb);
+                                      HvSintAckClb sint_ack_clb,
+                                      void *sint_ack_clb_data);
 
 void kvm_hv_sint_route_destroy(HvSintRoute *sint_route);
 
diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index b47af47..827a8b1 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -55,7 +55,7 @@ static void sint_route_create(HypervTestDev *dev, uint8_t vpidx, uint8_t sint)
     sint_route->vpidx = vpidx;
     sint_route->sint = sint;
 
-    sint_route->sint_route = kvm_hv_sint_route_create(vpidx, sint, NULL);
+    sint_route->sint_route = kvm_hv_sint_route_create(vpidx, sint, NULL, NULL);
     assert(sint_route->sint_route);
 
     QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 3594bd0..84ea228 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -16,6 +16,16 @@
 #include "hyperv.h"
 #include "hyperv_proto.h"
 
+struct HvSintRoute {
+    uint32_t sint;
+    uint32_t vcpu_id;
+    int gsi;
+    EventNotifier sint_set_notifier;
+    EventNotifier sint_ack_notifier;
+    HvSintAckClb sint_ack_clb;
+    void *sint_ack_clb_data;
+};
+
 uint32_t hyperv_vp_index(X86CPU *cpu)
 {
     return CPU(cpu)->cpu_index;
@@ -77,11 +87,12 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
                                            sint_ack_notifier);
     event_notifier_test_and_clear(notifier);
-    sint_route->sint_ack_clb(sint_route);
+    sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
 }
 
 HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
-                                      HvSintAckClb sint_ack_clb)
+                                      HvSintAckClb sint_ack_clb,
+                                      void *sint_ack_clb_data)
 {
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
@@ -116,6 +127,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
     }
     sint_route->gsi = gsi;
     sint_route->sint_ack_clb = sint_ack_clb;
+    sint_route->sint_ack_clb_data = sint_ack_clb_data;
     sint_route->vcpu_id = vp_index;
     sint_route->sint = sint;
 
-- 
2.9.4
