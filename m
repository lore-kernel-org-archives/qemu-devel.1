Received: from eggs.gnu.org ([2001:4830:134:3::10]:49878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEc-0005Ps-PZ
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fUlEa-00043R-Id
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 23:53:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 18 Jun 2018 13:53:20 +1000
Message-Id: <20180618035324.19907-25-david@gibson.dropbear.id.au>
In-Reply-To: <20180618035324.19907-1-david@gibson.dropbear.id.au>
References: <20180618035324.19907-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 24/28] spapr_cpu_core: add missing rollback on
 realization path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The spapr_realize_vcpu() function doesn't rollback in case of error.
This isn't a problem with coldplugged CPUs because the machine won't
start and QEMU will exit. Hotplug is a different story though: the
CPU thread is started under object_property_set_bool() and it assumes
it can access the CPU object.

If icp_create() fails, we return an error without unregistering the
reset handler for this CPU, and we let the underlying QEMU thread for
this CPU alive. Since spapr_cpu_core_realize() doesn't care to unrealize
already realized CPUs either, but happily frees all of them anyway, the
CPU thread crashes instantly:

(qemu) device_add host-spapr-cpu-core,core-id=1,id=gku
GKU: failing icp_create (cpu 0x11497fd0)
                             ^^^^^^^^^^
Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffee3feaa0 (LWP 24725)]
0x00000000104c8374 in object_dynamic_cast_assert (obj=0x11497fd0,
                                                  ^^^^^^^^^^^^^^
                                             pointer to the CPU object
623         trace_object_dynamic_cast_assert(obj ? obj->class->type->name
(gdb) p obj->class->type
$1 = (Type) 0x0
(gdb) p * obj
$2 = {class = 0x10ea9c10, free = 0x11244620,
                                 ^^^^^^^^^^
                              should be g_free
(gdb) p g_free
$3 = {<text variable, no debug info>} 0x7ffff282bef0 <g_free>

obj is a dangling pointer to the CPU that was just destroyed in
spapr_cpu_core_realize().

This patch adds proper rollback to both spapr_realize_vcpu() and
spapr_cpu_core_realize().

Signed-off-by: Greg Kurz <groug@kaod.org>
[dwg: Fixed a conflict due to a change in my tree]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_cpu_core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index a9bb2d61e8..30a7cf9e03 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -145,11 +145,14 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     cpu->intc = icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
                            &local_err);
     if (local_err) {
-        goto error;
+        goto error_unregister;
     }
 
     return;
 
+error_unregister:
+    qemu_unregister_reset(spapr_cpu_reset, cpu);
+    cpu_remove_sync(CPU(cpu));
 error:
     error_propagate(errp, local_err);
 }
@@ -208,11 +211,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     for (j = 0; j < cc->nr_threads; j++) {
         spapr_realize_vcpu(sc->threads[j], spapr, &local_err);
         if (local_err) {
-            goto err;
+            goto err_unrealize;
         }
     }
     return;
 
+err_unrealize:
+    while (--j >= 0) {
+        spapr_unrealize_vcpu(sc->threads[j]);
+    }
 err:
     while (--i >= 0) {
         obj = OBJECT(sc->threads[i]);
-- 
2.17.1
