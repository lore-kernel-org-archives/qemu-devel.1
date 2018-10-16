Received: from eggs.gnu.org ([2001:4830:134:3::10]:43029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRCE-0000lq-AN
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC8-0007wS-AM
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:46 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC8-0007sS-2f
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:40 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRBy-0003mG-DT
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:30 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:07 +0100
Message-Id: <20181016152325.31367-2-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/19] hw/arm/virt: add DT property
 /secure-chosen/stdout-path indicating secure UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Jerome Forissier <jerome.forissier@linaro.org>

Bindings for /secure-chosen and /secure-chosen/stdout-path have been
proposed 1.5 years ago [1] and implemented in OP-TEE at the same time [2].
They've now been officially agreed on, so we can implement them
in QEMU.

This patch creates the property when the machine is secure.

[1] https://patchwork.kernel.org/patch/9602401/
[2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Message-id: 20181005080729.6480-1-jerome.forissier@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: commit message tweak]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 96dd4ef10c5..9f677825f9f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -712,6 +712,10 @@ static void create_uart(const VirtMachineState *vms, qemu_irq *pic, int uart,
         /* Mark as not usable by the normal world */
         qemu_fdt_setprop_string(vms->fdt, nodename, "status", "disabled");
         qemu_fdt_setprop_string(vms->fdt, nodename, "secure-status", "okay");
+
+        qemu_fdt_add_subnode(vms->fdt, "/secure-chosen");
+        qemu_fdt_setprop_string(vms->fdt, "/secure-chosen", "stdout-path",
+                                nodename);
     }
 
     g_free(nodename);
-- 
2.19.0
