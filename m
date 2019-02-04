Received: from eggs.gnu.org ([209.51.188.92]:38328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8g-0000bw-G4
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8e-0007eD-NN
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:02 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:54 +1100
Message-Id: <20190204090124.26191-8-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/37] sam460ex: Fix support for memory larger
 than 1GB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Fix the encoding of larger memory modules in the SoC registers which
allows specifying more than 1GB memory for sam460ex. Well, only 2GB
due to SoC and firmware restrictions which was the only missing value
compared to what the real hardware supports. The SoC should support up
to 4GB but when setting that the firmware hangs during memory test.
This may be an overflow bug in the firmware which I did not try to
debug but this may affect real hardware as well.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc440_uc.c | 22 ++++++++++++----------
 hw/ppc/sam460ex.c  |  6 ++++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 60dbb35eee..c489368905 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -2,7 +2,7 @@
  * QEMU PowerPC 440 embedded processors emulation
  *
  * Copyright (c) 2012 Fran=C3=A7ois Revol
- * Copyright (c) 2016-2018 BALATON Zoltan
+ * Copyright (c) 2016-2019 BALATON Zoltan
  *
  * This work is licensed under the GNU GPL license version 2 or later.
  *
@@ -505,10 +505,6 @@ enum {
     SDRAM_PLBADDUHB =3D 0x50,
 };
=20
-/* XXX: TOFIX: some patches have made this code become inconsistent:
- *      there are type inconsistencies, mixing hwaddr, target_ulong
- *      and uint32_t
- */
 static uint32_t sdram_bcr(hwaddr ram_base, hwaddr ram_size)
 {
     uint32_t bcr;
@@ -538,11 +534,17 @@ static uint32_t sdram_bcr(hwaddr ram_base, hwaddr r=
am_size)
     case (1 * GiB):
         bcr =3D 0xe000;
         break;
+    case (2 * GiB):
+        bcr =3D 0xc000;
+        break;
+    case (4 * GiB):
+        bcr =3D 0x8000;
+        break;
     default:
         error_report("invalid RAM size " TARGET_FMT_plx, ram_size);
         return 0;
     }
-    bcr |=3D ram_base & 0xFF800000;
+    bcr |=3D ram_base >> 2 & 0xffe00000;
     bcr |=3D 1;
=20
     return bcr;
@@ -550,12 +552,12 @@ static uint32_t sdram_bcr(hwaddr ram_base, hwaddr r=
am_size)
=20
 static inline hwaddr sdram_base(uint32_t bcr)
 {
-    return bcr & 0xFF800000;
+    return (bcr & 0xffe00000) << 2;
 }
=20
-static target_ulong sdram_size(uint32_t bcr)
+static uint64_t sdram_size(uint32_t bcr)
 {
-    target_ulong size;
+    uint64_t size;
     int sh;
=20
     sh =3D 1024 - ((bcr >> 6) & 0x3ff);
@@ -575,7 +577,7 @@ static void sdram_set_bcr(ppc440_sdram_t *sdram, int =
i,
                                     &sdram->ram_memories[i]);
         object_unparent(OBJECT(&sdram->containers[i]));
     }
-    sdram->bcr[i] =3D bcr & 0xFFDEE001;
+    sdram->bcr[i] =3D bcr & 0xffe0ffc1;
     if (enabled && (bcr & 1)) {
         memory_region_init(&sdram->containers[i], NULL, "sdram-container=
s",
                            sdram_size(bcr));
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 7a8c745021..202ed14bcf 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -76,9 +76,11 @@
 #define UART_FREQ 11059200
 #define SDRAM_NR_BANKS 4
=20
-/* FIXME: See u-boot.git 8ac41e, also fix in ppc440_uc.c */
+/* The SoC could also handle 4 GiB but firmware does not work with that.=
 */
+/* Maybe it overflows a signed 32 bit number somewhere? */
 static const ram_addr_t ppc460ex_sdram_bank_sizes[] =3D {
-    1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB, 64 * MiB, 32 * MiB, 0
+    2 * GiB, 1 * GiB, 512 * MiB, 256 * MiB, 128 * MiB, 64 * MiB,
+    32 * MiB, 0
 };
=20
 struct boot_info {
--=20
2.20.1
