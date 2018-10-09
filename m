Received: from eggs.gnu.org ([2001:4830:134:3::10]:51085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9kzN-000680-QG
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1g9kzK-0002x1-Ga
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:55:25 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34827)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1g9kzK-0002wg-8p
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 01:55:22 -0400
Received: by mail-pg1-x541.google.com with SMTP id v133-v6so261193pgb.2
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 22:55:21 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon,  8 Oct 2018 22:55:14 -0700
Message-Id: <1539064514-2606-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH] i386: pc_sysfw: load bios using rom API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

As the bios is a ROM, just using rom API.
AFAICS no functionality changed.

Signed-off-by: Li Qiang <liq3ea@gmail.com>
---
 hw/i386/pc_sysfw.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 091e22dd60..7f469fd582 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -209,9 +209,9 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
         goto bios_error;
     }
     bios = g_malloc(sizeof(*bios));
-    memory_region_init_ram(bios, NULL, "pc.bios", bios_size, &error_fatal);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(bios, true);
+    memory_region_init_rom(bios, NULL, "pc.bios", bios_size, &error_fatal);
+    if (isapc_ram_fw) {
+        memory_region_set_readonly(bios, false);
     }
     ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
     if (ret != 0) {
@@ -230,8 +230,8 @@ static void old_pc_system_rom_init(MemoryRegion *rom_memory, bool isapc_ram_fw)
                                         0x100000 - isa_bios_size,
                                         isa_bios,
                                         1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
+    if (isapc_ram_fw) {
+        memory_region_set_readonly(isa_bios, false);
     }
 
     /* map all the bios at the top of memory */
-- 
2.11.0
