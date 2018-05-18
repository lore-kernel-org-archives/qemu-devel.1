Received: from eggs.gnu.org ([2001:4830:134:3::10]:55319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNf-0000FU-Te
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNc-0003X1-1e
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:43 -0400
Received: from mail-pl0-x22d.google.com ([2607:f8b0:400e:c01::22d]:46593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNb-0003Ws-S6
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:39 -0400
Received: by mail-pl0-x22d.google.com with SMTP id 30-v6so5293427pld.13
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:27 -0700
Message-Id: <20180518215734.18833-2-richard.henderson@linaro.org>
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/8] target/alpha: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 8a6a948572..57e2c212b3 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -442,20 +442,19 @@ void alpha_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     cpu_fprintf(f, "     PC  " TARGET_FMT_lx "      PS  %02x\n",
                 env->pc, extract32(env->flags, ENV_FLAG_PS_SHIFT, 8));
     for (i = 0; i < 31; i++) {
-        cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx " ", i,
-                    linux_reg_names[i], cpu_alpha_load_gr(env, i));
-        if ((i % 3) == 2)
-            cpu_fprintf(f, "\n");
+        cpu_fprintf(f, "IR%02d %s " TARGET_FMT_lx "%c", i,
+                    linux_reg_names[i], cpu_alpha_load_gr(env, i),
+                    (i % 3) == 2 ? '\n' : ' ');
     }
 
     cpu_fprintf(f, "lock_a   " TARGET_FMT_lx " lock_v   " TARGET_FMT_lx "\n",
                 env->lock_addr, env->lock_value);
 
-    for (i = 0; i < 31; i++) {
-        cpu_fprintf(f, "FIR%02d    " TARGET_FMT_lx " ", i,
-                    *((uint64_t *)(&env->fir[i])));
-        if ((i % 3) == 2)
-            cpu_fprintf(f, "\n");
+    if (flags & CPU_DUMP_FPU) {
+        for (i = 0; i < 31; i++) {
+            cpu_fprintf(f, "FIR%02d    %016" PRIx64 "%c", i, env->fir[i],
+                        (i % 3) == 2 ? '\n' : ' ');
+        }
     }
     cpu_fprintf(f, "\n");
 }
-- 
2.17.0
