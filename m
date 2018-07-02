Received: from eggs.gnu.org ([2001:4830:134:3::10]:59464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AO-0007w0-Oh
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AK-00047F-SQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:08 -0400
Received: from mail-eopbgr80117.outbound.protection.outlook.com
	([40.107.8.117]:8538
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa2AK-000465-GK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:04 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 19:58:40 +0300
Message-Id: <20180702165842.11423-5-rkagan@virtuozzo.com>
In-Reply-To: <20180702165842.11423-1-rkagan@virtuozzo.com>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 4/6] hyperv: allow passing arbitrary data to
 sint ack callback
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
index 00c9b454bb..93f7300dd6 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -19,21 +19,13 @@
 #include "qemu/event_notifier.h"
 
 typedef struct HvSintRoute HvSintRoute;
-typedef void (*HvSintAckClb)(HvSintRoute *sint_route);
-
-struct HvSintRoute {
-    uint32_t sint;
-    uint32_t vp_index;
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
index de07d7e8c3..50dfa6af64 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -56,7 +56,7 @@ static void sint_route_create(HypervTestDev *dev,
     sint_route->vp_index = vp_index;
     sint_route->sint = sint;
 
-    sint_route->sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL);
+    sint_route->sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL, NULL);
     assert(sint_route->sint_route);
 
     QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index acdb0ca9df..11fd1add2c 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -16,6 +16,16 @@
 #include "hyperv.h"
 #include "hyperv-proto.h"
 
+struct HvSintRoute {
+    uint32_t sint;
+    uint32_t vp_index;
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
     sint_route->vp_index = vp_index;
     sint_route->sint = sint;
 
-- 
2.17.1
