Received: from eggs.gnu.org ([2001:4830:134:3::10]:43335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilO0-0001j5-7i
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNz-00036k-8S
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:28 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cilNz-00034e-1v
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 12:16:27 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cilNx-0003UA-Ew
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 17:16:25 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Feb 2017 17:16:09 +0000
Message-Id: <1488302176-19463-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
References: <1488302176-19463-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 14/21] hw/intc/arm_gicv3_kvm: Add ICC_SRE_EL1
 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

To Save and Restore ICC_SRE_EL1 register introduce vmstate
subsection and load only if non-zero.
Also initialize icc_sre_el1 with to 0x7 in pre_load
function.

Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 1487850673-26455-3-git-send-email-vijay.kilari@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h |  1 +
 hw/intc/arm_gicv3_common.c         | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 4156051..bccdfe1 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -172,6 +172,7 @@ struct GICv3CPUState {
     uint8_t gicr_ipriorityr[GIC_INTERNAL];
 
     /* CPU interface */
+    uint64_t icc_sre_el1;
     uint64_t icc_ctlr_el1[2];
     uint64_t icc_pmr_el1;
     uint64_t icc_bpr[3];
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 16b9b0f..5b0e456 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -70,6 +70,38 @@ static const VMStateDescription vmstate_gicv3_cpu_virt = {
     }
 };
 
+static int icc_sre_el1_reg_pre_load(void *opaque)
+{
+    GICv3CPUState *cs = opaque;
+
+   /*
+    * If the sre_el1 subsection is not transferred this
+    * means SRE_EL1 is 0x7 (which might not be the same as
+    * our reset value).
+    */
+    cs->icc_sre_el1 = 0x7;
+    return 0;
+}
+
+static bool icc_sre_el1_reg_needed(void *opaque)
+{
+    GICv3CPUState *cs = opaque;
+
+    return cs->icc_sre_el1 != 7;
+}
+
+const VMStateDescription vmstate_gicv3_cpu_sre_el1 = {
+    .name = "arm_gicv3_cpu/sre_el1",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = icc_sre_el1_reg_pre_load,
+    .needed = icc_sre_el1_reg_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3_cpu = {
     .name = "arm_gicv3_cpu",
     .version_id = 1,
@@ -100,6 +132,10 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     .subsections = (const VMStateDescription * []) {
         &vmstate_gicv3_cpu_virt,
         NULL
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_gicv3_cpu_sre_el1,
+        NULL
     }
 };
 
-- 
2.7.4
