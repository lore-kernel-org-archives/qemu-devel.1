Received: from eggs.gnu.org ([2001:4830:134:3::10]:43468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPT-0006Rn-SJ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPT-0007un-4e
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPS-0007mN-Ue
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:40 +0100
Message-Id: <20180420145249.32435-5-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 04/13] hw/mips/mips_malta: Don't create "null"
 chardevs for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Following commit 12051d82f004024, UART devices should handle
being passed a NULL pointer chardev, so we don't need to
create "null" backends in board code. Remove the code that
does this and updates serial_hds[].

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/mips_malta.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index f6513a4fd5..49fe7a0a72 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1056,11 +1056,6 @@ void mips_malta_init(MachineState *machine)
 
     /* FPGA */
 
-    /* Make sure the second serial port is associated with a device. */
-    if (!serial_hds[2]) {
-        serial_hds[2] = qemu_chr_new("fpga-uart", "null");
-    }
-
     /* The CBUS UART is attached to the MIPS CPU INT2 pin, ie interrupt 4 */
     malta_fpga_init(system_memory, FPGA_ADDRESS, cbus_irq, serial_hds[2]);
 
-- 
2.17.0
