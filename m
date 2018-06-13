Received: from eggs.gnu.org ([2001:4830:134:3::10]:34241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSzic-0002xK-B3
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSziZ-0006a1-Rk
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 02:57:22 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 13 Jun 2018 16:57:05 +1000
Message-Id: <20180613065707.30766-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180613065707.30766-1-david@gibson.dropbear.id.au>
References: <20180613065707.30766-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PATCH 5/7] pnv: Add cpu unrealize path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: groug@kaod.org
Cc: clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

Currently we don't have any unrealize path for pnv cpu cores.  We get away
with this because we don't yet support cpu hotplug for pnv.

However, we're going to want it eventually, and in the meantime, it makes
it non-obvious why there are a bunch of allocations on the realize() path
that don't have matching frees.

So, implement the missing unrealize path.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index c9648fd1ad..c70dbbe056 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -192,6 +192,26 @@ err:
     error_propagate(errp, local_err);
 }
 
+static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
+{
+    qemu_unregister_reset(pnv_cpu_reset, cpu);
+    object_unparent(cpu->intc);
+    cpu_remove_sync(CPU(cpu));
+    object_unparent(OBJECT(cpu));
+}
+
+static void pnv_core_unrealize(DeviceState *dev, Error **errp)
+{
+    PnvCore *pc = PNV_CORE(dev);
+    CPUCore *cc = CPU_CORE(dev);
+    int i;
+
+    for (i = 0; i < cc->nr_threads; i++) {
+        pnv_unrealize_vcpu(pc->threads[i]);
+    }
+    g_free(pc->threads);
+}
+
 static Property pnv_core_properties[] = {
     DEFINE_PROP_UINT32("pir", PnvCore, pir, 0),
     DEFINE_PROP_END_OF_LIST(),
@@ -202,6 +222,7 @@ static void pnv_core_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->realize = pnv_core_realize;
+    dc->unrealize = pnv_core_unrealize;
     dc->props = pnv_core_properties;
 }
 
-- 
2.17.1
