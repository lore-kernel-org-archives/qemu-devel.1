Received: from eggs.gnu.org ([2001:4830:134:3::10]:40880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxp-0002nW-0k
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dUmxo-0007kY-3k
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 00:39:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 11 Jul 2017 14:39:06 +1000
Message-Id: <20170711043917.1757-7-david@gibson.dropbear.id.au>
In-Reply-To: <20170711043917.1757-1-david@gibson.dropbear.id.au>
References: <20170711043917.1757-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 06/17] spapr: Leave DR-indicator management to
 the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, groug@kaod.org, bharata@linux.vnet.ibm.com, lvivier@redhat.com, aik@ozlabs.ru, surajjs@au1.ibm.com, sbobroff@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The DR-indicator is essentially a "virtual LED" attached to a hotpluggable
device, which the guest can set to various states for the attention of
the operator or management layers.

It's mostly guest managed, except that we once-off set it to
ACTIVE/INACTIVE in the attach/detach path.  While that makes certain sense,
there's no indication in PAPR that the hypervisor should do this, and the
drmgr code on the guest side doesn't appear to need it (it will already set
the indicator to ACTIVE on hotplug, and INACTIVE on remove).

So, leave the DR-indicator entirely to the guest; the only thing we need
to do is ensure it's in a sane state on reset.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_drc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index bd40b84..22d4d81 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -353,8 +353,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
     }
     g_assert(fdt || coldplug);
 
-    drc->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
-
     drc->dev = d;
     drc->fdt = fdt;
     drc->fdt_start_offset = fdt_start_offset;
@@ -372,8 +370,6 @@ void spapr_drc_attach(sPAPRDRConnector *drc, DeviceState *d, void *fdt,
 
 static void spapr_drc_release(sPAPRDRConnector *drc)
 {
-    drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
-
     /* Calling release callbacks based on spapr_drc_type(drc). */
     switch (spapr_drc_type(drc)) {
     case SPAPR_DR_CONNECTOR_TYPE_CPU:
@@ -454,12 +450,14 @@ static void reset(DeviceState *d)
         if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
             drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_USABLE;
         }
+        drc->dr_indicator = SPAPR_DR_INDICATOR_ACTIVE;
     } else {
         /* Otherwise device is absent, but might be hotplugged */
         drc->isolation_state = SPAPR_DR_ISOLATION_STATE_ISOLATED;
         if (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_PCI) {
             drc->allocation_state = SPAPR_DR_ALLOCATION_STATE_UNUSABLE;
         }
+        drc->dr_indicator = SPAPR_DR_INDICATOR_INACTIVE;
     }
 }
 
-- 
2.9.4
