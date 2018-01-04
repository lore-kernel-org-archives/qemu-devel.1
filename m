Received: from eggs.gnu.org ([2001:4830:134:3::10]:55459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bf-0007dq-DZ
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eX8bd-0003gN-Nr
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:03 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60482)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eX8bd-0003e8-BV
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 11:43:01 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu,  4 Jan 2018 17:42:51 +0100
Message-Id: <20180104164251.26494-18-laurent@vivier.eu>
In-Reply-To: <20180104164251.26494-1-laurent@vivier.eu>
References: <20180104164251.26494-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 17/17] target/m68k: fix m68k_cpu_dump_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Display correctly the Trace bits for 680x0
(2 bits instead of 1 for Coldfire).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20180104012913.30763-18-laurent@vivier.eu>
---
 target/m68k/cpu.h       | 3 ++-
 target/m68k/translate.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 759b30d389..2985b039e1 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -219,7 +219,8 @@ typedef enum {
 #define SR_I  0x0700
 #define SR_M  0x1000
 #define SR_S  0x2000
-#define SR_T  0x8000
+#define SR_T_SHIFT 14
+#define SR_T  0xc000
 
 #define M68K_SSP    0
 #define M68K_USP    1
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4d5173c4be..4a6d799ee2 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5936,9 +5936,12 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
     }
     cpu_fprintf (f, "PC = %08x   ", env->pc);
     sr = env->sr | cpu_m68k_get_ccr(env);
-    cpu_fprintf(f, "SR = %04x %c%c%c%c%c ", sr, (sr & CCF_X) ? 'X' : '-',
-                (sr & CCF_N) ? 'N' : '-', (sr & CCF_Z) ? 'Z' : '-',
-                (sr & CCF_V) ? 'V' : '-', (sr & CCF_C) ? 'C' : '-');
+    cpu_fprintf(f, "SR = %04x T:%x I:%x %c%c %c%c%c%c%c\n",
+                sr, (sr & SR_T) >> SR_T_SHIFT, (sr & SR_I) >> SR_I_SHIFT,
+                (sr & SR_S) ? 'S' : 'U', (sr & SR_M) ? '%' : 'I',
+                (sr & CCF_X) ? 'X' : '-', (sr & CCF_N) ? 'N' : '-',
+                (sr & CCF_Z) ? 'Z' : '-', (sr & CCF_V) ? 'V' : '-',
+                (sr & CCF_C) ? 'C' : '-');
     cpu_fprintf(f, "FPSR = %08x %c%c%c%c ", env->fpsr,
                 (env->fpsr & FPSR_CC_A) ? 'A' : '-',
                 (env->fpsr & FPSR_CC_I) ? 'I' : '-',
-- 
2.14.3
