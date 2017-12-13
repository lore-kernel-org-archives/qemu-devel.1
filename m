Received: from eggs.gnu.org ([2001:4830:134:3::10]:51429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWV-0004d3-Qw
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ePBWU-0007fj-TM
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:51 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ePBWU-0007Ts-Lt
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 13:12:50 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2017 17:52:29 +0000
Message-Id: <1513187549-2435-3-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1513187549-2435-1-git-send-email-peter.maydell@linaro.org>
References: <1513187549-2435-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] hw/mips/boston: Remove workaround for
 writes to ROM aborting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, Paul Burton <paul.burton@mips.com>

Now that the memory system correctly handles writes to ROM for
guest CPUs that may generate exceptions for decode errors, we
can remove the workaround from the boston board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Disclaimer: not tested beyond 'make check'...
---
 hw/mips/boston.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 1cb4b6a..fb23161 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -248,16 +248,6 @@ static const MemoryRegionOps boston_platreg_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void boston_flash_write(void *opaque, hwaddr addr,
-                               uint64_t val, unsigned size)
-{
-}
-
-static const MemoryRegionOps boston_flash_ops = {
-    .write = boston_flash_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
 static const TypeInfo boston_device = {
     .name          = TYPE_MIPS_BOSTON,
     .parent        = TYPE_SYS_BUS_DEVICE,
@@ -481,8 +471,8 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom_device_nomigrate(flash, NULL, &boston_flash_ops, s,
-                                  "boston.flash", 128 * M_BYTE, &err);
+    memory_region_init_rom_nomigrate(flash, NULL,
+                                     "boston.flash", 128 * M_BYTE, &err);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
 
     ddr = g_new(MemoryRegion, 1);
-- 
2.7.4
