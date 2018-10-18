Received: from eggs.gnu.org ([2001:4830:134:3::10]:48473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyd-0007my-Om
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyc-0006dQ-KE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyc-0006cc-8D
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id o17-v6so901319wmh.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:33:02 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:07 +0200
Message-Id: <1539894735-14232-41-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 40/48] hyperv: make overlay pages for SynIC
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

Per Hyper-V spec, SynIC message and event flag pages are to be
implemented as so called overlay pages.  That is, they are owned by the
hypervisor and, when mapped into the guest physical address space,
overlay the guest physical pages such that

1) the overlaid guest page becomes invisible to the guest CPUs until the
   overlay page is turned off
2) the contents of the overlay page is preserved when it's turned off
   and back on, even at a different address; it's only zeroed at vcpu
   reset

This particular nature of SynIC message and event flag pages is ignored
in the current code, and guest physical pages are used directly instead.
This happens to (mostly) work because the actual guests seem not to
depend on the features listed above.

This patch implements those pages as the spec mandates.

Since the extra RAM regions, which introduce migration incompatibility,
are only added at SynIC object creation which only happens when
hyperv_synic_kvm_only == false, no extra compat logic is necessary.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082217.29481-5-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/hyperv/hyperv.c   | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
 target/i386/hyperv.c | 20 ++++++++++++++------
 2 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 3d6f044..70cf129 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "sysemu/kvm.h"
 #include "hw/hyperv/hyperv.h"
 
@@ -21,6 +22,10 @@ typedef struct SynICState {
     bool enabled;
     hwaddr msg_page_addr;
     hwaddr event_page_addr;
+    MemoryRegion msg_page_mr;
+    MemoryRegion event_page_mr;
+    struct hyperv_message_page *msg_page;
+    struct hyperv_event_flags_page *event_page;
 } SynICState;
 
 #define TYPE_SYNIC "hyperv-synic"
@@ -36,8 +41,28 @@ static void synic_update(SynICState *synic, bool enable,
 {
 
     synic->enabled = enable;
-    synic->msg_page_addr = msg_page_addr;
-    synic->event_page_addr = event_page_addr;
+    if (synic->msg_page_addr != msg_page_addr) {
+        if (synic->msg_page_addr) {
+            memory_region_del_subregion(get_system_memory(),
+                                        &synic->msg_page_mr);
+        }
+        if (msg_page_addr) {
+            memory_region_add_subregion(get_system_memory(), msg_page_addr,
+                                        &synic->msg_page_mr);
+        }
+        synic->msg_page_addr = msg_page_addr;
+    }
+    if (synic->event_page_addr != event_page_addr) {
+        if (synic->event_page_addr) {
+            memory_region_del_subregion(get_system_memory(),
+                                        &synic->event_page_mr);
+        }
+        if (event_page_addr) {
+            memory_region_add_subregion(get_system_memory(), event_page_addr,
+                                        &synic->event_page_mr);
+        }
+        synic->event_page_addr = event_page_addr;
+    }
 }
 
 void hyperv_synic_update(CPUState *cs, bool enable,
@@ -54,11 +79,31 @@ void hyperv_synic_update(CPUState *cs, bool enable,
 
 static void synic_realize(DeviceState *dev, Error **errp)
 {
+    Object *obj = OBJECT(dev);
+    SynICState *synic = SYNIC(dev);
+    char *msgp_name, *eventp_name;
+    uint32_t vp_index;
+
+    /* memory region names have to be globally unique */
+    vp_index = hyperv_vp_index(synic->cs);
+    msgp_name = g_strdup_printf("synic-%u-msg-page", vp_index);
+    eventp_name = g_strdup_printf("synic-%u-event-page", vp_index);
+
+    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
+                           sizeof(*synic->msg_page), &error_abort);
+    memory_region_init_ram(&synic->event_page_mr, obj, eventp_name,
+                           sizeof(*synic->event_page), &error_abort);
+    synic->msg_page = memory_region_get_ram_ptr(&synic->msg_page_mr);
+    synic->event_page = memory_region_get_ram_ptr(&synic->event_page_mr);
+
+    g_free(msgp_name);
+    g_free(eventp_name);
 }
-
 static void synic_reset(DeviceState *dev)
 {
     SynICState *synic = SYNIC(dev);
+    memset(synic->msg_page, 0, sizeof(*synic->msg_page));
+    memset(synic->event_page, 0, sizeof(*synic->event_page));
     synic_update(synic, false, 0, 0);
 }
 
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 0216735..3f76c3e 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -12,6 +12,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "hyperv.h"
 #include "hw/hyperv/hyperv.h"
 #include "hyperv-proto.h"
@@ -38,6 +39,13 @@ void hyperv_x86_synic_update(X86CPU *cpu)
     hyperv_synic_update(CPU(cpu), enable, msg_page_addr, event_page_addr);
 }
 
+static void async_synic_update(CPUState *cs, run_on_cpu_data data)
+{
+    qemu_mutex_lock_iothread();
+    hyperv_x86_synic_update(X86_CPU(cs));
+    qemu_mutex_unlock_iothread();
+}
+
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
@@ -48,11 +56,6 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
             return -1;
         }
 
-        /*
-         * For now just track changes in SynIC control and msg/evt pages msr's.
-         * When SynIC messaging/events processing will be added in future
-         * here we will do messages queues flushing and pages remapping.
-         */
         switch (exit->u.synic.msr) {
         case HV_X64_MSR_SCONTROL:
             env->msr_hv_synic_control = exit->u.synic.control;
@@ -67,7 +70,12 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
             return -1;
         }
 
-        hyperv_x86_synic_update(cpu);
+        /*
+         * this will run in this cpu thread before it returns to KVM, but in a
+         * safe environment (i.e. when all cpus are quiescent) -- this is
+         * necessary because memory hierarchy is being changed
+         */
+        async_safe_run_on_cpu(CPU(cpu), async_synic_update, RUN_ON_CPU_NULL);
 
         return 0;
     case KVM_EXIT_HYPERV_HCALL: {
-- 
1.8.3.1
