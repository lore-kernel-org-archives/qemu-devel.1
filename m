Received: from eggs.gnu.org ([2001:4830:134:3::10]:37497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0g-0008HH-Qb
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0f-0006IQ-K7
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:30 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1eGq0f-0006H1-Bf
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 12:37:29 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1eGq0e-0006Nv-Am
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 17:37:28 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 17:37:23 +0000
Message-Id: <1511199444-17922-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
References: <1511199444-17922-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 4/5] hw/arm/aspeed: Unlock SCU when running
 kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Joel Stanley <joel@jms.id.au>

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
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20171114122018.12204-1-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_scu.h | 3 +++
 hw/arm/aspeed.c              | 9 +++++++++
 hw/arm/aspeed_soc.c          | 2 ++
 hw/misc/aspeed_scu.c         | 5 +++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index bd4ac01..d70cc0a 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -29,6 +29,7 @@ typedef struct AspeedSCUState {
     uint32_t silicon_rev;
     uint32_t hw_strap1;
     uint32_t hw_strap2;
+    uint32_t hw_prot_key;
 } AspeedSCUState;
 
 #define AST2400_A0_SILICON_REV   0x02000303U
@@ -38,6 +39,8 @@ typedef struct AspeedSCUState {
 
 extern bool is_supported_silicon_rev(uint32_t silicon_rev);
 
+#define ASPEED_SCU_PROT_KEY      0x1688A8A8
+
 /*
  * Extracted from Aspeed SDK v00.03.21. Fixes and extra definitions
  * were added.
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index ab895ad..7088c90 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -186,6 +186,15 @@ static void aspeed_board_init(MachineState *machine,
                             &error_abort);
     object_property_set_int(OBJECT(&bmc->soc), cfg->num_cs, "num-cs",
                             &error_abort);
+    if (machine->kernel_filename) {
+        /*
+         * When booting with a -kernel command line there is no u-boot
+         * that runs to unlock the SCU. In this case set the default to
+         * be unlocked as the kernel expects
+         */
+        object_property_set_int(OBJECT(&bmc->soc), ASPEED_SCU_PROT_KEY,
+                                "hw-prot-key", &error_abort);
+    }
     object_property_set_bool(OBJECT(&bmc->soc), true, "realized",
                              &error_abort);
 
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 5aa3d2d..c83b7e2 100644
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
index 95022d3..74537ce 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -85,7 +85,6 @@
 #define BMC_REV              TO_REG(0x19C)
 #define BMC_DEV_ID           TO_REG(0x1A4)
 
-#define PROT_KEY_UNLOCK 0x1688A8A8
 #define SCU_IO_REGION_SIZE 0x1000
 
 static const uint32_t ast2400_a0_resets[ASPEED_SCU_NR_REGS] = {
@@ -192,7 +191,7 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
     }
 
     if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
-            s->regs[PROT_KEY] != PROT_KEY_UNLOCK) {
+            s->regs[PROT_KEY] != ASPEED_SCU_PROT_KEY) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
         return;
     }
@@ -246,6 +245,7 @@ static void aspeed_scu_reset(DeviceState *dev)
     s->regs[SILICON_REV] = s->silicon_rev;
     s->regs[HW_STRAP1] = s->hw_strap1;
     s->regs[HW_STRAP2] = s->hw_strap2;
+    s->regs[PROT_KEY] = s->hw_prot_key;
 }
 
 static uint32_t aspeed_silicon_revs[] = {
@@ -299,6 +299,7 @@ static Property aspeed_scu_properties[] = {
     DEFINE_PROP_UINT32("silicon-rev", AspeedSCUState, silicon_rev, 0),
     DEFINE_PROP_UINT32("hw-strap1", AspeedSCUState, hw_strap1, 0),
     DEFINE_PROP_UINT32("hw-strap2", AspeedSCUState, hw_strap2, 0),
+    DEFINE_PROP_UINT32("hw-prot-key", AspeedSCUState, hw_prot_key, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.7.4
