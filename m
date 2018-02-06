Received: from eggs.gnu.org ([2001:4830:134:3::10]:44790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8jB-0005o8-VH
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ej8j2-0008Ik-2J
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ej8j1-0008I1-Pw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:16:15 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w16JEbr4043600
	for <qemu-devel@nongnu.org>; Tue, 6 Feb 2018 14:16:14 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fyea63vp8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 14:16:13 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Tue, 6 Feb 2018 14:16:11 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Tue,  6 Feb 2018 13:15:13 -0600
In-Reply-To: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
Message-Id: <20180206191515.25830-53-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 52/54] target/ppc/spapr_caps: Add new tristate
 cap safe_bounds_check
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

Add new tristate cap cap-sbbc to represent the speculation barrier
bounds checking capability.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 09114fd8179977e4157b36aab2e3d68eaf08adca)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |  2 ++
 hw/ppc/spapr_caps.c    | 21 +++++++++++++++++++++
 include/hw/ppc/spapr.h |  5 ++++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 37a414ffe6..0db86a7945 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1766,6 +1766,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_cap_vsx,
         &vmstate_spapr_cap_dfp,
         &vmstate_spapr_cap_cfpc,
+        &vmstate_spapr_cap_sbbc,
         NULL
     }
 };
@@ -3711,6 +3712,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     smc->default_caps.caps[SPAPR_CAP_VSX] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_DFP] = SPAPR_CAP_ON;
     smc->default_caps.caps[SPAPR_CAP_CFPC] = SPAPR_CAP_BROKEN;
+    smc->default_caps.caps[SPAPR_CAP_SBBC] = SPAPR_CAP_BROKEN;
     spapr_caps_add_properties(smc, &error_abort);
 }
 
diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 183916895c..680cb6f0e5 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -192,6 +192,17 @@ static void cap_safe_cache_apply(sPAPRMachineState *spapr, uint8_t val,
     }
 }
 
+static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
+                                        Error **errp)
+{
+    if (tcg_enabled() && val) {
+        /* TODO - for now only allow broken for TCG */
+        error_setg(errp, "Requested safe bounds check capability level not supported by tcg, try a different value for cap-sbbc");
+    } else if (kvm_enabled() && (val > kvmppc_get_cap_safe_bounds_check())) {
+        error_setg(errp, "Requested safe bounds check capability level not supported by kvm, try a different value for cap-sbbc");
+    }
+}
+
 #define VALUE_DESC_TRISTATE     " (broken, workaround, fixed)"
 
 sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
@@ -234,6 +245,15 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
         .type = "string",
         .apply = cap_safe_cache_apply,
     },
+    [SPAPR_CAP_SBBC] = {
+        .name = "sbbc",
+        .description = "Speculation Barrier Bounds Checking" VALUE_DESC_TRISTATE,
+        .index = SPAPR_CAP_SBBC,
+        .get = spapr_cap_get_tristate,
+        .set = spapr_cap_set_tristate,
+        .type = "string",
+        .apply = cap_safe_bounds_check_apply,
+    },
 };
 
 static sPAPRCapabilities default_caps_with_cpu(sPAPRMachineState *spapr,
@@ -340,6 +360,7 @@ SPAPR_CAP_MIG_STATE(htm, HTM);
 SPAPR_CAP_MIG_STATE(vsx, VSX);
 SPAPR_CAP_MIG_STATE(dfp, DFP);
 SPAPR_CAP_MIG_STATE(cfpc, CFPC);
+SPAPR_CAP_MIG_STATE(sbbc, SBBC);
 
 void spapr_caps_reset(sPAPRMachineState *spapr)
 {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index fdb80f2118..f272a304d3 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -62,8 +62,10 @@ typedef enum {
 #define SPAPR_CAP_DFP                   0x02
 /* Cache Flush on Privilege Change */
 #define SPAPR_CAP_CFPC                  0x03
+/* Speculation Barrier Bounds Checking */
+#define SPAPR_CAP_SBBC                  0x04
 /* Num Caps */
-#define SPAPR_CAP_NUM                   (SPAPR_CAP_CFPC + 1)
+#define SPAPR_CAP_NUM                   (SPAPR_CAP_SBBC + 1)
 
 /*
  * Capability Values
@@ -764,6 +766,7 @@ extern const VMStateDescription vmstate_spapr_cap_htm;
 extern const VMStateDescription vmstate_spapr_cap_vsx;
 extern const VMStateDescription vmstate_spapr_cap_dfp;
 extern const VMStateDescription vmstate_spapr_cap_cfpc;
+extern const VMStateDescription vmstate_spapr_cap_sbbc;
 
 static inline uint8_t spapr_get_cap(sPAPRMachineState *spapr, int cap)
 {
-- 
2.11.0
