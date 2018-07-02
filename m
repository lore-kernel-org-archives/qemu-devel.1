Received: from eggs.gnu.org ([2001:4830:134:3::10]:59338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AH-0007lr-5i
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1fa2AD-00040c-9H
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:59:01 -0400
Received: from mail-db5eur01on0103.outbound.protection.outlook.com
	([104.47.2.103]:6163
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1fa2AC-0003zS-TO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:58:57 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon,  2 Jul 2018 19:58:37 +0300
Message-Id: <20180702165842.11423-2-rkagan@virtuozzo.com>
In-Reply-To: <20180702165842.11423-1-rkagan@virtuozzo.com>
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/6] hyperv_testdev: refactor for better
 maintainability
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

Make hyperv_testdev slightly easier to follow and enhance in future.
For that, put the hyperv sint routes (wrapped in a helper structure) on
a linked list rather than a fixed-size array.  Besides, this way
HvSintRoute can be treated as an opaque structure, allowing for easier
refactoring of the core Hyper-V SynIC code in followup pathches.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/misc/hyperv_testdev.c | 116 +++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 61 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index bf6bbfa8cf..de07d7e8c3 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/queue.h"
 #include <linux/kvm.h>
 #include "hw/hw.h"
 #include "hw/qdev.h"
@@ -20,12 +21,17 @@
 #include "target/i386/hyperv.h"
 #include "kvm_i386.h"
 
-#define HV_TEST_DEV_MAX_SINT_ROUTES 64
+typedef struct TestSintRoute {
+    QLIST_ENTRY(TestSintRoute) le;
+    uint8_t vp_index;
+    uint8_t sint;
+    HvSintRoute *sint_route;
+} TestSintRoute;
 
 struct HypervTestDev {
     ISADevice parent_obj;
     MemoryRegion sint_control;
-    HvSintRoute *sint_route[HV_TEST_DEV_MAX_SINT_ROUTES];
+    QLIST_HEAD(, TestSintRoute) sint_routes;
 };
 typedef struct HypervTestDev HypervTestDev;
 
@@ -39,88 +45,76 @@ enum {
     HV_TEST_DEV_SINT_ROUTE_SET_SINT
 };
 
-static int alloc_sint_route_index(HypervTestDev *dev)
+static void sint_route_create(HypervTestDev *dev,
+                              uint8_t vp_index, uint8_t sint)
 {
-    int i;
+    TestSintRoute *sint_route;
 
-    for (i = 0; i < ARRAY_SIZE(dev->sint_route); i++) {
-        if (dev->sint_route[i] == NULL) {
-            return i;
-        }
-    }
-    return -1;
-}
+    sint_route = g_new0(TestSintRoute, 1);
+    assert(sint_route);
 
-static void free_sint_route_index(HypervTestDev *dev, int i)
-{
-    assert(i >= 0 && i < ARRAY_SIZE(dev->sint_route));
-    dev->sint_route[i] = NULL;
+    sint_route->vp_index = vp_index;
+    sint_route->sint = sint;
+
+    sint_route->sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL);
+    assert(sint_route->sint_route);
+
+    QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
 }
 
-static int find_sint_route_index(HypervTestDev *dev, uint32_t vp_index,
-                                 uint32_t sint)
+static TestSintRoute *sint_route_find(HypervTestDev *dev,
+                                      uint8_t vp_index, uint8_t sint)
 {
-    HvSintRoute *sint_route;
-    int i;
+    TestSintRoute *sint_route;
 
-    for (i = 0; i < ARRAY_SIZE(dev->sint_route); i++) {
-        sint_route = dev->sint_route[i];
-        if (sint_route && sint_route->vp_index == vp_index &&
-            sint_route->sint == sint) {
-            return i;
+    QLIST_FOREACH(sint_route, &dev->sint_routes, le) {
+        if (sint_route->vp_index == vp_index && sint_route->sint == sint) {
+            return sint_route;
         }
     }
-    return -1;
+    assert(false);
+    return NULL;
 }
 
-static void hv_synic_test_dev_control(HypervTestDev *dev, uint32_t ctl,
-                                      uint32_t vp_index, uint32_t sint)
+static void sint_route_destroy(HypervTestDev *dev,
+                               uint8_t vp_index, uint8_t sint)
 {
-    int i;
-    HvSintRoute *sint_route;
+    TestSintRoute *sint_route;
 
-    switch (ctl) {
-    case HV_TEST_DEV_SINT_ROUTE_CREATE:
-        i = alloc_sint_route_index(dev);
-        assert(i >= 0);
-        sint_route = kvm_hv_sint_route_create(vp_index, sint, NULL);
-        assert(sint_route);
-        dev->sint_route[i] = sint_route;
-        break;
-    case HV_TEST_DEV_SINT_ROUTE_DESTROY:
-        i = find_sint_route_index(dev, vp_index, sint);
-        assert(i >= 0);
-        sint_route = dev->sint_route[i];
-        kvm_hv_sint_route_destroy(sint_route);
-        free_sint_route_index(dev, i);
-        break;
-    case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
-        i = find_sint_route_index(dev, vp_index, sint);
-        assert(i >= 0);
-        sint_route = dev->sint_route[i];
-        kvm_hv_sint_route_set_sint(sint_route);
-        break;
-    default:
-        break;
-    }
+    sint_route = sint_route_find(dev, vp_index, sint);
+    QLIST_REMOVE(sint_route, le);
+    kvm_hv_sint_route_destroy(sint_route->sint_route);
+    g_free(sint_route);
+}
+
+static void sint_route_set_sint(HypervTestDev *dev,
+                                uint8_t vp_index, uint8_t sint)
+{
+    TestSintRoute *sint_route;
+
+    sint_route = sint_route_find(dev, vp_index, sint);
+
+    kvm_hv_sint_route_set_sint(sint_route->sint_route);
 }
 
 static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
                                 uint32_t len)
 {
     HypervTestDev *dev = HYPERV_TEST_DEV(opaque);
-    uint8_t ctl;
+    uint8_t sint = data & 0xFF;
+    uint8_t vp_index = (data >> 8ULL) & 0xFF;
+    uint8_t ctl = (data >> 16ULL) & 0xFF;
 
-    ctl = (data >> 16ULL) & 0xFF;
     switch (ctl) {
     case HV_TEST_DEV_SINT_ROUTE_CREATE:
+        sint_route_create(dev, vp_index, sint);
+        break;
     case HV_TEST_DEV_SINT_ROUTE_DESTROY:
-    case HV_TEST_DEV_SINT_ROUTE_SET_SINT: {
-        uint8_t sint = data & 0xFF;
-        uint8_t vp_index = (data >> 8ULL) & 0xFF;
-        hv_synic_test_dev_control(dev, ctl, vp_index, sint);
+        sint_route_destroy(dev, vp_index, sint);
+        break;
+    case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
+        sint_route_set_sint(dev, vp_index, sint);
         break;
-    }
     default:
         break;
     }
@@ -139,7 +133,7 @@ static void hv_test_dev_realizefn(DeviceState *d, Error **errp)
     HypervTestDev *dev = HYPERV_TEST_DEV(d);
     MemoryRegion *io = isa_address_space_io(isa);
 
-    memset(dev->sint_route, 0, sizeof(dev->sint_route));
+    QLIST_INIT(&dev->sint_routes);
     memory_region_init_io(&dev->sint_control, OBJECT(dev),
                           &synic_test_sint_ops, dev,
                           "hyperv-testdev-ctl", 4);
-- 
2.17.1
