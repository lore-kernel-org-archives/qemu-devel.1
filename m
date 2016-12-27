Received: from eggs.gnu.org ([2001:4830:134:3::10]:35566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaE-0002Zz-H8
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaD-0001MF-II
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:34 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:47878)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cLtaD-0001Ln-BG
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 10:22:33 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cLtaC-0003wK-GY
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 15:22:32 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Dec 2016 15:21:10 +0000
Message-Id: <1482852077-19397-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
References: <1482852077-19397-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/25] aspeed: add the definitions for the
 AST2400 A1 SoC
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

There is not much differences with the A0 revision apart from the DDR
calibration.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1480434248-27138-10-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_scu.h |  1 +
 hw/arm/aspeed_soc.c          | 10 ++++++++++
 hw/misc/aspeed_scu.c         |  2 ++
 hw/misc/aspeed_sdmc.c        |  3 +++
 4 files changed, 16 insertions(+)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index 14ffc43..bd4ac01 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -32,6 +32,7 @@ typedef struct AspeedSCUState {
 } AspeedSCUState;
 
 #define AST2400_A0_SILICON_REV   0x02000303U
+#define AST2400_A1_SILICON_REV   0x02010303U
 #define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
 
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 233a6b9..d111d2e 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -59,6 +59,16 @@ static const AspeedSoCInfo aspeed_socs[] = {
         .fmc_typename = "aspeed.smc.fmc",
         .spi_typename = aspeed_soc_ast2400_typenames,
     }, {
+        .name         = "ast2400-a1",
+        .cpu_model    = "arm926",
+        .silicon_rev  = AST2400_A1_SILICON_REV,
+        .sdram_base   = AST2400_SDRAM_BASE,
+        .sram_size    = 0x8000,
+        .spis_num     = 1,
+        .spi_bases    = aspeed_soc_ast2400_spi_bases,
+        .fmc_typename = "aspeed.smc.fmc",
+        .spi_typename = aspeed_soc_ast2400_typenames,
+    }, {
         .name         = "ast2400",
         .cpu_model    = "arm926",
         .silicon_rev  = AST2400_A0_SILICON_REV,
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index b1f3e6f..34e8638 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -231,6 +231,7 @@ static void aspeed_scu_reset(DeviceState *dev)
 
     switch (s->silicon_rev) {
     case AST2400_A0_SILICON_REV:
+    case AST2400_A1_SILICON_REV:
         reset = ast2400_a0_resets;
         break;
     case AST2500_A0_SILICON_REV:
@@ -249,6 +250,7 @@ static void aspeed_scu_reset(DeviceState *dev)
 
 static uint32_t aspeed_silicon_revs[] = {
     AST2400_A0_SILICON_REV,
+    AST2400_A1_SILICON_REV,
     AST2500_A0_SILICON_REV,
     AST2500_A1_SILICON_REV,
 };
diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 8830dc0..5f3ac0b 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -119,6 +119,7 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
         /* Make sure readonly bits are kept */
         switch (s->silicon_rev) {
         case AST2400_A0_SILICON_REV:
+        case AST2400_A1_SILICON_REV:
             data &= ~ASPEED_SDMC_READONLY_MASK;
             break;
         case AST2500_A0_SILICON_REV:
@@ -193,6 +194,7 @@ static void aspeed_sdmc_reset(DeviceState *dev)
     /* Set ram size bit and defaults values */
     switch (s->silicon_rev) {
     case AST2400_A0_SILICON_REV:
+    case AST2400_A1_SILICON_REV:
         s->regs[R_CONF] |=
             ASPEED_SDMC_VGA_COMPAT |
             ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
@@ -224,6 +226,7 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
 
     switch (s->silicon_rev) {
     case AST2400_A0_SILICON_REV:
+    case AST2400_A1_SILICON_REV:
         s->ram_bits = ast2400_rambits(s);
         break;
     case AST2500_A0_SILICON_REV:
-- 
2.7.4
