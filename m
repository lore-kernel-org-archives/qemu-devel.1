Received: from eggs.gnu.org ([2001:4830:134:3::10]:35352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSO-0007KT-S7
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dNiSM-0004en-6Z
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:16 -0400
Received: from mail-eopbgr30139.outbound.protection.outlook.com
	([40.107.3.139]:30159
	helo=EUR03-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dNiSL-0004eW-Ol
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 12:26:14 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 21 Jun 2017 19:24:16 +0300
Message-Id: <20170621162424.10462-16-rkagan@virtuozzo.com>
In-Reply-To: <20170621162424.10462-1-rkagan@virtuozzo.com>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 15/23] hyperv: block SynIC use in QEMU in
 incompatible configurations
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

Certain configurations do not allow SynIC to be used in QEMU.  In
particular,

- when hyperv_vpindex is off, SINT routes can't be used as they refer to
  the destination vCPU by vp_index

- older KVM (which doesn't expose KVM_CAP_HYPERV_SYNIC2) zeroes out
  SynIC message and event pages on every msr load, breaking migration

OTOH in-KVM users of SynIC -- SynIC timers -- do work in those
configurations, and we shouldn't stop the guest from using them.

Instead, introduce a SynIC property that disallows to use the SynIC
within QEMU but not in KVM.  The property is set during vCPU init and
via compat logic (as older QEMU had no users for SynIC beyond the test
device).

Also a function is added that allows the devices to query the status of
SynIC support across vCPUs.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
v1 -> v2:
 - new patch

 include/hw/i386/pc.h |  5 +++++
 target/i386/hyperv.h |  4 +++-
 target/i386/hyperv.c | 39 ++++++++++++++++++++++++++++++++++++++-
 target/i386/kvm.c    | 12 ++++++++++--
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 233216a..72b5c62 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -389,6 +389,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
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
index 20bbd7b..7d8753e 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -34,8 +34,10 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 uint32_t hyperv_vp_index(X86CPU *cpu);
 X86CPU *hyperv_find_vcpu(uint32_t vp_index);
 
-void hyperv_synic_add(X86CPU *cpu);
+void hyperv_synic_add(X86CPU *cpu, bool in_kvm_only);
 void hyperv_synic_reset(X86CPU *cpu);
 void hyperv_synic_update(X86CPU *cpu);
 
+bool hyperv_synic_usable(void);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index eff612c..e183638 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -23,6 +23,8 @@ typedef struct SynICState {
 
     X86CPU *cpu;
 
+    bool in_kvm_only;
+
     bool enabled;
     hwaddr msg_page_addr;
     hwaddr evt_page_addr;
@@ -78,6 +80,10 @@ static void synic_update_evt_page_addr(SynICState *synic)
 
 static void synic_update(SynICState *synic)
 {
+    if (synic->in_kvm_only) {
+        return;
+    }
+
     synic->enabled = synic->cpu->env.msr_hv_synic_control & HV_SYNIC_ENABLE;
     synic_update_msg_page_addr(synic);
     synic_update_evt_page_addr(synic);
@@ -154,6 +160,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
     }
 
     synic = get_synic(cpu);
+    assert(!synic->in_kvm_only);
 
     sint_route = g_new0(HvSintRoute, 1);
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
@@ -240,6 +247,11 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route)
     return event_notifier_set(&sint_route->sint_set_notifier);
 }
 
+static Property synic_props[] = {
+    DEFINE_PROP_BOOL("in-kvm-only", SynICState, in_kvm_only, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void synic_realize(DeviceState *dev, Error **errp)
 {
     Object *obj = OBJECT(dev);
@@ -258,18 +270,24 @@ static void synic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->props = synic_props;
     dc->realize = synic_realize;
     dc->reset = synic_reset;
     dc->user_creatable = false;
 }
 
-void hyperv_synic_add(X86CPU *cpu)
+void hyperv_synic_add(X86CPU *cpu, bool in_kvm_only)
 {
     Object *obj;
+    SynICState *synic;
 
     obj = object_new(TYPE_SYNIC);
     object_property_add_child(OBJECT(cpu), "synic", obj, &error_abort);
     object_unref(obj);
+
+    synic = SYNIC(obj);
+    synic->in_kvm_only = synic->in_kvm_only || in_kvm_only;
+
     object_property_set_bool(obj, true, "realized", &error_abort);
 }
 
@@ -283,6 +301,25 @@ void hyperv_synic_update(X86CPU *cpu)
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
index eaa2df3..8d1d232 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -700,12 +700,20 @@ static int hyperv_init_vcpu(X86CPU *cpu)
     }
 
     if (cpu->hyperv_synic) {
-        if (kvm_vcpu_enable_cap(CPU(cpu), KVM_CAP_HYPERV_SYNIC, 0)) {
+        bool in_kvm_only = !cpu->hyperv_vpindex;
+
+        if (!in_kvm_only &&
+            kvm_vcpu_enable_cap(CPU(cpu), KVM_CAP_HYPERV_SYNIC2, 0)) {
+            in_kvm_only = true;
+        }
+
+        if (in_kvm_only &&
+            kvm_vcpu_enable_cap(CPU(cpu), KVM_CAP_HYPERV_SYNIC, 0)) {
             fprintf(stderr, "failed to enable Hyper-V SynIC\n");
             return -ENOSYS;
         }
 
-        hyperv_synic_add(cpu);
+        hyperv_synic_add(cpu, in_kvm_only);
     }
 
     return 0;
-- 
2.9.4
