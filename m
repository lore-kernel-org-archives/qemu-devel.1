Received: from eggs.gnu.org ([2001:4830:134:3::10]:60284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMN-0001gp-S7
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMM-0007wL-Ll
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:03 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:34571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMM-0007w8-Gx
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:02 -0400
Received: by mail-qk0-x244.google.com with SMTP id 91so969192qkq.1
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:23:02 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:38 -0700
Message-Id: <20170623162241.8964-13-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/15] target/s390x: Clean up TB flag bits
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

Most of the PSW bits that were being copied into TB->flags
are not relevant to translation.  Removing those that are
unnecessary reduces the amount of translation required.

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/cpu.h       | 24 +++++++++---------------
 target/s390x/translate.c | 16 ++++++++--------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 5b94ace..9faca04 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -346,19 +346,14 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 
 /* tb flags */
 
-#define FLAG_MASK_PER           (PSW_MASK_PER    >> 32)
-#define FLAG_MASK_DAT           (PSW_MASK_DAT    >> 32)
-#define FLAG_MASK_IO            (PSW_MASK_IO     >> 32)
-#define FLAG_MASK_EXT           (PSW_MASK_EXT    >> 32)
-#define FLAG_MASK_KEY           (PSW_MASK_KEY    >> 32)
-#define FLAG_MASK_MCHECK        (PSW_MASK_MCHECK >> 32)
-#define FLAG_MASK_WAIT          (PSW_MASK_WAIT   >> 32)
-#define FLAG_MASK_PSTATE        (PSW_MASK_PSTATE >> 32)
-#define FLAG_MASK_ASC           (PSW_MASK_ASC    >> 32)
-#define FLAG_MASK_CC            (PSW_MASK_CC     >> 32)
-#define FLAG_MASK_PM            (PSW_MASK_PM     >> 32)
-#define FLAG_MASK_64            (PSW_MASK_64     >> 32)
-#define FLAG_MASK_32            0x00001000
+#define FLAG_MASK_PSW_SHIFT     31
+#define FLAG_MASK_PER           (PSW_MASK_PER    >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_PSTATE        (PSW_MASK_PSTATE >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_ASC           (PSW_MASK_ASC    >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_64            (PSW_MASK_64     >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_32            (PSW_MASK_32     >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_PSW		(FLAG_MASK_PER | FLAG_MASK_PSTATE \
+                                | FLAG_MASK_ASC | FLAG_MASK_64 | FLAG_MASK_32)
 
 /* Control register 0 bits */
 #define CR0_LOWPROT             0x0000000010000000ULL
@@ -416,8 +411,7 @@ static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
 {
     *pc = env->psw.addr;
     *cs_base = env->ex_value;
-    *flags = ((env->psw.mask >> 32) & ~FLAG_MASK_CC) |
-             ((env->psw.mask & PSW_MASK_32) ? FLAG_MASK_32 : 0);
+    *flags = (env->psw.mask >> FLAG_MASK_PSW_SHIFT) & FLAG_MASK_PSW;
 }
 
 #define MAX_ILEN 6
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index a3414c0..df3fefa 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -323,11 +323,11 @@ static inline uint64_t ld_code4(CPUS390XState *env, uint64_t pc)
 static int get_mem_index(DisasContext *s)
 {
     switch (s->tb->flags & FLAG_MASK_ASC) {
-    case PSW_ASC_PRIMARY >> 32:
+    case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
         return 0;
-    case PSW_ASC_SECONDARY >> 32:
+    case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
         return 1;
-    case PSW_ASC_HOME >> 32:
+    case PSW_ASC_HOME >> FLAG_MASK_PSW_SHIFT:
         return 2;
     default:
         tcg_abort();
@@ -387,7 +387,7 @@ static inline void gen_trap(DisasContext *s)
 #ifndef CONFIG_USER_ONLY
 static void check_privileged(DisasContext *s)
 {
-    if (s->tb->flags & (PSW_MASK_PSTATE >> 32)) {
+    if (s->tb->flags & FLAG_MASK_PSTATE) {
         gen_program_exception(s, PGM_PRIVILEGED);
     }
 }
@@ -2932,20 +2932,20 @@ static ExitStatus op_mov2e(DisasContext *s, DisasOps *o)
     o->g_in2 = false;
 
     switch (s->tb->flags & FLAG_MASK_ASC) {
-    case PSW_ASC_PRIMARY >> 32:
+    case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
         tcg_gen_movi_i64(ar1, 0);
         break;
-    case PSW_ASC_ACCREG >> 32:
+    case PSW_ASC_ACCREG >> FLAG_MASK_PSW_SHIFT:
         tcg_gen_movi_i64(ar1, 1);
         break;
-    case PSW_ASC_SECONDARY >> 32:
+    case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
         if (b2) {
             tcg_gen_ld32u_i64(ar1, cpu_env, offsetof(CPUS390XState, aregs[b2]));
         } else {
             tcg_gen_movi_i64(ar1, 0);
         }
         break;
-    case PSW_ASC_HOME >> 32:
+    case PSW_ASC_HOME >> FLAG_MASK_PSW_SHIFT:
         tcg_gen_movi_i64(ar1, 2);
         break;
     }
-- 
2.9.4
