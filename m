Received: from eggs.gnu.org ([2001:4830:134:3::10]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPncS-0003Wz-5S
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:25:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fPncR-0003Ht-B2
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:25:48 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fPncR-0003Gn-4P
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 07:25:47 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Jun 2018 12:03:58 +0100
Message-Id: <20180604110358.2821-3-peter.maydell@linaro.org>
In-Reply-To: <20180604110358.2821-1-peter.maydell@linaro.org>
References: <20180604110358.2821-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 2/2] hw/mips/mips_malta: don't make bios region
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
the "bios.1fc" memory region, and we don't manually register
it with vmstate_register_ram(). This currently means that its
contents are migrated but as a ram block whose name is the empty
string; in future it may mean they are not migrated at all. Use
memory_region_init_ram() instead.

Note that this is a a cross-version migration compatibility break
for the "malta" machine.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/mips/mips_malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index af70ecffc0..927944899b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1153,7 +1153,7 @@ void mips_malta_init(MachineState *machine)
      * handled by an overlapping region as the resulting ROM code subpage
      * regions are not executable.
      */
-    memory_region_init_ram_nomigrate(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
+    memory_region_init_ram(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
                            &error_fatal);
     if (!rom_copy(memory_region_get_ram_ptr(bios_copy),
                   FLASH_ADDRESS, BIOS_SIZE)) {
-- 
2.17.1
