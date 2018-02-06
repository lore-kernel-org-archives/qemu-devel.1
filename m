Received: from eggs.gnu.org ([2001:4830:134:3::10]:44699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9to-0000jj-3H
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tk-00035u-OR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:28 -0500
Received: from mail-eopbgr00099.outbound.protection.outlook.com
	([40.107.0.99]:61504
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9tk-00035N-DU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:24 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:23 +0300
Message-Id: <20180206203048.11096-10-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 09/34] hyperv: block SynIC use in QEMU in
 incompatible configurations
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

Certain configurations do not allow SynIC to be used in QEMU.  In
particular,

- when hyperv_vpindex is off, SINT routes can't be used as they refer to
  the destination vCPU by vp_index

- older KVM (which doesn't expose KVM_CAP_HYPERV_SYNIC2) zeroes out
  SynIC message and event pages on every msr load, breaking migration

OTOH in-KVM users of SynIC -- SynIC timers -- do work in those
configurations, and we shouldn't stop the guest from using them.

To cover both scenarios, introduce a (user-invisible) SynIC property
that disallows to use the SynIC within QEMU but not in KVM.  The
property is clear by default but is set via compat logic for older
machine types.

As a result, when hv_synic and a modern machine type are specified, QEMU
will refuse to run unless vp_index is on and the kernel is recent
enough.  OTOH with older machine types QEMU will fine run against an
older kernel and/or without vp_index enabled but will refuse the in-QEMU
uses of SynIC (e.g. VMBus).

Also a function is added that allows the devices to query the status of
SynIC support across vCPUs.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 include/hw/i386/pc.h |  5 ++++
 target/i386/hyperv.h |  4 ++-
 target/i386/hyperv.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/kvm.c    |  8 +++---
 4 files changed, 80 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index bb49165fe0..744f6a20d2 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -352,6 +352,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
         .property = "extended-tseg-mbytes",\
         .value    = stringify(0),\
     },\
+    {\
+        .driver   = "hyperv-synic",\
+        .property = "in-kvm-only",\
+        .value    = "on",\
+    },\
 
 #define PC_COMPAT_2_8 \
     HW_COMPAT_2_8 \
diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index 20bbd7bb29..249bc15232 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -34,8 +34,10 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 uint32_t hyperv_vp_index(X86CPU *cpu);
 X86CPU *hyperv_find_vcpu(uint32_t vp_index);
 
-void hyperv_synic_add(X86CPU *cpu);
+int hyperv_synic_add(X86CPU *cpu);
 void hyperv_synic_reset(X86CPU *cpu);
 void hyperv_synic_update(X86CPU *cpu);
 
+bool hyperv_synic_usable(void);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index a27d33acb3..933bfe5bcb 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "hw/qdev-properties.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
@@ -23,6 +24,8 @@ typedef struct SynICState {
 
     X86CPU *cpu;
 
+    bool in_kvm_only;
+
     bool enabled;
     hwaddr msg_page_addr;
     hwaddr evt_page_addr;
@@ -78,6 +81,10 @@ static void synic_update_evt_page_addr(SynICState *synic)
 
 static void synic_update(SynICState *synic)
 {
+    if (synic->in_kvm_only) {
+        return;
+    }
+
     synic->enabled = synic->cpu->env.msr_hv_synic_control & HV_SYNIC_ENABLE;
     synic_update_msg_page_addr(synic);
     synic_update_evt_page_addr(synic);
@@ -154,6 +161,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
     }
 
     synic = get_synic(cpu);
+    assert(!synic->in_kvm_only);
 
     sint_route = g_new0(HvSintRoute, 1);
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
@@ -240,17 +248,32 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route)
     return event_notifier_set(&sint_route->sint_set_notifier);
 }
 
+static Property synic_props[] = {
+    /* user-invisible, only used for compat handling */
+    DEFINE_PROP_BOOL("in-kvm-only", SynICState, in_kvm_only, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void synic_realize(DeviceState *dev, Error **errp)
 {
     Object *obj = OBJECT(dev);
     SynICState *synic = SYNIC(dev);
 
+    if (synic->in_kvm_only) {
+        return;
+    }
+
     synic->cpu = X86_CPU(obj->parent);
 }
 
 static void synic_reset(DeviceState *dev)
 {
     SynICState *synic = SYNIC(dev);
+
+    if (synic->in_kvm_only) {
+        return;
+    }
+
     synic_update(synic);
 }
 
@@ -258,19 +281,45 @@ static void synic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->props = synic_props;
     dc->realize = synic_realize;
     dc->reset = synic_reset;
     dc->user_creatable = false;
 }
 
-void hyperv_synic_add(X86CPU *cpu)
+int hyperv_synic_add(X86CPU *cpu)
 {
     Object *obj;
+    SynICState *synic;
+    uint32_t synic_cap;
+    int ret;
 
     obj = object_new(TYPE_SYNIC);
     object_property_add_child(OBJECT(cpu), "synic", obj, &error_abort);
     object_unref(obj);
+
+    synic = SYNIC(obj);
+
+    if (!synic->in_kvm_only) {
+        synic_cap = KVM_CAP_HYPERV_SYNIC2;
+        if (!cpu->hyperv_vpindex) {
+            error_report("Hyper-V SynIC requires VP_INDEX support");
+            return -ENOSYS;
+        }
+    } else {
+        /* compat mode: only in-KVM SynIC timers supported */
+        synic_cap = KVM_CAP_HYPERV_SYNIC;
+    }
+
+    ret = kvm_vcpu_enable_cap(CPU(cpu), synic_cap, 0);
+    if (ret) {
+        error_report("failed to enable Hyper-V SynIC in KVM: %s",
+                     strerror(-ret));
+        return ret;
+    }
+
     object_property_set_bool(obj, true, "realized", &error_abort);
+    return 0;
 }
 
 void hyperv_synic_reset(X86CPU *cpu)
@@ -283,6 +332,25 @@ void hyperv_synic_update(X86CPU *cpu)
     synic_update(get_synic(cpu));
 }
 
+bool hyperv_synic_usable(void)
+{
+    CPUState *cs;
+
+    CPU_FOREACH(cs) {
+        X86CPU *cpu = X86_CPU(cs);
+
+        if (!cpu->hyperv_synic) {
+            return false;
+        }
+
+        if (get_synic(cpu)->in_kvm_only) {
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static const TypeInfo synic_type_info = {
     .name = TYPE_SYNIC,
     .parent = TYPE_DEVICE,
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 84c5cc2131..663501355b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -717,12 +717,10 @@ static int hyperv_init_vcpu(X86CPU *cpu)
     }
 
     if (cpu->hyperv_synic) {
-        if (kvm_vcpu_enable_cap(CPU(cpu), KVM_CAP_HYPERV_SYNIC, 0)) {
-            fprintf(stderr, "failed to enable Hyper-V SynIC\n");
-            return -ENOSYS;
+        int ret = hyperv_synic_add(cpu);
+        if (ret) {
+            return ret;
         }
-
-        hyperv_synic_add(cpu);
     }
 
     return 0;
-- 
2.14.3
