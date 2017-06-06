Received: from eggs.gnu.org ([2001:4830:134:3::10]:41638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIEBA-00061C-R7
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:05:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIEB3-0000rf-3z
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 09:05:48 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  6 Jun 2017 23:05:33 +1000
Message-Id: <20170606130534.11019-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170606130534.11019-1-david@gibson.dropbear.id.au>
References: <20170606130534.11019-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC 2/3] spapr: Start hotplugged PCI devices in
 ISOLATED state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

PCI DRCs, and only PCI DRCs, are immediately moved to UNISOLATED isolation
state once the device is attached.  This has been there from the initial
implementation, and it's not clear why.

The state diagram in PAPR 13.4 suggests PCI devices should start in
ISOLATED state until the guest moves them into UNISOLATED, and the code in
the guest-side drmgr tool seems to work that way too.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index c73fae0..22f9224 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -291,16 +291,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
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
