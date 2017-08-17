Received: from eggs.gnu.org ([2001:4830:134:3::10]:32920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1diDB1-0006IR-Dx
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1diDAy-0007Pr-7O
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:17:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36642
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1diDAy-0007Pf-2A
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 01:17:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7H5DsIC145943
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 01:16:59 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cd3tm3wus-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 01:16:59 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Thu, 17 Aug 2017 15:16:56 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Thu, 17 Aug 2017 10:46:42 +0530
Message-Id: <1502947002-19016-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [FIX PATCH v1] spapr: Allow configure-connector to be
 called multiple times
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

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
---
v0: https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg02942.html
Changes in v1:
 - Allow configure-connector to be called multiple times for all types
   of DR connectors and not just LMB DRCs. (David Gibson)
 - Explicitly allow configure-connector to proceed only if the DRC is
   either in unisolated or in configured state. (David Gibson)

 hw/ppc/spapr_drc.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 5260b5d..40d1e99 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -446,8 +446,12 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
         drc->state = drck->empty_state;
     }
 
-    drc->ccs_offset = -1;
-    drc->ccs_depth = -1;
+    /*
+     * Ensure that we are able to send the FDT fragment again
+     * via configure-connector call if the guest requests.
+     */
+    drc->ccs_offset = drc->fdt_start_offset;
+    drc->ccs_depth = 0;
 }
 
 static void drc_reset(void *opaque)
@@ -1071,8 +1075,14 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
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
@@ -1108,8 +1118,13 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
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
2.7.4
