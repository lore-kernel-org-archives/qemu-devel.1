Received: from eggs.gnu.org ([2001:4830:134:3::10]:56092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL8MA-0005so-QH
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dL8M6-00044b-PU
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:29:10 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:45549)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dL8M6-00044L-Io
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:29:06 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3DC74106209
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 15:29:05 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 14 Jun 2017 15:29:00 +0200
Message-ID: <149744694069.5507.18392116536249515873.stgit@bahia.lan>
In-Reply-To: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
References: <149744692318.5507.14451686460325895979.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v5 1/3] spapr: manage hotplugged devices while
 the VM is not started
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Cedric Le Goater <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Laurent Vivier <lvivier@redhat.com>

For QEMU, a hotlugged device is a device added using the HMP/QMP
interface.
For SPAPR, a hotplugged device is a device added while the
machine is running. In this case QEMU doesn't update internal
state but relies on the OS for this part

In the case of migration, when we (libvirt) hotplug a device
on the source guest, we (libvirt) generally hotplug the same
device on the destination guest. But in this case, the machine
is stopped (RUN_STATE_INMIGRATE) and QEMU must not expect
the OS will manage it as an hotplugged device as it will
be "imported" by the migration.

This patch changes the meaning of "hotplugged" in spapr.c
to manage a QEMU hotplugged device like a "coldplugged" one
when the machine is awaiting an incoming migration.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
Tested-by: Daniel Barboza <danielhb@linux.vnet.ibm.com>
[groug: rebased to latest ppc-for-2.10]
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1df642f4f5cf..1e13880ecb7c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2566,6 +2566,12 @@ static void spapr_nmi(NMIState *n, int cpu_index, Error **errp)
     }
 }
 
+static bool spapr_coldplugged(DeviceState *dev)
+{
+    return runstate_check(RUN_STATE_INMIGRATE) ||
+           !dev->hotplugged;
+}
+
 static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
                            uint32_t node, bool dedicated_hp_event_source,
                            Error **errp)
@@ -2575,6 +2581,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     int i, fdt_offset, fdt_size;
     void *fdt;
     uint64_t addr = addr_start;
+    bool coldplugged = spapr_coldplugged(dev);
 
     for (i = 0; i < nr_lmbs; i++) {
         drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
@@ -2585,9 +2592,9 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
         fdt_offset = spapr_populate_memory_node(fdt, node, addr,
                                                 SPAPR_MEMORY_BLOCK_SIZE);
 
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged, errp);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, coldplugged, errp);
         addr += SPAPR_MEMORY_BLOCK_SIZE;
-        if (!dev->hotplugged) {
+        if (coldplugged) {
             sPAPRDRConnectorClass *drck = SPAPR_DR_CONNECTOR_GET_CLASS(drc);
             /* guests expect coldplugged LMBs to be pre-allocated */
             drck->set_allocation_state(drc, SPAPR_DR_ALLOCATION_STATE_USABLE);
@@ -2597,7 +2604,7 @@ static void spapr_add_lmbs(DeviceState *dev, uint64_t addr_start, uint64_t size,
     /* send hotplug notification to the
      * guest only in case of hotplugged memory
      */
-    if (dev->hotplugged) {
+    if (!coldplugged) {
         if (dedicated_hp_event_source) {
             drc = spapr_drc_by_id(TYPE_SPAPR_DRC_LMB,
                                   addr_start / SPAPR_MEMORY_BLOCK_SIZE);
@@ -2908,6 +2915,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     int smt = kvmppc_smt_threads();
     CPUArchId *core_slot;
     int index;
+    bool coldplugged = spapr_coldplugged(dev);
 
     core_slot = spapr_find_cpu_slot(MACHINE(hotplug_dev), cc->core_id, &index);
     if (!core_slot) {
@@ -2928,8 +2936,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     if (drc) {
-        spapr_drc_attach(drc, dev, fdt, fdt_offset, !dev->hotplugged,
-                         &local_err);
+        spapr_drc_attach(drc, dev, fdt, fdt_offset, coldplugged, &local_err);
         if (local_err) {
             g_free(fdt);
             error_propagate(errp, local_err);
@@ -2937,7 +2944,7 @@ static void spapr_core_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
         }
     }
 
-    if (dev->hotplugged) {
+    if (!coldplugged) {
         /*
          * Send hotplug notification interrupt to the guest only in case
          * of hotplugged CPUs.
