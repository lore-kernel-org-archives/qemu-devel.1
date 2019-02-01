Received: from eggs.gnu.org ([209.51.188.92]:59115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMG-0008Iw-3d
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0003kb-Fu
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:00 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36414)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMB-0003KC-52
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:55 -0500
Received: by mail-wm1-x343.google.com with SMTP id p6so6752822wmc.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.09
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:10 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:17 +0000
Message-Id: <20190201160653.13829-12-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 11/47] hw/arm/armsse: Make SRAM bank size
 configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For the IoTKit the SRAM bank size is always 32K (15 bits); for the
SSE-200 this is a configurable parameter, which defaults to 32K but
can be changed when it is built into a particular SoC. For instance
the Musca-B1 board sets it to 128K (17 bits).

Make the bank size a QOM property. We follow the SSE-200 hardware in
naming the parameter SRAM_ADDR_WIDTH, which specifies the number of
address bits of a single SRAM bank.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190121185118.18550-11-peter.maydell@linaro.org
---
 include/hw/arm/armsse.h |  1 +
 hw/arm/armsse.c         | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
index 99714aa63cd..e4a05013316 100644
--- a/include/hw/arm/armsse.h
+++ b/include/hw/arm/armsse.h
@@ -146,6 +146,7 @@ typedef struct ARMSSE {
     MemoryRegion *board_memory;
     uint32_t exp_numirq;
     uint32_t mainclk_frq;
+    uint32_t sram_addr_width;
 } ARMSSE;
 
 typedef struct ARMSSEInfo ARMSSEInfo;
diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index b639b54e0db..a2ae5d3c4b9 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -221,6 +221,7 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     DeviceState *dev_apb_ppc1;
     DeviceState *dev_secctl;
     DeviceState *dev_splitter;
+    uint32_t addr_width_max;
 
     if (!s->board_memory) {
         error_setg(errp, "memory property was not set");
@@ -232,6 +233,15 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* max SRAM_ADDR_WIDTH: 24 - log2(SRAM_NUM_BANK) */
+    assert(is_power_of_2(info->sram_banks));
+    addr_width_max = 24 - ctz32(info->sram_banks);
+    if (s->sram_addr_width < 1 || s->sram_addr_width > addr_width_max) {
+        error_setg(errp, "SRAM_ADDR_WIDTH must be between 1 and %d",
+                   addr_width_max);
+        return;
+    }
+
     /* Handling of which devices should be available only to secure
      * code is usually done differently for M profile than for A profile.
      * Instead of putting some devices only into the secure address space,
@@ -352,8 +362,10 @@ static void armsse_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < info->sram_banks; i++) {
         char *ramname = g_strdup_printf("armsse.sram%d", i);
         SysBusDevice *sbd_mpc;
+        uint32_t sram_bank_size = 1 << s->sram_addr_width;
 
-        memory_region_init_ram(&s->sram[i], NULL, ramname, 0x00008000, &err);
+        memory_region_init_ram(&s->sram[i], NULL, ramname,
+                               sram_bank_size, &err);
         g_free(ramname);
         if (err) {
             error_propagate(errp, err);
@@ -372,7 +384,8 @@ static void armsse_realize(DeviceState *dev, Error **errp)
         }
         /* Map the upstream end of the MPC into the right place... */
         sbd_mpc = SYS_BUS_DEVICE(&s->mpc[i]);
-        memory_region_add_subregion(&s->container, 0x20000000 + i * 0x8000,
+        memory_region_add_subregion(&s->container,
+                                    0x20000000 + i * sram_bank_size,
                                     sysbus_mmio_get_region(sbd_mpc, 1));
         /* ...and its register interface */
         memory_region_add_subregion(&s->container, 0x50083000 + i * 0x1000,
@@ -748,6 +761,7 @@ static Property armsse_properties[] = {
                      MemoryRegion *),
     DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
     DEFINE_PROP_UINT32("MAINCLK", ARMSSE, mainclk_frq, 0),
+    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.20.1
