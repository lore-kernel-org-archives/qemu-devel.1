Received: from eggs.gnu.org ([2001:4830:134:3::10]:48244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyO-0007QR-S0
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyN-0006QF-0p
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:40851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyL-0006OC-HT
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id z204-v6so1611202wmc.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:45 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:51 +0200
Message-Id: <1539894735-14232-25-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 24/48] hyperv_testdev: refactor for better
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
Cc: Roman Kagan <rkagan@virtuozzo.com>

From: Roman Kagan <rkagan@virtuozzo.com>

Make hyperv_testdev slightly easier to follow and enhance in future.
For that, put the hyperv sint routes (wrapped in a helper structure) on
a linked list rather than a fixed-size array.  Besides, this way
HvSintRoute can be treated as an opaque structure, allowing for easier
refactoring of the core Hyper-V SynIC code in followup pathches.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921081836.29230-2-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/hyperv_testdev.c | 116 ++++++++++++++++++++++-------------------------
 1 file changed, 55 insertions(+), 61 deletions(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index 7549f47..915d74e 100644
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
 
@@ -39,70 +45,56 @@ enum {
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
 
 static uint64_t hv_test_dev_read(void *opaque, hwaddr addr, unsigned size)
@@ -114,18 +106,20 @@ static void hv_test_dev_write(void *opaque, hwaddr addr, uint64_t data,
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
@@ -145,7 +139,7 @@ static void hv_test_dev_realizefn(DeviceState *d, Error **errp)
     HypervTestDev *dev = HYPERV_TEST_DEV(d);
     MemoryRegion *io = isa_address_space_io(isa);
 
-    memset(dev->sint_route, 0, sizeof(dev->sint_route));
+    QLIST_INIT(&dev->sint_routes);
     memory_region_init_io(&dev->sint_control, OBJECT(dev),
                           &synic_test_sint_ops, dev,
                           "hyperv-testdev-ctl", 4);
-- 
1.8.3.1
