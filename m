Received: from eggs.gnu.org ([2001:4830:134:3::10]:50614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6T-0000lP-TR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi6T-0005Tr-2x
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:29:13 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:38 -0300
Message-Id: <20170724182751.18261-23-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 22/35] arm/vexpress: fix potential
 memory leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-arm@nongnu.org

Reorder to only allocate if required.

hw/arm/vexpress.c:667:13: warning: Potential leak of memory pointed to by 'flashalias'

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/vexpress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 528c65ddb6..76c4d84482 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -553,8 +553,6 @@ static void vexpress_common_init(MachineState *machine)
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *vram = g_new(MemoryRegion, 1);
     MemoryRegion *sram = g_new(MemoryRegion, 1);
-    MemoryRegion *flashalias = g_new(MemoryRegion, 1);
-    MemoryRegion *flash0mem;
     const hwaddr *map = daughterboard->motherboard_map;
     int i;
 
@@ -657,6 +655,9 @@ static void vexpress_common_init(MachineState *machine)
     }
 
     if (map[VE_NORFLASHALIAS] != -1) {
+        MemoryRegion *flashalias = g_new(MemoryRegion, 1);
+        MemoryRegion *flash0mem;
+
         /* Map flash 0 as an alias into low memory */
         flash0mem = sysbus_mmio_get_region(SYS_BUS_DEVICE(pflash0), 0);
         memory_region_init_alias(flashalias, NULL, "vexpress.flashalias",
-- 
2.13.3
