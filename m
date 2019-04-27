Received: from eggs.gnu.org ([209.51.188.92]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBZs-0005He-1T
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBYv-0000zx-9C
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:30 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hKBYv-0000zY-2X
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:29 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so2494108pfd.1
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 17:51:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	b20sm5301745pff.118.2019.04.26.17.51.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 17:51:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 17:51:23 -0700
Message-Id: <20190427005124.12756-2-richard.henderson@linaro.org>
In-Reply-To: <20190427005124.12756-1-richard.henderson@linaro.org>
References: <20190427005124.12756-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] target/alpha: Clean up alpha_cpu_dump_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Drop the "RI" and "FIR" prefixes; use only the normal linux names.
Add the FPCR to the dump.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 7201576aae..31de9593b6 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -429,32 +429,33 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 
 void alpha_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 {
-    static const char *linux_reg_names[] = {
-        "v0 ", "t0 ", "t1 ", "t2 ", "t3 ", "t4 ", "t5 ", "t6 ",
-        "t7 ", "s0 ", "s1 ", "s2 ", "s3 ", "s4 ", "s5 ", "fp ",
-        "a0 ", "a1 ", "a2 ", "a3 ", "a4 ", "a5 ", "t8 ", "t9 ",
-        "t10", "t11", "ra ", "t12", "at ", "gp ", "sp ", "zero",
+    static const char linux_reg_names[31][4] = {
+        "v0",  "t0",  "t1", "t2",  "t3", "t4", "t5", "t6",
+        "t7",  "s0",  "s1", "s2",  "s3", "s4", "s5", "fp",
+        "a0",  "a1",  "a2", "a3",  "a4", "a5", "t8", "t9",
+        "t10", "t11", "ra", "t12", "at", "gp", "sp"
     };
     AlphaCPU *cpu = ALPHA_CPU(cs);
     CPUAlphaState *env = &cpu->env;
     int i;
 
-    qemu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
+    qemu_fprintf(f, "PC      " TARGET_FMT_lx " PS      %02x\n",
                  env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
     for (i = 0; i < 31; i++) {
-        qemu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
+        qemu_fprintf(f, "%-8s" TARGET_FMT_lx "%c",
                      linux_reg_names[i], cpu_alpha_load_gr(env, i),
                      (i % 3) == 2 ? '\n' : ' ');
     }
 
-    qemu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
+    qemu_fprintf(f, "lock_a  " TARGET_FMT_lx " lock_v  " TARGET_FMT_lx "\n",
                  env->lock_addr, env->lock_value);
 
     if (flags & CPU_DUMP_FPU) {
         for (i = 0; i < 31; i++) {
-            qemu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],
+            qemu_fprintf(f, "f%-7d%016" PRIx64 "%c", i, env->fir[i],
                          (i % 3) == 2 ? '\n' : ' ');
         }
+        qemu_fprintf(f, "fpcr    %016" PRIx64 "\n", cpu_alpha_load_fpcr(env));
     }
     qemu_fprintf(f, "\n");
 }
-- 
2.17.1
