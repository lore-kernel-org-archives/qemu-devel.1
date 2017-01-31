Received: from eggs.gnu.org ([2001:4830:134:3::10]:57559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYaA1-0007ef-8C
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cYa9v-00019b-Gd
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 10:15:57 -0500
From: Wei Huang <wei@redhat.com>
Date: Tue, 31 Jan 2017 10:15:44 -0500
Message-Id: <1485875745-27741-5-git-send-email-wei@redhat.com>
In-Reply-To: <1485875745-27741-1-git-send-email-wei@redhat.com>
References: <1485875745-27741-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V2 4/5] target-arm: Add support for PMU
 register PMINTENSET_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org

This patch adds access support for PMINTENSET_EL1.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 target/arm/cpu.h    |  2 +-
 target/arm/helper.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index ce02044..42aaea9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -310,7 +310,7 @@ typedef struct CPUARMState {
         uint64_t c9_pmxevtyper; /* perf monitor event type */
         uint32_t c9_pmuserenr; /* perf monitor user enable */
         uint64_t c9_pmselr; /* perf monitor counter selection register */
-        uint32_t c9_pminten; /* perf monitor interrupt enables */
+        uint64_t c9_pminten; /* perf monitor interrupt enables */
         union { /* Memory attribute redirection */
             struct {
 #ifdef HOST_WORDS_BIGENDIAN
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6b8460a..b028042 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1272,9 +1272,17 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
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
1.8.3.1
