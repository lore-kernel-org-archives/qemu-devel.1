Received: from eggs.gnu.org ([2001:4830:134:3::10]:38004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPncR-0003WB-6y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPncQ-0003HN-Df
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:25:47 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fPncQ-0003Gn-5n
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:25:46 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Jun 2018 12:03:57 +0100
Message-Id: <20180604110358.2821-2-peter.maydell@linaro.org>
In-Reply-To: <20180604110358.2821-1-peter.maydell@linaro.org>
References: <20180604110358.2821-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] hw/mips/boston: don't make flash region
 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Paul Burton <paul.burton@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Juan Quintela <quintela@redhat.com>, dgilbert@redhat.com

Currently we use memory_region_init_rom_nomigrate() to create
the "boston.flash" memory region, and we don't manually register
it with vmstate_register_ram(). This currently means that its
contents are migrated but as a ram block whose name is the empty
string; in future it may mean they are not migrated at all. Use
memory_region_init_ram() instead.

Note that this is a a cross-version migration compatibility break
for the "boston" machine.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/boston.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 5302e5c885..1d136529ad 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -471,8 +471,7 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
 
     flash =  g_new(MemoryRegion, 1);
-    memory_region_init_rom_nomigrate(flash, NULL,
-                                     "boston.flash", 128 * M_BYTE, &err);
+    memory_region_init_rom(flash, NULL, "boston.flash", 128 * M_BYTE, &err);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
 
     ddr = g_new(MemoryRegion, 1);
-- 
2.17.1
