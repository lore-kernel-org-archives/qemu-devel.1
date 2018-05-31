Received: from eggs.gnu.org ([2001:4830:134:3::10]:41619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0000sM-PX
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUt-0006Wo-OR
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUt-0006TM-Gk
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUj-0002pP-Qb
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:24:01 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:36 +0100
Message-Id: <20180531142357.904-5-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 04/25] arm_gicv3_kvm: increase clroffset
 accordingly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Shannon Zhao <zhaoshenglong@huawei.com>

It forgot to increase clroffset during the loop. So it only clear the
first 4 bytes.

Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
Cc: qemu-stable@nongnu.org
Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index ec371772b3..3536795501 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -243,6 +243,7 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
         if (clroffset != 0) {
             reg = 0;
             kvm_gicd_access(s, clroffset, &reg, true);
+            clroffset += 4;
         }
         reg = *gic_bmp_ptr32(bmp, irq);
         kvm_gicd_access(s, offset, &reg, true);
-- 
2.17.1
