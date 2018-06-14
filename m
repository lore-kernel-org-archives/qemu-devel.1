Received: from eggs.gnu.org ([2001:4830:134:3::10]:47846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa8x-0007dj-3V
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fTa8s-0002TB-7R
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:59 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:54222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fTa8r-0002Rd-VD
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:50:54 -0400
Received: from player730.ha.ovh.net (unknown [10.109.105.36])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 744E817FA6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 23:50:52 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Jun 2018 23:50:42 +0200
Message-ID: <152901304242.252222.9947658955703347553.stgit@bahia.lan>
In-Reply-To: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
References: <152901299450.252222.14219708016930421485.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 3/5] spapr_cpu_core: add missing rollback on
 realization path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>

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
---
 hw/ppc/spapr_cpu_core.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 003c4c5a79d2..04c818a6ecac 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -159,12 +159,16 @@ static void spapr_realize_vcpu(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     spapr_cpu->icp = icp_create(OBJECT(cpu), spapr->icp_type,
                                 XICS_FABRIC(spapr), &local_err);
     if (local_err) {
-        goto error;
+        goto error_unregister;
     }
 
     return;
 
+error_unregister:
+    qemu_unregister_reset(spapr_cpu_reset, cpu);
+    cpu_remove_sync(CPU(cpu));
 error:
+    g_free(spapr_cpu);
     error_propagate(errp, local_err);
 }
 
@@ -222,11 +226,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
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
+        spapr_unrealize_vcpu(sc->threads[i]);
+    }
 err:
     while (--i >= 0) {
         obj = OBJECT(sc->threads[i]);
