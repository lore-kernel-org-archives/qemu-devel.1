Received: from eggs.gnu.org ([2001:4830:134:3::10]:34551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9XP-00018E-OA
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eR9XN-0007mw-10
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 23:29:55 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Dec 2017 15:29:32 +1100
Message-Id: <20171219042942.29297-5-david@gibson.dropbear.id.au>
In-Reply-To: <20171219042942.29297-1-david@gibson.dropbear.id.au>
References: <20171219042942.29297-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 04/14] sm501: Add some more unimplemented
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, BALATON Zoltan <balaton@eik.bme.hu>, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

These are not really implemented (just return zero or default values)
but add these so guests accessing them can run.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/display/sm501.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index b9b611131e..4f7dc59b25 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -795,6 +795,8 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
     case SM501_ARBTRTN_CONTROL:
         ret = s->arbitration_control;
         break;
+    case SM501_COMMAND_LIST_STATUS:
+        ret = 0x00180002; /* FIFOs are empty, everything idle */
     case SM501_IRQ_MASK:
         ret = s->irq_mask;
         break;
@@ -812,6 +814,9 @@ static uint64_t sm501_system_config_read(void *opaque, hwaddr addr,
     case SM501_POWER_MODE_CONTROL:
         ret = s->power_mode_control;
         break;
+    case SM501_ENDIAN_CONTROL:
+        ret = 0; /* Only default little endian mode is supported */
+        break;
 
     default:
         printf("sm501 system config : not implemented register read."
@@ -865,6 +870,12 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
     case SM501_POWER_MODE_CONTROL:
         s->power_mode_control = value & 0x00000003;
         break;
+    case SM501_ENDIAN_CONTROL:
+        if (value & 0x00000001) {
+            printf("sm501 system config : big endian mode not implemented.\n");
+            abort();
+        }
+        break;
 
     default:
         printf("sm501 system config : not implemented register write."
@@ -924,6 +935,9 @@ static uint64_t sm501_disp_ctrl_read(void *opaque, hwaddr addr,
     case SM501_DC_PANEL_PANNING_CONTROL:
         ret = s->dc_panel_panning_control;
         break;
+    case SM501_DC_PANEL_COLOR_KEY:
+        /* Not implemented yet */
+        break;
     case SM501_DC_PANEL_FB_ADDR:
         ret = s->dc_panel_fb_addr;
         break;
@@ -1035,6 +1049,9 @@ static void sm501_disp_ctrl_write(void *opaque, hwaddr addr,
     case SM501_DC_PANEL_PANNING_CONTROL:
         s->dc_panel_panning_control = value & 0xFF3FFF3F;
         break;
+    case SM501_DC_PANEL_COLOR_KEY:
+        /* Not implemented yet */
+        break;
     case SM501_DC_PANEL_FB_ADDR:
         s->dc_panel_fb_addr = value & 0x8FFFFFF0;
         break;
-- 
2.14.3
