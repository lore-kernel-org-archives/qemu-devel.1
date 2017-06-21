Received: from eggs.gnu.org ([2001:4830:134:3::10]:35204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRx-0006vY-PX
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRu-0004Wh-Oi
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:49 -0400
Received: from mail-eopbgr30100.outbound.protection.outlook.com
	([40.107.3.100]:23032
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiRu-0004W9-Dh
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:46 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:11 +0300
Message-Id: <20170621162424.10462-11-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 10/23] hyperv: synic: only setup ack
 notifier if there's a callback
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

There's no point setting up an sint ack notifier if no callback is
specified.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 2121d8f..3594bd0 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -77,15 +77,14 @@ static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
     HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
                                            sint_ack_notifier);
     event_notifier_test_and_clear(notifier);
-    if (sint_route->sint_ack_clb) {
-        sint_route->sint_ack_clb(sint_route);
-    }
+    sint_route->sint_ack_clb(sint_route);
 }
 
 HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
                                       HvSintAckClb sint_ack_clb)
 {
     HvSintRoute *sint_route;
+    EventNotifier *ack_notifier;
     int r, gsi;
 
     sint_route = g_new0(HvSintRoute, 1);
@@ -94,13 +93,15 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
         goto err;
     }
 
-    r = event_notifier_init(&sint_route->sint_ack_notifier, false);
-    if (r) {
-        goto err_sint_set_notifier;
-    }
+    ack_notifier = sint_ack_clb ? &sint_route->sint_ack_notifier : NULL;
+    if (ack_notifier) {
+        r = event_notifier_init(ack_notifier, false);
+        if (r) {
+            goto err_sint_set_notifier;
+        }
 
-    event_notifier_set_handler(&sint_route->sint_ack_notifier,
-                               kvm_hv_sint_ack_handler);
+        event_notifier_set_handler(ack_notifier, kvm_hv_sint_ack_handler);
+    }
 
     gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
     if (gsi < 0) {
@@ -109,7 +110,7 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
 
     r = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
                                            &sint_route->sint_set_notifier,
-                                           &sint_route->sint_ack_notifier, gsi);
+                                           ack_notifier, gsi);
     if (r) {
         goto err_irqfd;
     }
@@ -123,8 +124,10 @@ HvSintRoute *kvm_hv_sint_route_create(uint32_t vp_index, uint32_t sint,
 err_irqfd:
     kvm_irqchip_release_virq(kvm_state, gsi);
 err_gsi:
-    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
-    event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    if (ack_notifier) {
+        event_notifier_set_handler(ack_notifier, NULL);
+        event_notifier_cleanup(ack_notifier);
+    }
 err_sint_set_notifier:
     event_notifier_cleanup(&sint_route->sint_set_notifier);
 err:
@@ -139,8 +142,10 @@ void kvm_hv_sint_route_destroy(HvSintRoute *sint_route)
                                           &sint_route->sint_set_notifier,
                                           sint_route->gsi);
     kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
-    event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
-    event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    if (sint_route->sint_ack_clb) {
+        event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
+        event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    }
     event_notifier_cleanup(&sint_route->sint_set_notifier);
     g_free(sint_route);
 }
-- 
2.9.4
