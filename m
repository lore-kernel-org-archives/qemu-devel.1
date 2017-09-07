Received: from eggs.gnu.org ([2001:4830:134:3::10]:39241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3CK-0004i4-Qc
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dq3CF-0002WY-Mm
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dq3CF-0002Vx-Dr
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 16:14:43 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  7 Sep 2017 22:13:33 +0200
Message-Id: <20170907201335.13956-20-david@redhat.com>
In-Reply-To: <20170907201335.13956-1-david@redhat.com>
References: <20170907201335.13956-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v3 19/21] s390x: get rid of cpu_s390x_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>

Now that there is only one user of cpu_s390x_create() left, make cpu
creation look like on x86.
- Perform the model/properties split and checks in s390_init_cpus()
- Parse features only once without having to remember if already parsed
- Pass only the typename to s390x_new_cpu()
- Use the typename of an existing CPU for hotplug via cpu-add

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 29 +++++++++++++++++++++++++++--
 target/s390x/cpu.h         |  2 +-
 target/s390x/helper.c      | 45 ++-------------------------------------------
 target/s390x/internal.h    |  1 -
 4 files changed, 30 insertions(+), 47 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 0e10a4c73a..10f6933fbd 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -41,6 +41,10 @@
 static void s390_init_cpus(MachineState *machine)
 {
     MachineClass *mc = MACHINE_GET_CLASS(machine);
+    const char *typename;
+    gchar **model_pieces;
+    ObjectClass *oc;
+    CPUClass *cc;
     int i;
 
     if (machine->cpu_model == NULL) {
@@ -57,8 +61,25 @@ static void s390_init_cpus(MachineState *machine)
     /* initialize possible_cpus */
     mc->possible_cpu_arch_ids(machine);
 
+    model_pieces = g_strsplit(machine->cpu_model, ",", 2);
+    if (!model_pieces[0]) {
+        error_report("Invalid/empty CPU model name");
+        exit(1);
+    }
+
+    oc = cpu_class_by_name(TYPE_S390_CPU, model_pieces[0]);
+    if (!oc) {
+        error_report("Unable to find CPU definition: %s", model_pieces[0]);
+        exit(1);
+    }
+    typename = object_class_get_name(oc);
+    cc = CPU_CLASS(oc);
+    /* after parsing, properties will be applied to all *typename* instances */
+    cc->parse_features(typename, model_pieces[1], &error_fatal);
+    g_strfreev(model_pieces);
+
     for (i = 0; i < smp_cpus; i++) {
-        s390x_new_cpu(machine->cpu_model, i, &error_fatal);
+        s390x_new_cpu(typename, i, &error_fatal);
     }
 }
 
@@ -382,8 +403,12 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
 static void s390_hot_add_cpu(const int64_t id, Error **errp)
 {
     MachineState *machine = MACHINE(qdev_get_machine());
+    ObjectClass *oc;
+
+    g_assert(machine->possible_cpus->cpus[0].cpu);
+    oc = OBJECT_CLASS(CPU_GET_CLASS(machine->possible_cpus->cpus[0].cpu));
 
-    s390x_new_cpu(machine->cpu_model, id, errp);
+    s390x_new_cpu(object_class_get_name(oc), id, errp);
 }
 
 static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5707268e43..a197869b0e 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -689,7 +689,7 @@ const char *s390_default_cpu_model_name(void);
 
 /* helper.c */
 #define cpu_init(cpu_model) cpu_generic_init(TYPE_S390_CPU, cpu_model)
-S390CPU *s390x_new_cpu(const char *cpu_model, uint32_t core_id, Error **errp);
+S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp);
 /* you can call this signal handler from your SIGBUS and SIGSEGV
    signal handlers to inform the virtual CPU of exceptions. non zero
    is returned if the signal was handled by the virtual CPU.  */
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index dfb24ef5b2..97adbcc86d 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -68,52 +68,11 @@ void s390x_cpu_timer(void *opaque)
 }
 #endif
 
-S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp)
+S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id, Error **errp)
 {
-    static bool features_parsed;
-    char *name, *features;
-    const char *typename;
-    ObjectClass *oc;
-    CPUClass *cc;
-
-    name = g_strdup(cpu_model);
-    features = strchr(name, ',');
-    if (features) {
-        features[0] = 0;
-        features++;
-    }
-
-    oc = cpu_class_by_name(TYPE_S390_CPU, name);
-    if (!oc) {
-        error_setg(errp, "Unknown CPU definition \'%s\'", name);
-        g_free(name);
-        return NULL;
-    }
-    typename = object_class_get_name(oc);
-
-    if (!features_parsed) {
-        features_parsed = true;
-        cc = CPU_CLASS(oc);
-        cc->parse_features(typename, features, errp);
-    }
-    g_free(name);
-
-    if (*errp) {
-        return NULL;
-    }
-    return S390_CPU(CPU(object_new(typename)));
-}
-
-S390CPU *s390x_new_cpu(const char *cpu_model, uint32_t core_id, Error **errp)
-{
-    S390CPU *cpu;
+    S390CPU *cpu = S390_CPU(object_new(typename));
     Error *err = NULL;
 
-    cpu = cpu_s390x_create(cpu_model, &err);
-    if (err != NULL) {
-        goto out;
-    }
-
     object_property_set_int(OBJECT(cpu), core_id, "core-id", &err);
     if (err != NULL) {
         goto out;
diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index b4d3583b24..bc8f83129a 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -337,7 +337,6 @@ uint64_t get_psw_mask(CPUS390XState *env);
 void s390_cpu_recompute_watchpoints(CPUState *cs);
 void s390x_tod_timer(void *opaque);
 void s390x_cpu_timer(void *opaque);
-S390CPU *cpu_s390x_create(const char *cpu_model, Error **errp);
 void do_restart_interrupt(CPUS390XState *env);
 #ifndef CONFIG_USER_ONLY
 LowCore *cpu_map_lowcore(CPUS390XState *env);
-- 
2.13.5
