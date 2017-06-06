Received: from eggs.gnu.org ([2001:4830:134:3::10]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4ay-0003VD-7s
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dI4aw-0002yt-QL
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 22:51:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 12:51:30 +1000
Message-Id: <20170606025135.2685-13-david@gibson.dropbear.id.au>
In-Reply-To: <20170606025135.2685-1-david@gibson.dropbear.id.au>
References: <20170606025135.2685-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 12/17] spapr/drc: don't migrate DRC of
 cold-plugged CPUs and LMBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

As explained in commit 5c0139a8c2f0 ("spapr: fix default DRC state for
coldplugged LMBs"), guests expect cold-plugged LMBs to be pre-allocated
and unisolated. The same goes for cold-plugged CPUs.

While here, let's convert g_assert(false) to the better self documenting
g_assert_not_reached().

Signed-off-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index a35314e..c1d4b10 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -546,20 +546,16 @@ static bool spapr_drc_needed(void *opaque)
      */
     switch (drc->type) {
     case SPAPR_DR_CONNECTOR_TYPE_PCI:
-        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
-               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
-               drc->configured && drc->signalled && !drc->awaiting_release);
-        break;
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
     case SPAPR_DR_CONNECTOR_TYPE_LMB:
-        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_ISOLATED) &&
-               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_UNUSABLE) &&
+        rc = !((drc->isolation_state == SPAPR_DR_ISOLATION_STATE_UNISOLATED) &&
+               (drc->allocation_state == SPAPR_DR_ALLOCATION_STATE_USABLE) &&
                drc->configured && drc->signalled && !drc->awaiting_release);
         break;
     case SPAPR_DR_CONNECTOR_TYPE_PHB:
     case SPAPR_DR_CONNECTOR_TYPE_VIO:
     default:
-        g_assert(false);
+        g_assert_not_reached();
     }
     return rc;
 }
-- 
2.9.4
