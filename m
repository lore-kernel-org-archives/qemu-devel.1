Received: from eggs.gnu.org ([2001:4830:134:3::10]:59680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUus-0004cM-Rm
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dsUup-00009z-IW
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:54 -0400
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:54263)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dsUup-00009N-91
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 10:14:51 -0400
Received: from player770.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 4031BAC1DC
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 16:14:50 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Thu, 14 Sep 2017 16:14:44 +0200
Message-ID: <150539848430.21523.2732328570419779115.stgit@bahia>
In-Reply-To: <150539846159.21523.16161730500010192093.stgit@bahia>
References: <150539846159.21523.16161730500010192093.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 2/2] spapr_pci: make index property mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Paolo Bonzini <pbonzini@redhat.com>

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
line. We have to introduce a PHB instance init function to initialize
the 64-bit window address to -1 because pseries-2.7 and older machines
don't set it.

This DOES BREAK backwards compat, but we don't think the non-index
PHB feature was used in practice (at least libvirt doesn't) and the
simplification is worth it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v1->v2: - error out if mem64_win_pciaddr is set but mem64_win_size
          isn't
        - set mem64_win_addr to -1 for old configuration with 32-bit
          window below 2G in spapr_phb_realize()
        - drop instance init function

RFC->v1: - as suggested dy David, updated the changelog to explicitely
           mention that we intentionally break backwards compat.
---
 hw/ppc/spapr_pci.c |   53 +++++++++++-----------------------------------------
 1 file changed, 11 insertions(+), 42 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cf54160526fa..024638e18b53 100644
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
@@ -1581,6 +1547,9 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
             /* 64-bit window defaults to identity mapping */
             sphb->mem64_win_pciaddr = sphb->mem64_win_addr;
         }
+    } else if (sphb->mem64_win_pciaddr != (hwaddr) -1) {
+        error_setg(errp, "64-bit memory window requires \"mem64_win_size\"");
+        return;
     } else if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
         /*
          * For compatibility with old configuration, if no 64-bit MMIO
@@ -1594,6 +1563,12 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
         sphb->mem64_win_pciaddr =
             SPAPR_PCI_MEM_WIN_BUS_OFFSET + SPAPR_PCI_MEM32_WIN_SIZE;
         sphb->mem_win_size = SPAPR_PCI_MEM32_WIN_SIZE;
+    } else {
+        /* Old configuration with the 32-bit MMIO window <= 2GiB don't need a
+         * 64-bit MMIO window.
+         */
+        sphb->mem64_win_addr = (hwaddr) -1;
+        sphb->mem64_win_pciaddr = (hwaddr) -1;
     }
 
     if (spapr_pci_find_phb(spapr, sphb->buid)) {
@@ -1789,18 +1764,12 @@ static void spapr_phb_reset(DeviceState *qdev)
 
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
