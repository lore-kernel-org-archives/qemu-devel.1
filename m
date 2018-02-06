Received: from eggs.gnu.org ([2001:4830:134:3::10]:44803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8jD-0005pO-1T
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j2-0008J8-Gg
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34782
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8j2-0008Ip-Bo
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:16 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JELBR126800
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:16 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fyhwn1fpe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:12 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:12 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:14 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-54-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 53/54] target/ppc/spapr_caps: Add new tristate
 cap safe_indirect_branch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Add new tristate cap cap-ibs to represent the indirect branch
serialisation capability.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 4be8d4e7d935fc8919d61f53a0f0fb7230052bb3)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 21 +++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0db86a7945..b57528baf4 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1767,6 +1767,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_dfp,
         &vmstate_spapr_cap_cfpc,
         &vmstate_spapr_cap_sbbc,
+        &vmstate_spapr_cap_ibs,
         NULL
     }
 };
@@ -3713,6 +3714,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
     smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_IBS] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 680cb6f0e5..7b229517be 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -203,6 +203,17 @@ static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
     }
 }
 
+static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
+                                           uint8_t val, Error **errp)
+{
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp, "Requested safe indirect branch capability level not supported by tcg, try a different value for cap-ibs");
+    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_indirect_branch())) {
+        error_setg(errp, "Requested safe indirect branch capability level not supported by kvm, try a different value for cap-ibs");
+    }
+}
+
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
@@ -254,6 +265,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "string",
         .apply = cap_safe_bounds_check_apply,
     },
+    [SPAPR_CAP_IBS] = {
+        .name = "ibs",
+        .description = "Indirect Branch Serialisation" VALUE_DESC_TRISTATE,
+        .index = SPAPR_CAP_IBS,
+        .get = spapr_cap_get_tristate,
+        .set = spapr_cap_set_tristate,
+        .type = "string",
+        .apply = cap_safe_indirect_branch_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -361,6 +381,7 @@ SPAPR_CAP_MIG_STATE(vsx, VSX);
 SPAPR_CAP_MIG_STATE(dfp, DFP);
 SPAPR_CAP_MIG_STATE(cfpc, CFPC);
 SPAPR_CAP_MIG_STATE(sbbc, SBBC);
+SPAPR_CAP_MIG_STATE(ibs, IBS);
 
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index f272a304d3..9e7be34d4e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -64,8 +64,10 @@ typedef enum {
 #define SPAPR_CAP_CFPC                  0x03
 /* Speculation Barrier Bounds Checking */
 #define SPAPR_CAP_SBBC                  0x04
+/* Indirect Branch Serialisation */
+#define SPAPR_CAP_IBS                   0x05
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_SBBC + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_IBS + 1)
 
 /*
  * Capability Values
@@ -767,6 +769,7 @@ extern const VMStateDescription vmstate_spapr_cap_vsx;
 extern const VMStateDescription vmstate_spapr_cap_dfp;
 extern const VMStateDescription vmstate_spapr_cap_cfpc;
 extern const VMStateDescription vmstate_spapr_cap_sbbc;
+extern const VMStateDescription vmstate_spapr_cap_ibs;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
-- 
2.11.0
