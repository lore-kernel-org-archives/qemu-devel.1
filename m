Received: from eggs.gnu.org ([209.51.188.92]:35918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AS-0001uV-M9
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AR-0000Yx-I2
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:52 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35761)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AR-0000V1-7T
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: by mail-wr1-x443.google.com with SMTP id z18so3712104wrh.2
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.42
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:09 +0000
Message-Id: <20190205170510.21984-22-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 21/22] hw/arm/boot: Support DTB autoload for
 firmware-only boots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190131112240.8395-6-peter.maydell@linaro.org
---
 hw/arm/boot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 328cc6bd245..496c8c18b08 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1215,7 +1215,6 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
     /* Load the kernel.  */
     if (!info->kernel_filename || info->firmware_loaded) {
         arm_setup_firmware_boot(cpu, info);
-        return;
     } else {
         arm_setup_direct_kernel_boot(cpu, info);
     }
-- 
2.20.1
