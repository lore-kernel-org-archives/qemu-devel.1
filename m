Received: from eggs.gnu.org ([209.51.188.92]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gzYjt-0001oT-Fj
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 22:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1gzYi5-00059G-FC
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 22:19:43 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri,  1 Mar 2019 14:19:11 +1100
Message-Id: <20190301031912.28809-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] target/ppc/spapr: Add
 workaround option to SPAPR_CAP_IBS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-devel@nongnu.org, mpe@ellerman.id.au, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The spapr_cap SPAPR_CAP_IBS is used to indicate the level of capability
for mitigations for indirect branch speculation. Currently the available
values are broken (default), fixed-ibs (fixed by serialising indirect
branches) and fixed-ccd (fixed by diabling the count cache).

Introduce a new value for this capability denoted workaround, meaning that
software can work around the issue by flushing the count cache on
context switch. This option is available if the hypervisor sets the
H_CPU_BEHAV_FLUSH_COUNT_CACHE flag in the cpu behaviours returned from
the KVM_PPC_GET_CPU_CHAR ioctl.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr_caps.c    | 21 ++++++++++-----------
 hw/ppc/spapr_hcall.c   |  5 +++++
 include/hw/ppc/spapr.h |  7 +++++++
 target/ppc/kvm.c       |  8 +++++++-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 920224d0c2..74a48a423a 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -276,11 +276,13 @@ static void cap_safe_bounds_check_apply(sPAPRMachineState *spapr, uint8_t val,
 }
 
 sPAPRCapPossible cap_ibs_possible = {
-    .num = 4,
+    .num = 5,
     /* Note workaround only maintained for compatibility */
-    .vals = {"broken", "workaround", "fixed-ibs", "fixed-ccd"},
-    .help = "broken - no protection, fixed-ibs - indirect branch serialisation,"
-            " fixed-ccd - cache count disabled",
+    .vals = {"broken", "workaround", "fixed-ibs", "fixed-ccd", "fixed-na"},
+    .help = "broken - no protection, workaround - count cache flush"
+            ", fixed-ibs - indirect branch serialisation,"
+            " fixed-ccd - cache count disabled,"
+            " fixed-na - fixed in hardware (no longer applicable)",
 };
 
 static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
@@ -288,15 +290,11 @@ static void cap_safe_indirect_branch_apply(sPAPRMachineState *spapr,
 {
     uint8_t kvm_val = kvmppc_get_cap_safe_indirect_branch();
 
-    if (val == SPAPR_CAP_WORKAROUND) { /* Can only be Broken or Fixed */
-        error_setg(errp,
-"Requested safe indirect branch capability level \"workaround\" not valid, try cap-ibs=%s",
-                   cap_ibs_possible.vals[kvm_val]);
-    } else if (tcg_enabled() && val) {
+    if (tcg_enabled() && val) {
         /* TODO - for now only allow broken for TCG */
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by tcg, try a different value for cap-ibs");
-    } else if (kvm_enabled() && val && (val != kvm_val)) {
+    } else if (kvm_enabled() && (val > kvm_val)) {
         error_setg(errp,
 "Requested safe indirect branch capability level not supported by kvm, try cap-ibs=%s",
                    cap_ibs_possible.vals[kvm_val]);
@@ -489,7 +487,8 @@ sPAPRCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
     [SPAPR_CAP_IBS] = {
         .name = "ibs",
         .description =
-            "Indirect Branch Speculation (broken, fixed-ibs, fixed-ccd)",
+            "Indirect Branch Speculation (broken, workaround, fixed-ibs,"
+            "fixed-ccd, fixed-na)",
         .index = SPAPR_CAP_IBS,
         .get = spapr_cap_get_string,
         .set = spapr_cap_set_string,
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 476bad6271..4aa8036fc0 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1723,12 +1723,17 @@ static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
     }
 
     switch (safe_indirect_branch) {
+    case SPAPR_CAP_FIXED_NA:
+        break;
     case SPAPR_CAP_FIXED_CCD:
         characteristics |= H_CPU_CHAR_CACHE_COUNT_DIS;
         break;
     case SPAPR_CAP_FIXED_IBS:
         characteristics |= H_CPU_CHAR_BCCTRL_SERIALISED;
         break;
+    case SPAPR_CAP_WORKAROUND:
+        behaviour |= H_CPU_BEHAV_FLUSH_COUNT_CACHE;
+        break;
     default: /* broken */
         assert(safe_indirect_branch == SPAPR_CAP_BROKEN);
         break;
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 3cd47fb6e8..80d33ea284 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -85,12 +85,17 @@ typedef enum {
 /* Bool Caps */
 #define SPAPR_CAP_OFF                   0x00
 #define SPAPR_CAP_ON                    0x01
+
 /* Custom Caps */
+
+/* Generic */
 #define SPAPR_CAP_BROKEN                0x00
 #define SPAPR_CAP_WORKAROUND            0x01
 #define SPAPR_CAP_FIXED                 0x02
+/* SPAPR_CAP_IBS (cap-ibs) */
 #define SPAPR_CAP_FIXED_IBS             0x02
 #define SPAPR_CAP_FIXED_CCD             0x03
+#define SPAPR_CAP_FIXED_NA              0x10 /* Lets leave a bit of a gap... */
 
 typedef struct sPAPRCapabilities sPAPRCapabilities;
 struct sPAPRCapabilities {
@@ -340,9 +345,11 @@ struct sPAPRMachineState {
 #define H_CPU_CHAR_HON_BRANCH_HINTS             PPC_BIT(5)
 #define H_CPU_CHAR_THR_RECONF_TRIG              PPC_BIT(6)
 #define H_CPU_CHAR_CACHE_COUNT_DIS              PPC_BIT(7)
+#define H_CPU_CHAR_BCCTR_FLUSH_ASSIST           PPC_BIT(9)
 #define H_CPU_BEHAV_FAVOUR_SECURITY             PPC_BIT(0)
 #define H_CPU_BEHAV_L1D_FLUSH_PR                PPC_BIT(1)
 #define H_CPU_BEHAV_BNDS_CHK_SPEC_BAR           PPC_BIT(2)
+#define H_CPU_BEHAV_FLUSH_COUNT_CACHE           PPC_BIT(5)
 
 /* Each control block has to be on a 4K boundary */
 #define H_CB_ALIGNMENT     4096
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 3f650c8fc4..7a7a5adee3 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2391,7 +2391,13 @@ static int parse_cap_ppc_safe_bounds_check(struct kvm_ppc_cpu_char c)
 
 static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
 {
-    if (c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) {
+    if ((~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_FLUSH_COUNT_CACHE) &&
+        (~c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) &&
+        (~c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED)) {
+        return SPAPR_CAP_FIXED_NA;
+    } else if (c.behaviour & c.behaviour_mask & H_CPU_BEHAV_FLUSH_COUNT_CACHE) {
+        return SPAPR_CAP_WORKAROUND;
+    } else if (c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) {
         return  SPAPR_CAP_FIXED_CCD;
     } else if (c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED) {
         return SPAPR_CAP_FIXED_IBS;
-- 
2.13.6
