Received: from eggs.gnu.org ([2001:4830:134:3::10]:44114)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq5-00052f-Ej
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcQq4-0002Ac-Ef
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 03:44:05 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  9 Jul 2018 17:43:38 +1000
Message-Id: <20180709074350.27086-5-david@gibson.dropbear.id.au>
In-Reply-To: <20180709074350.27086-1-david@gibson.dropbear.id.au>
References: <20180709074350.27086-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/16] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, balaton@eik.bme.hu, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Sebastian Bauer <mail@sebastianbauer.info>, David Gibson <david@gibson.dropbear.id.au>

From: Sebastian Bauer <mail@sebastianbauer.info>

Changing the palette of a color index has as an immediate effect on
all pixels with the corresponding index on real hardware. Performing a
full update after a palette change is a simple way to emulate this
effect.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 05c964bea1..b095134d6f 100644
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
2.17.1
