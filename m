Received: from eggs.gnu.org ([2001:4830:134:3::10]:35510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSq-0007ja-Lt
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSo-0004pp-1e
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:44 -0400
Received: from mail-eopbgr30102.outbound.protection.outlook.com
	([40.107.3.102]:29592
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiSn-0004ow-Jo
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:41 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:21 +0300
Message-Id: <20170621162424.10462-21-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 20/23] hyperv: process POST_MESSAGE hypercall
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

Add handling of POST_MESSAGE hypercall.  For that, add an interface to
regsiter a handler for the messages arrived from the guest on a
particular connection id (IOW set up a message connection in Hyper-V
speak).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - use single mutex for evt and msg handler lists

 target/i386/hyperv.h |  5 +++
 target/i386/hyperv.c | 87 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 46c6836..f101144 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -43,6 +43,11 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
 
 int hyperv_set_evt_flag(HvSintRoute *sint_route, unsigned evtno);
 
+struct hyperv_post_message_input;
+typedef uint64_t (*HvMsgHandler)(const struct hyperv_post_message_input *msg,
+                                 void *data);
+int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data);
+
 int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier);
 
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 8abb418..f779977 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -246,6 +246,14 @@ static void async_synic_update(CPUState *cs, run_on_cpu_data data)
     qemu_mutex_unlock_iothread();
 }
 
+typedef struct MsgHandler {
+    struct rcu_head rcu;
+    QLIST_ENTRY(MsgHandler) le;
+    uint32_t conn_id;
+    HvMsgHandler handler;
+    void *data;
+} MsgHandler;
+
 typedef struct EvtHandler {
     struct rcu_head rcu;
     QLIST_ENTRY(EvtHandler) le;
@@ -253,15 +261,51 @@ typedef struct EvtHandler {
     EventNotifier *notifier;
 } EvtHandler;
 
+static QLIST_HEAD(, MsgHandler) msg_handlers;
 static QLIST_HEAD(, EvtHandler) evt_handlers;
 static QemuMutex handlers_mutex;
 
 static void __attribute__((constructor)) hv_init(void)
 {
+    QLIST_INIT(&msg_handlers);
     QLIST_INIT(&evt_handlers);
     qemu_mutex_init(&handlers_mutex);
 }
 
+int hyperv_set_msg_handler(uint32_t conn_id, HvMsgHandler handler, void *data)
+{
+    int ret;
+    MsgHandler *mh;
+
+    qemu_mutex_lock(&handlers_mutex);
+    QLIST_FOREACH(mh, &msg_handlers, le) {
+        if (mh->conn_id == conn_id) {
+            if (handler) {
+                ret = -EEXIST;
+            } else {
+                QLIST_REMOVE_RCU(mh, le);
+                g_free_rcu(mh, rcu);
+                ret = 0;
+            }
+            goto unlock;
+        }
+    }
+
+    if (handler) {
+        mh = g_new(MsgHandler, 1);
+        mh->conn_id = conn_id;
+        mh->handler = handler;
+        mh->data = data;
+        QLIST_INSERT_HEAD_RCU(&msg_handlers, mh, le);
+        ret = 0;
+    } else {
+        ret = -ENOENT;
+    }
+unlock:
+    qemu_mutex_unlock(&handlers_mutex);
+    return ret;
+}
+
 int hyperv_set_evt_notifier(uint32_t conn_id, EventNotifier *notifier)
 {
     int ret;
@@ -295,6 +339,46 @@ unlock:
     return ret;
 }
 
+static uint64_t hvcall_post_message(uint64_t param, bool fast)
+{
+    uint64_t ret;
+    hwaddr len;
+    struct hyperv_post_message_input *msg;
+    MsgHandler *mh;
+
+    if (fast) {
+        return HV_STATUS_INVALID_HYPERCALL_CODE;
+    }
+    if (param & (__alignof__(*msg) - 1)) {
+        return HV_STATUS_INVALID_ALIGNMENT;
+    }
+
+    len = sizeof(*msg);
+    msg = cpu_physical_memory_map(param, &len, 0);
+    if (len < sizeof(*msg)) {
+        ret = HV_STATUS_INSUFFICIENT_MEMORY;
+        goto unmap;
+    }
+    if (msg->payload_size > sizeof(msg->payload)) {
+        ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+        goto unmap;
+    }
+
+    ret = HV_STATUS_INVALID_CONNECTION_ID;
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(mh, &msg_handlers, le) {
+        if (mh->conn_id == (msg->connection_id & HV_CONNECTION_ID_MASK)) {
+            ret = mh->handler(msg, mh->data);
+            break;
+        }
+    }
+    rcu_read_unlock();
+
+unmap:
+    cpu_physical_memory_unmap(msg, len, 0, 0);
+    return ret;
+}
+
 static uint64_t sigevent_params(hwaddr addr, uint32_t *conn_id)
 {
     uint64_t ret;
@@ -383,6 +467,9 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         uint64_t param = exit->u.hcall.params[0];
 
         switch (code) {
+        case HV_POST_MESSAGE:
+            exit->u.hcall.result = hvcall_post_message(param, fast);
+            break;
         case HV_SIGNAL_EVENT:
             exit->u.hcall.result = hvcall_signal_event(param, fast);
             break;
-- 
2.9.4
