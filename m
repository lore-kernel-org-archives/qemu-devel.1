Received: from eggs.gnu.org ([209.51.188.92]:55934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1gouyw-0000n2-Bq
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1gouyv-0002lm-GW
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:53:06 -0500
From: Fabien Chouteau <chouteau@adacore.com>
Date: Wed, 30 Jan 2019 19:52:42 +0100
Message-Id: <20190130185242.12490-1-chouteau@adacore.com>
Subject: [Qemu-devel] [PATCH] hw/riscv/sifive_clint.c: avoid integer
 overflow in timecmp write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fabien Chouteau <chouteau@adacore.com>, Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "open list:RISC-V" <qemu-riscv@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Writing a high value in timecmp leads to an integer overflow. This patch
modifies the code to detect such case, and use the maximum integer value
as the next trigger for the timer.

Signed-off-by: Fabien Chouteau <chouteau@adacore.com>
---
 hw/riscv/sifive_clint.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
index d4c159e937..1ca1f8c75e 100644
--- a/hw/riscv/sifive_clint.c
+++ b/hw/riscv/sifive_clint.c
@@ -38,8 +38,10 @@ static uint64_t cpu_riscv_read_rtc(void)
  */
 static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
 {
-    uint64_t next;
     uint64_t diff;
+    uint64_t lapse_ns;
+    uint64_t clock_ns;
+    int64_t  next_ns;
 
     uint64_t rtc_r = cpu_riscv_read_rtc();
 
@@ -54,10 +56,29 @@ static void sifive_clint_write_timecmp(RISCVCPU *cpu, uint64_t value)
     /* otherwise, set up the future timer interrupt */
     riscv_cpu_update_mip(cpu, MIP_MTIP, BOOL_TO_MASK(0));
     diff = cpu->env.timecmp - rtc_r;
-    /* back to ns (note args switched in muldiv64) */
-    next = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
-        muldiv64(diff, NANOSECONDS_PER_SECOND, SIFIVE_CLINT_TIMEBASE_FREQ);
-    timer_mod(cpu->env.timer, next);
+
+    /*
+     * How many nanoseconds until the next trigger (note args switched in
+     * muldiv64)
+     */
+    lapse_ns = muldiv64(diff,
+                        NANOSECONDS_PER_SECOND,
+                        SIFIVE_CLINT_TIMEBASE_FREQ);
+
+    /* Current time in nanoseconds */
+    clock_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+
+    if ((G_MAXINT64 - clock_ns) <= lapse_ns) {
+        /*
+         * clock + lapse would overflow on 64bit. The highest 64bit value is
+         * used as the next trigger time.
+         */
+        next_ns = G_MAXINT64;
+    } else {
+        next_ns = clock_ns + lapse_ns;
+    }
+
+    timer_mod(cpu->env.timer, next_ns);
 }
 
 /*
-- 
2.17.1
