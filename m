Received: from eggs.gnu.org ([209.51.188.92]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguGk-0002m1-S5
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gguGf-0003oy-Dp
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:20 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gguGf-0003hS-39
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 11:30:17 -0500
Received: by mail-wm1-x344.google.com with SMTP id n190so4755048wmd.0
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 08:30:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  8 Jan 2019 16:30:06 +0000
Message-Id: <20190108163008.7006-3-peter.maydell@linaro.org>
In-Reply-To: <20190108163008.7006-1-peter.maydell@linaro.org>
References: <20190108163008.7006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/4] qom/cpu: Add cluster_index to CPUState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <richard.henderson@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Emilio G . Cota" <cota@braap.org>

For TCG we want to distinguish which cluster a CPU is in, and
we need to do it quickly. Cache the cluster index in the CPUState
struct, by having the cluster object set cpu->cluster_index for
each CPU child when it is realized.

This means that board/SoC code must add all CPUs to the cluster
before realizing the cluster object. Regrettably QOM provides no
way to prevent adding children to a realized object and no way for
the parent to be notified when a new child is added to it, so
we don't have any way to enforce/assert this constraint; all
we can do is document it in a comment.

The restriction on how many clusters can exist in the system
is imposed by TCG code which will be added in a subsequent commit,
but the check to enforce it in cluster.c fits better in this one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/cpu/cluster.h | 19 +++++++++++++++++++
 include/qom/cpu.h        |  7 +++++++
 hw/cpu/cluster.c         | 33 +++++++++++++++++++++++++++++++++
 qom/cpu.c                |  1 +
 4 files changed, 60 insertions(+)

diff --git a/include/hw/cpu/cluster.h b/include/hw/cpu/cluster.h
index 73818232437..d1bef315d10 100644
--- a/include/hw/cpu/cluster.h
+++ b/include/hw/cpu/cluster.h
@@ -34,12 +34,31 @@
  * Arm big.LITTLE system) they should be in different clusters. If the CPUs do
  * not have the same view of memory (for example the main CPU and a management
  * controller processor) they should be in different clusters.
+ *
+ * A cluster is created by creating an object of TYPE_CPU_CLUSTER, and then
+ * adding the CPUs to it as QOM child objects (e.g. using the
+ * object_initialize_child() or object_property_add_child() functions).
+ * All CPUs must be added as children before the cluster is realized.
+ * (Regrettably QOM provides no way to prevent adding children to a realized
+ * object and no way for the parent to be notified when a new child is added
+ * to it, so this restriction is not checked for, but the system will not
+ * behave correctly if it is not adhered to.)
+ *
+ * A CPU which is not put into any cluster will be considered implicitly
+ * to be in a cluster with all the other "loose" CPUs, so all CPUs that are
+ * not assigned to clusters must be identical.
  */
 
 #define TYPE_CPU_CLUSTER "cpu-cluster"
 #define CPU_CLUSTER(obj) \
     OBJECT_CHECK(CPUClusterState, (obj), TYPE_CPU_CLUSTER)
 
+/*
+ * This limit is imposed by TCG, which puts the cluster ID into an
+ * 8 bit field (and uses all-1s for the default "not in any cluster").
+ */
+#define MAX_CLUSTERS 255
+
 /**
  * CPUClusterState:
  * @cluster_id: The cluster ID. This value is for internal use only and should
diff --git a/include/qom/cpu.h b/include/qom/cpu.h
index 1396f53e5b5..844becbcedc 100644
--- a/include/qom/cpu.h
+++ b/include/qom/cpu.h
@@ -279,6 +279,11 @@ struct qemu_work_item;
 /**
  * CPUState:
  * @cpu_index: CPU index (informative).
+ * @cluster_index: Identifies which cluster this CPU is in.
+ *   For boards which don't define clusters or for "loose" CPUs not assigned
+ *   to a cluster this will be UNASSIGNED_CLUSTER_INDEX; otherwise it will
+ *   be the same as the cluster-id property of the CPU object's TYPE_CPU_CLUSTER
+ *   QOM parent.
  * @nr_cores: Number of cores within this CPU package.
  * @nr_threads: Number of threads within this CPU.
  * @running: #true if CPU is currently running (lockless).
@@ -404,6 +409,7 @@ struct CPUState {
 
     /* TODO Move common fields from CPUArchState here. */
     int cpu_index;
+    int cluster_index;
     uint32_t halted;
     uint32_t can_do_io;
     int32_t exception_index;
@@ -1109,5 +1115,6 @@ extern const struct VMStateDescription vmstate_cpu_common;
 #endif /* NEED_CPU_H */
 
 #define UNASSIGNED_CPU_INDEX -1
+#define UNASSIGNED_CLUSTER_INDEX -1
 
 #endif
diff --git a/hw/cpu/cluster.c b/hw/cpu/cluster.c
index 9d50a235d5c..d672f54a620 100644
--- a/hw/cpu/cluster.c
+++ b/hw/cpu/cluster.c
@@ -20,19 +20,52 @@
 
 #include "qemu/osdep.h"
 #include "hw/cpu/cluster.h"
+#include "qom/cpu.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/cutils.h"
 
 static Property cpu_cluster_properties[] = {
     DEFINE_PROP_UINT32("cluster-id", CPUClusterState, cluster_id, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
+static void cpu_cluster_realize(DeviceState *dev, Error **errp)
+{
+    /* Iterate through all our CPU children and set their cluster_index */
+    CPUClusterState *cluster = CPU_CLUSTER(dev);
+    ObjectPropertyIterator iter;
+    ObjectProperty *prop;
+    Object *cluster_obj = OBJECT(dev);
+
+    if (cluster->cluster_id >= MAX_CLUSTERS) {
+        error_setg(errp, "cluster-id must be less than %d", MAX_CLUSTERS);
+        return;
+    }
+
+    object_property_iter_init(&iter, cluster_obj);
+    while ((prop = object_property_iter_next(&iter))) {
+        Object *cpu_obj;
+        CPUState *cpu;
+
+        if (!strstart(prop->type, "child<", NULL)) {
+            continue;
+        }
+        cpu_obj = object_property_get_link(cluster_obj, prop->name, NULL);
+        cpu = (CPUState *)object_dynamic_cast(cpu_obj, TYPE_CPU);
+        if (!cpu) {
+            continue;
+        }
+        cpu->cluster_index = cluster->cluster_id;
+    }
+}
+
 static void cpu_cluster_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->props = cpu_cluster_properties;
+    dc->realize = cpu_cluster_realize;
 }
 
 static const TypeInfo cpu_cluster_type_info = {
diff --git a/qom/cpu.c b/qom/cpu.c
index 5442a7323be..f5579b1cd50 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -364,6 +364,7 @@ static void cpu_common_initfn(Object *obj)
     CPUClass *cc = CPU_GET_CLASS(obj);
 
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
+    cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
     /* *-user doesn't have configurable SMP topology */
     /* the default value is changed by qemu_init_vcpu() for softmmu */
-- 
2.19.2
