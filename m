Received: from eggs.gnu.org ([2001:4830:134:3::10]:57085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbsDj-0006cX-MR
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cbsDe-0002av-TA
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:23 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:35382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cbsDe-0002aY-Bp
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:09:18 -0500
Received: by mail-wm0-x232.google.com with SMTP id v186so87645822wmd.0
	for <qemu-devel@nongnu.org>; Thu, 09 Feb 2017 09:09:18 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  9 Feb 2017 17:09:03 +0000
Message-Id: <20170209170904.5713-24-alex.bennee@linaro.org>
In-Reply-To: <20170209170904.5713-1-alex.bennee@linaro.org>
References: <20170209170904.5713-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v11 23/24] hw/misc/imx6_src: defer clearing of
 SRC_SCR reset bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net
Cc: mttcg@listserver.greensocs.com, qemu-devel@nongnu.org, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, mark.burton@greensocs.com, pbonzini@redhat.com, jan.kiszka@siemens.com, serge.fdrv@gmail.com, bamvor.zhangjian@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Chubb <peter.chubb@nicta.com.au>, "open list:i.MX31" <qemu-arm@nongnu.org>

The arm_reset_cpu/set_cpu_on/set_cpu_off() functions do their work
asynchronously in the target vCPUs context. As a result we need to
ensure the SRC_SCR reset bits correctly report the reset status at the
right time. To do this we defer the clearing of the bit with an async
job which will run after the work queued by ARM powerctl functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/misc/imx6_src.c | 58 +++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/hw/misc/imx6_src.c b/hw/misc/imx6_src.c
index 55b817b8d7..f7c1d94a3e 100644
--- a/hw/misc/imx6_src.c
+++ b/hw/misc/imx6_src.c
@@ -14,6 +14,7 @@
 #include "qemu/bitops.h"
 #include "qemu/log.h"
 #include "arm-powerctl.h"
+#include "qom/cpu.h"
 
 #ifndef DEBUG_IMX6_SRC
 #define DEBUG_IMX6_SRC 0
@@ -113,6 +114,45 @@ static uint64_t imx6_src_read(void *opaque, hwaddr offset, unsigned size)
     return value;
 }
 
+
+/* The reset is asynchronous so we need to defer clearing the reset
+ * bit until the work is completed.
+ */
+
+struct src_scr_reset_info {
+    IMX6SRCState *s;
+    unsigned long reset_bit;
+};
+
+static void imx6_clear_reset_bit(CPUState *cpu, run_on_cpu_data data)
+{
+    struct src_scr_reset_info *ri = data.host_ptr;
+    IMX6SRCState *s = ri->s;
+
+    assert(qemu_mutex_iothread_locked());
+
+    s->regs[SRC_SCR] = deposit32(s->regs[SRC_SCR], ri->reset_bit, 1, 0);
+    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n",
+            imx6_src_reg_name(SRC_SCR), s->regs[SRC_SCR]);
+
+    g_free(ri);
+}
+
+static void imx6_defer_clear_reset_bit(int cpuid,
+                                       IMX6SRCState *s,
+                                       unsigned long reset_shift)
+{
+    struct src_scr_reset_info *ri;
+
+    ri = g_malloc(sizeof(struct src_scr_reset_info));
+    ri->s = s;
+    ri->reset_bit = reset_shift;
+
+    async_run_on_cpu(arm_get_cpu_by_id(cpuid), imx6_clear_reset_bit,
+                     RUN_ON_CPU_HOST_PTR(ri));
+}
+
+
 static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
@@ -153,7 +193,7 @@ static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
                 arm_set_cpu_off(3);
             }
             /* We clear the reset bits as the processor changed state */
-            clear_bit(CORE3_RST_SHIFT, &current_value);
+            imx6_defer_clear_reset_bit(3, s, CORE3_RST_SHIFT);
             clear_bit(CORE3_RST_SHIFT, &change_mask);
         }
         if (EXTRACT(change_mask, CORE2_ENABLE)) {
@@ -162,11 +202,11 @@ static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
                 arm_set_cpu_on(2, s->regs[SRC_GPR5], s->regs[SRC_GPR6],
                                3, false);
             } else {
-                /* CORE 3 is shut down */
+                /* CORE 2 is shut down */
                 arm_set_cpu_off(2);
             }
             /* We clear the reset bits as the processor changed state */
-            clear_bit(CORE2_RST_SHIFT, &current_value);
+            imx6_defer_clear_reset_bit(2, s, CORE2_RST_SHIFT);
             clear_bit(CORE2_RST_SHIFT, &change_mask);
         }
         if (EXTRACT(change_mask, CORE1_ENABLE)) {
@@ -175,28 +215,28 @@ static void imx6_src_write(void *opaque, hwaddr offset, uint64_t value,
                 arm_set_cpu_on(1, s->regs[SRC_GPR3], s->regs[SRC_GPR4],
                                3, false);
             } else {
-                /* CORE 3 is shut down */
+                /* CORE 1 is shut down */
                 arm_set_cpu_off(1);
             }
             /* We clear the reset bits as the processor changed state */
-            clear_bit(CORE1_RST_SHIFT, &current_value);
+            imx6_defer_clear_reset_bit(1, s, CORE1_RST_SHIFT);
             clear_bit(CORE1_RST_SHIFT, &change_mask);
         }
         if (EXTRACT(change_mask, CORE0_RST)) {
             arm_reset_cpu(0);
-            clear_bit(CORE0_RST_SHIFT, &current_value);
+            imx6_defer_clear_reset_bit(0, s, CORE0_RST_SHIFT);
         }
         if (EXTRACT(change_mask, CORE1_RST)) {
             arm_reset_cpu(1);
-            clear_bit(CORE1_RST_SHIFT, &current_value);
+            imx6_defer_clear_reset_bit(1, s, CORE1_RST_SHIFT);
         }
         if (EXTRACT(change_mask, CORE2_RST)) {
             arm_reset_cpu(2);
-            clear_bit(CORE2_RST_SHIFT, &current_value);
+            imx6_defer_clear_reset_bit(2, s, CORE2_RST_SHIFT);
         }
         if (EXTRACT(change_mask, CORE3_RST)) {
             arm_reset_cpu(3);
-            clear_bit(CORE3_RST_SHIFT, &current_value);
+            imx6_defer_clear_reset_bit(3, s, CORE3_RST_SHIFT);
         }
         if (EXTRACT(change_mask, SW_IPU2_RST)) {
             /* We pretend the IPU2 is reset */
-- 
2.11.0
