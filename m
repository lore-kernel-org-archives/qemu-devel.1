Received: from eggs.gnu.org ([2001:4830:134:3::10]:47593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPt-00011Q-W0
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPr-0005E0-Kl
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:17 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cUDPr-00059u-8V
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:10:15 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cUDPc-00036l-91
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 14:10:00 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 14:09:28 +0000
Message-Id: <1484834995-26826-10-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/36] aspeed/smc: rework the prototype of the
 AspeedSMCFlash helper routines
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

Change the routines prototype to use a 'AspeedSMCFlash *' instead of
'AspeedSMCState *'. The result will help in making future changes
clearer.

Also change aspeed_smc_update_cs() which uselessly loops on all slave
devices to update their status.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Message-id: 1483979087-32663-4-git-send-email-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/ssi/aspeed_smc.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 205c0ab..9b31d5d 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -328,19 +328,23 @@ static const MemoryRegionOps aspeed_smc_flash_default_ops = {
     },
 };
 
-static inline int aspeed_smc_flash_mode(const AspeedSMCState *s, int cs)
+static inline int aspeed_smc_flash_mode(const AspeedSMCFlash *fl)
 {
-    return s->regs[s->r_ctrl0 + cs] & CTRL_CMD_MODE_MASK;
+    const AspeedSMCState *s = fl->controller;
+
+    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CMD_MODE_MASK;
 }
 
-static inline bool aspeed_smc_is_usermode(const AspeedSMCState *s, int cs)
+static inline bool aspeed_smc_is_usermode(const AspeedSMCFlash *fl)
 {
-    return aspeed_smc_flash_mode(s, cs) == CTRL_USERMODE;
+    return aspeed_smc_flash_mode(fl) == CTRL_USERMODE;
 }
 
-static inline bool aspeed_smc_is_writable(const AspeedSMCState *s, int cs)
+static inline bool aspeed_smc_is_writable(const AspeedSMCFlash *fl)
 {
-    return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + cs));
+    const AspeedSMCState *s = fl->controller;
+
+    return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + fl->id));
 }
 
 static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
@@ -350,7 +354,7 @@ static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigned size)
     uint64_t ret = 0;
     int i;
 
-    if (aspeed_smc_is_usermode(s, fl->id)) {
+    if (aspeed_smc_is_usermode(fl)) {
         for (i = 0; i < size; i++) {
             ret |= ssi_transfer(s->spi, 0x0) << (8 * i);
         }
@@ -370,13 +374,13 @@ static void aspeed_smc_flash_write(void *opaque, hwaddr addr, uint64_t data,
     const AspeedSMCState *s = fl->controller;
     int i;
 
-    if (!aspeed_smc_is_writable(s, fl->id)) {
+    if (!aspeed_smc_is_writable(fl)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: flash is not writable at 0x%"
                       HWADDR_PRIx "\n", __func__, addr);
         return;
     }
 
-    if (!aspeed_smc_is_usermode(s, fl->id)) {
+    if (!aspeed_smc_is_usermode(fl)) {
         qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
                       __func__);
         return;
@@ -397,18 +401,18 @@ static const MemoryRegionOps aspeed_smc_flash_ops = {
     },
 };
 
-static bool aspeed_smc_is_ce_stop_active(const AspeedSMCState *s, int cs)
+static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl)
 {
-    return s->regs[s->r_ctrl0 + cs] & CTRL_CE_STOP_ACTIVE;
+    const AspeedSMCState *s = fl->controller;
+
+    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
 }
 
-static void aspeed_smc_update_cs(const AspeedSMCState *s)
+static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
 {
-    int i;
+    const AspeedSMCState *s = fl->controller;
 
-    for (i = 0; i < s->num_cs; ++i) {
-        qemu_set_irq(s->cs_lines[i], aspeed_smc_is_ce_stop_active(s, i));
-    }
+    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
 }
 
 static void aspeed_smc_reset(DeviceState *d)
@@ -481,8 +485,9 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
         addr == s->r_ce_ctrl) {
         s->regs[addr] = value;
     } else if (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs) {
+        int cs = addr - s->r_ctrl0;
         s->regs[addr] = value;
-        aspeed_smc_update_cs(s);
+        aspeed_smc_flash_update_cs(&s->flashes[cs]);
     } else if (addr >= R_SEG_ADDR0 &&
                addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
         int cs = addr - R_SEG_ADDR0;
-- 
2.7.4
