Received: from eggs.gnu.org ([2001:4830:134:3::10]:38456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmej3-00035O-Vc
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmej3-0006gy-56
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:06 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Aug 2018 13:34:42 +0100
Message-Id: <20180806123445.1459-3-peter.maydell@linaro.org>
In-Reply-To: <20180806123445.1459-1-peter.maydell@linaro.org>
References: <20180806123445.1459-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 v2 2/5] hw/intc/arm_gicv3_common:
 Combine duplicate .subsections in vmstate_gicv3_cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

Commit 6692aac411199064 accidentally introduced a second initialization
of the .subsections field of vmstate_gicv3_cpu, instead of adding
the new subsection to the existing list. The effect of this was
probably that migration of GICv3 with virtualization enabled was
broken (or alternatively that migration of ICC_SRE_EL1 was broken,
depending on which of the two initializers the compiler used).
Combine the two into a single list.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
Not strictly a 2.12 regression.
---
 hw/intc/arm_gicv3_common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e58bc8b8105..e1a8999cf5b 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -134,9 +134,6 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     },
     .subsections = (const VMStateDescription * []) {
         &vmstate_gicv3_cpu_virt,
-        NULL
-    },
-    .subsections = (const VMStateDescription * []) {
         &vmstate_gicv3_cpu_sre_el1,
         NULL
     }
-- 
2.17.1
