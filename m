Received: from eggs.gnu.org ([2001:4830:134:3::10]:47176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxX-0005lW-Uz
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxS-0005zT-E7
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:27 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 15:34:52 +0000
Message-Id: <20180313153458.26822-4-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-1-peter.maydell@linaro.org>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/9] hw/arm/boot: If booting a kernel in EL2,
 set SCR_EL3.HCE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Pekka Enberg <penberg@iki.fi>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>

If we're directly booting a Linux kernel and the CPU supports both
EL3 and EL2, we start the kernel in EL2, as it expects. We must also
set the SCR_EL3.HCE bit in this situation, so that the HVC
instruction is enabled rather than UNDEFing. Otherwise at least some
kernels will panic when trying to initialize KVM in the guest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index e21a92f972..9319b12fcd 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -729,6 +729,11 @@ static void do_cpu_reset(void *opaque)
                     assert(!info->secure_board_setup);
                 }
 
+                if (arm_feature(env, ARM_FEATURE_EL2)) {
+                    /* If we have EL2 then Linux expects the HVC insn to work */
+                    env->cp15.scr_el3 |= SCR_HCE;
+                }
+
                 /* Set to non-secure if not a secure boot */
                 if (!info->secure_boot &&
                     (cs != first_cpu || !info->secure_board_setup)) {
-- 
2.16.2
