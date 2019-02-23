Received: from eggs.gnu.org ([209.51.188.92]:55664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNEW-0002we-8Z
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gxNEV-0002bT-E7
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:08 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gxNEV-0002ag-6X
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 21:40:07 -0500
Received: by mail-pl1-x643.google.com with SMTP id k2so1913398plt.3
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 18:40:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 22 Feb 2019 18:39:56 -0800
Message-Id: <20190223023957.18865-6-richard.henderson@linaro.org>
In-Reply-To: <20190223023957.18865-1-richard.henderson@linaro.org>
References: <20190223023957.18865-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [RFC 5/6] target/arm: Conditionalize DBGDIDR vs
 ID_AA64DFR0_EL1 assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

Only perform the assert when both registers exist.
Extract the variables from ID_AA64DFR0_EL1 for AArch64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 58 +++++++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index fbdca9324b..1d8c8998c4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5544,32 +5544,50 @@ static void define_debug_regs(ARMCPU *cpu)
     /* Define v7 and v8 architectural debug registers.
      * These are just dummy implementations for now.
      */
-    int i;
-    int wrps, brps, ctx_cmps;
-    ARMCPRegInfo dbgdidr = {
-        .name = "DBGDIDR", .cp = 14, .crn = 0, .crm = 0, .opc1 = 0, .opc2 = 0,
-        .access = PL0_R, .accessfn = access_tda,
-        .type = ARM_CP_CONST, .resetvalue = cpu->dbgdidr,
-    };
+    int i, wrps, brps, ctx_cmps;
+    bool have_aa32;
 
-    /* Note that all these register fields hold "number of Xs minus 1". */
-    brps = extract32(cpu->dbgdidr, 24, 4);
-    wrps = extract32(cpu->dbgdidr, 28, 4);
-    ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
-
-    assert(ctx_cmps <= brps);
-
-    /* The DBGDIDR and ID_AA64DFR0_EL1 define various properties
+    /*
+     * The DBGDIDR and ID_AA64DFR0_EL1 define various properties
      * of the debug registers such as number of breakpoints;
      * check that if they both exist then they agree.
+     *
+     * Note that all these register fields hold "number of Xs minus 1".
      */
     if (arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
-        assert(extract32(cpu->id_aa64dfr0, 12, 4) == brps);
-        assert(extract32(cpu->id_aa64dfr0, 20, 4) == wrps);
-        assert(extract32(cpu->id_aa64dfr0, 28, 4) == ctx_cmps);
-    }
+        brps = extract32(cpu->id_aa64dfr0, 12, 4);
+        wrps = extract32(cpu->id_aa64dfr0, 20, 4);
+        ctx_cmps = extract32(cpu->id_aa64dfr0, 28, 4);
 
-    define_one_arm_cp_reg(cpu, &dbgdidr);
+        /*
+         * There are cpus with aarch32 only at EL0, and which do not
+         * have the 32-bit system registers.
+         */
+        have_aa32
+            = (FIELD_EX64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, EL1) >= 2 ||
+               FIELD_EX64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, EL2) >= 2 ||
+               FIELD_EX64(cpu->isar.id_aa64pfr0, ID_AA64PFR0, EL3) >= 2);
+        if (have_aa32) {
+            assert(extract32(cpu->dbgdidr, 24, 4) == brps);
+            assert(extract32(cpu->dbgdidr, 28, 4) == wrps);
+            assert(extract32(cpu->dbgdidr, 20, 4) == ctx_cmps);
+        }
+    } else {
+        have_aa32 = true;
+        brps = extract32(cpu->dbgdidr, 24, 4);
+        wrps = extract32(cpu->dbgdidr, 28, 4);
+        ctx_cmps = extract32(cpu->dbgdidr, 20, 4);
+    }
+    assert(ctx_cmps <= brps);
+
+    if (have_aa32) {
+        ARMCPRegInfo dbgdidr = {
+            .name = "DBGDIDR", .cp = 14, .crn = 0, .crm = 0,
+            .opc1 = 0, .opc2 = 0, .access = PL0_R, .accessfn = access_tda,
+            .type = ARM_CP_CONST, .resetvalue = cpu->dbgdidr,
+        };
+        define_one_arm_cp_reg(cpu, &dbgdidr);
+    }
     define_arm_cp_regs(cpu, debug_cp_reginfo);
 
     if (arm_feature(&cpu->env, ARM_FEATURE_LPAE)) {
-- 
2.17.2
