Received: from eggs.gnu.org ([2001:4830:134:3::10]:38919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1eCGz5-0004sj-BD
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:25:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1eCGz4-00008R-Ac
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 22:24:59 -0500
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed,  8 Nov 2017 13:54:27 +1030
Message-Id: <20171108032427.11163-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH] hw/arm/aspeed: Unlock SCU when running kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The ASPEED hardware contains a lock register for the SCU that disables
any writes to the SCU when it is locked. The machine comes up with the
lock enabled, but on all known hardware u-boot will unlock it and leave
it unlocked when loading the kernel.

This means the kernel expects the SCU to be unlocked. When booting from
an emulated ROM the normal u-boot unlock path is executed. Things don't
go well when booting using the -kernel command line, as u-boot does not
run first.

Change behaviour so that when a kernel is passed to the machine, set the
reset value of the SCU to be unlocked.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/arm/aspeed.c               | 10 ++++++++++
 hw/arm/aspeed_soc.c           |  2 ++
 hw/misc/aspeed_scu.c          |  2 ++
 hw/misc/aspeed_sdmc.c         |  1 -
 include/hw/misc/aspeed_scu.h  |  1 +
 include/hw/misc/aspeed_sdmc.h |  2 ++
 6 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ab895ad490af..179ee66624b9 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -36,6 +36,7 @@ typedef struct AspeedBoardState {
 typedef struct AspeedBoardConfig {
     const char *soc_name;
     uint32_t hw_strap1;
+    uint32_t hw_prot_key;
     const char *fmc_model;
     const char *spi_model;
     uint32_t num_cs;
@@ -186,6 +187,15 @@ static void aspeed_board_init(MachineState *machine,
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
                             &error_abort);
+    if (machine->kernel_filename) {
+        /*
+         * When booting with a -kernel command line there is no u-boot
+         * that runs to unlock the SCU. In this case set the default to
+         * be unlocked as the kernel expects
+         */
+        object_property_set_int(OBJECT(&bmc->soc), PROT_KEY_UNLOCK,
+                                "hw-prot-key", &error_abort);
+    }
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
                              &error_abort);
 
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5aa3d2ddd9cd..c83b7e207b86 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -154,6 +154,8 @@ static void aspeed_soc_init(Object *obj)
                               "hw-strap1", &error_abort);
     object_property_add_alias(obj, "hw-strap2", OBJECT(&s->scu),
                               "hw-strap2", &error_abort);
+    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
+                              "hw-prot-key", &error_abort);
 
     object_initialize(&s->fmc, sizeof(s->fmc), sc->info->fmc_typename);
     object_property_add_child(obj, "fmc", OBJECT(&s->fmc), NULL);
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 95022d3607ad..c71e77729581 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -246,6 +246,7 @@ static void aspeed_scu_reset(DeviceState *dev)
     s->regs[SILICON_REV] = s->silicon_rev;
     s->regs[HW_STRAP1] = s->hw_strap1;
     s->regs[HW_STRAP2] = s->hw_strap2;
+    s->regs[PROT_KEY] = s->hw_prot_key;
 }
 
 static uint32_t aspeed_silicon_revs[] = {
@@ -299,6 +300,7 @@ static Property aspeed_scu_properties[] = {
     DEFINE_PROP_UINT32("silicon-rev", AspeedSCUState, silicon_rev, 0),
     DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
+    DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f0b3053fae36..35dc803604f8 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -18,7 +18,6 @@
 
 /* Protection Key Register */
 #define R_PROT            (0x00 / 4)
-#define   PROT_KEY_UNLOCK     0xFC600309
 
 /* Configuration Register */
 #define R_CONF            (0x04 / 4)
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index bd4ac013f997..f5da54e27105 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -29,6 +29,7 @@ typedef struct AspeedSCUState {
     uint32_t silicon_rev;
     uint32_t hw_strap1;
     uint32_t hw_strap2;
+    uint32_t hw_prot_key;
 } AspeedSCUState;
 
 #define AST2400_A0_SILICON_REV   0x02000303U
diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 551c8afdf4be..a1b3232c5ef3 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -16,6 +16,8 @@
 
 #define ASPEED_SDMC_NR_REGS (0x8 >> 2)
 
+#define PROT_KEY_UNLOCK 0xFC600309
+
 typedef struct AspeedSDMCState {
     /*< private >*/
     SysBusDevice parent_obj;
-- 
2.14.1
