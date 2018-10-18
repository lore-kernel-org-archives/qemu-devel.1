Received: from eggs.gnu.org ([2001:4830:134:3::10]:48522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyg-0007qI-SF
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyf-0006fn-PJ
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:42135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyf-0006f1-Fh
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:05 -0400
Received: by mail-wr1-x429.google.com with SMTP id r17-v6so2746659wrt.9
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:05 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:10 +0200
Message-Id: <1539894735-14232-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/48] hyperv: process SIGNAL_EVENT hypercall
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

Add handling of SIGNAL_EVENT hypercall.  For that, provide an interface
to associate an EventNotifier with an event connection number, so that
it's signaled when the SIGNAL_EVENT hypercall with the matching
connection ID is called by the guest.

Support for using KVM functionality for this will be added in a followup
patch.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082217.29481-8-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c               | 93 ++++++++++++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv-proto.h |  1 +
 include/hw/hyperv/hyperv.h       | 13 ++++++
 target/i386/hyperv.c             | 10 +++--
 4 files changed, 113 insertions(+), 4 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 2b0e593..d745016 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -13,6 +13,9 @@
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "qemu/bitops.h"
+#include "qemu/queue.h"
+#include "qemu/rcu.h"
+#include "qemu/rcu_queue.h"
 #include "hw/hyperv/hyperv.h"
 
 typedef struct SynICState {
@@ -450,3 +453,93 @@ int hyperv_sint_route_set_sint(HvSintRoute *sint_route)
 {
     return event_notifier_set(&sint_route->sint_set_notifier);
 }
+
+typedef struct EventFlagHandler {
+    struct rcu_head rcu;
+    QLIST_ENTRY(EventFlagHandler) link;
+    uint32_t conn_id;
+    EventNotifier *notifier;
+} EventFlagHandler;
+
+static QLIST_HEAD(, EventFlagHandler) event_flag_handlers;
+static QemuMutex handlers_mutex;
+
+static void __attribute__((constructor)) hv_init(void)
+{
+    QLIST_INIT(&event_flag_handlers);
+    qemu_mutex_init(&handlers_mutex);
+}
+
+int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
+{
+    int ret;
+    EventFlagHandler *handler;
+
+    qemu_mutex_lock(&handlers_mutex);
+    QLIST_FOREACH(handler, &event_flag_handlers, link) {
+        if (handler->conn_id == conn_id) {
+            if (notifier) {
+                ret = -EEXIST;
+            } else {
+                QLIST_REMOVE_RCU(handler, link);
+                g_free_rcu(handler, rcu);
+                ret = 0;
+            }
+            goto unlock;
+        }
+    }
+
+    if (notifier) {
+        handler = g_new(EventFlagHandler, 1);
+        handler->conn_id = conn_id;
+        handler->notifier = notifier;
+        QLIST_INSERT_HEAD_RCU(&event_flag_handlers, handler, link);
+        ret = 0;
+    } else {
+        ret = -ENOENT;
+    }
+unlock:
+    qemu_mutex_unlock(&handlers_mutex);
+    return ret;
+}
+
+uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
+{
+    uint16_t ret;
+    EventFlagHandler *handler;
+
+    if (unlikely(!fast)) {
+        hwaddr addr = param;
+
+        if (addr & (__alignof__(addr) - 1)) {
+            return HV_STATUS_INVALID_ALIGNMENT;
+        }
+
+        param = ldq_phys(&address_space_memory, addr);
+    }
+
+    /*
+     * Per spec, bits 32-47 contain the extra "flag number".  However, we
+     * have no use for it, and in all known usecases it is zero, so just
+     * report lookup failure if it isn't.
+     */
+    if (param & 0xffff00000000ULL) {
+        return HV_STATUS_INVALID_PORT_ID;
+    }
+    /* remaining bits are reserved-zero */
+    if (param & ~HV_CONNECTION_ID_MASK) {
+        return HV_STATUS_INVALID_HYPERCALL_INPUT;
+    }
+
+    ret = HV_STATUS_INVALID_CONNECTION_ID;
+    rcu_read_lock();
+    QLIST_FOREACH_RCU(handler, &event_flag_handlers, link) {
+        if (handler->conn_id == param) {
+            event_notifier_set(handler->notifier);
+            ret = 0;
+            break;
+        }
+    }
+    rcu_read_unlock();
+    return ret;
+}
diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index 2dc78ee..21dc28a 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -21,6 +21,7 @@
 #define HV_STATUS_INVALID_ALIGNMENT           4
 #define HV_STATUS_INVALID_PARAMETER           5
 #define HV_STATUS_INSUFFICIENT_MEMORY         11
+#define HV_STATUS_INVALID_PORT_ID             17
 #define HV_STATUS_INVALID_CONNECTION_ID       18
 #define HV_STATUS_INSUFFICIENT_BUFFERS        19
 
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 757c85e..df92ed7 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -39,6 +39,19 @@ int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
  */
 int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno);
 
+/*
+ * Associate @notifier with the event connection @conn_id, such that @notifier
+ * is signaled when the guest executes HV_SIGNAL_EVENT hypercall on @conn_id.
+ * If @notifier is NULL clear the association.
+ */
+int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier);
+
+/*
+ * Process HV_SIGNAL_EVENT hypercall: signal the EventNotifier associated with
+ * the connection as specified in @param.
+ */
+uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast);
+
 static inline uint32_t hyperv_vp_index(CPUState *cs)
 {
     return cs->cpu_index;
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 3f76c3e..96b3b5a 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -79,16 +79,18 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 
         return 0;
     case KVM_EXIT_HYPERV_HCALL: {
-        uint16_t code;
+        uint16_t code = exit->u.hcall.input & 0xffff;
+        bool fast = exit->u.hcall.input & HV_HYPERCALL_FAST;
+        uint64_t param = exit->u.hcall.params[0];
 
-        code  = exit->u.hcall.input & 0xffff;
         switch (code) {
-        case HV_POST_MESSAGE:
         case HV_SIGNAL_EVENT:
+            exit->u.hcall.result = hyperv_hcall_signal_event(param, fast);
+            break;
         default:
             exit->u.hcall.result = HV_STATUS_INVALID_HYPERCALL_CODE;
-            return 0;
         }
+        return 0;
     }
     default:
         return -1;
-- 
1.8.3.1
