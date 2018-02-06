Received: from eggs.gnu.org ([2001:4830:134:3::10]:44788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tz-0000wr-5c
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tv-0003Bi-Pm
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:39 -0500
Received: from mail-eopbgr00109.outbound.protection.outlook.com
	([40.107.0.109]:52480
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9tu-00039t-S7
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:35 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:29 +0300
Message-Id: <20180206203048.11096-16-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 15/34] hyperv_testdev: add SynIC message
 and event testmodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>, Ben Warren <ben@skyportsystems.com>, si-wei liu <si-wei.liu@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, Vadim Rozenfeld <vrozenfe@redhat.com>

Add testmodes for SynIC messages and events.  The message or event
connection setup / teardown is initiated by the guest via new control
codes written to the test device port.  Then the test connections bounce
the respective operations back to the guest, i.e. the incoming messages
are posted or the incoming events are signaled on the configured vCPUs.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 hw/misc/hyperv_testdev.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 1 deletion(-)

diff --git a/hw/misc/hyperv_testdev.c b/hw/misc/hyperv_testdev.c
index fa435abbbf..79077789e1 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/misc/hyperv_testdev.c
@@ -13,12 +13,15 @@
 
 #include "qemu/osdep.h"
 #include "qemu/queue.h"
+#include "qemu/event_notifier.h"
+#include "qemu/main-loop.h"
 #include <linux/kvm.h>
 #include "hw/hw.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
 #include "sysemu/kvm.h"
 #include "target/i386/hyperv.h"
+#include "target/i386/hyperv-proto.h"
 #include "kvm_i386.h"
 
 typedef struct TestSintRoute {
@@ -28,10 +31,26 @@ typedef struct TestSintRoute {
     HvSintRoute *sint_route;
 } TestSintRoute;
 
+typedef struct TestMsgConn {
+    QLIST_ENTRY(TestMsgConn) le;
+    uint8_t conn_id;
+    HvSintRoute *sint_route;
+    struct hyperv_message msg;
+} TestMsgConn;
+
+typedef struct TestEvtConn {
+    QLIST_ENTRY(TestEvtConn) le;
+    uint8_t conn_id;
+    HvSintRoute *sint_route;
+    EventNotifier notifier;
+} TestEvtConn;
+
 struct HypervTestDev {
     ISADevice parent_obj;
     MemoryRegion sint_control;
     QLIST_HEAD(, TestSintRoute) sint_routes;
+    QLIST_HEAD(, TestMsgConn) msg_conns;
+    QLIST_HEAD(, TestEvtConn) evt_conns;
 };
 typedef struct HypervTestDev HypervTestDev;
 
@@ -42,7 +61,11 @@ typedef struct HypervTestDev HypervTestDev;
 enum {
     HV_TEST_DEV_SINT_ROUTE_CREATE = 1,
     HV_TEST_DEV_SINT_ROUTE_DESTROY,
-    HV_TEST_DEV_SINT_ROUTE_SET_SINT
+    HV_TEST_DEV_SINT_ROUTE_SET_SINT,
+    HV_TEST_DEV_MSG_CONN_CREATE,
+    HV_TEST_DEV_MSG_CONN_DESTROY,
+    HV_TEST_DEV_EVT_CONN_CREATE,
+    HV_TEST_DEV_EVT_CONN_DESTROY,
 };
 
 static void sint_route_create(HypervTestDev *dev, uint8_t vpidx, uint8_t sint)
@@ -95,6 +118,128 @@ static void sint_route_set_sint(HypervTestDev *dev,
     kvm_hv_sint_route_set_sint(sint_route->sint_route);
 }
 
+static void msg_cb(void *data, int status)
+{
+    TestMsgConn *conn = data;
+
+    assert(status == 0 || status == -EAGAIN);
+
+    if (!status) {
+        return;
+    }
+
+    /* no concurrent posting is expected so this should succeed */
+    assert(!hyperv_post_msg(conn->sint_route, &conn->msg));
+}
+
+static uint64_t msg_handler(const struct hyperv_post_message_input *msg,
+                            void *data)
+{
+    int ret;
+    TestMsgConn *conn = data;
+
+    /* post the same message we've got */
+    conn->msg.header.message_type = msg->message_type;
+    assert(msg->payload_size < sizeof(conn->msg.payload));
+    conn->msg.header.payload_size = msg->payload_size;
+    memcpy(&conn->msg.payload, msg->payload, msg->payload_size);
+
+    ret = hyperv_post_msg(conn->sint_route, &conn->msg);
+
+    switch (ret) {
+    case 0:
+        return HV_STATUS_SUCCESS;
+    case -EAGAIN:
+        return HV_STATUS_INSUFFICIENT_BUFFERS;
+    default:
+        return HV_STATUS_INVALID_HYPERCALL_INPUT;
+    }
+}
+
+static void msg_conn_create(HypervTestDev *dev, uint8_t vpidx,
+                            uint8_t sint, uint8_t conn_id)
+{
+    TestMsgConn *conn;
+
+    conn = g_new0(TestMsgConn, 1);
+    assert(conn);
+
+    conn->conn_id = conn_id;
+
+    conn->sint_route = hyperv_sint_route_new(vpidx, sint, msg_cb, conn);
+    assert(conn->sint_route);
+
+    assert(!hyperv_set_msg_handler(conn->conn_id, msg_handler, conn));
+
+    QLIST_INSERT_HEAD(&dev->msg_conns, conn, le);
+}
+
+static void msg_conn_destroy(HypervTestDev *dev, uint8_t conn_id)
+{
+    TestMsgConn *conn;
+
+    QLIST_FOREACH(conn, &dev->msg_conns, le) {
+        if (conn->conn_id == conn_id) {
+            QLIST_REMOVE(conn, le);
+            hyperv_set_msg_handler(conn->conn_id, NULL, NULL);
+            hyperv_sint_route_unref(conn->sint_route);
+            g_free(conn);
+            return;
+        }
+    }
+    assert(false);
+}
+
+static void evt_conn_handler(EventNotifier *notifier)
+{
+    TestEvtConn *conn = container_of(notifier, TestEvtConn, notifier);
+
+    event_notifier_test_and_clear(notifier);
+
+    /* signal the same event flag we've got */
+    assert(!hyperv_set_evt_flag(conn->sint_route, conn->conn_id));
+}
+
+static void evt_conn_create(HypervTestDev *dev, uint8_t vpidx,
+                            uint8_t sint, uint8_t conn_id)
+{
+    TestEvtConn *conn;
+
+    conn = g_new0(TestEvtConn, 1);
+    assert(conn);
+
+    conn->conn_id = conn_id;
+
+    conn->sint_route = hyperv_sint_route_new(vpidx, sint, NULL, NULL);
+    assert(conn->sint_route);
+
+    assert(!event_notifier_init(&conn->notifier, false));
+
+    event_notifier_set_handler(&conn->notifier, evt_conn_handler);
+
+    assert(!hyperv_set_evt_notifier(conn_id, &conn->notifier));
+
+    QLIST_INSERT_HEAD(&dev->evt_conns, conn, le);
+}
+
+static void evt_conn_destroy(HypervTestDev *dev, uint8_t conn_id)
+{
+    TestEvtConn *conn;
+
+    QLIST_FOREACH(conn, &dev->evt_conns, le) {
+        if (conn->conn_id == conn_id) {
+            QLIST_REMOVE(conn, le);
+            hyperv_set_evt_notifier(conn->conn_id, NULL);
+            event_notifier_set_handler(&conn->notifier, NULL);
+            event_notifier_cleanup(&conn->notifier);
+            hyperv_sint_route_unref(conn->sint_route);
+            g_free(conn);
+            return;
+        }
+    }
+    assert(false);
+}
+
 static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
                                 uint32_t len)
 {
@@ -102,6 +247,7 @@ static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
     uint8_t sint = data & 0xFF;
     uint8_t vpidx = (data >> 8ULL) & 0xFF;
     uint8_t ctl = (data >> 16ULL) & 0xFF;
+    uint8_t conn_id = (data >> 24ULL) & 0xFF;
 
     switch (ctl) {
     case HV_TEST_DEV_SINT_ROUTE_CREATE:
@@ -113,6 +259,18 @@ static void hv_test_dev_control(void *opaque, hwaddr addr, uint64_t data,
     case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
         sint_route_set_sint(dev, vpidx, sint);
         break;
+    case HV_TEST_DEV_MSG_CONN_CREATE:
+        msg_conn_create(dev, vpidx, sint, conn_id);
+        break;
+    case HV_TEST_DEV_MSG_CONN_DESTROY:
+        msg_conn_destroy(dev, conn_id);
+        break;
+    case HV_TEST_DEV_EVT_CONN_CREATE:
+        evt_conn_create(dev, vpidx, sint, conn_id);
+        break;
+    case HV_TEST_DEV_EVT_CONN_DESTROY:
+        evt_conn_destroy(dev, conn_id);
+        break;
     default:
         break;
     }
@@ -132,6 +290,8 @@ static void hv_test_dev_realizefn(DeviceState *d, Error **errp)
     MemoryRegion *io = isa_address_space_io(isa);
 
     QLIST_INIT(&dev->sint_routes);
+    QLIST_INIT(&dev->msg_conns);
+    QLIST_INIT(&dev->evt_conns);
     memory_region_init_io(&dev->sint_control, OBJECT(dev),
                           &synic_test_sint_ops, dev,
                           "hyperv-testdev-ctl", 4);
-- 
2.14.3
