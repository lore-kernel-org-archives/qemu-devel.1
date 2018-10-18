Received: from eggs.gnu.org ([2001:4830:134:3::10]:48495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyf-0007qF-6l
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEye-0006el-Fz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEye-0006eD-9K
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:04 -0400
Received: by mail-wm1-x342.google.com with SMTP id z204-v6so1612001wmc.5
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:04 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:09 +0200
Message-Id: <1539894735-14232-43-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 42/48] hyperv: add synic event flag signaling
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

Add infrastructure to signal SynIC event flags by atomically setting the
corresponding bit in the event flags page and firing a SINT if
necessary.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082217.29481-7-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c         | 32 ++++++++++++++++++++++++++++++++
 include/hw/hyperv/hyperv.h |  4 ++++
 2 files changed, 36 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 654ca4f..2b0e593 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
+#include "qemu/bitops.h"
 #include "hw/hyperv/hyperv.h"
 
 typedef struct SynICState {
@@ -310,6 +311,37 @@ static void sint_ack_handler(EventNotifier *notifier)
     aio_bh_schedule_oneshot(qemu_get_aio_context(), sint_msg_bh, sint_route);
 }
 
+/*
+ * Set given event flag for a given sint on a given vcpu, and signal the sint.
+ */
+int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno)
+{
+    int ret;
+    SynICState *synic = sint_route->synic;
+    unsigned long *flags, set_mask;
+    unsigned set_idx;
+
+    if (eventno > HV_EVENT_FLAGS_COUNT) {
+        return -EINVAL;
+    }
+    if (!synic->enabled || !synic->event_page_addr) {
+        return -ENXIO;
+    }
+
+    set_idx = BIT_WORD(eventno);
+    set_mask = BIT_MASK(eventno);
+    flags = synic->event_page->slot[sint_route->sint].flags;
+
+    if ((atomic_fetch_or(&flags[set_idx], set_mask) & set_mask) != set_mask) {
+        memory_region_set_dirty(&synic->event_page_mr, 0,
+                                sizeof(*synic->event_page));
+        ret = hyperv_sint_route_set_sint(sint_route);
+    } else {
+        ret = 0;
+    }
+    return ret;
+}
+
 HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
                                    HvSintMsgCb cb, void *cb_data)
 {
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 82d561f..757c85e 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -34,6 +34,10 @@ int hyperv_sint_route_set_sint(HvSintRoute *sint_route);
  * with the @sint_route; until then no more messages are accepted.
  */
 int hyperv_post_msg(HvSintRoute *sint_route, struct hyperv_message *msg);
+/*
+ * Set event flag @eventno, and signal the SINT if the flag has changed.
+ */
+int hyperv_set_event_flag(HvSintRoute *sint_route, unsigned eventno);
 
 static inline uint32_t hyperv_vp_index(CPUState *cs)
 {
-- 
1.8.3.1
