Received: from eggs.gnu.org ([2001:4830:134:3::10]:60678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwst-0002f8-Gi
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fmwss-0005XK-N9
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:58:27 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue,  7 Aug 2018 17:27:52 +0930
Message-Id: <20180807075757.7242-3-joel@jms.id.au>
In-Reply-To: <20180807075757.7242-1-joel@jms.id.au>
References: <20180807075757.7242-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 2/7] aspeed_sdmc: Fix saved values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This fixes the intended protection of read-only values in the
configuration register. They were being always set to zero by mistake.

The read-only fields depend on the configured memory size of the system,
so they cannot be fixed at compile time. The most straight forward
option was to store them in the state structure.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c         | 27 ++++++++-------------------
 include/hw/misc/aspeed_sdmc.h |  1 +
 2 files changed, 9 insertions(+), 19 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index 0df008e52a18..24fd4aee2d82 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -126,10 +126,12 @@ static void aspeed_sdmc_write(void *opaque, hwaddr addr, uint64_t data,
         case AST2400_A0_SILICON_REV:
         case AST2400_A1_SILICON_REV:
             data &= ~ASPEED_SDMC_READONLY_MASK;
+            data |= s->fixed_conf;
             break;
         case AST2500_A0_SILICON_REV:
         case AST2500_A1_SILICON_REV:
             data &= ~ASPEED_SDMC_AST2500_READONLY_MASK;
+            data |= s->fixed_conf;
             break;
         default:
             g_assert_not_reached();
@@ -198,25 +200,7 @@ static void aspeed_sdmc_reset(DeviceState *dev)
     memset(s->regs, 0, sizeof(s->regs));
 
     /* Set ram size bit and defaults values */
-    switch (s->silicon_rev) {
-    case AST2400_A0_SILICON_REV:
-    case AST2400_A1_SILICON_REV:
-        s->regs[R_CONF] |=
-            ASPEED_SDMC_VGA_COMPAT |
-            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
-        break;
-
-    case AST2500_A0_SILICON_REV:
-    case AST2500_A1_SILICON_REV:
-        s->regs[R_CONF] |=
-            ASPEED_SDMC_HW_VERSION(1) |
-            ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
-            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
-        break;
-
-    default:
-        g_assert_not_reached();
-    }
+    s->regs[R_CONF] = s->fixed_conf;
 }
 
 static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
@@ -234,10 +218,15 @@ static void aspeed_sdmc_realize(DeviceState *dev, Error **errp)
     case AST2400_A0_SILICON_REV:
     case AST2400_A1_SILICON_REV:
         s->ram_bits = ast2400_rambits(s);
+        s->fixed_conf = ASPEED_SDMC_VGA_COMPAT |
+            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
         break;
     case AST2500_A0_SILICON_REV:
     case AST2500_A1_SILICON_REV:
         s->ram_bits = ast2500_rambits(s);
+        s->fixed_conf = ASPEED_SDMC_HW_VERSION(1) |
+            ASPEED_SDMC_VGA_APERTURE(ASPEED_SDMC_VGA_64MB) |
+            ASPEED_SDMC_DRAM_SIZE(s->ram_bits);
         break;
     default:
         g_assert_not_reached();
diff --git a/include/hw/misc/aspeed_sdmc.h b/include/hw/misc/aspeed_sdmc.h
index 682f0f5d56dc..e079c66a7d73 100644
--- a/include/hw/misc/aspeed_sdmc.h
+++ b/include/hw/misc/aspeed_sdmc.h
@@ -27,6 +27,7 @@ typedef struct AspeedSDMCState {
     uint32_t silicon_rev;
     uint32_t ram_bits;
     uint64_t ram_size;
+    uint32_t fixed_conf;
 
 } AspeedSDMCState;
 
-- 
2.17.1
