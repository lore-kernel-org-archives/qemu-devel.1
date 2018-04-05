Received: from eggs.gnu.org ([2001:4830:134:3::10]:35207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQL-0001XV-H0
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f3uQH-0000s9-3S
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 22:14:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  5 Apr 2018 12:14:25 +1000
Message-Id: <20180405021437.16761-2-david@gibson.dropbear.id.au>
In-Reply-To: <20180405021437.16761-1-david@gibson.dropbear.id.au>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH for-2.13 01/13] target/ppc: Standardize
 instance_init and realize function names
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, groug@kaod.org
Cc: qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

Because of the various hooks called some variant on "init" - and the rather
greater number that used to exist, I'm always wondering when a function
called simply "*_init" or "*_initfn" will be called.

To make it easier on myself, and maybe others, rename the instance_init
hooks for ppc cpus to *_instance_init().  While we're at it rename the
realize time hooks to *_realize() (from *_realizefn()) which seems to be
the more common current convention.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/translate_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 391b94b97d..56b80a204a 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -9726,7 +9726,7 @@ static inline bool ppc_cpu_is_valid(PowerPCCPUClass *pcc)
 #endif
 }
 
-static void ppc_cpu_realizefn(DeviceState *dev, Error **errp)
+static void ppc_cpu_realize(DeviceState *dev, Error **errp)
 {
     CPUState *cs = CPU(dev);
     PowerPCCPU *cpu = POWERPC_CPU(dev);
@@ -9952,7 +9952,7 @@ unrealize:
     cpu_exec_unrealizefn(cs);
 }
 
-static void ppc_cpu_unrealizefn(DeviceState *dev, Error **errp)
+static void ppc_cpu_unrealize(DeviceState *dev, Error **errp)
 {
     PowerPCCPU *cpu = POWERPC_CPU(dev);
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
@@ -10438,7 +10438,7 @@ static bool ppc_cpu_is_big_endian(CPUState *cs)
 }
 #endif
 
-static void ppc_cpu_initfn(Object *obj)
+static void ppc_cpu_instance_init(Object *obj)
 {
     CPUState *cs = CPU(obj);
     PowerPCCPU *cpu = POWERPC_CPU(obj);
@@ -10561,9 +10561,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, void *data)
     CPUClass *cc = CPU_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
 
-    device_class_set_parent_realize(dc, ppc_cpu_realizefn,
+    device_class_set_parent_realize(dc, ppc_cpu_realize,
                                     &pcc->parent_realize);
-    device_class_set_parent_unrealize(dc, ppc_cpu_unrealizefn,
+    device_class_set_parent_unrealize(dc, ppc_cpu_unrealize,
                                       &pcc->parent_unrealize);
     pcc->pvr_match = ppc_pvr_match_default;
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_always;
@@ -10623,7 +10623,7 @@ static const TypeInfo ppc_cpu_type_info = {
     .name = TYPE_POWERPC_CPU,
     .parent = TYPE_CPU,
     .instance_size = sizeof(PowerPCCPU),
-    .instance_init = ppc_cpu_initfn,
+    .instance_init = ppc_cpu_instance_init,
     .abstract = true,
     .class_size = sizeof(PowerPCCPUClass),
     .class_init = ppc_cpu_class_init,
-- 
2.14.3
