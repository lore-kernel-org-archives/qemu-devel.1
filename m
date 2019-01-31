Received: from eggs.gnu.org ([209.51.188.92]:55385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQf-0002A5-Az
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQe-0008B0-LC
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:45 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpAQe-0008AX-FQ
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so2130472wmd.2
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:22:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 11:22:35 +0000
Message-Id: <20190131112240.8395-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] hw/arm/boot: Support DTB autoload for
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

The first four patches in this set are just refactoring,
splitting the code in arm_load_kernel() out into a
couple of sub-functions for "direct kernel boot" and
"firmware boot". The last patch that fixes the issue is
then just a one-liner. (Without the refactoring we'd
need to use a goto, which is what I wanted to avoid.)

thanks
-- PMM

Peter Maydell (5):
  hw/arm/boot: Fix block comment style in arm_load_kernel()
  hw/arm/boot: Factor out "direct kernel boot" code into its own
    function
  hw/arm/boot: Factor out "set up firmware boot" code
  hw/arm/boot: Clarify why arm_setup_firmware_boot() doesn't set
    env->boot_info
  hw/arm/boot: Support DTB autoload for firmware-only boots

 hw/arm/boot.c | 166 +++++++++++++++++++++++++++++---------------------
 1 file changed, 96 insertions(+), 70 deletions(-)

-- 
2.20.1
