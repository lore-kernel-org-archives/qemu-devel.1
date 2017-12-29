Received: from eggs.gnu.org ([2001:4830:134:3::10]:50513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCv-0002jf-HF
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eUoCu-0004Um-BN
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:53 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eUoCu-0004UH-3f
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 01:31:52 -0500
Received: by mail-pg0-x244.google.com with SMTP id r2so5321307pgq.13
	for <qemu-devel@nongnu.org>; Thu, 28 Dec 2017 22:31:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Dec 2017 22:31:09 -0800
Message-Id: <20171229063145.29167-3-richard.henderson@linaro.org>
In-Reply-To: <20171229063145.29167-1-richard.henderson@linaro.org>
References: <20171229063145.29167-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 02/38] target/hppa: Define the rest of the PSW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de

We don't actually do anything with most of the bits yet,
but at least they have names and we have somewhere to
store them.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h    | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 target/hppa/helper.c | 53 ++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 7fad92144c..ea7e495408 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -46,6 +46,52 @@
 #define EXCP_SIGILL      4
 #define EXCP_SIGFPE      5
 
+/* Taken from Linux kernel: arch/parisc/include/asm/psw.h */
+#define PSW_I            0x00000001
+#define PSW_D            0x00000002
+#define PSW_P            0x00000004
+#define PSW_Q            0x00000008
+#define PSW_R            0x00000010
+#define PSW_F            0x00000020
+#define PSW_G            0x00000040 /* PA1.x only */
+#define PSW_O            0x00000080 /* PA2.0 only */
+#define PSW_CB           0x0000ff00
+#define PSW_M            0x00010000
+#define PSW_V            0x00020000
+#define PSW_C            0x00040000
+#define PSW_B            0x00080000
+#define PSW_X            0x00100000
+#define PSW_N            0x00200000
+#define PSW_L            0x00400000
+#define PSW_H            0x00800000
+#define PSW_T            0x01000000
+#define PSW_S            0x02000000
+#define PSW_E            0x04000000
+#ifdef TARGET_HPPA64
+#define PSW_W            0x08000000 /* PA2.0 only */
+#else
+#define PSW_W            0
+#endif
+#define PSW_Z            0x40000000 /* PA1.x only */
+#define PSW_Y            0x80000000 /* PA1.x only */
+
+#define PSW_SM (PSW_W | PSW_E | PSW_O | PSW_G | PSW_F \
+               | PSW_R | PSW_Q | PSW_P | PSW_D | PSW_I)
+
+/* ssm/rsm instructions number PSW_W and PSW_E differently */
+#define PSW_SM_I         PSW_I      /* Enable External Interrupts */
+#define PSW_SM_D         PSW_D
+#define PSW_SM_P         PSW_P
+#define PSW_SM_Q         PSW_Q      /* Enable Interrupt State Collection */
+#define PSW_SM_R         PSW_R      /* Enable Recover Counter Trap */
+#ifdef TARGET_HPPA64
+#define PSW_SM_E         0x100
+#define PSW_SM_W         0x200      /* PA2.0 only : Enable Wide Mode */
+#else
+#define PSW_SM_E         0
+#define PSW_SM_W         0
+#endif
+
 typedef struct CPUHPPAState CPUHPPAState;
 
 struct CPUHPPAState {
@@ -56,6 +102,7 @@ struct CPUHPPAState {
     target_ulong cr26;
     target_ulong cr27;
 
+    target_long  psw;        /* All psw bits except the following:  */
     target_ulong psw_n;      /* boolean */
     target_long  psw_v;      /* in most significant bit */
 
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index d6d6f06cb0..4231ef3bff 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -39,10 +39,11 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
     /* .........................bcdefgh */
     psw |= (psw >> 12) & 0xf;
     psw |= env->psw_cb_msb << 7;
-    psw <<= 8;
+    psw = (psw & 0xff) << 8;
 
-    psw |= env->psw_n << 21;
-    psw |= (env->psw_v < 0) << 17;
+    psw |= env->psw_n * PSW_N;
+    psw |= (env->psw_v < 0) * PSW_V;
+    psw |= env->psw;
 
     return psw;
 }
@@ -51,8 +52,9 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulong psw)
 {
     target_ulong cb = 0;
 
-    env->psw_n = (psw >> 21) & 1;
-    env->psw_v = -((psw >> 17) & 1);
+    env->psw = psw & ~(PSW_N | PSW_V | PSW_CB);
+    env->psw_n = (psw / PSW_N) & 1;
+    env->psw_v = -((psw / PSW_V) & 1);
     env->psw_cb_msb = (psw >> 15) & 1;
 
     cb |= ((psw >> 14) & 1) << 28;
@@ -106,22 +108,45 @@ void hppa_cpu_dump_state(CPUState *cs, FILE *f,
 {
     HPPACPU *cpu = HPPA_CPU(cs);
     CPUHPPAState *env = &cpu->env;
+    target_ulong psw = cpu_hppa_get_psw(env);
+    target_ulong psw_cb;
+    char psw_c[20];
     int i;
 
-    cpu_fprintf(f, "IA_F " TARGET_FMT_lx
-                   " IA_B " TARGET_FMT_lx
-                   " PSW  " TARGET_FMT_lx
-                   " [N:" TARGET_FMT_ld " V:%d"
-                   " CB:" TARGET_FMT_lx "]\n              ",
-                env->iaoq_f, env->iaoq_b, cpu_hppa_get_psw(env),
-                env->psw_n, env->psw_v < 0,
-                ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28));
-    for (i = 1; i < 32; i++) {
+    cpu_fprintf(f, "IA_F " TARGET_FMT_lx " IA_B " TARGET_FMT_lx "\n",
+                env->iaoq_f, env->iaoq_b);
+
+    psw_c[0]  = (psw & PSW_W ? 'W' : '-');
+    psw_c[1]  = (psw & PSW_E ? 'E' : '-');
+    psw_c[2]  = (psw & PSW_S ? 'S' : '-');
+    psw_c[3]  = (psw & PSW_T ? 'T' : '-');
+    psw_c[4]  = (psw & PSW_H ? 'H' : '-');
+    psw_c[5]  = (psw & PSW_L ? 'L' : '-');
+    psw_c[6]  = (psw & PSW_N ? 'N' : '-');
+    psw_c[7]  = (psw & PSW_X ? 'X' : '-');
+    psw_c[8]  = (psw & PSW_B ? 'B' : '-');
+    psw_c[9]  = (psw & PSW_C ? 'C' : '-');
+    psw_c[10] = (psw & PSW_V ? 'V' : '-');
+    psw_c[11] = (psw & PSW_M ? 'M' : '-');
+    psw_c[12] = (psw & PSW_F ? 'F' : '-');
+    psw_c[13] = (psw & PSW_R ? 'R' : '-');
+    psw_c[14] = (psw & PSW_Q ? 'Q' : '-');
+    psw_c[15] = (psw & PSW_P ? 'P' : '-');
+    psw_c[16] = (psw & PSW_D ? 'D' : '-');
+    psw_c[17] = (psw & PSW_I ? 'I' : '-');
+    psw_c[18] = '\0';
+    psw_cb = ((env->psw_cb >> 4) & 0x01111111) | (env->psw_cb_msb << 28);
+
+    cpu_fprintf(f, "PSW  " TARGET_FMT_lx " CB   " TARGET_FMT_lx " %s\n",
+                psw, psw_cb, psw_c);
+
+    for (i = 0; i < 32; i++) {
         cpu_fprintf(f, "GR%02d " TARGET_FMT_lx " ", i, env->gr[i]);
         if ((i % 4) == 3) {
             cpu_fprintf(f, "\n");
         }
     }
+    cpu_fprintf(f, "\n");
 
     /* ??? FR */
 }
-- 
2.14.3
