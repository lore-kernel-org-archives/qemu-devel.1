Received: from eggs.gnu.org ([209.51.188.92]:55529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQm-0002H7-35
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQl-0008G0-8D
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:52 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:51623)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpAQl-0008Fd-2G
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:51 -0500
Received: by mail-wm1-x342.google.com with SMTP id b11so2098280wmj.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:22:50 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 11:22:40 +0000
Message-Id: <20190131112240.8395-6-peter.maydell@linaro.org>
In-Reply-To: <20190131112240.8395-1-peter.maydell@linaro.org>
References: <20190131112240.8395-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/5] hw/arm/boot: Support DTB autoload for
 firmware-only boots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>

The arm_boot_info struct has a skip_dtb_autoload flag: if this is
set to true by the board code then arm_load_kernel() will not
load the DTB itself, but will leave this for the board code to
do itself later. However, the check for this is done in a
code path which is only executed for the case where we load
a kernel image file. If we're taking the "boot via firmware"
code path then the flag isn't honoured and the DTB is never
loaded.

We didn't notice this because the only real user of "boot
via firmware" that cares about the DTB is the virt board
(for UEFI boot), and that always wants skip_dtb_autoload
anyway. But the SBSA reference board model we're planning to
add will want the flag to behave correctly.

Now we've refactored the arm_load_kernel() function, the
fix is simple: drop the early 'return' so we fall into
the same "load the DTB" code the boot-direct-kernel path uses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index cfcfdf421cf..8e792a911f9 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1219,7 +1219,6 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
         arm_setup_firmware_boot(cpu, info);
-        return;
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
     }
-- 
2.20.1
