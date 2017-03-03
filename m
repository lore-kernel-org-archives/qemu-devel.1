Received: from eggs.gnu.org ([2001:4830:134:3::10]:55817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMN-0006Ka-U3
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1cjcMM-0001If-QL
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 20:50:19 -0500
Message-Id: <b71d924c9affac516da84f9eff5668e3a65f1c3c.1488504063.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1488504063.git.balaton@eik.bme.hu>
References: <cover.1488504063.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [Qemu-devel] [PATCH v3 03/13] sm501: Add missing arbitration
 control register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Fri, 03 Mar 2017 01:50:21 -0000
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 6b72964..6e74200 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -474,6 +474,7 @@ typedef struct SM501State {
     uint32_t gpio_31_0_control;
     uint32_t gpio_63_32_control;
     uint32_t dram_control;
+    uint32_t arbitration_control;
     uint32_t irq_mask;
     uint32_t misc_timing;
     uint32_t power_mode_control;
@@ -757,6 +758,9 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
     case SM501_DRAM_CONTROL:
         ret = (s->dram_control & 0x07F107C0) | s->local_mem_size_index << 13;
         break;
+    case SM501_ARBTRTN_CONTROL:
+        ret = s->arbitration_control;
+        break;
     case SM501_IRQ_MASK:
         ret = s->irq_mask;
         break;
@@ -809,6 +813,9 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         /* TODO : check validity of size change */
         s->dram_control |=  value & 0x7FFFFFC3;
         break;
+    case SM501_ARBTRTN_CONTROL:
+        s->arbitration_control =  value & 0x37777777;
+        break;
     case SM501_IRQ_MASK:
         s->irq_mask = value;
         break;
@@ -1422,6 +1429,7 @@ void sm501_init(MemoryRegion *address_space_mem, uint32_t base,
      *  BUS = 0 : Hitachi SH3/SH4
      */
     s->misc_control = SM501_MISC_DAC_POWER;
+    s->arbitration_control = 0x05146732;
     s->dc_panel_control = 0x00010000; /* FIFO level 3 */
     s->dc_crt_control = 0x00010000;
 
-- 
2.7.4
