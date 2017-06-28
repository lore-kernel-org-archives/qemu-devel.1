Received: from eggs.gnu.org ([2001:4830:134:3::10]:57443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQ55b-0002bv-Ua
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 01:00:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dQ55X-0004ip-6G
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 01:00:32 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:35172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dQ55X-0004iG-2G
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 01:00:27 -0400
Received: by mail-yw0-x242.google.com with SMTP id z21so2779536ywz.2
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 22:00:25 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed, 28 Jun 2017 01:00:02 -0400
Message-Id: <20170628050003.1809-2-bobby.prani@gmail.com>
In-Reply-To: <20170628050003.1809-1-bobby.prani@gmail.com>
References: <20170628050003.1809-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] [TEST] aarch64: Use pmuserenr_el0 register
 for instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

We need a way for the benchmark running in the guest to indicate us to
start/stop our instrumentation. On x86, we could use the 'cpuid'
instruction along with an appropriately populated 'eax'
register. However, no such dummy instruction exists for aarch64. So
we modify the permission bits for 'pmuserenr_el0' register and tap
that to instrument the guest code.

You can use the following annotations on your region-of-interest to
instrument the code.

#define magic_enable() \
  asm volatile ("msr pmuserenr_el0, %0" :: "r" (0xaaaaaaaa));
#define magic_disable() \
  asm volatile ("msr pmuserenr_el0, %0" :: "r" (0xfa11dead));

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 target/arm/helper.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 2594faa9b8..dfbf03676c 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1124,9 +1124,24 @@ static uint64_t pmxevtyper_read(CPUARMState *env, const ARMCPRegInfo *ri)
     }
 }
 
+bool enable_instrumentation;
+
 static void pmuserenr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
+
+    if (value == 0xaaaaaaaa) {
+        printf("Enabling instrumentation\n");
+        enable_instrumentation = true;
+        tb_flush(cs);
+    } else if (value == 0xfa11dead) {
+        printf("Disabling instrumentation\n");
+        enable_instrumentation = false;
+        tb_flush(cs);
+    }
+
     if (arm_feature(env, ARM_FEATURE_V8)) {
         env->cp15.c9_pmuserenr = value & 0xf;
     } else {
@@ -1316,13 +1331,13 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
       .accessfn = pmreg_access_xevcntr },
     { .name = "PMUSERENR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 0,
-      .access = PL0_R | PL1_RW, .accessfn = access_tpm,
+      .access = PL0_RW | PL1_RW, .accessfn = access_tpm,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmuserenr),
       .resetvalue = 0,
       .writefn = pmuserenr_write, .raw_writefn = raw_write },
     { .name = "PMUSERENR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 14, .opc2 = 0,
-      .access = PL0_R | PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
+      .access = PL0_RW | PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmuserenr),
       .resetvalue = 0,
       .writefn = pmuserenr_write, .raw_writefn = raw_write },
-- 
2.13.0
