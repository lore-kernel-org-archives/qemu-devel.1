Received: from eggs.gnu.org ([2001:4830:134:3::10]:43492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPU-0006T8-QJ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f9XPU-0007vT-2b
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f9XPT-0007mN-SC
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:53:12 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:52:39 +0100
Message-Id: <20180420145249.32435-4-peter.maydell@linaro.org>
In-Reply-To: <20180420145249.32435-1-peter.maydell@linaro.org>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 03/13] hw/mips/boston.c: Don't create "null"
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
 hw/mips/boston.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index fb23161b33..14f0f6673b 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -505,10 +505,6 @@ static void boston_mach_init(MachineState *machine)
                           "boston-platregs", 0x1000);
     memory_region_add_subregion_overlap(sys_mem, 0x17ffd000, platreg, 0);
 
-    if (!serial_hds[0]) {
-        serial_hds[0] = qemu_chr_new("serial0", "null");
-    }
-
     s->uart = serial_mm_init(sys_mem, 0x17ffe000, 2,
                              get_cps_irq(s->cps, 3), 10000000,
                              serial_hds[0], DEVICE_NATIVE_ENDIAN);
-- 
2.17.0
