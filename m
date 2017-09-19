Received: from eggs.gnu.org ([2001:4830:134:3::10]:39796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLeU-00074W-Qw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1duLeR-0003kW-Lk
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:2290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1duLeR-0003jL-DS
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 12:45:35 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Sep 2017 18:43:22 +0200
Message-Id: <20170919164337.18555-24-cohuck@redhat.com>
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
References: <20170919164337.18555-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/38] target/s390x: use "core-id" for cpu
 number/address/id handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Some time ago we discussed that using "id" as property name is not the
right thing to do, as it is a reserved property for other devices and
will not work with device_add.

Switch to the term "core-id" instead, and use it as an equivalent to
"CPU address" mentioned in the PoP. There is no such thing as cpu number,
so rename env.cpu_num to env.core_id. We use "core-id" as this is the
common term to use for device_add later on (x86 and ppc).

We can get rid of cpu->id now. Keep cpu_index and env->core_id in sync.
cpu_index was already implicitly used by e.g. cpu_exists(), so keeping
both in sync seems to be the right thing to do.

cpu_index will now no longer automatically get set via
cpu_exec_realizefn(). For now, we were lucky that both implicitly stayed
in sync.

Our new cpu property "core-id" can be a static property. Range checks can
be avoided by using the correct type and the "setting after realized"
check is done implicitly.

device_add will later need the reserved "id" property. Hotplugging a CPU
on s390x will then be: "device_add host-s390-cpu,id=cpu2,core-id=2".

Reviewed-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170913132417.24384-14-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c |  2 +-
 target/s390x/cpu.c         | 72 +++++++++++++---------------------------------
 target/s390x/cpu.h         |  5 ++--
 target/s390x/cpu_models.c  |  2 +-
 target/s390x/excp_helper.c |  2 +-
 target/s390x/helper.c      |  4 +--
 target/s390x/misc_helper.c |  4 +--
 target/s390x/translate.c   |  5 +---
 8 files changed, 30 insertions(+), 66 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 56f8200851..99c36a1315 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -312,7 +312,7 @@ static void s390_cpu_plug(HotplugHandler *hotplug_dev,
     S390CPU *cpu = S390_CPU(dev);
     CPUState *cs = CPU(dev);
 
-    name = g_strdup_printf("cpu[%i]", cpu->env.cpu_num);
+    name = g_strdup_printf("cpu[%i]", cpu->env.core_id);
     object_property_set_link(OBJECT(hotplug_dev), OBJECT(cs), name,
                              errp);
     g_free(name);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 5f9315fb16..87ebbe5b28 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -36,6 +36,7 @@
 #include "trace.h"
 #include "qapi/visitor.h"
 #include "exec/exec-all.h"
+#include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
 #include "hw/hw.h"
 #include "sysemu/arch_init.h"
@@ -189,28 +190,31 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
 #if !defined(CONFIG_USER_ONLY)
-    if (cpu->id >= max_cpus) {
-        error_setg(&err, "Unable to add CPU: %" PRIi64
-                   ", max allowed: %d", cpu->id, max_cpus - 1);
+    if (cpu->env.core_id >= max_cpus) {
+        error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
+                   ", maximum core-id: %d", cpu->env.core_id,
+                   max_cpus - 1);
         goto out;
     }
 #else
     /* implicitly set for linux-user only */
-    cpu->id = scc->next_cpu_id;
+    cpu->env.core_id = scc->next_cpu_id;
 #endif
 
-    if (cpu_exists(cpu->id)) {
-        error_setg(&err, "Unable to add CPU: %" PRIi64
-                   ", it already exists", cpu->id);
+    if (cpu_exists(cpu->env.core_id)) {
+        error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
+                   ", it already exists", cpu->env.core_id);
         goto out;
     }
-    if (cpu->id != scc->next_cpu_id) {
-        error_setg(&err, "Unable to add CPU: %" PRIi64
-                   ", The next available id is %" PRIi64, cpu->id,
+    if (cpu->env.core_id != scc->next_cpu_id) {
+        error_setg(&err, "Unable to add CPU with core-id: %" PRIu32
+                   ", the next available core-id is %" PRIi64, cpu->env.core_id,
                    scc->next_cpu_id);
         goto out;
     }
 
+    /* sync cs->cpu_index and env->core_id. The latter is needed for TCG. */
+    cs->cpu_index = env->core_id;
     cpu_exec_realizefn(cs, &err);
     if (err != NULL) {
         goto out;
@@ -220,7 +224,6 @@ static void s390_cpu_realizefn(DeviceState *dev, Error **errp)
 #if !defined(CONFIG_USER_ONLY)
     qemu_register_reset(s390_cpu_machine_reset_cb, cpu);
 #endif
-    env->cpu_num = cpu->id;
     s390_cpu_gdb_init(cs);
     qemu_init_vcpu(cs);
 #if !defined(CONFIG_USER_ONLY)
@@ -241,45 +244,6 @@ out:
     error_propagate(errp, err);
 }
 
-static void s390x_cpu_get_id(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp)
-{
-    S390CPU *cpu = S390_CPU(obj);
-    int64_t value = cpu->id;
-
-    visit_type_int(v, name, &value, errp);
-}
-
-static void s390x_cpu_set_id(Object *obj, Visitor *v, const char *name,
-                             void *opaque, Error **errp)
-{
-    S390CPU *cpu = S390_CPU(obj);
-    DeviceState *dev = DEVICE(obj);
-    const int64_t min = 0;
-    const int64_t max = UINT32_MAX;
-    Error *err = NULL;
-    int64_t value;
-
-    if (dev->realized) {
-        error_setg(errp, "Attempt to set property '%s' on '%s' after "
-                   "it was realized", name, object_get_typename(obj));
-        return;
-    }
-
-    visit_type_int(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-    if (value < min || value > max) {
-        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
-                   " (minimum: %" PRId64 ", maximum: %" PRId64 ")" ,
-                   object_get_typename(obj), name, value, min, max);
-        return;
-    }
-    cpu->id = value;
-}
-
 static void s390_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -293,8 +257,6 @@ static void s390_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
-    object_property_add(OBJECT(cpu), "id", "int64_t", s390x_cpu_get_id,
-                        s390x_cpu_set_id, NULL, NULL, NULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
     qemu_get_timedate(&tm, 0);
@@ -491,6 +453,11 @@ static gchar *s390_gdb_arch_name(CPUState *cs)
     return g_strdup("s390:64-bit");
 }
 
+static Property s390x_cpu_properties[] = {
+    DEFINE_PROP_UINT32("core-id", S390CPU, env.core_id, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static void s390_cpu_class_init(ObjectClass *oc, void *data)
 {
     S390CPUClass *scc = S390_CPU_CLASS(oc);
@@ -500,6 +467,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     scc->next_cpu_id = 0;
     scc->parent_realize = dc->realize;
     dc->realize = s390_cpu_realizefn;
+    dc->props = s390x_cpu_properties;
 
     scc->parent_reset = cc->reset;
 #if !defined(CONFIG_USER_ONLY)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5295bd3c66..1c8456fa57 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -150,7 +150,7 @@ struct CPUS390XState {
 
     CPU_COMMON
 
-    uint32_t cpu_num;
+    uint32_t core_id; /* PoP "CPU address", same as cpu_index */
     uint64_t cpuid;
 
     uint64_t tod_offset;
@@ -194,7 +194,6 @@ struct S390CPU {
     /*< public >*/
 
     CPUS390XState env;
-    int64_t id;
     S390CPUModel *model;
     /* needed for live migration */
     void *irqstate;
@@ -690,7 +689,7 @@ const char *s390_default_cpu_model_name(void);
 
 /* helper.c */
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
-S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp);
+S390CPU *s390x_new_cpu(const char *cpu_model, uint32_t core_id, Error **errp);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 18cbf91d9c..8e20e7637b 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -915,7 +915,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
     cpu->env.cpuid = s390_cpuid_from_cpu_model(cpu->model);
     if (tcg_enabled()) {
         /* basic mode, write the cpu address into the first 4 bit of the ID */
-        cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.cpu_num);
+        cpu->env.cpuid = deposit64(cpu->env.cpuid, 54, 4, cpu->env.core_id);
     }
 }
 
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 14d3160e92..470cf8f5bc 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -250,7 +250,7 @@ static void do_ext_interrupt(CPUS390XState *env)
     lowcore->ext_params2 = cpu_to_be64(q->param64);
     lowcore->external_old_psw.mask = cpu_to_be64(get_psw_mask(env));
     lowcore->external_old_psw.addr = cpu_to_be64(env->psw.addr);
-    lowcore->cpu_addr = cpu_to_be16(env->cpu_num | VIRTIO_SUBCODE_64);
+    lowcore->cpu_addr = cpu_to_be16(env->core_id | VIRTIO_SUBCODE_64);
     mask = be64_to_cpu(lowcore->external_new_psw.mask);
     addr = be64_to_cpu(lowcore->external_new_psw.addr);
 
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index ba29504476..dfb24ef5b2 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -104,7 +104,7 @@ S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp)
     return S390_CPU(CPU(object_new(typename)));
 }
 
-S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp)
+S390CPU *s390x_new_cpu(const char *cpu_model, uint32_t core_id, Error **errp)
 {
     S390CPU *cpu;
     Error *err = NULL;
@@ -114,7 +114,7 @@ S390CPU *s390x_new_cpu(const char *cpu_model, int64_t id, Error **errp)
         goto out;
     }
 
-    object_property_set_int(OBJECT(cpu), id, "id", &err);
+    object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
     if (err != NULL) {
         goto out;
     }
diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
index f3624d75eb..293fc8428a 100644
--- a/target/s390x/misc_helper.c
+++ b/target/s390x/misc_helper.c
@@ -232,7 +232,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
             /* XXX make different for different CPUs? */
             ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
             ebcdic_put(sysib.plant, "QEMU", 4);
-            stw_p(&sysib.cpu_addr, env->cpu_num);
+            stw_p(&sysib.cpu_addr, env->core_id);
             cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
         } else if ((sel1 == 2) && (sel2 == 2)) {
             /* Basic Machine CPUs */
@@ -260,7 +260,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0,
                 /* XXX make different for different CPUs? */
                 ebcdic_put(sysib.sequence, "QEMUQEMUQEMUQEMU", 16);
                 ebcdic_put(sysib.plant, "QEMU", 4);
-                stw_p(&sysib.cpu_addr, env->cpu_num);
+                stw_p(&sysib.cpu_addr, env->core_id);
                 stw_p(&sysib.cpu_id, 0);
                 cpu_physical_memory_write(a0, &sysib, sizeof(sysib));
             } else if ((sel1 == 2) && (sel2 == 2)) {
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 909b12818d..5abd34fb34 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -3823,10 +3823,7 @@ static ExitStatus op_ssm(DisasContext *s, DisasOps *o)
 static ExitStatus op_stap(DisasContext *s, DisasOps *o)
 {
     check_privileged(s);
-    /* ??? Surely cpu address != cpu number.  In any case the previous
-       version of this stored more than the required half-word, so it
-       is unlikely this has ever been tested.  */
-    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, cpu_num));
+    tcg_gen_ld32u_i64(o->out, cpu_env, offsetof(CPUS390XState, core_id));
     return NO_EXIT;
 }
 
-- 
2.13.5
