Received: from eggs.gnu.org ([209.51.188.92]:52193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXr-0008Uv-HS
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gwtXp-0007Sr-9a
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:07 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gwtXo-0007Pv-SM
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 13:58:05 -0500
Received: by mail-wr1-x434.google.com with SMTP id n2so19644307wrw.8
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 10:58:02 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	c18sm29065085wre.32.2019.02.21.10.57.59 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Feb 2019 10:58:00 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Feb 2019 18:57:33 +0000
Message-Id: <20190221185739.25362-16-peter.maydell@linaro.org>
In-Reply-To: <20190221185739.25362-1-peter.maydell@linaro.org>
References: <20190221185739.25362-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 15/21] hw/arm/armsse: Allow boards to specify
 init-svtor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The Musca boards have DAPLink firmware that sets the initial
secure VTOR value (the location of the vector table) differently
depending on the boot mode (from flash, from RAM, etc). Export
the init-svtor as a QOM property of the ARMSSE object so that
the board can change it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/arm/armsse.h | 3 +++
 hw/arm/armsse.c         | 8 ++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 444605b44dc..84879f40dd8 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -48,6 +48,8 @@
  *    if necessary.)
  *  + QOM property "SRAM_ADDR_WIDTH" sets the number of bits used for the
  *    address of each SRAM bank (and thus the total amount of internal SRAM)
+ *  + QOM property "init-svtor" sets the initial value of the CPU SVTOR register
+ *    (where it expects to load the PC and SP from the vector table on reset)
  *  + Named GPIO inputs "EXP_IRQ" 0..n are the expansion interrupts for CPU 0,
  *    which are wired to its NVIC lines 32 .. n+32
  *  + Named GPIO inputs "EXP_CPU1_IRQ" 0..n are the expansion interrupts for
@@ -204,6 +206,7 @@ typedef struct ARMSSE {
     uint32_t exp_numirq;
     uint32_t mainclk_frq;
     uint32_t sram_addr_width;
+    uint32_t init_svtor;
 } ARMSSE;
 
 typedef struct ARMSSEInfo ARMSSEInfo;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index d0207dbabc7..50da41f64c5 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -505,11 +505,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
          * the INITSVTOR* registers before powering up the CPUs in any case,
          * so the hardware's default value doesn't matter. QEMU doesn't emulate
          * the control processor, so instead we behave in the way that the
-         * firmware does. All boards currently known about have firmware that
-         * sets the INITSVTOR0 and INITSVTOR1 registers to 0x10000000, like the
-         * IoTKit default. We can make this more configurable if necessary.
+         * firmware does. The initial value is configurable by the board code
+         * to match whatever its firmware does.
          */
-        qdev_prop_set_uint32(cpudev, "init-svtor", 0x10000000);
+        qdev_prop_set_uint32(cpudev, "init-svtor", s->init_svtor);
         /*
          * Start all CPUs except CPU0 powered down. In real hardware it is
          * a configurable property of the SSE-200 which CPUs start powered up
@@ -1187,6 +1186,7 @@ static Property armsse_properties[] = {
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
     DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
     DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
+    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.20.1
