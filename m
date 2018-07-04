Received: from eggs.gnu.org ([2001:4830:134:3::10]:57272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOo-0008D2-48
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003uo-Ag
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:34 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:46749)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1faeOj-0003uU-4G
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:48:29 -0400
Message-Id: <9f1748f9606783e4bd84d9567a7d50b82c57553a.1530697258.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530697258.git.balaton@eik.bme.hu>
References: <cover.1530697258.git.balaton@eik.bme.hu>
From: Sebastian Bauer <mail@sebastianbauer.info>
Date: Wed, 04 Jul 2018 11:40:58 +0200
Subject: [Qemu-devel] [PATCH v3 2/7] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>, Philippe Mathieu-Daude <f4bug@amsat.org>

From: Sebastian Bauer <mail@sebastianbauer.info>

Changing the palette of a color index has as an immediate effect on
all pixels with the corresponding index on real hardware. Performing a
full update after a palette change is a simple way to emulate this
effect.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v2: change type to bool

 hw/display/sm501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 05c964b..b095134 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -487,6 +487,7 @@ typedef struct SM501State {
     MemoryRegion twoD_engine_region;
     uint32_t last_width;
     uint32_t last_height;
+    bool do_full_update; /* perform a full update next time */
     I2CBus *i2c_bus;
 
     /* mmio registers */
@@ -1042,6 +1043,7 @@ static void sm501_palette_write(void *opaque, hwaddr addr,
 
     assert(range_covers_byte(0, 0x400 * 3, addr));
     *(uint32_t *)&s->dc_palette[addr] = value;
+    s->do_full_update = true;
 }
 
 static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
@@ -1630,6 +1632,12 @@ static void sm501_update_display(void *opaque)
         full_update = 1;
     }
 
+    /* someone else requested a full update */
+    if (s->do_full_update) {
+        s->do_full_update = false;
+        full_update = 1;
+    }
+
     /* draw each line according to conditions */
     snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
               offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
-- 
2.7.6
