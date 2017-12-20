Received: from eggs.gnu.org ([2001:4830:134:3::10]:56513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyT-0004mH-CT
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRhyS-0007Iy-Cx
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:09 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:34988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRhyS-0007Ik-6f
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 12:16:08 -0500
Received: by mail-wr0-x243.google.com with SMTP id l19so10550382wrc.2
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 09:16:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 18:14:42 +0100
Message-Id: <1513790098-9815-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/46] hw/mips/boston: Remove workaround for
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
Cc: Peter Maydell <peter.maydell@linaro.org>

From: Peter Maydell <peter.maydell@linaro.org>

Now that the memory system correctly handles writes to ROM for
guest CPUs that may generate exceptions for decode errors, we
can remove the workaround from the boston board.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1513187549-2435-3-git-send-email-peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
