Received: from eggs.gnu.org ([2001:4830:134:3::10]:52588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSS-00051a-GD
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSC-0004mW-UZ
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSC-0004l7-MS
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSB-0005Ve-Hx
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:11 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:46 +0100
Message-Id: <1504527967-29248-16-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 15/36] nvic: Implement "user accesses BusFault"
 SCS region behaviour
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The ARMv7M architecture specifies that most of the addresses in the
PPB region (which includes the NVIC, systick and system registers)
are not accessible to unprivileged accesses, which should
BusFault with a few exceptions:
 * the STIR is configurably user-accessible
 * the ITM (which we don't implement at all) is always
   user-accessible

Implement this by switching the register access functions
to the _with_attrs scheme that lets us distinguish user
mode accesses.

This allows us to pull the handling of the CCR.USERSETMPEND
flag up to the level where we can make it generate a BusFault
as it should for non-permitted accesses.

Note that until the core ARM CPU code implements turning
MEMTX_ERROR into a BusFault the registers will continue to
act as RAZ/WI to user accesses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 1501692241-23310-16-git-send-email-peter.maydell@linaro.org
---
 hw/intc/armv7m_nvic.c | 58 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 5a18025..bbfe2d5 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -733,11 +733,8 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
     }
     case 0xf00: /* Software Triggered Interrupt Register */
     {
-        /* user mode can only write to STIR if CCR.USERSETMPEND permits it */
         int excnum = (value & 0x1ff) + NVIC_FIRST_IRQ;
-        if (excnum < s->num_irq &&
-            (arm_current_el(&cpu->env) ||
-             (cpu->env.v7m.ccr & R_V7M_CCR_USERSETMPEND_MASK))) {
+        if (excnum < s->num_irq) {
             armv7m_nvic_set_pending(s, excnum);
         }
         break;
@@ -748,14 +745,32 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value)
     }
 }
 
-static uint64_t nvic_sysreg_read(void *opaque, hwaddr addr,
-                                 unsigned size)
+static bool nvic_user_access_ok(NVICState *s, hwaddr offset)
+{
+    /* Return true if unprivileged access to this register is permitted. */
+    switch (offset) {
+    case 0xf00: /* STIR: accessible only if CCR.USERSETMPEND permits */
+        return s->cpu->env.v7m.ccr & R_V7M_CCR_USERSETMPEND_MASK;
+    default:
+        /* All other user accesses cause a BusFault unconditionally */
+        return false;
+    }
+}
+
+static MemTxResult nvic_sysreg_read(void *opaque, hwaddr addr,
+                                    uint64_t *data, unsigned size,
+                                    MemTxAttrs attrs)
 {
     NVICState *s = (NVICState *)opaque;
     uint32_t offset = addr;
     unsigned i, startvec, end;
     uint32_t val;
 
+    if (attrs.user && !nvic_user_access_ok(s, addr)) {
+        /* Generate BusFault for unprivileged accesses */
+        return MEMTX_ERROR;
+    }
+
     switch (offset) {
     /* reads of set and clear both return the status */
     case 0x100 ... 0x13f: /* NVIC Set enable */
@@ -826,11 +841,13 @@ static uint64_t nvic_sysreg_read(void *opaque, hwaddr addr,
     }
 
     trace_nvic_sysreg_read(addr, val, size);
-    return val;
+    *data = val;
+    return MEMTX_OK;
 }
 
-static void nvic_sysreg_write(void *opaque, hwaddr addr,
-                              uint64_t value, unsigned size)
+static MemTxResult nvic_sysreg_write(void *opaque, hwaddr addr,
+                                     uint64_t value, unsigned size,
+                                     MemTxAttrs attrs)
 {
     NVICState *s = (NVICState *)opaque;
     uint32_t offset = addr;
@@ -839,6 +856,11 @@ static void nvic_sysreg_write(void *opaque, hwaddr addr,
 
     trace_nvic_sysreg_write(addr, value, size);
 
+    if (attrs.user && !nvic_user_access_ok(s, addr)) {
+        /* Generate BusFault for unprivileged accesses */
+        return MEMTX_ERROR;
+    }
+
     switch (offset) {
     case 0x100 ... 0x13f: /* NVIC Set enable */
         offset += 0x80;
@@ -853,7 +875,7 @@ static void nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return;
+        return MEMTX_OK;
     case 0x200 ... 0x23f: /* NVIC Set pend */
         /* the special logic in armv7m_nvic_set_pending()
          * is not needed since IRQs are never escalated
@@ -870,9 +892,9 @@ static void nvic_sysreg_write(void *opaque, hwaddr addr,
             }
         }
         nvic_irq_update(s);
-        return;
+        return MEMTX_OK;
     case 0x300 ... 0x33f: /* NVIC Active */
-        return; /* R/O */
+        return MEMTX_OK; /* R/O */
     case 0x400 ... 0x5ef: /* NVIC Priority */
         startvec = 8 * (offset - 0x400) + NVIC_FIRST_IRQ; /* vector # */
 
@@ -880,26 +902,28 @@ static void nvic_sysreg_write(void *opaque, hwaddr addr,
             set_prio(s, startvec + i, (value >> (i * 8)) & 0xff);
         }
         nvic_irq_update(s);
-        return;
+        return MEMTX_OK;
     case 0xd18 ... 0xd23: /* System Handler Priority.  */
         for (i = 0; i < size; i++) {
             unsigned hdlidx = (offset - 0xd14) + i;
             set_prio(s, hdlidx, (value >> (i * 8)) & 0xff);
         }
         nvic_irq_update(s);
-        return;
+        return MEMTX_OK;
     }
     if (size == 4) {
         nvic_writel(s, offset, value);
-        return;
+        return MEMTX_OK;
     }
     qemu_log_mask(LOG_GUEST_ERROR,
                   "NVIC: Bad write of size %d at offset 0x%x\n", size, offset);
+    /* This is UNPREDICTABLE; treat as RAZ/WI */
+    return MEMTX_OK;
 }
 
 static const MemoryRegionOps nvic_sysreg_ops = {
-    .read = nvic_sysreg_read,
-    .write = nvic_sysreg_write,
+    .read_with_attrs = nvic_sysreg_read,
+    .write_with_attrs = nvic_sysreg_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-- 
2.7.4
