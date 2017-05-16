Received: from eggs.gnu.org ([2001:4830:134:3::10]:46825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFa-0002Hm-0L
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dAlFZ-0005JE-8a
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:30 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:45088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dAlFZ-0005Ib-1t
	for qemu-devel@nongnu.org; Tue, 16 May 2017 18:47:29 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 17 May 2017 00:47:20 +0200
Message-Id: <20170516224721.13832-5-aurelien@aurel32.net>
In-Reply-To: <20170516224721.13832-1-aurelien@aurel32.net>
References: <20170516224721.13832-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PATCH 4/5] target/sh4: ignore interrupts in a delay
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
Cc: Aurelien Jarno <aurelien@aurel32.net>

Delay slots are indivisible, therefore avoid scheduling an interrupt in
the delay slot. However exceptions are possible.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/helper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index d420931530..19d4ec5fb5 100644
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
