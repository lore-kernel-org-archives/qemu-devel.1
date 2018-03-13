Received: from eggs.gnu.org ([2001:4830:134:3::10]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxb-0005qm-Qe
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1evlxb-00067Z-61
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 11:35:31 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Mar 2018 15:34:51 +0000
Message-Id: <20180313153458.26822-3-peter.maydell@linaro.org>
In-Reply-To: <20180313153458.26822-1-peter.maydell@linaro.org>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/9] hw/arm/boot: assert that secure_boot and
 secure_board_setup are false for AArch64
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

Add some assertions that if we're about to boot an AArch64 kernel,
the board code has not mistakenly set either secure_boot or
secure_board_setup. It doesn't make sense to set secure_boot,
because all AArch64 kernels must be booted in non-secure mode.

It might in theory make sense to set secure_board_setup, but
we don't currently support that, because only the AArch32
bootloader[] code calls this hook; bootloader_aarch64[] does not.
Since we don't have a current need for this functionality, just
assert that we don't try to use it. If it's needed we'll add
it later.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 196c7fb242..e21a92f972 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -720,6 +720,13 @@ static void do_cpu_reset(void *opaque)
                     } else {
                         env->pstate = PSTATE_MODE_EL1h;
                     }
+                    /* AArch64 kernels never boot in secure mode */
+                    assert(!info->secure_boot);
+                    /* This hook is only supported for AArch32 currently:
+                     * bootloader_aarch64[] will not call the hook, and
+                     * the code above has already dropped us into EL2 or EL1.
+                     */
+                    assert(!info->secure_board_setup);
                 }
 
                 /* Set to non-secure if not a secure boot */
-- 
2.16.2
