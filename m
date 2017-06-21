Received: from eggs.gnu.org ([2001:4830:134:3::10]:35369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSU-0007Pu-W7
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSS-0004gJ-BM
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:23 -0400
Received: from mail-eopbgr30128.outbound.protection.outlook.com
	([40.107.3.128]:21312
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiSR-0004fn-TO
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:20 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:17 +0300
Message-Id: <20170621162424.10462-17-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 16/23] hyperv: make overlay pages for SynIC
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
This (mostly) works because the actual guests seem not to depend on the
features listed above.

This patch implements those pages as the spec mandates.

Since the extra RAM regions, which introduce migration incompatibility,
are only added when in_kvm_only == false, no extra compat logic is
necessary.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - was patch 15 in v1
 - add comment on using async_safe_run_on_cpu

 target/i386/hyperv.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 6 deletions(-)

diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index e183638..dca85de 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -15,6 +15,9 @@
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
+#include "exec/address-spaces.h"
+#include "sysemu/cpus.h"
+#include "migration/vmstate.h"
 #include "hyperv.h"
 #include "hyperv_proto.h"
 
@@ -28,6 +31,10 @@ typedef struct SynICState {
     bool enabled;
     hwaddr msg_page_addr;
     hwaddr evt_page_addr;
+    MemoryRegion msg_page_mr;
+    MemoryRegion evt_page_mr;
+    struct hyperv_message_page *msg_page;
+    struct hyperv_event_flags_page *evt_page;
 } SynICState;
 
 #define TYPE_SYNIC "hyperv-synic"
@@ -67,6 +74,17 @@ static void synic_update_msg_page_addr(SynICState *synic)
     uint64_t msr = synic->cpu->env.msr_hv_synic_msg_page;
     hwaddr new_addr = (msr & HV_SIMP_ENABLE) ? (msr & TARGET_PAGE_MASK) : 0;
 
+    if (new_addr == synic->msg_page_addr) {
+        return;
+    }
+
+    if (synic->msg_page_addr) {
+        memory_region_del_subregion(get_system_memory(), &synic->msg_page_mr);
+    }
+    if (new_addr) {
+        memory_region_add_subregion(get_system_memory(), new_addr,
+                                    &synic->msg_page_mr);
+    }
     synic->msg_page_addr = new_addr;
 }
 
@@ -75,6 +93,17 @@ static void synic_update_evt_page_addr(SynICState *synic)
     uint64_t msr = synic->cpu->env.msr_hv_synic_evt_page;
     hwaddr new_addr = (msr & HV_SIEFP_ENABLE) ? (msr & TARGET_PAGE_MASK) : 0;
 
+    if (new_addr == synic->evt_page_addr) {
+        return;
+    }
+
+    if (synic->evt_page_addr) {
+        memory_region_del_subregion(get_system_memory(), &synic->evt_page_mr);
+    }
+    if (new_addr) {
+        memory_region_add_subregion(get_system_memory(), new_addr,
+                                    &synic->evt_page_mr);
+    }
     synic->evt_page_addr = new_addr;
 }
 
@@ -89,6 +118,15 @@ static void synic_update(SynICState *synic)
     synic_update_evt_page_addr(synic);
 }
 
+
+static void async_synic_update(CPUState *cs, run_on_cpu_data data)
+{
+    SynICState *synic = data.host_ptr;
+    qemu_mutex_lock_iothread();
+    synic_update(synic);
+    qemu_mutex_unlock_iothread();
+}
+
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
@@ -99,11 +137,6 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
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
@@ -117,7 +150,13 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         default:
             return -1;
         }
-        synic_update(get_synic(cpu));
+        /*
+         * this will run in this cpu thread before it returns to KVM, but in a
+         * safe environment (i.e. when all cpus are quiescent) -- this is
+         * necessary because we're changing memory hierarchy
+         */
+        async_safe_run_on_cpu(CPU(cpu), async_synic_update,
+                              RUN_ON_CPU_HOST_PTR(get_synic(cpu)));
         return 0;
     case KVM_EXIT_HYPERV_HCALL: {
         uint16_t code;
@@ -256,13 +295,34 @@ static void synic_realize(DeviceState *dev, Error **errp)
 {
     Object *obj = OBJECT(dev);
     SynICState *synic = SYNIC(dev);
+    char *msgp_name, *evtp_name;
+    uint32_t vp_index;
 
     synic->cpu = X86_CPU(obj->parent);
+
+    /* memory region names have to be globally unique */
+    vp_index = hyperv_vp_index(synic->cpu);
+    msgp_name = g_strdup_printf("synic-%u-msg-page", vp_index);
+    evtp_name = g_strdup_printf("synic-%u-evt-page", vp_index);
+
+    memory_region_init_ram(&synic->msg_page_mr, obj, msgp_name,
+                           sizeof(*synic->msg_page), &error_abort);
+    memory_region_init_ram(&synic->evt_page_mr, obj, evtp_name,
+                           sizeof(*synic->evt_page), &error_abort);
+    vmstate_register_ram(&synic->msg_page_mr, dev);
+    vmstate_register_ram(&synic->evt_page_mr, dev);
+    synic->msg_page = memory_region_get_ram_ptr(&synic->msg_page_mr);
+    synic->evt_page = memory_region_get_ram_ptr(&synic->evt_page_mr);
+
+    g_free(msgp_name);
+    g_free(evtp_name);
 }
 
 static void synic_reset(DeviceState *dev)
 {
     SynICState *synic = SYNIC(dev);
+    memset(synic->msg_page, 0, sizeof(*synic->msg_page));
+    memset(synic->evt_page, 0, sizeof(*synic->evt_page));
     synic_update(synic);
 }
 
-- 
2.9.4
