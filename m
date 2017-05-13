Received: from eggs.gnu.org ([2001:4830:134:3::10]:37138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQC-0005Az-CP
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9TQA-0001MD-Ri
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:08 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:43768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9TQA-0001HC-I0
	for qemu-devel@nongnu.org; Sat, 13 May 2017 05:33:06 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Sat, 13 May 2017 11:32:48 +0200
Message-Id: <20170513093248.18230-16-aurelien@aurel32.net>
In-Reply-To: <20170513093248.18230-1-aurelien@aurel32.net>
References: <20170513093248.18230-1-aurelien@aurel32.net>
Subject: [Qemu-devel] [PULL 15/15] target/sh4: use cpu_loop_exit_restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

Use cpu_loop_exit_restore when using cpu_restore_state and cpu_loop_exit
together.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/op_helper.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index fa238c660e..528a40ac1d 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -48,10 +48,7 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAccessType access_type,
     ret = superh_cpu_handle_mmu_fault(cs, addr, access_type, mmu_idx);
     if (ret) {
         /* now we have a real cpu fault */
-        if (retaddr) {
-            cpu_restore_state(cs, retaddr);
-        }
-        cpu_loop_exit(cs);
+        cpu_loop_exit_restore(cs, retaddr);
     }
 }
 
@@ -75,10 +72,7 @@ static inline void QEMU_NORETURN raise_exception(CPUSH4State *env, int index,
     CPUState *cs = CPU(sh_env_get_cpu(env));
 
     cs->exception_index = index;
-    if (retaddr) {
-        cpu_restore_state(cs, retaddr);
-    }
-    cpu_loop_exit(cs);
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 void helper_raise_illegal_instruction(CPUSH4State *env)
-- 
2.11.0
