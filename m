Received: from eggs.gnu.org ([2001:4830:134:3::10]:40209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTGBF-0006O3-HY
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:32:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fTGBC-00037S-BX
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 20:32:01 -0400
Message-Id: <7a407b15b683417745e71a95452d5094e6e9fe94.1528935420.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1528935420.git.balaton@eik.bme.hu>
References: <cover.1528935420.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Thu, 14 Jun 2018 02:17:00 +0200
Subject: [Qemu-devel] [PATCH v3 6/9] sm501: Do not clear read only bits when
 writing registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

When writing registers that have read only bits we have to avoid
changing these bits as they may have non zero values. Make sure we use
the correct masks to mask out read only and reserved bits when
changing registers.

Also remove extra spaces from dram_control and arbitration_control
assignments.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
v3: Not only preserve read only bits but also allow clearing r/w bits

 hw/display/sm501.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index e47be99..ca0840f 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -836,27 +836,30 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
 
     switch (addr) {
     case SM501_SYSTEM_CONTROL:
-        s->system_control = value & 0xE300B8F7;
+        s->system_control &= 0x10DB0000;
+        s->system_control |= value & 0xEF00B8F7;
         break;
     case SM501_MISC_CONTROL:
-        s->misc_control = value & 0xFF7FFF20;
+        s->misc_control &= 0xEF;
+        s->misc_control |= value & 0xFF7FFF10;
         break;
     case SM501_GPIO31_0_CONTROL:
         s->gpio_31_0_control = value;
         break;
     case SM501_GPIO63_32_CONTROL:
-        s->gpio_63_32_control = value;
+        s->gpio_63_32_control = value & 0xFF80FFFF;
         break;
     case SM501_DRAM_CONTROL:
         s->local_mem_size_index = (value >> 13) & 0x7;
         /* TODO : check validity of size change */
-        s->dram_control |=  value & 0x7FFFFFC3;
+        s->dram_control &= 0x80000000;
+        s->dram_control |= value & 0x7FFFFFC3;
         break;
     case SM501_ARBTRTN_CONTROL:
-        s->arbitration_control =  value & 0x37777777;
+        s->arbitration_control = value & 0x37777777;
         break;
     case SM501_IRQ_MASK:
-        s->irq_mask = value;
+        s->irq_mask = value & 0xFFDF3F5F;
         break;
     case SM501_MISC_TIMING:
         s->misc_timing = value & 0xF31F1FFF;
-- 
2.7.6
