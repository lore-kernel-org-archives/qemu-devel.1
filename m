Received: from eggs.gnu.org ([2001:4830:134:3::10]:34534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCkS-00060A-Ej
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVCkN-0000MZ-Mo
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:16:24 -0400
Message-Id: <fba100cbed7a603bc5fcd1cc48555a5671a7d873.1529398335.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1529398335.git.balaton@eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Tue, 19 Jun 2018 10:52:15 +0200
Subject: [Qemu-devel] [PATCH v4 08/11] sm501: Perform a full update after
 palette change
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Sebastian Bauer <mail@sebastianbauer.info>

From: Sebastian Bauer <mail@sebastianbauer.info>

Changing the palette of a color index has as an immediate
effect on all pixels with the corresponding index on real
hardware. Performing a full update after a palette change
is a simple way to emulate this effect.

Signed-off-by: Sebastian Bauer <mail@sebastianbauer.info>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v4: Updated commit message

 hw/display/sm501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index a076248..e5df6c7 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -479,6 +479,7 @@ typedef struct SM501State {
     MemoryRegion twoD_engine_region;
     uint32_t last_width;
     uint32_t last_height;
+    uint32_t do_full_update; /* perform a full update next time */
     I2CBus *i2c_bus;
 
     /* mmio registers */
@@ -1032,6 +1033,7 @@ static void sm501_palette_write(void *opaque, hwaddr addr,
 
     assert(range_covers_byte(0, 0x400 * 3, addr));
     *(uint32_t *)&s->dc_palette[addr] = value;
+    s->do_full_update = 1;
 }
 
 static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
@@ -1620,6 +1622,12 @@ static void sm501_update_display(void *opaque)
         full_update = 1;
     }
 
+    /* someone else requested a full update */
+    if (s->do_full_update) {
+        s->do_full_update = 0;
+        full_update = 1;
+    }
+
     /* draw each line according to conditions */
     snap = memory_region_snapshot_and_clear_dirty(&s->local_mem_region,
               offset, width * height * src_bpp, DIRTY_MEMORY_VGA);
-- 
2.7.6
