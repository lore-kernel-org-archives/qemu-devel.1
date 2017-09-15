Received: from eggs.gnu.org ([2001:4830:134:3::10]:54163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfL-0006hO-PG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfJ-0003NO-SE
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:43 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:27 +1000
Message-Id: <20170915035130.8354-16-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 15/18] spapr_pci: don't create 64-bit MMIO
 window if we don't need to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

When running a pseries-2.2 or older machine type, we get the following
lines in info mtree:

address-space: memory
...
ffffffffffffffff-ffffffffffffffff (prio 0, i/o): alias
 pci@800000020000000.mmio64-alias @pci@800000020000000.mmio
  ffffffffffffffff-ffffffffffffffff

address-space: cpu-memory
...
ffffffffffffffff-ffffffffffffffff (prio 0, i/o): alias
 pci@800000020000000.mmio64-alias @pci@800000020000000.mmio
  ffffffffffffffff-ffffffffffffffff

The same thing occurs when running a pseries-2.7 with

    -global spapr-pci-host-bridge.mem_win_size=2147483648

This happens because we always create a 64-bit MMIO window, even if
we didn't explicitely requested it (ie, mem64_win_size == 0) and the
32-bit window is below 2GiB. It doesn't seem to have an impact on the
guest though because spapr_populate_pci_dt() doesn't advertise the
bogus windows when mem64_win_size == 0.

Since these memory regions don't induce any state, we can safely
choose to not create them when their address is equal to -1,
without breaking migration from existing setups.

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 7d84b9766e..cf54160526 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1622,13 +1622,19 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(), sphb->mem_win_addr,
                                 &sphb->mem32window);
 
-    namebuf = g_strdup_printf("%s.mmio64-alias", sphb->dtbusname);
-    memory_region_init_alias(&sphb->mem64window, OBJECT(sphb),
-                             namebuf, &sphb->memspace,
-                             sphb->mem64_win_pciaddr, sphb->mem64_win_size);
-    g_free(namebuf);
-    memory_region_add_subregion(get_system_memory(), sphb->mem64_win_addr,
-                                &sphb->mem64window);
+    if (sphb->mem64_win_pciaddr != (hwaddr)-1) {
+        namebuf = g_strdup_printf("%s.mmio64-alias", sphb->dtbusname);
+        memory_region_init_alias(&sphb->mem64window, OBJECT(sphb),
+                                 namebuf, &sphb->memspace,
+                                 sphb->mem64_win_pciaddr, sphb->mem64_win_size);
+        g_free(namebuf);
+
+        if (sphb->mem64_win_addr != (hwaddr)-1) {
+            memory_region_add_subregion(get_system_memory(),
+                                        sphb->mem64_win_addr,
+                                        &sphb->mem64window);
+        }
+    }
 
     /* Initialize IO regions */
     namebuf = g_strdup_printf("%s.io", sphb->dtbusname);
-- 
2.13.5
