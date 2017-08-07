Received: from eggs.gnu.org ([2001:4830:134:3::10]:43625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1delm4-0004Eh-M1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dellz-0002Hs-KL
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:25:04 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:60933)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dellz-0002HS-ET
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 13:24:59 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 715CA8B4AA
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 19:24:58 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 07 Aug 2017 19:24:51 +0200
Message-ID: <150212669147.12227.8408662555599046182.stgit@bahia>
In-Reply-To: <150212666472.12227.5292551535430570753.stgit@bahia>
References: <150212666472.12227.5292551535430570753.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [for-2.10 PATCH 2/3] spapr_drc: add Error ** argument
 to spapr_dr_connector_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

This just allow spapr_dr_connector_new() to propagate errors to its
callers. It doesn't change any functionality.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c             |    4 ++--
 hw/ppc/spapr_drc.c         |    4 ++--
 hw/ppc/spapr_pci.c         |    2 +-
 include/hw/ppc/spapr_drc.h |    2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7a19720dcdf..2bc3dbc25653 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2023,7 +2023,7 @@ static void spapr_create_lmb_dr_connectors(sPAPRMachineState *spapr)
 
         addr = i * lmb_size + spapr->hotplug_memory.base;
         spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_LMB,
-                               addr / lmb_size);
+                               addr / lmb_size, NULL);
     }
 }
 
@@ -2118,7 +2118,7 @@ static void spapr_init_cpus(sPAPRMachineState *spapr)
 
         if (mc->has_hotpluggable_cpus) {
             spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_CPU,
-                                   (core_id / smp_threads) * smt);
+                                   (core_id / smp_threads) * smt, NULL);
         }
 
         if (i < boot_cores_nr) {
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 5260b5d363a0..061fff41654a 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -532,7 +532,7 @@ static void unrealize(DeviceState *d, Error **errp)
 }
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
-                                         uint32_t id)
+                                         uint32_t id, Error **errp)
 {
     sPAPRDRConnector *drc = SPAPR_DR_CONNECTOR(object_new(type));
     char *prop_name;
@@ -542,7 +542,7 @@ sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
     prop_name = g_strdup_printf("dr-connector[%"PRIu32"]",
                                 spapr_drc_index(drc));
     object_property_add_child(owner, prop_name, OBJECT(drc), &error_abort);
-    object_property_set_bool(OBJECT(drc), true, "realized", NULL);
+    object_property_set_bool(OBJECT(drc), true, "realized", errp);
     g_free(prop_name);
 
     return drc;
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index d84abf1070a0..4b7882e3613d 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1733,7 +1733,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     if (sphb->dr_enabled) {
         for (i = 0; i < PCI_SLOT_MAX * 8; i++) {
             spapr_dr_connector_new(OBJECT(phb), TYPE_SPAPR_DRC_PCI,
-                                   (sphb->index << 16) | i);
+                                   (sphb->index << 16) | i, NULL);
         }
     }
 
diff --git a/include/hw/ppc/spapr_drc.h b/include/hw/ppc/spapr_drc.h
index a7958d0a8d14..8651af2ffae0 100644
--- a/include/hw/ppc/spapr_drc.h
+++ b/include/hw/ppc/spapr_drc.h
@@ -248,7 +248,7 @@ uint32_t spapr_drc_index(sPAPRDRConnector *drc);
 sPAPRDRConnectorType spapr_drc_type(sPAPRDRConnector *drc);
 
 sPAPRDRConnector *spapr_dr_connector_new(Object *owner, const char *type,
-                                         uint32_t id);
+                                         uint32_t id, Error **errp);
 sPAPRDRConnector *spapr_drc_by_index(uint32_t index);
 sPAPRDRConnector *spapr_drc_by_id(const char *type, uint32_t id);
 int spapr_drc_populate_dt(void *fdt, int fdt_offset, Object *owner,
