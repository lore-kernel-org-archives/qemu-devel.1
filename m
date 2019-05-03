Received: from eggs.gnu.org ([209.51.188.92]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNxk-0004Aw-IE
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:30:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1hMNxj-0004Y8-GR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 22:30:12 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri,  3 May 2019 11:59:57 +0930
Message-Id: <20190503022958.1394-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2] arm: aspeed: Set SDRAM size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

We currently use Qemu's default of 128MB. As we know how much ram each
machine ships with, make it easier on users by setting a default.

It can still be overridden with -m on the command line.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
v2:
 - Fix 'if' style issue. Thanks patchew
 - Use units.h defines

 hw/arm/aspeed.c         | 8 ++++++++
 include/hw/arm/aspeed.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1c23ebd99252..29d225ed1405 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -25,6 +25,7 @@
 #include "sysemu/block-backend.h"
 #include "hw/loader.h"
 #include "qemu/error-report.h"
+#include "qemu/units.h"
 
 static struct arm_boot_info aspeed_board_binfo = {
     .board_id = -1, /* device-tree-only board */
@@ -331,6 +332,9 @@ static void aspeed_machine_class_init(ObjectClass *oc, void *data)
     mc->no_floppy = 1;
     mc->no_cdrom = 1;
     mc->no_parallel = 1;
+    if (board->ram) {
+        mc->default_ram_size = board->ram;
+    }
     amc->board = board;
 }
 
@@ -352,6 +356,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
         .i2c_init  = palmetto_bmc_i2c_init,
+        .ram       = 256 * MiB,
     }, {
         .name      = MACHINE_TYPE_NAME("ast2500-evb"),
         .desc      = "Aspeed AST2500 EVB (ARM1176)",
@@ -361,6 +366,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx25l25635e",
         .num_cs    = 1,
         .i2c_init  = ast2500_evb_i2c_init,
+        .ram       = 512 * MiB,
     }, {
         .name      = MACHINE_TYPE_NAME("romulus-bmc"),
         .desc      = "OpenPOWER Romulus BMC (ARM1176)",
@@ -370,6 +376,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx66l1g45g",
         .num_cs    = 2,
         .i2c_init  = romulus_bmc_i2c_init,
+        .ram       = 512 * MiB,
     }, {
         .name      = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .desc      = "OpenPOWER Witherspoon BMC (ARM1176)",
@@ -379,6 +386,7 @@ static const AspeedBoardConfig aspeed_boards[] = {
         .spi_model = "mx66l1g45g",
         .num_cs    = 2,
         .i2c_init  = witherspoon_bmc_i2c_init,
+        .ram       = 512 * MiB,
     },
 };
 
diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 325c091d09e4..02073a6b4d61 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -22,6 +22,7 @@ typedef struct AspeedBoardConfig {
     const char *spi_model;
     uint32_t num_cs;
     void (*i2c_init)(AspeedBoardState *bmc);
+    uint32_t ram;
 } AspeedBoardConfig;
 
 #define TYPE_ASPEED_MACHINE       MACHINE_TYPE_NAME("aspeed")
-- 
2.20.1
