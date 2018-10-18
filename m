Received: from eggs.gnu.org ([2001:4830:134:3::10]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyh-0007t2-Gr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyg-0006gZ-PR
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:07 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyg-0006fw-Gz
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id q7-v6so7267051wrr.8
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:06 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:11 +0200
Message-Id: <1539894735-14232-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/48] hyperv: add support for KVM_HYPERV_EVENTFD
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

When setting up a notifier for Hyper-V event connection, try to use the
KVM-assisted one first, and fall back to userspace handling of the
hypercall if the kernel doesn't provide the requested feature.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082217.29481-9-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index d745016..7a1c1bb 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -13,6 +13,7 @@
 #include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "qemu/bitops.h"
+#include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
@@ -470,7 +471,7 @@ static void __attribute__((constructor)) hv_init(void)
     qemu_mutex_init(&handlers_mutex);
 }
 
-int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
+static int set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
 {
     int ret;
     EventFlagHandler *handler;
@@ -503,6 +504,30 @@ unlock:
     return ret;
 }
 
+static bool process_event_flags_userspace;
+
+int hyperv_set_event_flag_handler(uint32_t conn_id, EventNotifier *notifier)
+{
+    if (!process_event_flags_userspace &&
+        !kvm_check_extension(kvm_state, KVM_CAP_HYPERV_EVENTFD)) {
+        process_event_flags_userspace = true;
+
+        warn_report("Hyper-V event signaling is not supported by this kernel; "
+                    "using slower userspace hypercall processing");
+    }
+
+    if (!process_event_flags_userspace) {
+        struct kvm_hyperv_eventfd hvevfd = {
+            .conn_id = conn_id,
+            .fd = notifier ? event_notifier_get_fd(notifier) : -1,
+            .flags = notifier ? 0 : KVM_HYPERV_EVENTFD_DEASSIGN,
+        };
+
+        return kvm_vm_ioctl(kvm_state, KVM_HYPERV_EVENTFD, &hvevfd);
+    }
+    return set_event_flag_handler(conn_id, notifier);
+}
+
 uint16_t hyperv_hcall_signal_event(uint64_t param, bool fast)
 {
     uint16_t ret;
-- 
1.8.3.1
