Received: from eggs.gnu.org ([2001:4830:134:3::10]:60001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOM-0006bJ-1y
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:42:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=CMim=ZN=redhat.com=mst@kernel.org>)
	id 1cYdOL-00009z-4m
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 13:42:58 -0500
Date: Tue, 31 Jan 2017 20:42:52 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1485888144-16531-4-git-send-email-mst@redhat.com>
References: <1485888144-16531-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1485888144-16531-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL v4 03/23] ppc: switch to constants within
 BUILD_BUG_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

We are switching BUILD_BUG_ON to verify that it's parameter is a
compile-time constant, and it turns out that some gcc versions
(specifically gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609) are
not smart enough to figure it out for expressions involving local
variables. This is harmless but means that the check is ineffective for
these platforms.  To fix, replace the variable with macros.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/ppc/spapr.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a642e66..b81f2ac 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2630,8 +2630,8 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
      * 1TiB 64-bit MMIO windows for each PHB.
      */
     const uint64_t base_buid = 0x800000020000000ULL;
-    const int max_phbs =
-        (SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / SPAPR_PCI_MEM64_WIN_SIZE - 1;
+#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
+                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
     int i;
 
     /* Sanity check natural alignments */
@@ -2640,12 +2640,14 @@ static void spapr_phb_placement(sPAPRMachineState *spapr, uint32_t index,
     QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM64_WIN_SIZE % SPAPR_PCI_MEM32_WIN_SIZE) != 0);
     QEMU_BUILD_BUG_ON((SPAPR_PCI_MEM32_WIN_SIZE % SPAPR_PCI_IO_WIN_SIZE) != 0);
     /* Sanity check bounds */
-    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_IO_WIN_SIZE) > SPAPR_PCI_MEM32_WIN_SIZE);
-    QEMU_BUILD_BUG_ON((max_phbs * SPAPR_PCI_MEM32_WIN_SIZE) > SPAPR_PCI_MEM64_WIN_SIZE);
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_IO_WIN_SIZE) >
+                      SPAPR_PCI_MEM32_WIN_SIZE);
+    QEMU_BUILD_BUG_ON((SPAPR_MAX_PHBS * SPAPR_PCI_MEM32_WIN_SIZE) >
+                      SPAPR_PCI_MEM64_WIN_SIZE);
 
-    if (index >= max_phbs) {
+    if (index >= SPAPR_MAX_PHBS) {
         error_setg(errp, "\"index\" for PAPR PHB is too large (max %u)",
-                   max_phbs - 1);
+                   SPAPR_MAX_PHBS - 1);
         return;
     }
 
-- 
MST
