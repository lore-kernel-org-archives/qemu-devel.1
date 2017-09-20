Received: from eggs.gnu.org ([2001:4830:134:3::10]:36035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dugGo-0007pG-Dm
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:46:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dugGl-0000FK-AI
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:46:34 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:53246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dugGl-0000Ei-1D
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:46:31 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 4C44773228
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 16:46:28 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Wed, 20 Sep 2017 16:46:20 +0200
Message-ID: <150591878000.25597.7317602171707035692.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3] spapr_pci: make index property mandatory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>

PHBs can be created with an index property, in which case the machine
code automatically sets all the MMIO windows at addresses derived from
the index. Alternatively, they can be manually created without index,
but the user has to provide addresses for all MMIO windows.

The non-index way happens to be more trouble than it's worth: it's
difficult to use, keeps requiring (potentially incompatible) changes
when some new parameter needs adding, and is awkward to check for
collisions. It currently even has a bug that prevents to use two
non-index PHBs because their child DRCs are all derived from the
same index == -1 value, and, thus, collide.

This patch hence makes the index property mandatory. As a consequence,
the PHB's memory regions and BUID are now always configured according
to the index, and it is no longer possible to set them from the command
line.

This DOES BREAK backwards compat, but we don't think the non-index
PHB feature was used in practice (at least libvirt doesn't) and the
simplification is worth it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
v2->v3: - re-write commit message
        - mem64_win_pciaddr no longer configurable
        - simplified check to map 64-bit window

v1->v2: - error out if mem64_win_pciaddr is set but mem64_win_size
          isn't
        - set mem64_win_addr to -1 for old configuration with 32-bit
          window below 2G in spapr_phb_realize()
        - drop instance init function

RFC->v1: - as suggested dy David, updated the changelog to explicitely
           mention that we intentionally break backwards compat.
---
---
 hw/ppc/spapr_pci.c |   62 +++++++---------------------------------------------
 1 file changed, 8 insertions(+), 54 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index cf54160526fa..6126c800440f 100644
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
@@ -1541,46 +1531,20 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
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
             return;
         }
 
-        if (sphb->mem64_win_pciaddr == (hwaddr)-1) {
-            /* 64-bit window defaults to identity mapping */
-            sphb->mem64_win_pciaddr = sphb->mem64_win_addr;
-        }
+        /* 64-bit window defaults to identity mapping */
+        sphb->mem64_win_pciaddr = sphb->mem64_win_addr;
     } else if (sphb->mem_win_size > SPAPR_PCI_MEM32_WIN_SIZE) {
         /*
          * For compatibility with old configuration, if no 64-bit MMIO
@@ -1622,18 +1586,16 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), sphb->mem_win_addr,
                                 &sphb->mem32window);
 
-    if (sphb->mem64_win_pciaddr != (hwaddr)-1) {
+    if (sphb->mem64_win_size != 0) {
         namebuf = g_strdup_printf("%s.mmio64-alias", sphb->dtbusname);
         memory_region_init_alias(&sphb->mem64window, OBJECT(sphb),
                                  namebuf, &sphb->memspace,
                                  sphb->mem64_win_pciaddr, sphb->mem64_win_size);
         g_free(namebuf);
 
-        if (sphb->mem64_win_addr != (hwaddr)-1) {
-            memory_region_add_subregion(get_system_memory(),
-                                        sphb->mem64_win_addr,
-                                        &sphb->mem64window);
-        }
+        memory_region_add_subregion(get_system_memory(),
+                                    sphb->mem64_win_addr,
+                                    &sphb->mem64window);
     }
 
     /* Initialize IO regions */
@@ -1789,18 +1751,10 @@ static void spapr_phb_reset(DeviceState *qdev)
 
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
-    DEFINE_PROP_UINT64("mem64_win_pciaddr", sPAPRPHBState, mem64_win_pciaddr,
-                       -1),
-    DEFINE_PROP_UINT64("io_win_addr", sPAPRPHBState, io_win_addr, -1),
     DEFINE_PROP_UINT64("io_win_size", sPAPRPHBState, io_win_size,
                        SPAPR_PCI_IO_WIN_SIZE),
     DEFINE_PROP_BOOL("dynamic-reconfiguration", sPAPRPHBState, dr_enabled,
