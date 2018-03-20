Received: from eggs.gnu.org ([2001:4830:134:3::10]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyDFs-00031c-3l
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eyDFn-0002Ok-KP
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59527)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eyDFn-0002Nb-A5
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 05:08:23 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Mar 2018 10:08:13 +0100
Message-Id: <20180320090813.852-3-laurent@vivier.eu>
In-Reply-To: <20180320090813.852-1-laurent@vivier.eu>
References: <20180320090813.852-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/2] target/m68k: add a mechanism to
 automatically free TCGv
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

SRC_EA() and gen_extend() can return either a temporary
TCGv or a memory allocated one. Mark them when they are
allocated, and free them automatically at end of the
instruction translation.

We want to free locally allocated TCGv to avoid
overflow in sequence like:

  0xc00ae406:  movel %fp@(-132),%fp@(-268)
  0xc00ae40c:  movel %fp@(-128),%fp@(-264)
  0xc00ae412:  movel %fp@(-20),%fp@(-212)
  0xc00ae418:  movel %fp@(-16),%fp@(-208)
  0xc00ae41e:  movel %fp@(-60),%fp@(-220)
  0xc00ae424:  movel %fp@(-56),%fp@(-216)
  0xc00ae42a:  movel %fp@(-124),%fp@(-252)
  0xc00ae430:  movel %fp@(-120),%fp@(-248)
  0xc00ae436:  movel %fp@(-12),%fp@(-260)
  0xc00ae43c:  movel %fp@(-8),%fp@(-256)
  0xc00ae442:  movel %fp@(-52),%fp@(-276)
  0xc00ae448:  movel %fp@(-48),%fp@(-272)
  ...

That can fill a lot of TCGv entries in a sequence,
especially since 15fa08f845 ("tcg: Dynamically allocate TCGOps")
we have no limit to fill the TCGOps cache and we can fill
the entire TCG variables array and overflow it.

Suggested-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180319113544.704-3-laurent@vivier.eu>
---
 target/m68k/translate.c | 56 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 13 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 1c2ff56305..6beaf9ed66 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -123,8 +123,34 @@ typedef struct DisasContext {
     int done_mac;
     int writeback_mask;
     TCGv writeback[8];
+#define MAX_TO_RELEASE 8
+    int release_count;
+    TCGv release[MAX_TO_RELEASE];
 } DisasContext;
 
+static void init_release_array(DisasContext *s)
+{
+#ifdef CONFIG_DEBUG_TCG
+    memset(s->release, 0, sizeof(s->release));
+#endif
+    s->release_count = 0;
+}
+
+static void do_release(DisasContext *s)
+{
+    int i;
+    for (i = 0; i < s->release_count; i++) {
+        tcg_temp_free(s->release[i]);
+    }
+    init_release_array(s);
+}
+
+static TCGv mark_to_release(DisasContext *s, TCGv tmp)
+{
+    g_assert(s->release_count < MAX_TO_RELEASE);
+    return s->release[s->release_count++] = tmp;
+}
+
 static TCGv get_areg(DisasContext *s, unsigned regno)
 {
     if (s->writeback_mask & (1 << regno)) {
@@ -347,7 +373,8 @@ static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
         gen_store(s, opsize, addr, val, index);
         return store_dummy;
     } else {
-        return gen_load(s, opsize, addr, what == EA_LOADS, index);
+        return mark_to_release(s, gen_load(s, opsize, addr,
+                                           what == EA_LOADS, index));
     }
 }
 
@@ -439,7 +466,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         } else {
             bd = 0;
         }
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         if ((ext & 0x44) == 0) {
             /* pre-index */
             add = gen_addr_index(s, ext, tmp);
@@ -449,7 +476,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         if ((ext & 0x80) == 0) {
             /* base not suppressed */
             if (IS_NULL_QREG(base)) {
-                base = tcg_const_i32(offset + bd);
+                base = mark_to_release(s, tcg_const_i32(offset + bd));
                 bd = 0;
             }
             if (!IS_NULL_QREG(add)) {
@@ -465,11 +492,11 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
                 add = tmp;
             }
         } else {
-            add = tcg_const_i32(bd);
+            add = mark_to_release(s, tcg_const_i32(bd));
         }
         if ((ext & 3) != 0) {
             /* memory indirect */
-            base = gen_load(s, OS_LONG, add, 0, IS_USER(s));
+            base = mark_to_release(s, gen_load(s, OS_LONG, add, 0, IS_USER(s)));
             if ((ext & 0x44) == 4) {
                 add = gen_addr_index(s, ext, tmp);
                 tcg_gen_add_i32(tmp, add, base);
@@ -494,7 +521,7 @@ static TCGv gen_lea_indexed(CPUM68KState *env, DisasContext *s, TCGv base)
         }
     } else {
         /* brief extension word format */
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         add = gen_addr_index(s, ext, tmp);
         if (!IS_NULL_QREG(base)) {
             tcg_gen_add_i32(tmp, add, base);
@@ -624,7 +651,7 @@ static inline TCGv gen_extend(DisasContext *s, TCGv val, int opsize, int sign)
     if (opsize == OS_LONG) {
         tmp = val;
     } else {
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         gen_ext(tmp, val, opsize, sign);
     }
 
@@ -746,7 +773,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
             return NULL_QREG;
         }
         reg = get_areg(s, reg0);
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         if (reg0 == 7 && opsize == OS_BYTE &&
             m68k_feature(s->env, M68K_FEATURE_M68000)) {
             tcg_gen_subi_i32(tmp, reg, 2);
@@ -756,7 +783,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         return tmp;
     case 5: /* Indirect displacement.  */
         reg = get_areg(s, reg0);
-        tmp = tcg_temp_new();
+        tmp = mark_to_release(s, tcg_temp_new());
         ext = read_im16(env, s);
         tcg_gen_addi_i32(tmp, reg, (int16_t)ext);
         return tmp;
@@ -767,14 +794,14 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         switch (reg0) {
         case 0: /* Absolute short.  */
             offset = (int16_t)read_im16(env, s);
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         case 1: /* Absolute long.  */
             offset = read_im32(env, s);
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         case 2: /* pc displacement  */
             offset = s->pc;
             offset += (int16_t)read_im16(env, s);
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         case 3: /* pc index+displacement.  */
             return gen_lea_indexed(env, s, NULL_QREG);
         case 4: /* Immediate.  */
@@ -900,7 +927,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
             default:
                 g_assert_not_reached();
             }
-            return tcg_const_i32(offset);
+            return mark_to_release(s, tcg_const_i32(offset));
         default:
             return NULL_QREG;
         }
@@ -6033,6 +6060,7 @@ static void disas_m68k_insn(CPUM68KState * env, DisasContext *s)
     uint16_t insn = read_im16(env, s);
     opcode_table[insn](env, s, insn);
     do_writebacks(s);
+    do_release(s);
 }
 
 /* generate intermediate code for basic block 'tb'.  */
@@ -6067,6 +6095,8 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb)
         max_insns = TCG_MAX_INSNS;
     }
 
+    init_release_array(dc);
+
     gen_tb_start(tb);
     do {
         pc_offset = dc->pc - pc_start;
-- 
2.14.3
