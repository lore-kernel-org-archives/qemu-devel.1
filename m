Received: from eggs.gnu.org ([2001:4830:134:3::10]:44843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXw0c-00041Z-Fd
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fXw0X-0002hJ-HI
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fXw0X-0002en-93
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 18:00:17 -0400
Message-Id: <70edd7a1c32a88531ee5c1cc8dfcbbad6223145c.1530047900.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1530047900.git.balaton@eik.bme.hu>
References: <cover.1530047900.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 26 Jun 2018 23:18:20 +0200
Subject: [Qemu-devel] [PATCH v2 2/7] sm501: Perform a full update after
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

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
index 273495e..2fbb10e 100644
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
