Received: from eggs.gnu.org ([2001:4830:134:3::10]:45423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh5-0007Ra-Rj
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1cKkh2-000833-Mn
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:55 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50359)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1cKkh2-00081e-9k
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 06:40:52 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Sat, 24 Dec 2016 12:40:22 +0100
Message-Id: <1482579633-3393-2-git-send-email-laurent@vivier.eu>
In-Reply-To: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
References: <1482579633-3393-1-git-send-email-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 01/12] target-m68k: Delay autoinc writeback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <1478206203-4606-2-git-send-email-rth@twiddle.net>
---
 target/m68k/translate.c | 84 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 64 insertions(+), 20 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d6ed883..a9066dc 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -59,12 +59,12 @@ static TCGv cpu_aregs[8];
 static TCGv_i64 cpu_fregs[8];
 static TCGv_i64 cpu_macc[4];
 
-#define REG(insn, pos) (((insn) >> (pos)) & 7)
+#define REG(insn, pos)  (((insn) >> (pos)) & 7)
 #define DREG(insn, pos) cpu_dregs[REG(insn, pos)]
-#define AREG(insn, pos) cpu_aregs[REG(insn, pos)]
+#define AREG(insn, pos) get_areg(s, REG(insn, pos))
 #define FREG(insn, pos) cpu_fregs[REG(insn, pos)]
-#define MACREG(acc) cpu_macc[acc]
-#define QREG_SP cpu_aregs[7]
+#define MACREG(acc)     cpu_macc[acc]
+#define QREG_SP         get_areg(s, 7)
 
 static TCGv NULL_QREG;
 #define IS_NULL_QREG(t) (TCGV_EQUAL(t, NULL_QREG))
@@ -141,8 +141,55 @@ typedef struct DisasContext {
     int singlestep_enabled;
     TCGv_i64 mactmp;
     int done_mac;
+    int writeback_mask;
+    TCGv writeback[8];
 } DisasContext;
 
+static TCGv get_areg(DisasContext *s, unsigned regno)
+{
+    if (s->writeback_mask & (1 << regno)) {
+        return s->writeback[regno];
+    } else {
+        return cpu_aregs[regno];
+    }
+}
+
+static void delay_set_areg(DisasContext *s, unsigned regno,
+                           TCGv val, bool give_temp)
+{
+    if (s->writeback_mask & (1 << regno)) {
+        if (give_temp) {
+            tcg_temp_free(s->writeback[regno]);
+            s->writeback[regno] = val;
+        } else {
+            tcg_gen_mov_i32(s->writeback[regno], val);
+        }
+    } else {
+        s->writeback_mask |= 1 << regno;
+        if (give_temp) {
+            s->writeback[regno] = val;
+        } else {
+            TCGv tmp = tcg_temp_new();
+            s->writeback[regno] = tmp;
+            tcg_gen_mov_i32(tmp, val);
+        }
+    }
+}
+
+static void do_writebacks(DisasContext *s)
+{
+    unsigned mask = s->writeback_mask;
+    if (mask) {
+        s->writeback_mask = 0;
+        do {
+            unsigned regno = ctz32(mask);
+            tcg_gen_mov_i32(cpu_aregs[regno], s->writeback[regno]);
+            tcg_temp_free(s->writeback[regno]);
+            mask &= mask - 1;
+        } while (mask);
+    }
+}
+
 #define DISAS_JUMP_NEXT 4
 
 #if defined(CONFIG_USER_ONLY)
@@ -331,7 +378,7 @@ static inline uint32_t read_im32(CPUM68KState *env, DisasContext *s)
 }
 
 /* Calculate and address index.  */
-static TCGv gen_addr_index(uint16_t ext, TCGv tmp)
+static TCGv gen_addr_index(DisasContext *s, uint16_t ext, TCGv tmp)
 {
     TCGv add;
     int scale;
@@ -388,7 +435,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         tmp = tcg_temp_new();
         if ((ext & 0x44) == 0) {
             /* pre-index */
-            add = gen_addr_index(ext, tmp);
+            add = gen_addr_index(s, ext, tmp);
         } else {
             add = NULL_QREG;
         }
@@ -417,7 +464,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
             /* memory indirect */
             base = gen_load(s, OS_LONG, add, 0);
             if ((ext & 0x44) == 4) {
-                add = gen_addr_index(ext, tmp);
+                add = gen_addr_index(s, ext, tmp);
                 tcg_gen_add_i32(tmp, add, base);
                 add = tmp;
             } else {
@@ -441,7 +488,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
     } else {
         /* brief extension word format */
         tmp = tcg_temp_new();
-        add = gen_addr_index(ext, tmp);
+        add = gen_addr_index(s, ext, tmp);
         if (!IS_NULL_QREG(base)) {
             tcg_gen_add_i32(tmp, add, base);
             if ((int8_t)ext)
@@ -755,10 +802,11 @@ static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
     case 3: /* Indirect postincrement.  */
         reg = AREG(insn, 0);
         result = gen_ldst(s, opsize, reg, val, what);
-        /* ??? This is not exception safe.  The instruction may still
-           fault after this point.  */
-        if (what == EA_STORE || !addrp)
-            tcg_gen_addi_i32(reg, reg, opsize_bytes(opsize));
+        if (what == EA_STORE || !addrp) {
+            TCGv tmp = tcg_temp_new();
+            tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
+            delay_set_areg(s, REG(insn, 0), tmp, true);
+        }
         return result;
     case 4: /* Indirect predecrememnt.  */
         {
@@ -773,11 +821,8 @@ static TCGv gen_ea(CPUM68KState *env, DisasContext *s, uint16_t insn,
                     *addrp = tmp;
             }
             result = gen_ldst(s, opsize, tmp, val, what);
-            /* ??? This is not exception safe.  The instruction may still
-               fault after this point.  */
             if (what == EA_STORE || !addrp) {
-                reg = AREG(insn, 0);
-                tcg_gen_mov_i32(reg, tmp);
+                delay_set_areg(s, REG(insn, 0), tmp, false);
             }
         }
         return result;
@@ -3446,11 +3491,9 @@ void register_m68k_insns (CPUM68KState *env)
    write back the result to memory before setting the condition codes.  */
 static void disas_m68k_insn(CPUM68KState * env, DisasContext *s)
 {
-    uint16_t insn;
-
-    insn = read_im16(env, s);
-
+    uint16_t insn = read_im16(env, s);
     opcode_table[insn](env, s, insn);
+    do_writebacks(s);
 }
 
 /* generate intermediate code for basic block 'tb'.  */
@@ -3478,6 +3521,7 @@ void gen_intermediate_code(CPUM68KState *env, TranslationBlock *tb)
     dc->fpcr = env->fpcr;
     dc->user = (env->sr & SR_S) == 0;
     dc->done_mac = 0;
+    dc->writeback_mask = 0;
     num_insns = 0;
     max_insns = tb->cflags & CF_COUNT_MASK;
     if (max_insns == 0) {
-- 
2.7.4
