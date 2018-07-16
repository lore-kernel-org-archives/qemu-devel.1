Received: from eggs.gnu.org ([2001:4830:134:3::10]:50629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aX-0008TT-M5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aW-0005Z2-PO
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:05 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:43586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ff6aW-0005YP-H1
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 12:43:04 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1ff6aV-0000zQ-3A
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 17:43:03 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jul 2018 17:42:54 +0100
Message-Id: <20180716164300.6731-3-peter.maydell@linaro.org>
In-Reply-To: <20180716164300.6731-1-peter.maydell@linaro.org>
References: <20180716164300.6731-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 2/8] aspeed: Implement write-1-{set,
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

From: Andrew Jeffery <andrew@aj.id.au>

The AST2500 SoC family changes the runtime behaviour of the hardware
strapping register (SCU70) to write-1-set/write-1-clear, with
write-1-clear implemented on the "read-only" SoC revision register
(SCU7C). For the the AST2400, the hardware strapping is
runtime-configured with read-modify-write semantics.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20180709143524.17480-1-andrew@aj.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/aspeed_scu.h |  2 ++
 hw/misc/aspeed_scu.c         | 19 +++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index f662c38188f..38996adc59f 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -41,6 +41,8 @@ typedef struct AspeedSCUState {
 #define AST2500_A0_SILICON_REV   0x04000303U
 #define AST2500_A1_SILICON_REV   0x04010303U
 
+#define ASPEED_IS_AST2500(si_rev)     ((((si_rev) >> 24) & 0xff) == 0x04)
+
 extern bool is_supported_silicon_rev(uint32_t silicon_rev);
 
 #define ASPEED_SCU_PROT_KEY      0x1688A8A8
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 59333b50abd..c8217740efc 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -247,11 +247,26 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
         s->regs[reg] = data;
         aspeed_scu_set_apb_freq(s);
         break;
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
-- 
2.17.1
