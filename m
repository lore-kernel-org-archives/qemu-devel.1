Received: from eggs.gnu.org ([2001:4830:134:3::10]:36133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6L-0001YB-QO
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eWB6K-00059F-Sl
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:45 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:55851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eWB6K-00058N-JG
	for qemu-devel@nongnu.org; Mon, 01 Jan 2018 20:10:44 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  2 Jan 2018 02:10:32 +0100
Message-Id: <20180102011032.30056-18-laurent@vivier.eu>
In-Reply-To: <20180102011032.30056-1-laurent@vivier.eu>
References: <20180102011032.30056-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH v5 17/17] target/m68k: fix m68k_cpu_dump_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>

Display correctly the Trace bits for 680x0
(2 bits instead of 1 for Coldfire).

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/m68k/cpu.h       | 3 ++-
 target/m68k/translate.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index fdb780c81c..41714d8fd6 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -218,7 +218,8 @@ typedef enum {
 #define SR_I  0x0700
 #define SR_M  0x1000
 #define SR_S  0x2000
-#define SR_T  0x8000
+#define SR_T_SHIFT 14
+#define SR_T  0xc000
 
 #define M68K_SSP    0
 #define M68K_USP    1
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index bd43e60a23..a7937de8d0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -5997,9 +5997,12 @@ void m68k_cpu_dump_state(CPUState *cs, FILE *f, fprintf_function cpu_fprintf,
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
