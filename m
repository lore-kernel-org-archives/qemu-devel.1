Received: from eggs.gnu.org ([2001:4830:134:3::10]:52723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kH-0007xm-6j
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ9kA-0004IC-EO
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 00:15:45 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  2 Feb 2017 16:14:36 +1100
Message-Id: <20170202051445.5735-99-david@gibson.dropbear.id.au>
In-Reply-To: <20170202051445.5735-1-david@gibson.dropbear.id.au>
References: <20170202051445.5735-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 098/107] ppc: switch to constants within
 BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: "Michael S. Tsirkin" <mst@redhat.com>

We are switching BUILD_BUG_ON to verify that it's parameter is a
compile-time constant, and it turns out that some gcc versions
(specifically gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609) are
not smart enough to figure it out for expressions involving local
variables. This is harmless but means that the check is ineffective for
these platforms.  To fix, replace the variable with macros.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[dwg: Correct a printf format warning]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9fc3fb9..e465d7a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2662,8 +2662,8 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
      * 1TiB 64-bit MMIO windows for each PHB.
      */
     const uint64_t base_buid = 0x800000020000000ULL;
-    const int max_phbs =
-        (SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / SPAPR_PCI_MEM64_WIN_SIZE - 1;
+#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
+                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
     int i;
 
     /* Sanity check natural alignments */
@@ -2672,12 +2672,14 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
     QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SIZE) != 0);
     QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE) != 0);
     /* Sanity check bounds */
-    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_IO_WIN_SIZE) > SPAPR_PCI_MEM32_WIN_SIZE);
-    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_MEM32_WIN_SIZE) > SPAPR_PCI_MEM64_WIN_SIZE);
-
-    if (index >= max_phbs) {
-        error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
-                   max_phbs - 1);
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
+                      SPAPR_PCI_MEM32_WIN_SIZE);
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
+                      SPAPR_PCI_MEM64_WIN_SIZE);
+
+    if (index >= SPAPR_MAX_PHBS) {
+        error_setg(errp, "\"index\" for PAPR PHB is too large (max %llu)",
+                   SPAPR_MAX_PHBS - 1);
         return;
     }
 
-- 
2.9.3
