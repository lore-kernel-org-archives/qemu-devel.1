Received: from eggs.gnu.org ([2001:4830:134:3::10]:40733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxS-0002QL-Hu
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxR-0007Xa-MP
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:34 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:13 +1000
Message-Id: <20170711043917.1757-14-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 13/17] spapr: fix memory hotplug error path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

QEMU shouldn't abort if spapr_add_lmbs()->spapr_drc_attach() fails.
Let's propagate the error instead, like it is done everywhere else
where spapr_drc_attach() is called.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 70b3fd3..ba8f57a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2601,6 +2601,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     int i, fdt_offset, fdt_size;
     void *fdt;
     uint64_t addr = addr_start;
+    Error *local_err = NULL;
 
     for (i = 0; i < nr_lmbs; i++) {
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
@@ -2611,7 +2612,18 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         fdt_offset = spapr_populate_memory_node(fdt, node, addr,
                                                 SPAPR_MEMORY_BLOCK_SIZE);
 
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
+        if (local_err) {
+            while (addr > addr_start) {
+                addr -= SPAPR_MEMORY_BLOCK_SIZE;
+                drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
+                                      addr / SPAPR_MEMORY_BLOCK_SIZE);
+                spapr_drc_detach(drc, dev, NULL);
+            }
+            g_free(fdt);
+            error_propagate(errp, local_err);
+            return;
+        }
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
     /* send hotplug notification to the
@@ -2651,14 +2663,20 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     addr = object_property_get_uint(OBJECT(dimm),
                                     PC_DIMM_ADDR_PROP, &local_err);
     if (local_err) {
-        pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
-        goto out;
+        goto out_unplug;
     }
 
     spapr_add_lmbs(dev, addr, size, node,
                    spapr_ovec_test(ms->ov5_cas, OV5_HP_EVT),
-                   &error_abort);
+                   &local_err);
+    if (local_err) {
+        goto out_unplug;
+    }
+
+    return;
 
+out_unplug:
+    pc_dimm_memory_unplug(dev, &ms->hotplug_memory, mr);
 out:
     error_propagate(errp, local_err);
 }
-- 
2.9.4
