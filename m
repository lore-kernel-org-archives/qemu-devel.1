Received: from eggs.gnu.org ([2001:4830:134:3::10]:44681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9tm-0000hB-9Z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ej9ti-000355-Sx
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:26 -0500
Received: from mail-db5eur01on0117.outbound.protection.outlook.com
	([104.47.2.117]:9120
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ej9ti-00034X-EB
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:31:22 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Tue,  6 Feb 2018 23:30:22 +0300
Message-Id: <20180206203048.11096-9-rkagan@virtuozzo.com>
In-Reply-To: <20180206203048.11096-1-rkagan@virtuozzo.com>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH 08/34] hyperv: qom-ify SynIC
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

Make Hyper-V SynIC a device which is attached as a child to X86CPU.  For
now it only makes SynIC visibile in the qom hierarchy, and maintains its
internal fields in sync with the respecitve msrs of the parent cpu (the
fields will be used in followup patches).

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
---
 target/i386/hyperv.h  |   4 ++
 target/i386/hyperv.c  | 111 +++++++++++++++++++++++++++++++++++++++++++++++++-
 target/i386/kvm.c     |  14 ++++++-
 target/i386/machine.c |   9 ++++
 4 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/target/i386/hyperv.h b/target/i386/hyperv.h
index af5fc05ea4..20bbd7bb29 100644
--- a/target/i386/hyperv.h
+++ b/target/i386/hyperv.h
@@ -34,4 +34,8 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route);
 uint32_t hyperv_vp_index(X86CPU *cpu);
 X86CPU *hyperv_find_vcpu(uint32_t vp_index);
 
+void hyperv_synic_add(X86CPU *cpu);
+void hyperv_synic_reset(X86CPU *cpu);
+void hyperv_synic_update(X86CPU *cpu);
+
 #endif
diff --git a/target/i386/hyperv.c b/target/i386/hyperv.c
index 4d8ef6f2da..a27d33acb3 100644
--- a/target/i386/hyperv.c
+++ b/target/i386/hyperv.c
@@ -13,12 +13,27 @@
 
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
+#include "qapi/error.h"
+#include "hw/qdev-properties.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
 
+typedef struct SynICState {
+    DeviceState parent_obj;
+
+    X86CPU *cpu;
+
+    bool enabled;
+    hwaddr msg_page_addr;
+    hwaddr evt_page_addr;
+} SynICState;
+
+#define TYPE_SYNIC "hyperv-synic"
+#define SYNIC(obj) OBJECT_CHECK(SynICState, (obj), TYPE_SYNIC)
+
 struct HvSintRoute {
     uint32_t sint;
-    X86CPU *cpu;
+    SynICState *synic;
     int gsi;
     EventNotifier sint_set_notifier;
     EventNotifier sint_ack_notifier;
@@ -37,6 +52,37 @@ X86CPU *hyperv_find_vcpu(uint32_t vp_index)
     return X86_CPU(qemu_get_cpu(vp_index));
 }
 
+static SynICState *get_synic(X86CPU *cpu)
+{
+    SynICState *synic =
+        SYNIC(object_resolve_path_component(OBJECT(cpu), "synic"));
+    assert(synic);
+    return synic;
+}
+
+static void synic_update_msg_page_addr(SynICState *synic)
+{
+    uint64_t msr = synic->cpu->env.msr_hv_synic_msg_page;
+    hwaddr new_addr = (msr & HV_SIMP_ENABLE) ? (msr & TARGET_PAGE_MASK) : 0;
+
+    synic->msg_page_addr = new_addr;
+}
+
+static void synic_update_evt_page_addr(SynICState *synic)
+{
+    uint64_t msr = synic->cpu->env.msr_hv_synic_evt_page;
+    hwaddr new_addr = (msr & HV_SIEFP_ENABLE) ? (msr & TARGET_PAGE_MASK) : 0;
+
+    synic->evt_page_addr = new_addr;
+}
+
+static void synic_update(SynICState *synic)
+{
+    synic->enabled = synic->cpu->env.msr_hv_synic_control & HV_SYNIC_ENABLE;
+    synic_update_msg_page_addr(synic);
+    synic_update_evt_page_addr(synic);
+}
+
 int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
 {
     CPUX86State *env = &cpu->env;
@@ -65,6 +111,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct kvm_hyperv_exit *exit)
         default:
             return -1;
         }
+        synic_update(get_synic(cpu));
         return 0;
     case KVM_EXIT_HYPERV_HCALL: {
         uint16_t code;
@@ -95,6 +142,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
                                    HvSintAckClb sint_ack_clb,
                                    void *sint_ack_clb_data)
 {
+    SynICState *synic;
     HvSintRoute *sint_route;
     EventNotifier *ack_notifier;
     int r, gsi;
@@ -105,6 +153,8 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
         return NULL;
     }
 
+    synic = get_synic(cpu);
+
     sint_route = g_new0(HvSintRoute, 1);
     r = event_notifier_init(&sint_route->sint_set_notifier, false);
     if (r) {
@@ -135,7 +185,7 @@ HvSintRoute *hyperv_sint_route_new(uint32_t vp_index, uint32_t sint,
     sint_route->gsi = gsi;
     sint_route->sint_ack_clb = sint_ack_clb;
     sint_route->sint_ack_clb_data = sint_ack_clb_data;
-    sint_route->cpu = cpu;
+    sint_route->synic = synic;
     sint_route->sint = sint;
     sint_route->refcount = 1;
 
@@ -189,3 +239,60 @@ int kvm_hv_sint_route_set_sint(HvSintRoute *sint_route)
 {
     return event_notifier_set(&sint_route->sint_set_notifier);
 }
+
+static void synic_realize(DeviceState *dev, Error **errp)
+{
+    Object *obj = OBJECT(dev);
+    SynICState *synic = SYNIC(dev);
+
+    synic->cpu = X86_CPU(obj->parent);
+}
+
+static void synic_reset(DeviceState *dev)
+{
+    SynICState *synic = SYNIC(dev);
+    synic_update(synic);
+}
+
+static void synic_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = synic_realize;
+    dc->reset = synic_reset;
+    dc->user_creatable = false;
+}
+
+void hyperv_synic_add(X86CPU *cpu)
+{
+    Object *obj;
+
+    obj = object_new(TYPE_SYNIC);
+    object_property_add_child(OBJECT(cpu), "synic", obj, &error_abort);
+    object_unref(obj);
+    object_property_set_bool(obj, true, "realized", &error_abort);
+}
+
+void hyperv_synic_reset(X86CPU *cpu)
+{
+    device_reset(DEVICE(get_synic(cpu)));
+}
+
+void hyperv_synic_update(X86CPU *cpu)
+{
+    synic_update(get_synic(cpu));
+}
+
+static const TypeInfo synic_type_info = {
+    .name = TYPE_SYNIC,
+    .parent = TYPE_DEVICE,
+    .instance_size = sizeof(SynICState),
+    .class_init = synic_class_init,
+};
+
+static void synic_register_types(void)
+{
+    type_register_static(&synic_type_info);
+}
+
+type_init(synic_register_types)
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index dfce60e5cf..84c5cc2131 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -665,8 +665,7 @@ static int hyperv_handle_properties(CPUState *cs)
         env->features[FEAT_HYPERV_EAX] |= HV_VP_RUNTIME_AVAILABLE;
     }
     if (cpu->hyperv_synic) {
-        if (!has_msr_hv_synic ||
-            kvm_vcpu_enable_cap(cs, KVM_CAP_HYPERV_SYNIC, 0)) {
+        if (!has_msr_hv_synic) {
             fprintf(stderr, "Hyper-V SynIC is not supported by kernel\n");
             return -ENOSYS;
         }
@@ -717,6 +716,15 @@ static int hyperv_init_vcpu(X86CPU *cpu)
         }
     }
 
+    if (cpu->hyperv_synic) {
+        if (kvm_vcpu_enable_cap(CPU(cpu), KVM_CAP_HYPERV_SYNIC, 0)) {
+            fprintf(stderr, "failed to enable Hyper-V SynIC\n");
+            return -ENOSYS;
+        }
+
+        hyperv_synic_add(cpu);
+    }
+
     return 0;
 }
 
@@ -1107,6 +1115,8 @@ void kvm_arch_reset_vcpu(X86CPU *cpu)
         for (i = 0; i < ARRAY_SIZE(env->msr_hv_synic_sint); i++) {
             env->msr_hv_synic_sint[i] = HV_SINT_MASKED;
         }
+
+        hyperv_synic_reset(cpu);
     }
 }
 
diff --git a/target/i386/machine.c b/target/i386/machine.c
index 361c05aedf..8c4baa2f79 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -7,6 +7,7 @@
 #include "hw/i386/pc.h"
 #include "hw/isa/isa.h"
 #include "migration/cpu.h"
+#include "hyperv.h"
 
 #include "sysemu/kvm.h"
 
@@ -653,11 +654,19 @@ static bool hyperv_synic_enable_needed(void *opaque)
     return false;
 }
 
+static int hyperv_synic_post_load(void *opaque, int version_id)
+{
+    X86CPU *cpu = opaque;
+    hyperv_synic_update(cpu);
+    return 0;
+}
+
 static const VMStateDescription vmstate_msr_hyperv_synic = {
     .name = "cpu/msr_hyperv_synic",
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = hyperv_synic_enable_needed,
+    .post_load = hyperv_synic_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(env.msr_hv_synic_control, X86CPU),
         VMSTATE_UINT64(env.msr_hv_synic_evt_page, X86CPU),
-- 
2.14.3
