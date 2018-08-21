Received: from eggs.gnu.org ([2001:4830:134:3::10]:50991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fs7cm-0003Rt-6c
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fs7cl-0000bd-88
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:12 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:45085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fs7ck-0000b4-Vt
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:27:11 -0400
Received: by mail-pf1-x433.google.com with SMTP id i26-v6so8575748pfo.12
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 07:27:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 21 Aug 2018 07:27:01 -0700
Message-Id: <20180821142704.18783-3-richard.henderson@linaro.org>
In-Reply-To: <20180821142704.18783-1-richard.henderson@linaro.org>
References: <20180821142704.18783-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 2/5] target/i386: Convert to HAVE_CMPXCHG128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org, pbonzini@redhat.com

Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/mem_helper.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/i386/mem_helper.c b/target/i386/mem_helper.c
index 30c26b9d9c..6cc53bcb40 100644
--- a/target/i386/mem_helper.c
+++ b/target/i386/mem_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "qemu/int128.h"
+#include "qemu/atomic128.h"
 #include "tcg.h"
 
 void helper_cmpxchg8b_unlocked(CPUX86State *env, target_ulong a0)
@@ -137,10 +138,7 @@ void helper_cmpxchg16b(CPUX86State *env, target_ulong a0)
 
     if ((a0 & 0xf) != 0) {
         raise_exception_ra(env, EXCP0D_GPF, ra);
-    } else {
-#ifndef CONFIG_ATOMIC128
-        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
-#else
+    } else if (HAVE_CMPXCHG128) {
         int eflags = cpu_cc_compute_all(env, CC_OP);
 
         Int128 cmpv = int128_make128(env->regs[R_EAX], env->regs[R_EDX]);
@@ -159,7 +157,8 @@ void helper_cmpxchg16b(CPUX86State *env, target_ulong a0)
             eflags &= ~CC_Z;
         }
         CC_SRC = eflags;
-#endif
+    } else {
+        cpu_loop_exit_atomic(ENV_GET_CPU(env), ra);
     }
 }
 #endif
-- 
2.17.1
