Received: from eggs.gnu.org ([2001:4830:134:3::10]:47005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1exvvB-0000lc-R7
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:37:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1exvvB-00062i-0p
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:37:57 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 19 Mar 2018 22:36:16 +0800
Message-ID: <1521470177-14760-2-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1521470177-14760-1-git-send-email-zhaoshenglong@huawei.com>
References: <1521470177-14760-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/2] arm_gicv3_kvm: increase clroffset
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

It forgot to increase clroffset during the loop. So it only clear the
first 4 bytes.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
 hw/intc/arm_gicv3_kvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index ec37177..7000716 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -232,9 +232,10 @@ static void kvm_dist_getbmp(GICv3State *s, uint32_t offset, uint32_t *bmp)
 static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
                             uint32_t clroffset, uint32_t *bmp)
 {
-    uint32_t reg;
+    uint32_t reg, clroffset_index;
     int irq;
 
+    clroffset_index = clroffset;
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         /* If this bitmap is a set/clear register pair, first write to the
          * clear-reg to clear all bits before using the set-reg to write
@@ -242,7 +243,8 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
          */
         if (clroffset != 0) {
             reg = 0;
-            kvm_gicd_access(s, clroffset, &reg, true);
+            kvm_gicd_access(s, clroffset_index, &reg, true);
+            clroffset_index += 4;
         }
         reg = *gic_bmp_ptr32(bmp, irq);
         kvm_gicd_access(s, offset, &reg, true);
-- 
2.0.4
