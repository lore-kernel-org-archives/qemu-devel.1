Received: from eggs.gnu.org ([2001:4830:134:3::10]:41668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fPdGq-0004bV-0V
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 20:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fPdGo-0008Gq-Om
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 20:22:48 -0400
Message-Id: <63c008337021769f6e207d5bbe7c576b99586ec2.1528069840.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1528069840.git.balaton@eik.bme.hu>
References: <cover.1528069840.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 04 Jun 2018 01:50:40 +0200
Subject: [Qemu-devel] [PATCH 4/4] sm501: Do not clear read only bits when
 writing register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

When writing a register that has read only bits besides reserved bits
we have to avoid changing read only bits that may have non zero
default values. While at it, fix a reserved bit mask and a white space
error.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index f4bb33c..51b2bb8 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -837,10 +837,10 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
 
     switch (addr) {
     case SM501_SYSTEM_CONTROL:
-        s->system_control = value & 0xE300B8F7;
+        s->system_control |= value & 0xEF00B8F7;
         break;
     case SM501_MISC_CONTROL:
-        s->misc_control = value & 0xFF7FFF20;
+        s->misc_control |= value & 0xFF7FFF10;
         break;
     case SM501_GPIO31_0_CONTROL:
         s->gpio_31_0_control = value;
@@ -854,7 +854,7 @@ static void sm501_system_config_write(void *opaque, hwaddr addr,
         s->dram_control |=  value & 0x7FFFFFC3;
         break;
     case SM501_ARBTRTN_CONTROL:
-        s->arbitration_control =  value & 0x37777777;
+        s->arbitration_control = value & 0x37777777;
         break;
     case SM501_IRQ_MASK:
         s->irq_mask = value;
-- 
2.7.6
