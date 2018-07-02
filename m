Received: from eggs.gnu.org ([2001:4830:134:3::10]:59442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AM-0007rM-Kk
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AI-00045X-Ow
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:06 -0400
Received: from mail-eopbgr80097.outbound.protection.outlook.com
	([40.107.8.97]:59505
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa2AI-000440-D5
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:02 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 19:58:39 +0300
Message-Id: <20180702165842.11423-4-rkagan@virtuozzo.com>
In-Reply-To: <20180702165842.11423-1-rkagan@virtuozzo.com>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 3/6] hyperv: synic: only setup ack notifier if
 there's a callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

There's no point setting up an sint ack notifier if no callback is
specified.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 47368b77c0..acdb0ca9df 100644
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
2.17.1
