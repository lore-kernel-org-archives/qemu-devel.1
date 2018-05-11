Received: from eggs.gnu.org ([2001:4830:134:3::10]:52262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6v-0004iU-Ni
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6u-000693-OL
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:49 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38219)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGz6u-00068a-JB
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:48 -0400
Received: by mail-pl0-x241.google.com with SMTP id c11-v6so2507742plr.5
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:52:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 20:52:34 -0700
Message-Id: <20180511035240.4016-4-richard.henderson@linaro.org>
In-Reply-To: <20180511035240.4016-1-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/9] target/ppc: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

Cc: Alexander Graf <agraf@suse.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 2a4140f420..fd66c80cc7 100644
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
