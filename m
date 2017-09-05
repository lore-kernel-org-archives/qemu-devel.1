Received: from eggs.gnu.org ([2001:4830:134:3::10]:49601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dpBw1-0000uM-AU
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1dpBvw-0005um-Ki
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:22:25 -0400
From: P J P <ppandit@redhat.com>
Date: Tue,  5 Sep 2017 16:51:52 +0530
Message-Id: <20170905112152.8851-1-ppandit@redhat.com>
Subject: [Qemu-devel] [PATCH] intc: arm_gicv3: limit GICR ipriority index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Guoxiang Niu <niuguoxiang@huawei.com>, Prasad J Pandit <pjp@fedoraproject.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

When reading or writing to GICR ipriority array, index 'irq'
could go beyond its bounds; Restrict it within array limits.

Reported-by: Guoxiang Niu <niuguoxiang@huawei.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/intc/arm_gicv3_redist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 77e5cfa327..7683c4cc7f 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -187,7 +187,7 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
     case GICR_ICACTIVER0:
         *data = gicr_read_bitmap_reg(cs, attrs, cs->gicr_iactiver0);
         return MEMTX_OK;
-    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1f:
+    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1c:
     {
         int i, irq = offset - GICR_IPRIORITYR;
         uint32_t value = 0;
@@ -310,7 +310,7 @@ static MemTxResult gicr_writel(GICv3CPUState *cs, hwaddr offset,
     case GICR_ICACTIVER0:
         gicr_write_clear_bitmap_reg(cs, attrs, &cs->gicr_iactiver0, value);
         return MEMTX_OK;
-    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1f:
+    case GICR_IPRIORITYR ... GICR_IPRIORITYR + 0x1c:
     {
         int i, irq = offset - GICR_IPRIORITYR;
 
-- 
2.13.5
