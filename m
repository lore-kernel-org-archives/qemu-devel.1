Received: from eggs.gnu.org ([2001:4830:134:3::10]:49566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc8-00021Z-2Q
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc6-0003vz-Qm
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:08 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccFc6-0003sU-J0
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 13:08:06 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1ccFc5-0007bW-FB
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 18:08:05 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 18:07:53 +0000
Message-Id: <1486750082-12324-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
References: <1486750082-12324-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/12] target-arm: Add support for PMU register
 PMINTENSET_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Wei Huang <wei@redhat.com>

This patch adds access support for PMINTENSET_EL1.

Signed-off-by: Wei Huang <wei@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 1486504171-26807-4-git-send-email-wei@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index edc1f76..0956a54 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -309,7 +309,7 @@ typedef struct CPUARMState {
         uint32_t c9_pmovsr; /* perf monitor overflow status */
         uint32_t c9_pmuserenr; /* perf monitor user enable */
         uint64_t c9_pmselr; /* perf monitor counter selection register */
-        uint32_t c9_pminten; /* perf monitor interrupt enables */
+        uint64_t c9_pminten; /* perf monitor interrupt enables */
         union { /* Memory attribute redirection */
             struct {
 #ifdef HOST_WORDS_BIGENDIAN
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b837d36..5358ac6 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1275,9 +1275,17 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .writefn = pmuserenr_write, .raw_writefn = raw_write },
     { .name = "PMINTENSET", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 1,
       .access = PL1_RW, .accessfn = access_tpm,
-      .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
+      .type = ARM_CP_ALIAS,
+      .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pminten),
       .resetvalue = 0,
       .writefn = pmintenset_write, .raw_writefn = raw_write },
+    { .name = "PMINTENSET_EL1", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 1,
+      .access = PL1_RW, .accessfn = access_tpm,
+      .type = ARM_CP_IO,
+      .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
+      .writefn = pmintenset_write, .raw_writefn = raw_write,
+      .resetvalue = 0x0 },
     { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-- 
2.7.4
