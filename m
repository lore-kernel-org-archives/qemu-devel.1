Received: from eggs.gnu.org ([2001:4830:134:3::10]:52285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6x-0004py-TW
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6x-0006AA-3a
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:51 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGz6w-00069o-US
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:51 -0400
Received: by mail-pl0-x244.google.com with SMTP id ay10-v6so2508609plb.1
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:52:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 20:52:36 -0700
Message-Id: <20180511035240.4016-6-richard.henderson@linaro.org>
In-Reply-To: <20180511035240.4016-1-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 5/9] target/riscv: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Clark <mjc@sifive.com>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

Cc: Michael Clark <mjc@sifive.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e5a56d4e3..4612f324c9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -199,6 +199,10 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
     int i;
 
     cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "pc      ", env->pc);
+    if (flags & CPU_DUMP_FPU) {
+        cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "fcsr    ",
+                    cpu_riscv_get_fcsr(env));
+    }
 #ifndef CONFIG_USER_ONLY
     cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
     cpu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", env->mstatus);
@@ -219,11 +223,13 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f,
             cpu_fprintf(f, "\n");
         }
     }
-    for (i = 0; i < 32; i++) {
-        cpu_fprintf(f, " %s %016" PRIx64,
-            riscv_fpr_regnames[i], env->fpr[i]);
-        if ((i & 3) == 3) {
-            cpu_fprintf(f, "\n");
+    if (flags & CPU_DUMP_FPU) {
+        for (i = 0; i < 32; i++) {
+            cpu_fprintf(f, " %s %016" PRIx64,
+                riscv_fpr_regnames[i], env->fpr[i]);
+            if ((i & 3) == 3) {
+                cpu_fprintf(f, "\n");
+            }
         }
     }
 }
-- 
2.17.0
