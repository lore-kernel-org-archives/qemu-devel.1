Received: from eggs.gnu.org ([2001:4830:134:3::10]:52449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drMzi-0005GH-GT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:35:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drMzf-0002nw-6b
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:35:14 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:33431)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drMze-0002lu-Ti
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:35:11 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 4B4F493475
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 13:35:09 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 11 Sep 2017 13:35:03 +0200
Message-ID: <150512970330.16081.7553039475680302776.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH] spapr_pci: make index property mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>

Creating several PHBs without index property confuses the DRC code
and causes issues:
- only the first index-less PHB is functional, the other ones will
  silently ignore hotplugging of PCI devices
- QEMU will even terminate if these PHBs have cold-plugged devices

qemu-system-ppc64: -device virtio-net,bus=pci2.0: an attached device
 is still awaiting release

This happens because DR connectors for child PCI devices are created
with a DRC index that is derived from the PHB's index property. If the
PHBs are created without index, then the same value of -1 is used to
compute the DRC indexes for both PHBs, hence causing the collision.

Also, the index property is used to compute the placement of the PHB's
memory regions. It is limited to 31 or 255, depending on the machine
type version. This fits well with the requirements of DRC indexes, which
need the PHB index to be a 16-bit value.

This patch hence makes the index property mandatory. As a consequence,
the PHB's memory regions and BUID are now always configured according
to the index, and it is no longer possible to set them from the command
line. This is a reasonable trade-off, as it is very unlikely that people
create PHBs without index (at least libvirt doesn't do it FWIW).

We have to introduce a PHB instance init function to initialize the
64-bit window address to -1 because pseries-2.7 and older machines
don't set it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---

Hi,

This is a proposal to address the issue uncovered during the review of the
PHB hotplug patches:

https://lists.nongnu.org/archive/html/qemu-ppc/2017-07/msg00557.html

I'd like to address this properly before resuming work on PHB hotplug
itself. Please comment.

Cheers,

--
Greg
---
 hw/ppc/spapr_pci.c |   52 ++++++++++------------------------------------------
 1 file changed, 10 insertions(+), 42 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cf54160526fa..9a338b7f197b 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1523,16 +1523,6 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
         Error *local_err = NULL;
 
-        if ((sphb->buid != (uint64_t)-1) || (sphb->dma_liobn[0] != (uint32_t)-1)
-            || (sphb->dma_liobn[1] != (uint32_t)-1 && windows_supported == 2)
-            || (sphb->mem_win_addr != (hwaddr)-1)
-            || (sphb->mem64_win_addr != (hwaddr)-1)
-            || (sphb->io_win_addr != (hwaddr)-1)) {
-            error_setg(errp, "Either \"index\" or other parameters must"
-                       " be specified for PAPR PHB, not both");
-            return;
-        }
-
         smc->phb_placement(spapr, sphb->index,
                            &sphb->buid, &sphb->io_win_addr,
                            &sphb->mem_win_addr, &sphb->mem64_win_addr,
@@ -1541,36 +1531,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
             error_propagate(errp, local_err);
             return;
         }
-    }
-
-    if (sphb->buid == (uint64_t)-1) {
-        error_setg(errp, "BUID not specified for PHB");
-        return;
-    }
-
-    if ((sphb->dma_liobn[0] == (uint32_t)-1) ||
-        ((sphb->dma_liobn[1] == (uint32_t)-1) && (windows_supported > 1))) {
-        error_setg(errp, "LIOBN(s) not specified for PHB");
-        return;
-    }
-
-    if (sphb->mem_win_addr == (hwaddr)-1) {
-        error_setg(errp, "Memory window address not specified for PHB");
-        return;
-    }
-
-    if (sphb->io_win_addr == (hwaddr)-1) {
-        error_setg(errp, "IO window address not specified for PHB");
+    } else {
+        error_setg(errp, "\"index\" for PAPR PHB is mandatory");
         return;
     }
 
     if (sphb->mem64_win_size != 0) {
-        if (sphb->mem64_win_addr == (hwaddr)-1) {
-            error_setg(errp,
-                       "64-bit memory window address not specified for PHB");
-            return;
-        }
-
         if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
             error_setg(errp, "32-bit memory window of size 0x%"HWADDR_PRIx
                        " (max 2 GiB)", sphb->mem_win_size);
@@ -1789,18 +1755,12 @@ static void spapr_phb_reset(DeviceState *qdev)
 
 static Property spapr_phb_properties[] = {
     DEFINE_PROP_UINT32("index", sPAPRPHBState, index, -1),
-    DEFINE_PROP_UINT64("buid", sPAPRPHBState, buid, -1),
-    DEFINE_PROP_UINT32("liobn", sPAPRPHBState, dma_liobn[0], -1),
-    DEFINE_PROP_UINT32("liobn64", sPAPRPHBState, dma_liobn[1], -1),
-    DEFINE_PROP_UINT64("mem_win_addr", sPAPRPHBState, mem_win_addr, -1),
     DEFINE_PROP_UINT64("mem_win_size", sPAPRPHBState, mem_win_size,
                        SPAPR_PCI_MEM32_WIN_SIZE),
-    DEFINE_PROP_UINT64("mem64_win_addr", sPAPRPHBState, mem64_win_addr, -1),
     DEFINE_PROP_UINT64("mem64_win_size", sPAPRPHBState, mem64_win_size,
                        SPAPR_PCI_MEM64_WIN_SIZE),
     DEFINE_PROP_UINT64("mem64_win_pciaddr", sPAPRPHBState, mem64_win_pciaddr,
                        -1),
-    DEFINE_PROP_UINT64("io_win_addr", sPAPRPHBState, io_win_addr, -1),
     DEFINE_PROP_UINT64("io_win_size", sPAPRPHBState, io_win_size,
                        SPAPR_PCI_IO_WIN_SIZE),
     DEFINE_PROP_BOOL("dynamic-reconfiguration", sPAPRPHBState, dr_enabled,
@@ -1937,6 +1897,13 @@ static const char *spapr_phb_root_bus_path(PCIHostState *host_bridge,
     return sphb->dtbusname;
 }
 
+static void spapr_phb_instance_init(Object *obj)
+{
+    sPAPRPHBState *sphb = SPAPR_PCI_HOST_BRIDGE(obj);
+
+    sphb->mem64_win_addr = (hwaddr)-1;
+}
+
 static void spapr_phb_class_init(ObjectClass *klass, void *data)
 {
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
@@ -1960,6 +1927,7 @@ static const TypeInfo spapr_phb_info = {
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(sPAPRPHBState),
     .class_init    = spapr_phb_class_init,
+    .instance_init = spapr_phb_instance_init,
     .interfaces    = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { }
