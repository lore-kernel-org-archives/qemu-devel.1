Received: from eggs.gnu.org ([2001:4830:134:3::10]:52316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz72-00054K-KO
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fGz6z-0006B8-RN
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:56 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:39680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fGz6z-0006Av-LQ
	for qemu-devel@nongnu.org; Thu, 10 May 2018 23:52:53 -0400
Received: by mail-pl0-x241.google.com with SMTP id c19-v6so2507530pls.6
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 20:52:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 May 2018 20:52:38 -0700
Message-Id: <20180511035240.4016-8-richard.henderson@linaro.org>
In-Reply-To: <20180511035240.4016-1-richard.henderson@linaro.org>
References: <20180511035240.4016-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 7/9] target/sparc: Honor CPU_DUMP_FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ff6ed91f9a..0f090ece54 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -647,15 +647,18 @@ void sparc_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
         }
     }
 
-    for (i = 0; i < TARGET_DPREGS; i++) {
-        if ((i & 3) == 0) {
-            cpu_fprintf(f, "%%f%02d: ", i * 2);
-        }
-        cpu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
-        if ((i & 3) == 3) {
-            cpu_fprintf(f, "\n");
+    if (flags & CPU_DUMP_FPU) {
+        for (i = 0; i < TARGET_DPREGS; i++) {
+            if ((i & 3) == 0) {
+                cpu_fprintf(f, "%%f%02d: ", i * 2);
+            }
+            cpu_fprintf(f, " %016" PRIx64, env->fpr[i].ll);
+            if ((i & 3) == 3) {
+                cpu_fprintf(f, "\n");
+            }
         }
     }
+
 #ifdef TARGET_SPARC64
     cpu_fprintf(f, "pstate: %08x ccr: %02x (icc: ", env->pstate,
                 (unsigned)cpu_get_ccr(env));
-- 
2.17.0
