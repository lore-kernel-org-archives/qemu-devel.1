Received: from eggs.gnu.org ([2001:4830:134:3::10]:48561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyr-0008DL-R4
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyk-0006jH-Et
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:12 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyi-0006ha-Tj
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:10 -0400
Received: by mail-wr1-x441.google.com with SMTP id n1-v6so35103031wrt.10
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:08 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:13 +0200
Message-Id: <1539894735-14232-47-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 46/48] hyperv_testdev: add SynIC message and
 event testmodes
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

Add testmodes for SynIC messages and events.  The message or event
connection setup / teardown is initiated by the guest via new control
codes written to the test device port.  Then the test connections bounce
the respective operations back to the guest, i.e. the incoming messages
are posted or the incoming events are signaled on the configured vCPUs.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv_testdev.c | 165 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
index fc3f6c5..4880333 100644
--- a/hw/hyperv/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu/queue.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
@@ -24,10 +25,26 @@ typedef struct TestSintRoute {
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
 
@@ -38,7 +55,11 @@ typedef struct HypervTestDev HypervTestDev;
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
 
 static void sint_route_create(HypervTestDev *dev,
@@ -93,6 +114,133 @@ static void sint_route_set_sint(HypervTestDev *dev,
     hyperv_sint_route_set_sint(sint_route->sint_route);
 }
 
+static void msg_retry(void *opaque)
+{
+    TestMsgConn *conn = opaque;
+    assert(!hyperv_post_msg(conn->sint_route, &conn->msg));
+}
+
+static void msg_cb(void *data, int status)
+{
+    TestMsgConn *conn = data;
+
+    if (!status) {
+        return;
+    }
+
+    assert(status == -EAGAIN);
+
+    aio_bh_schedule_oneshot(qemu_get_aio_context(), msg_retry, conn);
+}
+
+static uint16_t msg_handler(const struct hyperv_post_message_input *msg,
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
+static void msg_conn_create(HypervTestDev *dev, uint8_t vp_index,
+                            uint8_t sint, uint8_t conn_id)
+{
+    TestMsgConn *conn;
+
+    conn = g_new0(TestMsgConn, 1);
+    assert(conn);
+
+    conn->conn_id = conn_id;
+
+    conn->sint_route = hyperv_sint_route_new(vp_index, sint, msg_cb, conn);
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
+    assert(!hyperv_set_event_flag(conn->sint_route, conn->conn_id));
+}
+
+static void evt_conn_create(HypervTestDev *dev, uint8_t vp_index,
+                            uint8_t sint, uint8_t conn_id)
+{
+    TestEvtConn *conn;
+
+    conn = g_new0(TestEvtConn, 1);
+    assert(conn);
+
+    conn->conn_id = conn_id;
+
+    conn->sint_route = hyperv_sint_route_new(vp_index, sint, NULL, NULL);
+    assert(conn->sint_route);
+
+    assert(!event_notifier_init(&conn->notifier, false));
+
+    event_notifier_set_handler(&conn->notifier, evt_conn_handler);
+
+    assert(!hyperv_set_event_flag_handler(conn_id, &conn->notifier));
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
+            hyperv_set_event_flag_handler(conn->conn_id, NULL);
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
 static uint64_t hv_test_dev_read(void *opaque, hwaddr addr, unsigned size)
 {
     return 0;
@@ -105,6 +253,7 @@ static void hv_test_dev_write(void *opaque, hwaddr addr, uint64_t data,
     uint8_t sint = data & 0xFF;
     uint8_t vp_index = (data >> 8ULL) & 0xFF;
     uint8_t ctl = (data >> 16ULL) & 0xFF;
+    uint8_t conn_id = (data >> 24ULL) & 0xFF;
 
     switch (ctl) {
     case HV_TEST_DEV_SINT_ROUTE_CREATE:
@@ -116,6 +265,18 @@ static void hv_test_dev_write(void *opaque, hwaddr addr, uint64_t data,
     case HV_TEST_DEV_SINT_ROUTE_SET_SINT:
         sint_route_set_sint(dev, vp_index, sint);
         break;
+    case HV_TEST_DEV_MSG_CONN_CREATE:
+        msg_conn_create(dev, vp_index, sint, conn_id);
+        break;
+    case HV_TEST_DEV_MSG_CONN_DESTROY:
+        msg_conn_destroy(dev, conn_id);
+        break;
+    case HV_TEST_DEV_EVT_CONN_CREATE:
+        evt_conn_create(dev, vp_index, sint, conn_id);
+        break;
+    case HV_TEST_DEV_EVT_CONN_DESTROY:
+        evt_conn_destroy(dev, conn_id);
+        break;
     default:
         break;
     }
@@ -136,6 +297,8 @@ static void hv_test_dev_realizefn(DeviceState *d, Error **errp)
     MemoryRegion *io = isa_address_space_io(isa);
 
     QLIST_INIT(&dev->sint_routes);
+    QLIST_INIT(&dev->msg_conns);
+    QLIST_INIT(&dev->evt_conns);
     memory_region_init_io(&dev->sint_control, OBJECT(dev),
                           &synic_test_sint_ops, dev,
                           "hyperv-testdev-ctl", 4);
-- 
1.8.3.1
