Received: from eggs.gnu.org ([2001:4830:134:3::10]:57765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fcXH4-00067W-27
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fcXH3-0001aB-6y
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 10:36:22 -0400
From: Andrew Jeffery <andrew@aj.id.au>
Date: Tue, 10 Jul 2018 00:05:24 +0930
Message-Id: <20180709143524.17480-1-andrew@aj.id.au>
Subject: [Qemu-devel] [PATCH] aspeed: Implement write-1-{set,
 clear} for AST2500 strapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: joel@jms.id.au, clg@kaod.org, peter.maydell@linaro.org, qemu-arm@nongnu.org, openbmc@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>

The AST2500 SoC family changes the runtime behaviour of the hardware
strapping register (SCU70) to write-1-set/write-1-clear, with
write-1-clear implemented on the "read-only" SoC revision register
(SCU7C). For the the AST2400, the hardware strapping is
runtime-configured with read-modify-write semantics.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/misc/aspeed_scu.c         | 19 +++++++++++++++++--
 include/hw/misc/aspeed_scu.h |  2 ++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 5e6d5744eeca..9051767cbbcd 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -202,11 +202,26 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
     case PROT_KEY:
         s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
         return;
-
+    case HW_STRAP1:
+        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
+            s->regs[HW_STRAP1] |= data;
+            return;
+        }
+        /* Jump to assignment below */
+        break;
+    case SILICON_REV:
+        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
+            s->regs[HW_STRAP1] &= ~data;
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
+                          __func__, offset);
+        }
+        /* Avoid assignment below, we've handled everything */
+        return;
     case FREQ_CNTR_EVAL:
     case VGA_SCRATCH1 ... VGA_SCRATCH8:
     case RNG_DATA:
-    case SILICON_REV:
     case FREE_CNTR4:
     case FREE_CNTR4_EXT:
         qemu_log_mask(LOG_GUEST_ERROR,
diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index d70cc0aeca61..169611a211bb 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -37,6 +37,8 @@ typedef struct AspeedSCUState {
 #define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
 
+#define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
+
 extern bool is_supported_silicon_rev(uint32_t silicon_rev);
 
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
-- 
2.17.1
