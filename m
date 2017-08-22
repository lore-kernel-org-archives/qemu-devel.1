Received: from eggs.gnu.org ([2001:4830:134:3::10]:54645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk0jr-0000rw-0K
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dk0jp-00083P-NO
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 00:24:27 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 22 Aug 2017 14:24:13 +1000
Message-Id: <20170822042416.26758-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170822042416.26758-1-david@gibson.dropbear.id.au>
References: <20170822042416.26758-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 4/7] spapr: Allow configure-connector to be
 called multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, thuth@redhat.com, mdroth@linux.vnet.ibm.com, cohuck@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Bharata B Rao <bharata@linux.vnet.ibm.com>

In case of in-kernel memory hot unplug, when the guest is not able
to remove all the LMBs that are requested for removal, it will add back
any LMBs that have been successfully removed. The DR Connectors of
these LMBs wouldn't have been unconfigured and hence the addition of
these LMBs will result in configure-connector call being issued on
LMB DR connectors that are already in configured state. Such
configure-connector calls will fail resulting in a DIMM which is
partially unplugged.

This however worked till recently before we overhauled the DRC
implementation in QEMU. Commit 9d4c0f4f0a71e: "spapr: Consolidate
DRC state variables" is the first commit where this problem shows up
as per git bisect.

Ideally guest shouldn't be issuing configure-connector call on an
already configured DR connector. However for now, work around this in
QEMU by allowing configure-connector to be called multiple times for
all types of DR connectors.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
[dwg: Corrected buglet that would have initialized fdt pointers ready
 for reading on a device not present at reset]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_drc.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 5260b5d363..605697d8bd 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -442,12 +442,17 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
     if (drc->dev) {
         /* A device present at reset is ready to go, same as coldplugged */
         drc->state = drck->ready_state;
+        /*
+         * Ensure that we are able to send the FDT fragment again
+         * via configure-connector call if the guest requests.
+         */
+        drc->ccs_offset = drc->fdt_start_offset;
+        drc->ccs_depth = 0;
     } else {
         drc->state = drck->empty_state;
+        drc->ccs_offset = -1;
+        drc->ccs_depth = -1;
     }
-
-    drc->ccs_offset = -1;
-    drc->ccs_depth = -1;
 }
 
 static void drc_reset(void *opaque)
@@ -1071,8 +1076,14 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     }
 
     if ((drc->state != SPAPR_DRC_STATE_LOGICAL_UNISOLATE)
-        && (drc->state != SPAPR_DRC_STATE_PHYSICAL_UNISOLATE)) {
-        /* Need to unisolate the device before configuring */
+        && (drc->state != SPAPR_DRC_STATE_PHYSICAL_UNISOLATE)
+        && (drc->state != SPAPR_DRC_STATE_LOGICAL_CONFIGURED)
+        && (drc->state != SPAPR_DRC_STATE_PHYSICAL_CONFIGURED)) {
+        /*
+         * Need to unisolate the device before configuring
+         * or it should already be in configured state to
+         * allow configure-connector be called repeatedly.
+         */
         rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
         goto out;
     }
@@ -1108,8 +1119,13 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
                 /* done sending the device tree, move to configured state */
                 trace_spapr_drc_set_configured(drc_index);
                 drc->state = drck->ready_state;
-                drc->ccs_offset = -1;
-                drc->ccs_depth = -1;
+                /*
+                 * Ensure that we are able to send the FDT fragment
+                 * again via configure-connector call if the guest requests.
+                 */
+                drc->ccs_offset = drc->fdt_start_offset;
+                drc->ccs_depth = 0;
+                fdt_offset_next = drc->fdt_start_offset;
                 resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
             } else {
                 resp = SPAPR_DR_CC_RESPONSE_PREV_PARENT;
-- 
2.13.5
