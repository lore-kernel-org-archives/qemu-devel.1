Received: from eggs.gnu.org ([2001:4830:134:3::10]:51953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dhwc5-0006qZ-Vh
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1dhwc2-0004qz-M4
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:35:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49609
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1dhwc2-0004os-GV
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:35:50 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7GBY2JL116503
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 07:35:49 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ccmgkbb11-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 07:35:48 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 16 Aug 2017 21:35:46 +1000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Wed, 16 Aug 2017 17:05:36 +0530
Message-Id: <1502883336-14608-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [FIX PATCH v0] spapr: Allow configure-connector to be
 called multiple times for LMBs
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
LMBs.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/ppc/spapr_drc.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 5260b5d..2dd9635 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -446,8 +446,17 @@ void spapr_drc_reset(sPAPRDRConnector *drc)
         drc->state = drck->empty_state;
     }
 
-    drc->ccs_offset = -1;
-    drc->ccs_depth = -1;
+    if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_LMB) {
+        /*
+         * Ensure that we are able to send the FDT fragment of the
+         * LMB again via configure-connector call if guest requests.
+         */
+        drc->ccs_offset = drc->fdt_start_offset;
+        drc->ccs_depth = 0;
+    } else {
+        drc->ccs_offset = -1;
+        drc->ccs_depth = -1;
+    }
 }
 
 static void drc_reset(void *opaque)
@@ -1071,8 +1080,14 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
     }
 
     if ((drc->state != SPAPR_DRC_STATE_LOGICAL_UNISOLATE)
-        && (drc->state != SPAPR_DRC_STATE_PHYSICAL_UNISOLATE)) {
-        /* Need to unisolate the device before configuring */
+        && (drc->state != SPAPR_DRC_STATE_PHYSICAL_UNISOLATE) &&
+        (spapr_drc_type(drc) != SPAPR_DR_CONNECTOR_TYPE_LMB)) {
+        /*
+         * Need to unisolate the device before configuring, however
+         * LMB DRCs are exempted from this check as guest can issue
+         * configure-connector calls for an already configured
+         * LMB DRC.
+         */
         rc = SPAPR_DR_CC_RESPONSE_NOT_CONFIGURABLE;
         goto out;
     }
@@ -1108,8 +1123,18 @@ static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
                 /* done sending the device tree, move to configured state */
                 trace_spapr_drc_set_configured(drc_index);
                 drc->state = drck->ready_state;
-                drc->ccs_offset = -1;
-                drc->ccs_depth = -1;
+                if (spapr_drc_type(drc) == SPAPR_DR_CONNECTOR_TYPE_LMB) {
+                    /*
+                     * Ensure that we are able to send the FDT fragment of the
+                     * LMB again via configure-connector call if guest requests.
+                     */
+                    drc->ccs_offset = drc->fdt_start_offset;
+                    drc->ccs_depth = 0;
+                    fdt_offset_next = drc->fdt_start_offset;
+                } else {
+                    drc->ccs_offset = -1;
+                    drc->ccs_depth = -1;
+                }
                 resp = SPAPR_DR_CC_RESPONSE_SUCCESS;
             } else {
                 resp = SPAPR_DR_CC_RESPONSE_PREV_PARENT;
-- 
2.7.4
