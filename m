Received: from eggs.gnu.org ([2001:4830:134:3::10]:54441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4b1-0003Yt-EG
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4az-00031V-R2
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:51 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:34 +1000
Message-Id: <20170606025135.2685-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/17] spapr: Eliminate spapr_drc_get_type_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>

This function was used in generating the device tree.  However, now that
we have different QOM types for different DRC types we can easily store
the information we need in the class structure and avoid this specialized
lookup function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c         | 31 ++++---------------------------
 include/hw/ppc/spapr_drc.h |  1 +
 2 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 783c621..06df5d0 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -712,6 +712,7 @@ static void spapr_drc_cpu_class_init(ObjectClass *k, void *data)
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_CPU;
+    drck->typename = "CPU";
 }
 
 static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
@@ -719,6 +720,7 @@ static void spapr_drc_pci_class_init(ObjectClass *k, void *data)
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_PCI;
+    drck->typename = "28";
 }
 
 static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
@@ -726,6 +728,7 @@ static void spapr_drc_lmb_class_init(ObjectClass *k, void *data)
     sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_CLASS(k);
 
     drck->typeshift = SPAPR_DR_CONNECTOR_TYPE_SHIFT_LMB;
+    drck->typename = "MEM";
 }
 
 static const TypeInfo spapr_dr_connector_info = {
@@ -795,31 +798,6 @@ sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id)
                               | (id & DRC_INDEX_ID_MASK));
 }
 
-/* generate a string the describes the DRC to encode into the
- * device tree.
- *
- * as documented by PAPR+ v2.7, 13.5.2.6 and C.6.1
- */
-static const char *spapr_drc_get_type_str(sPAPRDRConnectorType type)
-{
-    switch (type) {
-    case SPAPR_DR_CONNECTOR_TYPE_CPU:
-        return "CPU";
-    case SPAPR_DR_CONNECTOR_TYPE_PHB:
-        return "PHB";
-    case SPAPR_DR_CONNECTOR_TYPE_VIO:
-        return "SLOT";
-    case SPAPR_DR_CONNECTOR_TYPE_PCI:
-        return "28";
-    case SPAPR_DR_CONNECTOR_TYPE_LMB:
-        return "MEM";
-    default:
-        g_assert(false);
-    }
-
-    return NULL;
-}
-
 /**
  * spapr_drc_populate_dt
  *
@@ -901,8 +879,7 @@ int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
         drc_names = g_string_insert_len(drc_names, -1, "\0", 1);
 
         /* ibm,drc-types */
-        drc_types = g_string_append(drc_types,
-                                    spapr_drc_get_type_str(spapr_drc_type(drc)));
+        drc_types = g_string_append(drc_types, drck->typename);
         drc_types = g_string_insert_len(drc_types, -1, "\0", 1);
     }
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index 7dbb478..c88e1be 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -212,6 +212,7 @@ typedef struct sPAPRDRConnectorClass {
 
     /*< public >*/
     sPAPRDRConnectorTypeShift typeshift;
+    const char *typename; /* used in device tree, PAPR 13.5.2.6 & C.6.1 */
 
     /* accessors for guest-visible (generally via RTAS) DR state */
     uint32_t (*set_isolation_state)(sPAPRDRConnector *drc,
-- 
2.9.4
