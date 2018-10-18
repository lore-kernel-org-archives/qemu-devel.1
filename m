Received: from eggs.gnu.org ([2001:4830:134:3::10]:48439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyc-0007i8-Ef
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyY-0006aW-RK
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:33:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:33369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEyY-0006Yc-DE
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:58 -0400
Received: by mail-wr1-x42d.google.com with SMTP id e4-v6so35111093wrs.0
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:32:01 +0200
Message-Id: <1539894735-14232-35-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 34/48] hyperv: factor out arch-independent API
 into hw/hyperv
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

A significant part of hyperv.c is not actually tied to x86, and can
be moved to hw/.

This will allow to maintain most of Hyper-V and VMBus
target-independent, and to avoid conflicts with inclusion of
arch-specific headers down the road in VMBus implementation.

Also this stuff can now be opt-out with CONFIG_HYPERV.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20180921082041.29380-4-rkagan@virtuozzo.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/Makefile.objs                     |   1 +
 hw/hyperv/Makefile.objs              |   2 +
 hw/hyperv/hyperv.c                   | 138 +++++++++++++++++++++++++++++++++++
 hw/{misc => hyperv}/hyperv_testdev.c |   2 +-
 hw/misc/Makefile.objs                |   1 -
 include/hw/hyperv/hyperv.h           |  31 ++++++++
 target/i386/hyperv.c                 | 127 +-------------------------------
 target/i386/hyperv.h                 |  17 +----
 target/i386/kvm.c                    |   5 +-
 9 files changed, 178 insertions(+), 146 deletions(-)
 create mode 100644 hw/hyperv/Makefile.objs
 create mode 100644 hw/hyperv/hyperv.c
 rename hw/{misc => hyperv}/hyperv_testdev.c (99%)
 create mode 100644 include/hw/hyperv/hyperv.h

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index a19c141..30722cc 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -9,6 +9,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += cpu/
 devices-dirs-$(CONFIG_SOFTMMU) += display/
 devices-dirs-$(CONFIG_SOFTMMU) += dma/
 devices-dirs-$(CONFIG_SOFTMMU) += gpio/
+devices-dirs-$(CONFIG_HYPERV) += hyperv/
 devices-dirs-$(CONFIG_SOFTMMU) += i2c/
 devices-dirs-$(CONFIG_SOFTMMU) += ide/
 devices-dirs-$(CONFIG_SOFTMMU) += input/
diff --git a/hw/hyperv/Makefile.objs b/hw/hyperv/Makefile.objs
new file mode 100644
index 0000000..edaca2f
--- /dev/null
+++ b/hw/hyperv/Makefile.objs
@@ -0,0 +1,2 @@
+obj-y += hyperv.o
+obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
new file mode 100644
index 0000000..97db875
--- /dev/null
+++ b/hw/hyperv/hyperv.c
@@ -0,0 +1,138 @@
+/*
+ * Hyper-V guest/hypervisor interaction
+ *
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "sysemu/kvm.h"
+#include "hw/hyperv/hyperv.h"
+
+struct HvSintRoute {
+    uint32_t sint;
+    CPUState *cs;
+    int gsi;
+    EventNotifier sint_set_notifier;
+    EventNotifier sint_ack_notifier;
+    HvSintAckClb sint_ack_clb;
+    void *sint_ack_clb_data;
+    unsigned refcount;
+};
+
+static CPUState *hyperv_find_vcpu(uint32_t vp_index)
+{
+    CPUState *cs = qemu_get_cpu(vp_index);
+    assert(hyperv_vp_index(cs) == vp_index);
+    return cs;
+}
+
+static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
+{
+    HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
+                                           sint_ack_notifier);
+    event_notifier_test_and_clear(notifier);
+    sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
+}
+
+HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data)
+{
+    HvSintRoute *sint_route;
+    EventNotifier *ack_notifier;
+    int r, gsi;
+    CPUState *cs;
+
+    cs = hyperv_find_vcpu(vp_index);
+    if (!cs) {
+        return NULL;
+    }
+
+    sint_route = g_new0(HvSintRoute, 1);
+    r = event_notifier_init(&sint_route->sint_set_notifier, false);
+    if (r) {
+        goto err;
+    }
+
+    ack_notifier = sint_ack_clb ? &sint_route->sint_ack_notifier : NULL;
+    if (ack_notifier) {
+        r = event_notifier_init(ack_notifier, false);
+        if (r) {
+            goto err_sint_set_notifier;
+        }
+
+        event_notifier_set_handler(ack_notifier, kvm_hv_sint_ack_handler);
+    }
+
+    gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
+    if (gsi < 0) {
+        goto err_gsi;
+    }
+
+    r = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
+                                           &sint_route->sint_set_notifier,
+                                           ack_notifier, gsi);
+    if (r) {
+        goto err_irqfd;
+    }
+    sint_route->gsi = gsi;
+    sint_route->sint_ack_clb = sint_ack_clb;
+    sint_route->sint_ack_clb_data = sint_ack_clb_data;
+    sint_route->cs = cs;
+    sint_route->sint = sint;
+    sint_route->refcount = 1;
+
+    return sint_route;
+
+err_irqfd:
+    kvm_irqchip_release_virq(kvm_state, gsi);
+err_gsi:
+    if (ack_notifier) {
+        event_notifier_set_handler(ack_notifier, NULL);
+        event_notifier_cleanup(ack_notifier);
+    }
+err_sint_set_notifier:
+    event_notifier_cleanup(&sint_route->sint_set_notifier);
+err:
+    g_free(sint_route);
+
+    return NULL;
+}
+
+void hyperv_sint_route_ref(HvSintRoute *sint_route)
+{
+    sint_route->refcount++;
+}
+
+void hyperv_sint_route_unref(HvSintRoute *sint_route)
+{
+    if (!sint_route) {
+        return;
+    }
+
+    assert(sint_route->refcount > 0);
+
+    if (--sint_route->refcount) {
+        return;
+    }
+
+    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
+                                          &sint_route->sint_set_notifier,
+                                          sint_route->gsi);
+    kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
+    if (sint_route->sint_ack_clb) {
+        event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
+        event_notifier_cleanup(&sint_route->sint_ack_notifier);
+    }
+    event_notifier_cleanup(&sint_route->sint_set_notifier);
+    g_free(sint_route);
+}
+
+int hyperv_sint_route_set_sint(HvSintRoute *sint_route)
+{
+    return event_notifier_set(&sint_route->sint_set_notifier);
+}
diff --git a/hw/misc/hyperv_testdev.c b/hw/hyperv/hyperv_testdev.c
similarity index 99%
rename from hw/misc/hyperv_testdev.c
rename to hw/hyperv/hyperv_testdev.c
index 33bbd28..fc3f6c5 100644
--- a/hw/misc/hyperv_testdev.c
+++ b/hw/hyperv/hyperv_testdev.c
@@ -15,7 +15,7 @@
 #include "qemu/queue.h"
 #include "hw/qdev.h"
 #include "hw/isa/isa.h"
-#include "target/i386/hyperv.h"
+#include "hw/hyperv/hyperv.h"
 
 typedef struct TestSintRoute {
     QLIST_ENTRY(TestSintRoute) le;
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 6d50b03..680350b 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -71,7 +71,6 @@ obj-$(CONFIG_IOTKIT_SYSCTL) += iotkit-sysctl.o
 obj-$(CONFIG_IOTKIT_SYSINFO) += iotkit-sysinfo.o
 
 obj-$(CONFIG_PVPANIC) += pvpanic.o
-obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
 obj-$(CONFIG_MSF2) += msf2-sysreg.o
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
new file mode 100644
index 0000000..d6c8d78
--- /dev/null
+++ b/include/hw/hyperv/hyperv.h
@@ -0,0 +1,31 @@
+/*
+ * Hyper-V guest/hypervisor interaction
+ *
+ * Copyright (c) 2015-2018 Virtuozzo International GmbH.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_HYPERV_HYPERV_H
+#define HW_HYPERV_HYPERV_H
+
+#include "cpu-qom.h"
+
+typedef struct HvSintRoute HvSintRoute;
+typedef void (*HvSintAckClb)(void *data);
+
+HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
+                                   HvSintAckClb sint_ack_clb,
+                                   void *sint_ack_clb_data);
+void hyperv_sint_route_ref(HvSintRoute *sint_route);
+void hyperv_sint_route_unref(HvSintRoute *sint_route);
+
+int hyperv_sint_route_set_sint(HvSintRoute *sint_route);
+
+static inline uint32_t hyperv_vp_index(CPUState *cs)
+{
+    return cs->cpu_index;
+}
+
+#endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 6881664..1eac727 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -12,28 +12,10 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "hyperv.h"
+#include "hw/hyperv/hyperv.h"
 #include "hyperv-proto.h"
 
-struct HvSintRoute {
-    uint32_t sint;
-    X86CPU *cpu;
-    int gsi;
-    EventNotifier sint_set_notifier;
-    EventNotifier sint_ack_notifier;
-    HvSintAckClb sint_ack_clb;
-    void *sint_ack_clb_data;
-    unsigned refcount;
-};
-
-static X86CPU *hyperv_find_vcpu(uint32_t vp_index)
-{
-    X86CPU *cpu = X86_CPU(qemu_get_cpu(vp_index));
-    assert(hyperv_vp_index(cpu) == vp_index);
-    return cpu;
-}
-
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
@@ -79,110 +61,3 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         return -1;
     }
 }
-
-static void kvm_hv_sint_ack_handler(EventNotifier *notifier)
-{
-    HvSintRoute *sint_route = container_of(notifier, HvSintRoute,
-                                           sint_ack_notifier);
-    event_notifier_test_and_clear(notifier);
-    sint_route->sint_ack_clb(sint_route->sint_ack_clb_data);
-}
-
-HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
-                                   HvSintAckClb sint_ack_clb,
-                                   void *sint_ack_clb_data)
-{
-    HvSintRoute *sint_route;
-    EventNotifier *ack_notifier;
-    int r, gsi;
-    X86CPU *cpu;
-
-    cpu = hyperv_find_vcpu(vp_index);
-    if (!cpu) {
-        return NULL;
-    }
-
-    sint_route = g_new0(HvSintRoute, 1);
-    r = event_notifier_init(&sint_route->sint_set_notifier, false);
-    if (r) {
-        goto err;
-    }
-
-    ack_notifier = sint_ack_clb ? &sint_route->sint_ack_notifier : NULL;
-    if (ack_notifier) {
-        r = event_notifier_init(ack_notifier, false);
-        if (r) {
-            goto err_sint_set_notifier;
-        }
-
-        event_notifier_set_handler(ack_notifier, kvm_hv_sint_ack_handler);
-    }
-
-    gsi = kvm_irqchip_add_hv_sint_route(kvm_state, vp_index, sint);
-    if (gsi < 0) {
-        goto err_gsi;
-    }
-
-    r = kvm_irqchip_add_irqfd_notifier_gsi(kvm_state,
-                                           &sint_route->sint_set_notifier,
-                                           ack_notifier, gsi);
-    if (r) {
-        goto err_irqfd;
-    }
-    sint_route->gsi = gsi;
-    sint_route->sint_ack_clb = sint_ack_clb;
-    sint_route->sint_ack_clb_data = sint_ack_clb_data;
-    sint_route->cpu = cpu;
-    sint_route->sint = sint;
-    sint_route->refcount = 1;
-
-    return sint_route;
-
-err_irqfd:
-    kvm_irqchip_release_virq(kvm_state, gsi);
-err_gsi:
-    if (ack_notifier) {
-        event_notifier_set_handler(ack_notifier, NULL);
-        event_notifier_cleanup(ack_notifier);
-    }
-err_sint_set_notifier:
-    event_notifier_cleanup(&sint_route->sint_set_notifier);
-err:
-    g_free(sint_route);
-
-    return NULL;
-}
-
-void hyperv_sint_route_ref(HvSintRoute *sint_route)
-{
-    sint_route->refcount++;
-}
-
-void hyperv_sint_route_unref(HvSintRoute *sint_route)
-{
-    if (!sint_route) {
-        return;
-    }
-
-    assert(sint_route->refcount > 0);
-
-    if (--sint_route->refcount) {
-        return;
-    }
-
-    kvm_irqchip_remove_irqfd_notifier_gsi(kvm_state,
-                                          &sint_route->sint_set_notifier,
-                                          sint_route->gsi);
-    kvm_irqchip_release_virq(kvm_state, sint_route->gsi);
-    if (sint_route->sint_ack_clb) {
-        event_notifier_set_handler(&sint_route->sint_ack_notifier, NULL);
-        event_notifier_cleanup(&sint_route->sint_ack_notifier);
-    }
-    event_notifier_cleanup(&sint_route->sint_set_notifier);
-    g_free(sint_route);
-}
-
-int hyperv_sint_route_set_sint(HvSintRoute *sint_route)
-{
-    return event_notifier_set(&sint_route->sint_set_notifier);
-}
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 8d4619c..5c49251 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -16,23 +16,8 @@
 
 #include "cpu.h"
 #include "sysemu/kvm.h"
-
-typedef struct HvSintRoute HvSintRoute;
-typedef void (*HvSintAckClb)(void *data);
+#include "hw/hyperv/hyperv.h"
 
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit);
 
-HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
-                                   HvSintAckClb sint_ack_clb,
-                                   void *sint_ack_clb_data);
-void hyperv_sint_route_ref(HvSintRoute *sint_route);
-void hyperv_sint_route_unref(HvSintRoute *sint_route);
-
-int hyperv_sint_route_set_sint(HvSintRoute *sint_route);
-
-static inline uint32_t hyperv_vp_index(X86CPU *cpu)
-{
-    return CPU(cpu)->cpu_index;
-}
-
 #endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 4e62b5c..b0b42d2 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -774,7 +774,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
         assert(ret == 1);
 
-        if (msr_data.entries[0].data != hyperv_vp_index(cpu)) {
+        if (msr_data.entries[0].data != hyperv_vp_index(CPU(cpu))) {
             error_report("kernel's vp_index != QEMU's vp_index");
             return -ENXIO;
         }
@@ -1949,7 +1949,8 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
             kvm_msr_entry_add(cpu, HV_X64_MSR_VP_RUNTIME, env->msr_hv_runtime);
         }
         if (cpu->hyperv_vpindex && hv_vpindex_settable) {
-            kvm_msr_entry_add(cpu, HV_X64_MSR_VP_INDEX, hyperv_vp_index(cpu));
+            kvm_msr_entry_add(cpu, HV_X64_MSR_VP_INDEX,
+                              hyperv_vp_index(CPU(cpu)));
         }
         if (cpu->hyperv_synic) {
             int j;
-- 
1.8.3.1
