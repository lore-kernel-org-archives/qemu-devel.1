Received: from eggs.gnu.org ([2001:4830:134:3::10]:57089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZN7S-00069Q-N1
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <huayanghao@gmail.com>) id 1dZN7R-0008Bn-U0
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:50 -0400
Received: from mail-yb0-x232.google.com ([2607:f8b0:4002:c09::232]:36703)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <huayanghao@gmail.com>)
	id 1dZN7R-00089m-P8
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 16:04:49 -0400
Received: by mail-yb0-x232.google.com with SMTP id 74so19341681ybf.3
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 13:04:48 -0700 (PDT)
MIME-Version: 1.0
From: Hua Yanghao <huayanghao@gmail.com>
Date: Sun, 23 Jul 2017 22:04:47 +0200
Message-ID: <CAPTzt1Ai9x4OiHMH4HrDzj=vNbqhNnkmdDQ7wBLxYTJ-kcNM_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [PATCH] hw/core/loader: do not check for regions
 overlap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>From 84f25a8e4269f44255a8037837fdaa6e5404b76e Mon Sep 17 00:00:00 2001
From: Hua Yanghao <yanghao.hua@intel.com>
Date: Sun, 23 Jul 2017 21:48:21 +0200
Subject: [PATCH] hw/core/loader: do not check for regions overlap

There is a use case where regions are overlapped on purpose.
It should be up to the linker to check for regions overlap and qemu should
better not to do so.

For example:
SECTIONS
{
    ...... /* the normal text/data */
    _on_chip_ram_load_start = .;
    . = . + SIZEOF(.on_chip_ram_section);
    _on_chip_ram_load_end = .;

    .bss (NOLOAD) {
        *(.bss*)
        *(COM*)
    }
    ...... /* other things */
}

with current hw/core/loader implementation, .bss section consumes no LMU address
space as .bss is not a loadable section, it is only useful for VMA at runtime.
Where the .on_chip_ram_section is told to be loaded (LMA) from the VMA of .bss
section. And qemu complains and exits. This patch fixes the issue and tested
running fine for the above scenario.
---
 hw/core/loader.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index c17ace0a2e..9542cb3555 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1099,26 +1099,17 @@ int rom_check_and_register_reset(void)
     hwaddr addr = 0;
     MemoryRegionSection section;
     Rom *rom;
-    AddressSpace *as = NULL;

     QTAILQ_FOREACH(rom, &roms, next) {
         if (rom->fw_file) {
             continue;
         }
-        if ((addr > rom->addr) && (as == rom->as)) {
-            fprintf(stderr, "rom: requested regions overlap "
-                    "(rom %s. free=0x" TARGET_FMT_plx
-                    ", addr=0x" TARGET_FMT_plx ")\n",
-                    rom->name, addr, rom->addr);
-            return -1;
-        }
         addr  = rom->addr;
         addr += rom->romsize;
         section = memory_region_find(rom->mr ? rom->mr : get_system_memory(),
                                      rom->addr, 1);
         rom->isrom = int128_nz(section.size) &&
memory_region_is_rom(section.mr);
         memory_region_unref(section.mr);
-        as = rom->as;
     }
     qemu_register_reset(rom_reset, NULL);
     roms_loaded = 1;
-- 
2.11.0
