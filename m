Received: from eggs.gnu.org ([209.51.188.92]:38984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glevU-000854-Ey
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 14:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1glefa-0002qR-Mm
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:40 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:56109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1glefY-0002eg-Uh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:51:37 -0500
Received: by mail-wm1-x342.google.com with SMTP id y139so11755175wmc.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:51:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Jan 2019 18:51:05 +0000
Message-Id: <20190121185118.18550-11-peter.maydell@linaro.org>
In-Reply-To: <20190121185118.18550-1-peter.maydell@linaro.org>
References: <20190121185118.18550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/23] hw/arm/armsse: Make SRAM bank size
 configurable
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

For the IoTKit the SRAM bank size is always 32K (15 bits); for the
SSE-200 this is a configurable parameter, which defaults to 32K but
can be changed when it is built into a particular SoC. For instance
the Musca-B1 board sets it to 128K (17 bits).

Make the bank size a QOM property. We follow the SSE-200 hardware in
naming the parameter SRAM_ADDR_WIDTH, which specifies the number of
address bits of a single SRAM bank.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
