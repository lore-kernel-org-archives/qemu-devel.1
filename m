Received: from eggs.gnu.org ([2001:4830:134:3::10]:34037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cRZQy-0001Uj-JZ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei@redhat.com>) id 1cRZQx-00063d-RD
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:04:28 -0500
From: Wei Huang <wei@redhat.com>
Date: Thu, 12 Jan 2017 02:04:16 -0500
Message-Id: <1484204658-28058-3-git-send-email-wei@redhat.com>
In-Reply-To: <1484204658-28058-1-git-send-email-wei@redhat.com>
References: <1484204658-28058-1-git-send-email-wei@redhat.com>
Subject: [Qemu-devel] [PATCH V1 2/4] target-arm: Add support for AArch64 PMU
 register PMXEVTYPER_EL0
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

In order to support Linux perf, which uses PMXEVTYPER register,
this patch adds access support for PMXEVTYPER_EL0.

Signed-off-by: Wei Huang <wei@redhat.com>
---
 target/arm/helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 71adb0f..9044a33 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1233,10 +1233,17 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetof(CPUARMState, cp15.pmccfiltr_el0),
       .resetvalue = 0, },
     { .name = "PMXEVTYPER", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 1,
-      .access = PL0_RW,
+      .access = PL0_RW, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmxevtyper),
       .accessfn = pmreg_access, .writefn = pmxevtyper_write,
       .raw_writefn = raw_write },
+    { .name = "PMXEVTYPER_EL0", .state = ARM_CP_STATE_AA64,
+      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 1,
+      .access = PL0_RW, .accessfn = pmreg_access,
+      .type = ARM_CP_IO,
+      .fieldoffset = offsetof(CPUARMState, cp15.c9_pmxevtyper),
+      .writefn = pmxevtyper_write, .raw_writefn = raw_write,
+      .resetvalue = 0x0 },
     /* Unimplemented, RAZ/WI. */
     { .name = "PMXEVCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 2,
       .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
-- 
1.8.3.1
