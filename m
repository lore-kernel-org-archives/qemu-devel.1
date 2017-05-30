Received: from eggs.gnu.org ([2001:4830:134:3::10]:55718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFmcc-0005Zl-H5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFmcb-0007fT-H1
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:02 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:52284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFmcb-0007en-BI
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 30 May 2017 21:15:52 +0200
Message-Id: <20170530191553.31500-5-aurelien@aurel32.net>
In-Reply-To: <20170530191553.31500-1-aurelien@aurel32.net>
References: <20170530191553.31500-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 4/5] target/sh4: ignore interrupts in a delay
 slot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

Delay slots are indivisible, therefore avoid scheduling an interrupt in
the delay slot. However exceptions are possible.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 5785d6d22a..28d93c2543 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -871,8 +871,16 @@ int cpu_sh4_is_cached(CPUSH4State * env, target_ulong addr)
 bool superh_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     if (interrupt_request & CPU_INTERRUPT_HARD) {
-        superh_cpu_do_interrupt(cs);
-        return true;
+        SuperHCPU *cpu = SUPERH_CPU(cs);
+        CPUSH4State *env = &cpu->env;
+
+        /* Delay slots are indivisible, ignore interrupts */
+        if (env->flags & DELAY_SLOT_MASK) {
+            return false;
+        } else {
+            superh_cpu_do_interrupt(cs);
+            return true;
+        }
     }
     return false;
 }
-- 
2.11.0
