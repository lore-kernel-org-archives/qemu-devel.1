Received: from eggs.gnu.org ([2001:4830:134:3::10]:35389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tj-00078v-OT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Th-0003Oj-PJ
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:03 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ft8Th-0003LC-HL
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:34:01 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ft8Tg-0006QR-KB
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 10:34:00 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 10:33:02 +0100
Message-Id: <20180824093343.11346-12-peter.maydell@linaro.org>
In-Reply-To: <20180824093343.11346-1-peter.maydell@linaro.org>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 11/52] hw/arm/vexpress: Don't set
 info->secure_boot if CPU doesn't have EL3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Don't request that the arm_load_kernel() code should boot in secure
state if the CPU doesn't have a secure state. Currently this
doesn't make a difference because the boot.c code only examines
the secure_boot flag in code guarded by an ARM_FEATURE_EL3 check,
but upcoming changes for supporting booting into Hyp mode will
change that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-id: 20180821132811.17675-9-peter.maydell@linaro.org
---
 hw/arm/vexpress.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index dc47ed84c20..3631f4de3a4 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -705,8 +705,8 @@ static void vexpress_common_init(MachineState *machine)
     daughterboard->bootinfo.smp_bootreg_addr = map[VE_SYSREGS] + 0x30;
     daughterboard->bootinfo.gic_cpu_if_addr = daughterboard->gic_cpu_if_addr;
     daughterboard->bootinfo.modify_dtb = vexpress_modify_dtb;
-    /* Indicate that when booting Linux we should be in secure state */
-    daughterboard->bootinfo.secure_boot = true;
+    /* When booting Linux we should be in secure state if the CPU has one. */
+    daughterboard->bootinfo.secure_boot = vms->secure;
     arm_load_kernel(ARM_CPU(first_cpu), &daughterboard->bootinfo);
 }
 
-- 
2.18.0
