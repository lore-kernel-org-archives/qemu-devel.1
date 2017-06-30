Received: from eggs.gnu.org ([2001:4830:134:3::10]:34520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRn-00005D-Vn
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQtRm-0007yn-GS
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 06:46:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 30 Jun 2017 20:46:27 +1000
Message-Id: <20170630104632.27942-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170630104632.27942-1-david@gibson.dropbear.id.au>
References: <20170630104632.27942-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/21] spapr: Start hotplugged PCI devices in
 ISOLATED state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, sursingh@redhat.com, sbobroff@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

PCI DRCs, and only PCI DRCs, are immediately moved to UNISOLATED isolation
state once the device is attached.  This has been there from the initial
implementation, and it's not clear why.

The state diagram in PAPR 13.4 suggests PCI devices should start in
ISOLATED state until the guest moves them into UNISOLATED, and the code in
the guest-side drmgr tool seems to work that way too.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 5cb75bb..91fc08d 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -304,16 +304,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     }
     g_assert(fdt || coldplug);
 
-    /* NOTE: setting initial isolation state to UNISOLATED means we can't
-     * detach unless guest has a userspace/kernel that moves this state
-     * back to ISOLATED in response to an unplug event, or this is done
-     * manually by the admin prior. if we force things while the guest
-     * may be accessing the device, we can easily crash the guest, so we
-     * we defer completion of removal in such cases to the reset() hook.
-     */
-    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_PCI) {
-        drc->isolation_state = SPAPR_DR_ISOLATION_STATE_UNISOLATED;
-    }
     drc->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
 
     drc->dev = d;
-- 
2.9.4
