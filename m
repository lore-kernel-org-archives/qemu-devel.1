Received: from eggs.gnu.org ([2001:4830:134:3::10]:58711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3j-0002f5-32
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSd3h-0001nv-W4
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 02:45:39 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 12 Jun 2018 16:44:38 +1000
Message-Id: <20180612064503.14282-9-david@gibson.dropbear.id.au>
In-Reply-To: <20180612064503.14282-1-david@gibson.dropbear.id.au>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 08/33] target/ppc: Factor out the parsing in
 kvmppc_get_cpu_characteristics()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Factor out the parsing of struct kvm_ppc_cpu_char in
kvmppc_get_cpu_characteristics() into a separate function for each cap
for simplicity.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 59 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index cbe13b18d1..2c0c34e125 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2412,6 +2412,41 @@ bool kvmppc_has_cap_mmu_hash_v3(void)
     return cap_mmu_hash_v3;
 }
 
+static int parse_cap_ppc_safe_cache(struct kvm_ppc_cpu_char c)
+{
+    if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
+        return 2;
+    } else if ((c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
+               (c.character & c.character_mask
+                & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static int parse_cap_ppc_safe_bounds_check(struct kvm_ppc_cpu_char c)
+{
+    if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR) {
+        return 2;
+    } else if (c.character & c.character_mask & H_CPU_CHAR_SPEC_BAR_ORI31) {
+        return 1;
+    }
+
+    return 0;
+}
+
+static int parse_cap_ppc_safe_indirect_branch(struct kvm_ppc_cpu_char c)
+{
+    if (c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) {
+        return  SPAPR_CAP_FIXED_CCD;
+    } else if (c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED) {
+        return SPAPR_CAP_FIXED_IBS;
+    }
+
+    return 0;
+}
+
 static void kvmppc_get_cpu_characteristics(KVMState *s)
 {
     struct kvm_ppc_cpu_char c;
@@ -2430,26 +2465,10 @@ static void kvmppc_get_cpu_characteristics(KVMState *s)
     if (ret < 0) {
         return;
     }
-    /* Parse and set cap_ppc_safe_cache */
-    if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_L1D_FLUSH_PR) {
-        cap_ppc_safe_cache = 2;
-    } else if ((c.character & c.character_mask & H_CPU_CHAR_L1D_THREAD_PRIV) &&
-               (c.character & c.character_mask
-                & (H_CPU_CHAR_L1D_FLUSH_ORI30 | H_CPU_CHAR_L1D_FLUSH_TRIG2))) {
-        cap_ppc_safe_cache = 1;
-    }
-    /* Parse and set cap_ppc_safe_bounds_check */
-    if (~c.behaviour & c.behaviour_mask & H_CPU_BEHAV_BNDS_CHK_SPEC_BAR) {
-        cap_ppc_safe_bounds_check = 2;
-    } else if (c.character & c.character_mask & H_CPU_CHAR_SPEC_BAR_ORI31) {
-        cap_ppc_safe_bounds_check = 1;
-    }
-    /* Parse and set cap_ppc_safe_indirect_branch */
-    if (c.character & c.character_mask & H_CPU_CHAR_CACHE_COUNT_DIS) {
-        cap_ppc_safe_indirect_branch = SPAPR_CAP_FIXED_CCD;
-    } else if (c.character & c.character_mask & H_CPU_CHAR_BCCTRL_SERIALISED) {
-        cap_ppc_safe_indirect_branch = SPAPR_CAP_FIXED_IBS;
-    }
+
+    cap_ppc_safe_cache = parse_cap_ppc_safe_cache(c);
+    cap_ppc_safe_bounds_check = parse_cap_ppc_safe_bounds_check(c);
+    cap_ppc_safe_indirect_branch = parse_cap_ppc_safe_indirect_branch(c);
 }
 
 int kvmppc_get_cap_safe_cache(void)
-- 
2.17.1
