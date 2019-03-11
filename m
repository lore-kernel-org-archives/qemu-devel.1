Received: from eggs.gnu.org ([209.51.188.92]:35708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6O-00005g-N5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6M-0004bU-ST
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6M-0004aE-G6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:08:54 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:24 +0100
Message-Id: <20190311220843.4026-9-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/27] ppc405_boards: Don't size flash memory to
 match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

Machine "ref405ep" maps its flash memory at address 2^32 - image size.
Image size is rounded up to the next multiple of 64KiB.  Useless,
because pflash_cfi02_realize() fails with "failed to read the initial
flash content" unless the rounding is a no-op.

If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
other stuff.  No idea how that would play out, but useful outcomes
seem unlikely.

Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
regardless of image size, to match the physical hardware.

Machine "taihu" maps its boot flash memory similarly.  The code even
has a comment /* XXX: should check that size is 2MB */, followed by
disabled code to adjust the size to 2MiB regardless of image size.

Its code to map its application flash memory looks the same, except
there the XXX comment asks for 32MiB, and the code to adjust the size
isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
to read the initial flash content" for images smaller than 32MiB.

Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
to match the physical hardware.  Delete dead code from application
flash mapping, and simplify some.

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Message-Id: <20190308094610.21210-9-armbru@redhat.com>
---
 hw/ppc/ppc405_boards.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index bb73d6d848..fe8e3cad12 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -156,7 +156,7 @@ static void ref405ep_init(MachineState *machine)
     target_ulong kernel_base, initrd_base;
     long kernel_size, initrd_size;
     int linux_boot;
-    int fl_idx, fl_sectors, len;
+    int len;
     DriveInfo *dinfo;
     MemoryRegion *sysmem =3D get_system_memory();
=20
@@ -177,20 +177,16 @@ static void ref405ep_init(MachineState *machine)
                            &error_fatal);
     memory_region_add_subregion(sysmem, 0xFFF00000, sram);
     /* allocate and load BIOS */
-    fl_idx =3D 0;
 #ifdef USE_FLASH_BIOS
-    dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
+    dinfo =3D drive_get(IF_PFLASH, 0, 0);
     if (dinfo) {
-        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
-
-        bios_size =3D blk_getlength(blk);
-        fl_sectors =3D (bios_size + 65535) >> 16;
+        bios_size =3D 8 * MiB;
         pflash_cfi02_register((uint32_t)(-bios_size),
                               NULL, "ef405ep.bios", bios_size,
-                              blk, 65536, fl_sectors, 1,
+                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
+                              64 * KiB, bios_size / (64 * KiB), 1,
                               2, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
                               1);
-        fl_idx++;
     } else
 #endif
     {
@@ -425,7 +421,7 @@ static void taihu_405ep_init(MachineState *machine)
     target_ulong kernel_base, initrd_base;
     long kernel_size, initrd_size;
     int linux_boot;
-    int fl_idx, fl_sectors;
+    int fl_idx;
     DriveInfo *dinfo;
=20
     /* RAM is soldered to the board so the size cannot be changed */
@@ -450,15 +446,11 @@ static void taihu_405ep_init(MachineState *machine)
 #if defined(USE_FLASH_BIOS)
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
     if (dinfo) {
-        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
-
-        bios_size =3D blk_getlength(blk);
-        /* XXX: should check that size is 2MB */
-        //        bios_size =3D 2 * 1024 * 1024;
-        fl_sectors =3D (bios_size + 65535) >> 16;
-        pflash_cfi02_register((uint32_t)(-bios_size),
+        bios_size =3D 2 * MiB;
+        pflash_cfi02_register(0xFFE00000,
                               NULL, "taihu_405ep.bios", bios_size,
-                              blk, 65536, fl_sectors, 1,
+                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
+                              64 * KiB, bios_size / (64 * KiB), 1,
                               4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
                               1);
         fl_idx++;
@@ -491,14 +483,10 @@ static void taihu_405ep_init(MachineState *machine)
     /* Register Linux flash */
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
     if (dinfo) {
-        BlockBackend *blk =3D blk_by_legacy_dinfo(dinfo);
-
-        bios_size =3D blk_getlength(blk);
-        /* XXX: should check that size is 32MB */
         bios_size =3D 32 * MiB;
-        fl_sectors =3D (bios_size + 65535) >> 16;
         pflash_cfi02_register(0xfc000000, NULL, "taihu_405ep.flash", bio=
s_size,
-                              blk, 65536, fl_sectors, 1,
+                              dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
+                              64 * KiB, bios_size / (64 * KiB), 1,
                               4, 0x0001, 0x22DA, 0x0000, 0x0000, 0x555, =
0x2AA,
                               1);
         fl_idx++;
--=20
2.17.2
