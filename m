Received: from eggs.gnu.org ([2001:4830:134:3::10]:35112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRn-0006mw-91
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiRk-0004U6-JB
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:39 -0400
Received: from mail-eopbgr30110.outbound.protection.outlook.com
	([40.107.3.110]:49429
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiRj-0004Tm-VK
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:25:36 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:09 +0300
Message-Id: <20170621162424.10462-9-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 08/23] hyperv_testdev: refactor for
 readability
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

Make hyperv_testdev slightly easier to follow and enhance in future.
For that, put the hyperv sint routes (wrapped in a helper structure) on
a linked list rather than a fixed-size array.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - was patch 7 in v1
 - renamed the variables to distinguish vp_index from vcpu_id

 hw/misc/hyperv_testdev.c | 114 ++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 61 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index dbd7cdd..b47af47 100644
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
+    uint8_t vpidx;
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
 
@@ -39,88 +45,74 @@ enum {
     HV_TEST_DEV_SINT_ROUTE_SET_SINT
 };
 
-static int alloc_sint_route_index(HypervTestDev *dev)
+static void sint_route_create(HypervTestDev *dev, uint8_t vpidx, uint8_t sint)
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
+    sint_route->vpidx = vpidx;
+    sint_route->sint = sint;
+
+    sint_route->sint_route = kvm_hv_sint_route_create(vpidx, sint, NULL);
+    assert(sint_route->sint_route);
+
+    QLIST_INSERT_HEAD(&dev->sint_routes, sint_route, le);
 }
 
-static int find_sint_route_index(HypervTestDev *dev, uint32_t vcpu_id,
-                                 uint32_t sint)
+static TestSintRoute *sint_route_find(HypervTestDev *dev,
+                                      uint8_t vpidx, uint8_t sint)
 {
-    HvSintRoute *sint_route;
-    int i;
+    TestSintRoute *sint_route;
 
-    for (i = 0; i < ARRAY_SIZE(dev->sint_route); i++) {
-        sint_route = dev->sint_route[i];
-        if (sint_route && sint_route->vcpu_id == vcpu_id &&
-            sint_route->sint == sint) {
-            return i;
+    QLIST_FOREACH(sint_route, &dev->sint_routes, le) {
+        if (sint_route->vpidx == vpidx && sint_route->sint == sint) {
+            return sint_route;
         }
     }
-    return -1;
+    assert(false);
+    return NULL;
 }
 
-static void hv_synic_test_dev_control(HypervTestDev *dev, uint32_t ctl,
-                                      uint32_t vcpu_id, uint32_t sint)
+static void sint_route_destroy(HypervTestDev *dev, uint8_t vpidx, uint8_t sint)
 {
-    int i;
-    HvSintRoute *sint_route;
+    TestSintRoute *sint_route;
 
-    switch (ctl) {
-    case HV_TEST_DEV_SINT_ROUTE_CREATE:
-        i = alloc_sint_route_index(dev);
-        assert(i >= 0);
-        sint_route = kvm_hv_sint_route_create(vcpu_id, sint, NULL);
-        assert(sint_route);
-        dev->sint_route[i] = sint_route;
-        break;
-    case HV_TEST_DEV_SINT_ROUTE_DESTROY:
-        i = find_sint_route_index(dev, vcpu_id, sint);
-        assert(i >= 0);
-        sint_route = dev->sint_route[i];
-        kvm_hv_sint_route_destroy(sint_route);
-        free_sint_route_index(dev, i);
-        break;
-    case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
-        i = find_sint_route_index(dev, vcpu_id, sint);
-        assert(i >= 0);
-        sint_route = dev->sint_route[i];
-        kvm_hv_sint_route_set_sint(sint_route);
-        break;
-    default:
-        break;
-    }
+    sint_route = sint_route_find(dev, vpidx, sint);
+    QLIST_REMOVE(sint_route, le);
+    kvm_hv_sint_route_destroy(sint_route->sint_route);
+    g_free(sint_route);
+}
+
+static void sint_route_set_sint(HypervTestDev *dev,
+                                uint8_t vpidx, uint8_t sint)
+{
+    TestSintRoute *sint_route;
+
+    sint_route = sint_route_find(dev, vpidx, sint);
+
+    kvm_hv_sint_route_set_sint(sint_route->sint_route);
 }
 
 static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
                                 uint32_t len)
 {
     HypervTestDev *dev = HYPERV_TEST_DEV(opaque);
-    uint8_t ctl;
+    uint8_t sint = data & 0xFF;
+    uint8_t vpidx = (data >> 8ULL) & 0xFF;
+    uint8_t ctl = (data >> 16ULL) & 0xFF;
 
-    ctl = (data >> 16ULL) & 0xFF;
     switch (ctl) {
     case HV_TEST_DEV_SINT_ROUTE_CREATE:
+        sint_route_create(dev, vpidx, sint);
+        break;
     case HV_TEST_DEV_SINT_ROUTE_DESTROY:
-    case HV_TEST_DEV_SINT_ROUTE_SET_SINT: {
-        uint8_t sint = data & 0xFF;
-        uint8_t vcpu_id = (data >> 8ULL) & 0xFF;
-        hv_synic_test_dev_control(dev, ctl, vcpu_id, sint);
+        sint_route_destroy(dev, vpidx, sint);
+        break;
+    case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
+        sint_route_set_sint(dev, vpidx, sint);
         break;
-    }
     default:
         break;
     }
@@ -139,7 +131,7 @@ static void hv_test_dev_realizefn(DeviceState *d, Error **errp)
     HypervTestDev *dev = HYPERV_TEST_DEV(d);
     MemoryRegion *io = isa_address_space_io(isa);
 
-    memset(dev->sint_route, 0, sizeof(dev->sint_route));
+    QLIST_INIT(&dev->sint_routes);
     memory_region_init_io(&dev->sint_control, OBJECT(dev),
                           &synic_test_sint_ops, dev,
                           "hyperv-testdev-ctl", 4);
-- 
2.9.4
