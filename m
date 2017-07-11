Received: from eggs.gnu.org ([2001:4830:134:3::10]:40673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxP-0002MG-Jn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxO-0007VR-It
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:31 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:09 +1000
Message-Id: <20170711043917.1757-10-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 09/17] spapr: Remove unnecessary differences
 between hotplug and coldplug paths
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

spapr_drc_attach() has a 'coldplug' parameter which sets the DRC into
configured state initially, instead of the usual ISOLATED/UNUSABLE state.
It turns out this is unnecessary: although coldplugged devices do need to
be in CONFIGURED state once the guest starts, that will already be
accomplished by the reset code which will move DRCs for already plugged
devices into a coldplug equivalent state.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c             | 13 +++----------
 hw/ppc/spapr_drc.c         |  5 ++---
 hw/ppc/spapr_pci.c         |  3 +--
 include/hw/ppc/spapr_drc.h |  2 +-
 4 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 4fa982d..70b3fd3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2611,7 +2611,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         fdt_offset = spapr_populate_memory_node(fdt, node, addr,
                                                 SPAPR_MEMORY_BLOCK_SIZE);
 
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
     }
     /* send hotplug notification to the
@@ -2956,17 +2956,10 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
     g_assert(drc || !mc->has_hotpluggable_cpus);
 
-    /*
-     * Setup CPU DT entries only for hotplugged CPUs. For boot time or
-     * coldplugged CPUs DT entries are setup in spapr_build_fdt().
-     */
-    if (dev->hotplugged) {
-        fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
-    }
+    fdt = spapr_populate_hotplug_cpu_dt(cs, &fdt_offset, spapr);
 
     if (drc) {
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged,
-                         &local_err);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, &local_err);
         if (local_err) {
             g_free(fdt);
             error_propagate(errp, local_err);
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index aa37a47..f34355d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -340,7 +340,7 @@ static void prop_get_fdt(Object *obj, Visitor *v, const char *name,
 }
 
 void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                      int fdt_start_offset, bool coldplug, Error **errp)
+                      int fdt_start_offset, Error **errp)
 {
     trace_spapr_drc_attach(spapr_drc_index(drc));
 
@@ -351,12 +351,11 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
         g_assert(drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE);
     }
-    g_assert(fdt || coldplug);
+    g_assert(fdt);
 
     drc->dev = d;
     drc->fdt = fdt;
     drc->fdt_start_offset = fdt_start_offset;
-    drc->configured = coldplug;
 
     if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
         drc->awaiting_allocation = true;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index f09b4e1..49c8db8 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1435,8 +1435,7 @@ static void spapr_phb_hot_plug_child(HotplugHandler *plug_handler,
         goto out;
     }
 
-    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset,
-                     !plugged_dev->hotplugged, &local_err);
+    spapr_drc_attach(drc, DEVICE(pdev), fdt, fdt_start_offset, &local_err);
     if (local_err) {
         goto out;
     }
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 6fd84d1..d15e9eb 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -234,7 +234,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
                           uint32_t drc_type_mask);
 
 void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
-                      int fdt_start_offset, bool coldplug, Error **errp);
+                      int fdt_start_offset, Error **errp);
 void spapr_drc_detach(sPAPRDRConnector *drc, DeviceState *d, Error **errp);
 
 #endif /* HW_SPAPR_DRC_H */
-- 
2.9.4
