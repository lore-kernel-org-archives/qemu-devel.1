Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj3A-0000Yp-B4
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj38-0007PN-Q8
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:16 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fJj38-0007NV-IF
	for qemu-devel@nongnu.org; Fri, 18 May 2018 13:20:14 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fJj35-0004kH-Mr
	for qemu-devel@nongnu.org; Fri, 18 May 2018 18:20:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 May 2018 18:19:39 +0100
Message-Id: <20180518172009.14416-3-peter.maydell@linaro.org>
In-Reply-To: <20180518172009.14416-1-peter.maydell@linaro.org>
References: <20180518172009.14416-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/32] target/arm: Add "_S" suffix to the secure
 version of a sysreg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>

This is a preparation for the coming feature of creating dynamically an XML
description for the ARM sysregs.
Add "_S" suffix to the secure version of sysregs that have both S and NS views
Replace (S) and (NS) by _S and _NS for the register that are manually defined,
so all the registers follow the same convention.

Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 1524153386-3550-3-git-send-email-abdallah.bouassida@lauterbach.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 118422b92c..369292c8b0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -690,12 +690,12 @@ static const ARMCPRegInfo cp_reginfo[] = {
      * the secure register to be properly reset and migrated. There is also no
      * v8 EL1 version of the register so the non-secure instance stands alone.
      */
-    { .name = "FCSEIDR(NS)",
+    { .name = "FCSEIDR",
       .cp = 15, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .secure = ARM_CP_SECSTATE_NS,
       .fieldoffset = offsetof(CPUARMState, cp15.fcseidr_ns),
       .resetvalue = 0, .writefn = fcse_write, .raw_writefn = raw_write, },
-    { .name = "FCSEIDR(S)",
+    { .name = "FCSEIDR_S",
       .cp = 15, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 0,
       .access = PL1_RW, .secure = ARM_CP_SECSTATE_S,
       .fieldoffset = offsetof(CPUARMState, cp15.fcseidr_s),
@@ -711,7 +711,7 @@ static const ARMCPRegInfo cp_reginfo[] = {
       .access = PL1_RW, .secure = ARM_CP_SECSTATE_NS,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_el[1]),
       .resetvalue = 0, .writefn = contextidr_write, .raw_writefn = raw_write, },
-    { .name = "CONTEXTIDR(S)", .state = ARM_CP_STATE_AA32,
+    { .name = "CONTEXTIDR_S", .state = ARM_CP_STATE_AA32,
       .cp = 15, .opc1 = 0, .crn = 13, .crm = 0, .opc2 = 1,
       .access = PL1_RW, .secure = ARM_CP_SECSTATE_S,
       .fieldoffset = offsetof(CPUARMState, cp15.contextidr_s),
@@ -1981,7 +1981,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
                                    cp15.c14_timer[GTIMER_PHYS].ctl),
       .writefn = gt_phys_ctl_write, .raw_writefn = raw_write,
     },
-    { .name = "CNTP_CTL(S)",
+    { .name = "CNTP_CTL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 1,
       .secure = ARM_CP_SECSTATE_S,
       .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_R,
@@ -2020,7 +2020,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_ptimer_access,
       .readfn = gt_phys_tval_read, .writefn = gt_phys_tval_write,
     },
-    { .name = "CNTP_TVAL(S)",
+    { .name = "CNTP_TVAL_S",
       .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 0,
       .secure = ARM_CP_SECSTATE_S,
       .type = ARM_CP_NO_RAW | ARM_CP_IO, .access = PL1_RW | PL0_R,
@@ -2074,7 +2074,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
       .accessfn = gt_ptimer_access,
       .writefn = gt_phys_cval_write, .raw_writefn = raw_write,
     },
-    { .name = "CNTP_CVAL(S)", .cp = 15, .crm = 14, .opc1 = 2,
+    { .name = "CNTP_CVAL_S", .cp = 15, .crm = 14, .opc1 = 2,
       .secure = ARM_CP_SECSTATE_S,
       .access = PL1_RW | PL0_R,
       .type = ARM_CP_64BIT | ARM_CP_IO | ARM_CP_ALIAS,
@@ -5577,7 +5577,8 @@ CpuDefinitionInfoList *arch_query_cpu_definitions(Error **errp)
 
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                                    void *opaque, int state, int secstate,
-                                   int crm, int opc1, int opc2)
+                                   int crm, int opc1, int opc2,
+                                   const char *name)
 {
     /* Private utility function for define_one_arm_cp_reg_with_opaque():
      * add a single reginfo struct to the hash table.
@@ -5587,6 +5588,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     int is64 = (r->type & ARM_CP_64BIT) ? 1 : 0;
     int ns = (secstate & ARM_CP_SECSTATE_NS) ? 1 : 0;
 
+    r2->name = g_strdup(name);
     /* Reset the secure state to the specific incoming state.  This is
      * necessary as the register may have been defined with both states.
      */
@@ -5818,19 +5820,24 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                         /* Under AArch32 CP registers can be common
                          * (same for secure and non-secure world) or banked.
                          */
+                        char *name;
+
                         switch (r->secure) {
                         case ARM_CP_SECSTATE_S:
                         case ARM_CP_SECSTATE_NS:
                             add_cpreg_to_hashtable(cpu, r, opaque, state,
-                                                   r->secure, crm, opc1, opc2);
+                                                   r->secure, crm, opc1, opc2,
+                                                   r->name);
                             break;
                         default:
+                            name = g_strdup_printf("%s_S", r->name);
                             add_cpreg_to_hashtable(cpu, r, opaque, state,
                                                    ARM_CP_SECSTATE_S,
-                                                   crm, opc1, opc2);
+                                                   crm, opc1, opc2, name);
+                            g_free(name);
                             add_cpreg_to_hashtable(cpu, r, opaque, state,
                                                    ARM_CP_SECSTATE_NS,
-                                                   crm, opc1, opc2);
+                                                   crm, opc1, opc2, r->name);
                             break;
                         }
                     } else {
@@ -5838,7 +5845,7 @@ void define_one_arm_cp_reg_with_opaque(ARMCPU *cpu,
                          * of AArch32 */
                         add_cpreg_to_hashtable(cpu, r, opaque, state,
                                                ARM_CP_SECSTATE_NS,
-                                               crm, opc1, opc2);
+                                               crm, opc1, opc2, r->name);
                     }
                 }
             }
-- 
2.17.0
