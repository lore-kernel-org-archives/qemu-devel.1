Received: from eggs.gnu.org ([208.118.235.92]:35930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgV-0004PS-Ai
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1geWgT-0005SU-1k
	for qemu-devel@nongnu.org; Tue, 01 Jan 2019 21:55:07 -0500
Message-Id: <3bba70dcccdf7a13aa961ed576fbf8ba88138dcf.1546394798.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1546394798.git.balaton@eik.bme.hu>
References: <cover.1546394798.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Wed, 02 Jan 2019 03:06:38 +0100
Subject: [Qemu-devel] [PATCH 7/8] sam460ex: Fix support for memory larger
 than 1GB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

Fix the encoding of larger memory modules in the SoC registers which
allows specifying more than 1GB memory for sam460ex. Well, only 2GB
due to SoC and firmware restrictions which was the only missing value
compared to what the real hardware supports. The SoC should support up
to 4GB but when setting that the firmware hangs during memory test.
This may be an overflow bug in the firmware which I did not try to
debug but this may affect real hardware as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/ppc/ppc440_uc.c | 22 ++++++++++++----------
 hw/ppc/sam460ex.c  |  6 ++++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 60dbb35eee..414dc19c1d 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -2,7 +2,7 @@
  * QEMU PowerPC 440 embedded processors emulation
  *
  * Copyright (c) 2012 François Revol
- * Copyright (c) 2016-2018 BALATON Zoltan
+ * Copyright (c) 2016-2019 BALATON Zoltan
  *
  * This work is licensed under the GNU GPL license version 2 or later.
  *
@@ -505,10 +505,6 @@ enum {
     SDRAM_PLBADDUHB = 0x50,
 };
 
-/* XXX: TOFIX: some patches have made this code become inconsistent:
- *      there are type inconsistencies, mixing hwaddr, target_ulong
- *      and uint32_t
- */
 static uint32_t sdram_bcr(hwaddr ram_base, hwaddr ram_size)
 {
     uint32_t bcr;
@@ -538,11 +534,17 @@ static uint32_t sdram_bcr(hwaddr ram_base, hwaddr ram_size)
     case (1 * GiB):
         bcr = 0xe000;
         break;
+    case (2 * GiB):
+        bcr = 0xc000;
+        break;
+    case (4 * GiB):
+        bcr = 0x8000;
+        break;
     default:
         error_report("invalid RAM size " TARGET_FMT_plx, ram_size);
         return 0;
     }
-    bcr |= ram_base & 0xFF800000;
+    bcr |= ram_base >> 2 & 0xFFE00000;
     bcr |= 1;
 
     return bcr;
@@ -550,12 +552,12 @@ static uint32_t sdram_bcr(hwaddr ram_base, hwaddr ram_size)
 
 static inline hwaddr sdram_base(uint32_t bcr)
 {
-    return bcr & 0xFF800000;
+    return (bcr & 0xFFE00000) << 2;
 }
 
-static target_ulong sdram_size(uint32_t bcr)
+static uint64_t sdram_size(uint32_t bcr)
 {
-    target_ulong size;
+    uint64_t size;
     int sh;
 
     sh = 1024 - ((bcr >> 6) & 0x3ff);
@@ -575,7 +577,7 @@ static void sdram_set_bcr(ppc440_sdram_t *sdram, int i,
                                     &sdram->ram_memories[i]);
         object_unparent(OBJECT(&sdram->containers[i]));
     }
-    sdram->bcr[i] = bcr & 0xFFDEE001;
+    sdram->bcr[i] = bcr & 0xFFE0FFC1;
     if (enabled && (bcr & 1)) {
         memory_region_init(&sdram->containers[i], NULL, "sdram-containers",
                            sdram_size(bcr));
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7cbd2f54c6..7cc7d205d1 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -76,9 +76,11 @@
 #define UART_FREQ 11059200
 #define SDRAM_NR_BANKS 4
 
-/* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
+/* The SoC could also handle 4 GiB but firmware does not work with that. */
+/* Maybe it overflows a signed 32 bit number somewhere? */
 static const ram_addr_t ppc460ex_sdram_bank_sizes[] = {
-    1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 0
+    2 * GiB, 1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB, 64 * MiB,
+    32 * MiB, 0
 };
 
 struct boot_info {
-- 
2.13.7
