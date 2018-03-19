Received: from eggs.gnu.org ([2001:4830:134:3::10]:49740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzc0-0002Ll-J0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbz-0007h7-Ov
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exzbz-0007gJ-Hl
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:23 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1exzby-00031q-IQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:34:22 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:34:09 +0000
Message-Id: <20180319183415.1976-8-peter.maydell@linaro.org>
In-Reply-To: <20180319183415.1976-1-peter.maydell@linaro.org>
References: <20180319183415.1976-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 07/13] hw/arm/boot: If booting a kernel in EL2,
 set SCR_EL3.HCE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

If we're directly booting a Linux kernel and the CPU supports both
EL3 and EL2, we start the kernel in EL2, as it expects. We must also
set the SCR_EL3.HCE bit in this situation, so that the HVC
instruction is enabled rather than UNDEFing. Otherwise at least some
kernels will panic when trying to initialize KVM in the guest.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20180313153458.26822-4-peter.maydell@linaro.org
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
