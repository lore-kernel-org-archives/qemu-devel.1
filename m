Received: from eggs.gnu.org ([2001:4830:134:3::10]:55327)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNg-0000FW-9y
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJnNf-0003XY-4Q
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:44 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:37278)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJnNe-0003XS-UU
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:57:43 -0400
Received: by mail-pl0-x22e.google.com with SMTP id w19-v6so5311674plq.4
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 14:57:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 18 May 2018 14:57:29 -0700
Message-Id: <20180518215734.18833-4-richard.henderson@linaro.org>
In-Reply-To: <20180518215734.18833-1-richard.henderson@linaro.org>
References: <20180518215734.18833-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 3/8] target/ppc: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Cc: Alexander Graf <agraf@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index d5e5f953da..e30d99fcbc 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7048,14 +7048,20 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     }
     cpu_fprintf(f, " ]             RES " TARGET_FMT_lx "\n",
                 env->reserve_addr);
-    for (i = 0; i < 32; i++) {
-        if ((i & (RFPL - 1)) == 0)
-            cpu_fprintf(f, "FPR%02d", i);
-        cpu_fprintf(f, " %016" PRIx64, *((uint64_t *)&env->fpr[i]));
-        if ((i & (RFPL - 1)) == (RFPL - 1))
-            cpu_fprintf(f, "\n");
+
+    if (flags & CPU_DUMP_FPU) {
+        for (i = 0; i < 32; i++) {
+            if ((i & (RFPL - 1)) == 0) {
+                cpu_fprintf(f, "FPR%02d", i);
+            }
+            cpu_fprintf(f, " %016" PRIx64, *((uint64_t *)&env->fpr[i]));
+            if ((i & (RFPL - 1)) == (RFPL - 1)) {
+                cpu_fprintf(f, "\n");
+            }
+        }
+        cpu_fprintf(f, "FPSCR " TARGET_FMT_lx "\n", env->fpscr);
     }
-    cpu_fprintf(f, "FPSCR " TARGET_FMT_lx "\n", env->fpscr);
+
 #if !defined(CONFIG_USER_ONLY)
     cpu_fprintf(f, " SRR0 " TARGET_FMT_lx "  SRR1 " TARGET_FMT_lx
                    "    PVR " TARGET_FMT_lx " VRSAVE " TARGET_FMT_lx "\n",
-- 
2.17.0
