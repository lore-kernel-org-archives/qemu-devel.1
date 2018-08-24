Received: from eggs.gnu.org ([2001:4830:134:3::10]:35480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tp-0007FR-EI
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8To-0003kx-Ll
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:09 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8To-0003ee-DO
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tn-0006TN-6W
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:09 +0100
Message-Id: <20180824093343.11346-19-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 18/52] hw/arm/boot: AArch32 kernels should be
 started in Hyp mode if available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The kernel booting specification for an AArch32 kernel requires that
it is booted in Hyp mode if available; otherwise the kernel can't
enable KVM. We were incorrectly leaving the kernel in SVC mode.
If we're booting an AArch32 kernel in the Nonsecure state and Hyp
mode is available, start in it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180820153020.21478-7-peter.maydell@linaro.org
---
 hw/arm/boot.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ca9467e583f..20c71d7d961 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -736,6 +736,17 @@ static void do_cpu_reset(void *opaque)
                 }
             }
 
+            if (!env->aarch64 && !info->secure_boot &&
+                arm_feature(env, ARM_FEATURE_EL2)) {
+                /*
+                 * This is an AArch32 boot not to Secure state, and
+                 * we have Hyp mode available, so boot the kernel into
+                 * Hyp mode. This is not how the CPU comes out of reset,
+                 * so we need to manually put it there.
+                 */
+                cpsr_write(env, ARM_CPU_MODE_HYP, CPSR_M, CPSRWriteRaw);
+            }
+
             if (cs == first_cpu) {
                 AddressSpace *as = arm_boot_address_space(cpu, info);
 
-- 
2.18.0
