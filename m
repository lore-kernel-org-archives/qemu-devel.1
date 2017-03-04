Received: from eggs.gnu.org ([2001:4830:134:3::10]:35386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckIO2-0003HV-2G
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 17:42:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1ckINz-0000v5-JN
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 17:42:49 -0500
Message-Id: <a11c4b6386b7bb3a78a4f02b120d8860c4132be1.1488665935.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488665935.git.balaton@eik.bme.hu>
References: <cover.1488665935.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [Qemu-devel] [PATCH v4 02/13] sm501: Use defined constants instead
 of literal values where available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Sat, 04 Mar 2017 22:42:51 -0000
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

v3: Fix initial value of misc_control register as Peter Maydell suggested
    Also use M_BYTE constant from cutils.h

 hw/display/sm501.c          | 29 +++++++++++++++++++----------
 hw/display/sm501_template.h |  2 +-
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 4f40dee..6b72964 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -446,12 +447,12 @@
 
 /* SM501 local memory size taken from "linux/drivers/mfd/sm501.c" */
 static const uint32_t sm501_mem_local_size[] = {
-    [0] = 4 * 1024 * 1024,
-    [1] = 8 * 1024 * 1024,
-    [2] = 16 * 1024 * 1024,
-    [3] = 32 * 1024 * 1024,
-    [4] = 64 * 1024 * 1024,
-    [5] = 2 * 1024 * 1024,
+    [0] = 4 * M_BYTE,
+    [1] = 8 * M_BYTE,
+    [2] = 16 * M_BYTE,
+    [3] = 32 * M_BYTE,
+    [4] = 64 * M_BYTE,
+    [5] = 2 * M_BYTE,
 };
 #define get_local_mem_size(s) sm501_mem_local_size[(s)->local_mem_size_index]
 
@@ -555,7 +556,7 @@ static uint32_t get_local_mem_size_index(uint32_t size)
 static inline int is_hwc_enabled(SM501State *state, int crt)
 {
     uint32_t addr = crt ? state->dc_crt_hwc_addr : state->dc_panel_hwc_addr;
-    return addr & 0x80000000;
+    return addr & SM501_HWC_EN;
 }
 
 /**
@@ -1411,9 +1412,17 @@ void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
     s->local_mem_size_index = get_local_mem_size_index(local_mem_bytes);
     SM501_DPRINTF("local mem size=%x. index=%d\n", get_local_mem_size(s),
                   s->local_mem_size_index);
-    s->system_control = 0x00100000;
-    s->misc_control = 0x00001000; /* assumes SH, active=low */
-    s->dc_panel_control = 0x00010000;
+    s->system_control = 0x00100000; /* 2D engine FIFO empty */
+    /* Bits 17 (SH), 7 (CDR), 6:5 (Test), 2:0 (Bus) are all supposed
+     * to be determined at reset by GPIO lines which set config bits.
+     * We hardwire them:
+     *  SH = 0 : Hitachi Ready Polarity == Active Low
+     *  CDR = 0 : do not reset clock divider
+     *  TEST = 0 : Normal mode (not testing the silicon)
+     *  BUS = 0 : Hitachi SH3/SH4
+     */
+    s->misc_control = SM501_MISC_DAC_POWER;
+    s->dc_panel_control = 0x00010000; /* FIFO level 3 */
     s->dc_crt_control = 0x00010000;
 
     /* allocate local memory */
diff --git a/hw/display/sm501_template.h b/hw/display/sm501_template.h
index aeeac5d..16e500b 100644
--- a/hw/display/sm501_template.h
+++ b/hw/display/sm501_template.h
@@ -108,7 +108,7 @@ static void glue(draw_hwc_line_, PIXEL_NAME)(SM501State *s, int crt,
     /* get hardware cursor pattern */
     uint32_t cursor_addr = get_hwc_address(s, crt);
     assert(0 <= c_y && c_y < SM501_HWC_HEIGHT);
-    cursor_addr += 64 * c_y / 4;  /* 4 pixels per byte */
+    cursor_addr += SM501_HWC_WIDTH * c_y / 4;  /* 4 pixels per byte */
     cursor_addr += s->base;
 
     /* get cursor position */
-- 
2.7.4
