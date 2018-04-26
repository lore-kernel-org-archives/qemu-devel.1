Received: from eggs.gnu.org ([2001:4830:134:3::10]:39693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQy-0002kf-4s
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQx-0001XS-9z
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:41152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fBeQx-0001Vb-2S
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:47:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fBeQv-00034U-RD
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 11:47:25 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:47:09 +0100
Message-Id: <20180426104715.21702-14-peter.maydell@linaro.org>
In-Reply-To: <20180426104715.21702-1-peter.maydell@linaro.org>
References: <20180426104715.21702-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 13/19] target/arm: Make PMOVSCLR and PMUSERENR
 64 bits wide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Aaron Lindsay <alindsay@codeaurora.org>

This is a bug fix to ensure 64-bit reads of these registers don't read
adjacent data.

Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
Message-id: 1523997485-1905-13-git-send-email-alindsay@codeaurora.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 4 ++--
 target/arm/helper.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b9b47f4b22..44e6b77151 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -367,8 +367,8 @@ typedef struct CPUARMState {
         uint32_t c9_data;
         uint64_t c9_pmcr; /* performance monitor control register */
         uint64_t c9_pmcnten; /* perf monitor counter enables */
-        uint32_t c9_pmovsr; /* perf monitor overflow status */
-        uint32_t c9_pmuserenr; /* perf monitor user enable */
+        uint64_t c9_pmovsr; /* perf monitor overflow status */
+        uint64_t c9_pmuserenr; /* perf monitor user enable */
         uint64_t c9_pmselr; /* perf monitor counter selection register */
         uint64_t c9_pminten; /* perf monitor interrupt enables */
         union { /* Memory attribute redirection */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 85c289f3b9..52a88e0297 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1305,7 +1305,8 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
       .writefn = pmcntenclr_write },
     { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
-      .access = PL0_RW, .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
+      .access = PL0_RW,
+      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
       .accessfn = pmreg_access,
       .writefn = pmovsr_write,
       .raw_writefn = raw_write },
@@ -1360,7 +1361,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .accessfn = pmreg_access_xevcntr },
     { .name = "PMUSERENR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 0,
       .access = PL0_R | PL1_RW, .accessfn = access_tpm,
-      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmuserenr),
+      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmuserenr),
       .resetvalue = 0,
       .writefn = pmuserenr_write, .raw_writefn = raw_write },
     { .name = "PMUSERENR_EL0", .state = ARM_CP_STATE_AA64,
-- 
2.17.0
