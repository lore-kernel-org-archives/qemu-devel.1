Received: from eggs.gnu.org ([209.51.188.92]:38654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevP-0007jF-Nl
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefh-0002wL-JN
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:48 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefh-0002vv-CI
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:45 -0500
Received: by mail-wr1-x442.google.com with SMTP id c14so24667087wrr.0
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:16 +0000
Message-Id: <20190121185118.18550-22-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 21/23] hw/arm/armsse: Add SSE-200 model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

Add a model of the SSE-200, now we have put in all
the code that lets us make it different from the IoTKit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/armsse.h | 19 ++++++++++++++++---
 hw/arm/armsse.c         | 12 ++++++++++++
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 3914e8e4bf2..f800bafb14a 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -1,5 +1,5 @@
 /*
- * ARM SSE (Subsystems for Embedded): IoTKit
+ * ARM SSE (Subsystems for Embedded): IoTKit, SSE-200
  *
  * Copyright (c) 2018 Linaro Limited
  * Written by Peter Maydell
@@ -12,9 +12,13 @@
 /*
  * This is a model of the Arm "Subsystems for Embedded" family of
  * hardware, which include the IoT Kit and the SSE-050, SSE-100 and
- * SSE-200. Currently we model only the Arm IoT Kit which is documented in
+ * SSE-200. Currently we model:
+ *  - the Arm IoT Kit which is documented in
  * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
- * It contains:
+ *  - the SSE-200 which is documented in
+ * http://infocenter.arm.com/help/topic/com.arm.doc.101104_0100_00_en/corelink_sse200_subsystem_for_embedded_technical_reference_manual_101104_0100_00_en.pdf
+ *
+ * The IoTKit contains:
  *  a Cortex-M33
  *  the IDAU
  *  some timers and watchdogs
@@ -23,6 +27,14 @@
  *  a security controller
  *  a bus fabric which arranges that some parts of the address
  *  space are secure and non-secure aliases of each other
+ * The SSE-200 additionally contains:
+ *  a second Cortex-M33
+ *  two Message Handling Units (MHUs)
+ *  an optional CryptoCell (which we do not model)
+ *  more SRAM banks with associated MPCs
+ *  multiple Power Policy Units (PPUs)
+ *  a control interface for an icache for each CPU
+ *  per-CPU identity and control register blocks
  *
  * QEMU interface:
  *  + QOM property "memory" is a MemoryRegion containing the devices provided
@@ -93,6 +105,7 @@
  * them via the ARMSSE base class, so they have no IOTKIT() etc macros.
  */
 #define TYPE_IOTKIT "iotkit"
+#define TYPE_SSE200 "sse-200"
 
 /* We have an IRQ splitter and an OR gate input for each external PPC
  * and the 2 internal PPCs
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index eb691faf720..5d53071a5a0 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -50,6 +50,18 @@ static const ARMSSEInfo armsse_variants[] = {
         .has_cpusecctrl = false,
         .has_cpuid = false,
     },
+    {
+        .name = TYPE_SSE200,
+        .sram_banks = 4,
+        .num_cpus = 2,
+        .sys_version = 0x22041743,
+        .sys_config_format = SSE200Format,
+        .has_mhus = true,
+        .has_ppus = true,
+        .has_cachectrl = true,
+        .has_cpusecctrl = true,
+        .has_cpuid = true,
+    },
 };
 
 static uint32_t armsse_sys_config_value(ARMSSE *s, const ARMSSEInfo *info)
-- 
2.20.1
