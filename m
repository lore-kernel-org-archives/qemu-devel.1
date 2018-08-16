Received: from eggs.gnu.org ([2001:4830:134:3::10]:59111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQh-0000lL-9s
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQe-00021u-Kd
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:10 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQe-00021R-CV
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:08 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQd-00009j-GJ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:07 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:31 +0100
Message-Id: <20180816133438.17061-24-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 23/30] aspeed: add a max_ram_size property to
 the memory controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Cédric Le Goater <clg@kaod.org>

This will be used to construct a memory region beyond the RAM region
to let firmwares scan the address space with load/store to guess how
much RAM the SoC has.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Tested-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20180807075757.7242-7-joel@jms.id.au
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_sdmc.h |  1 +
 hw/arm/aspeed.c               | 31 +++++++++++++++++++++++++++++++
 hw/arm/aspeed_soc.c           |  2 ++
 hw/misc/aspeed_sdmc.c         |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index e079c66a7d7..b3c926acae9 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -27,6 +27,7 @@ typedef struct AspeedSDMCState {
     uint32_t silicon_rev;
     uint32_t ram_bits;
     uint64_t ram_size;
+    uint64_t max_ram_size;
     uint32_t fixed_conf;
 
 } AspeedSDMCState;
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index bb9d33848d3..bb9590f1aed 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -31,6 +31,7 @@ static struct arm_boot_info aspeed_board_binfo = {
 typedef struct AspeedBoardState {
     AspeedSoCState soc;
     MemoryRegion ram;
+    MemoryRegion max_ram;
 } AspeedBoardState;
 
 typedef struct AspeedBoardConfig {
@@ -127,6 +128,27 @@ static const AspeedBoardConfig aspeed_boards[] = {
     },
 };
 
+/*
+ * The max ram region is for firmwares that scan the address space
+ * with load/store to guess how much RAM the SoC has.
+ */
+static uint64_t max_ram_read(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0;
+}
+
+static void max_ram_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    /* Discard writes */
+}
+
+static const MemoryRegionOps max_ram_ops = {
+    .read = max_ram_read,
+    .write = max_ram_write,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
 #define FIRMWARE_ADDR 0x0
 
 static void write_boot_rom(DriveInfo *dinfo, hwaddr addr, size_t rom_size,
@@ -187,6 +209,7 @@ static void aspeed_board_init(MachineState *machine,
     AspeedBoardState *bmc;
     AspeedSoCClass *sc;
     DriveInfo *drive0 = drive_get(IF_MTD, 0, 0);
+    ram_addr_t max_ram_size;
 
     bmc = g_new0(AspeedBoardState, 1);
     object_initialize(&bmc->soc, (sizeof(bmc->soc)), cfg->soc_name);
@@ -226,6 +249,14 @@ static void aspeed_board_init(MachineState *machine,
     object_property_add_const_link(OBJECT(&bmc->soc), "ram", OBJECT(&bmc->ram),
                                    &error_abort);
 
+    max_ram_size = object_property_get_uint(OBJECT(&bmc->soc), "max-ram-size",
+                                            &error_abort);
+    memory_region_init_io(&bmc->max_ram, NULL, &max_ram_ops, NULL,
+                          "max_ram", max_ram_size  - ram_size);
+    memory_region_add_subregion(get_system_memory(),
+                                sc->info->sdram_base + ram_size,
+                                &bmc->max_ram);
+
     aspeed_board_init_flashes(&bmc->soc.fmc, cfg->fmc_model, &error_abort);
     aspeed_board_init_flashes(&bmc->soc.spi[0], cfg->spi_model, &error_abort);
 
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index e68911af0f9..a27233d4876 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -155,6 +155,8 @@ static void aspeed_soc_init(Object *obj)
                          sc->info->silicon_rev);
     object_property_add_alias(obj, "ram-size", OBJECT(&s->sdmc),
                               "ram-size", &error_abort);
+    object_property_add_alias(obj, "max-ram-size", OBJECT(&s->sdmc),
+                              "max-ram-size", &error_abort);
 
     for (i = 0; i < sc->info->wdts_num; i++) {
         object_initialize(&s->wdt[i], sizeof(s->wdt[i]), TYPE_ASPEED_WDT);
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 89de3138aff..eec77f24350 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -242,12 +242,14 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
     case AST2400_A0_SILICON_REV:
     case AST2400_A1_SILICON_REV:
         s->ram_bits = ast2400_rambits(s);
+        s->max_ram_size = 512 << 20;
         s->fixed_conf = ASPEED_SDMC_VGA_COMPAT |
             ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
         break;
     case AST2500_A0_SILICON_REV:
     case AST2500_A1_SILICON_REV:
         s->ram_bits = ast2500_rambits(s);
+        s->max_ram_size = 1024 << 20;
         s->fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
             ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
             ASPEED_SDMC_CACHE_INITIAL_DONE |
@@ -275,6 +277,7 @@ static const VMStateDescription vmstate_aspeed_sdmc = {
 static Property aspeed_sdmc_properties[] = {
     DEFINE_PROP_UINT32("silicon-rev", AspeedSDMCState, silicon_rev, 0),
     DEFINE_PROP_UINT64("ram-size", AspeedSDMCState, ram_size, 0),
+    DEFINE_PROP_UINT64("max-ram-size", AspeedSDMCState, max_ram_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.18.0
