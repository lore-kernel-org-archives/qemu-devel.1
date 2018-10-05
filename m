Received: from eggs.gnu.org ([2001:4830:134:3::10]:58663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerome.forissier@linaro.org>) id 1g8L9Z-0003c4-Rq
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerome.forissier@linaro.org>) id 1g8L9W-0005v1-NZ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:08:05 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jerome.forissier@linaro.org>)
	id 1g8L9W-0005uN-2S
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:08:02 -0400
Received: by mail-wm1-x342.google.com with SMTP id 206-v6so959794wmb.5
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 01:08:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
Date: Fri,  5 Oct 2018 10:07:29 +0200
Message-Id: <20181005080729.6480-1-jerome.forissier@linaro.org>
Subject: [Qemu-devel] [PATCH] hw/arm/virt: add DT property
 /secure-chosen/sdtout-path being secure UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Etienne Carriere <etienne.carriere@linaro.org>, tee-dev@lists.linaro.org, Jerome Forissier <jerome.forissier@linaro.org>

Bindings for /secure-chosen and /secure-chosen/stdout-path have been
proposed 1.5 years ago [1] and implemented in OP-TEE at the same time [2].

This patch creates the property when the machine is secure.

[1] https://patchwork.kernel.org/patch/9602401/
[2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 hw/arm/virt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0b57f87abc..a0faa40d64 100644
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
2.15.1
