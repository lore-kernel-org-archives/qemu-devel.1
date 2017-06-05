Received: from eggs.gnu.org ([2001:4830:134:3::10]:56665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFK-0004Km-Lz
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dHvFI-0003jT-Fz
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:50 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dHvFI-0003hu-5C
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 12:52:48 -0400
Received: by mail-qt0-x244.google.com with SMTP id s33so9906426qtg.3
	for <qemu-devel@nongnu.org>; Mon, 05 Jun 2017 09:52:47 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon,  5 Jun 2017 09:52:14 -0700
Message-Id: <20170605165233.4135-8-rth@twiddle.net>
In-Reply-To: <20170605165233.4135-1-rth@twiddle.net>
References: <20170605165233.4135-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 07/26] target/arm: optimize indirect branches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Speed up indirect branches by jumping to the target if it is valid.

Softmmu measurements (see later commit for user-mode results):

Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.

- Impact on Boot time

| setup  | ARM debian jessie boot+shutdown time | stddev |
|--------+--------------------------------------+--------|
| v2.9.0 |                                 8.84 |   0.07 |
| +cross |                                 8.85 |   0.03 |
| +jr    |                                 8.83 |   0.06 |

-                            NBench, arm-softmmu (debian jessie guest). Host: Intel i7-4790K @ 4.00GHz

  1.3x +-+-------------------------------------------------------------------------------------------------------------+-+
       |                                                                                                                 |
       |   cross                                                          ####                                           |
 1.25x +cross+jr..........................................................#++#.........................................+-+
       |                                                        ####      #  #                                           |
       |                                                     +++#  #      #  #                                           |
       |                                      +++            ****  #      #  #                                           |
  1.2x +-+...................................####............*..*..#......#..#.........................................+-+
       |                                  ****  #            *  *  #      #  #     ####                                  |
       |                                  *  *  #            *  *  #      #  #     #  #                                  |
 1.15x +-+................................*..*..#............*..*..#......#..#.....#..#................................+-+
       |                                  *  *  #            *  *  #      #  #     #  #                                  |
       |                                  *  *  #      ####  *  *  #      #  #     #  #                                  |
       |                                  *  *  #      #  #  *  *  #      #  #     #  #                         ####     |
  1.1x +-+................................*..*..#......#..#..*..*..#......#..#.....#..#.........................#..#...+-+
       |                                  *  *  #      #  #  *  *  #      #  #     #  #                         #  #     |
       |                                  *  *  #      #  #  *  *  #      #  #     #  #                         #  #     |
 1.05x +-+..........................####..*..*..#......#..#..*..*..#......#..#.....#..#......+++............*****..#...+-+
       |                        *****  #  *  *  #      #  #  *  *  #  *****  #     #  #   +++ |    ****###  *   *  #     |
       |                        *+++*  #  *  *  #      #  #  *  *  #  *+++*  #  ****  #  *****###  *  *  #  *   *  #     |
       |     *****###  +++####  *   *  #  *  *  #  *****  #  *  *  #  *   *  #  *  *  #  * | *++#  *  *  #  *   *  #     |
    1x +-++-+*+++*-+#++****++#++*+-+*++#+-*++*++#-+*+++*-+#++*++*++#++*+-+*++#+-*++*++#-+*+++*-+#++*++*++#++*+-+*++#+-++-+
       |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
       |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
 0.95x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
       ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
  png: http://imgur.com/eOLmZNR

NB. 'cross' represents the previous commit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-8-git-send-email-cota@braap.org>
[rth: Replace gen_jr global variable with DISAS_EXIT state.]
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 25 ++++++++++++++++---------
 target/arm/translate.h |  4 ++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index d72953f..0862f9e 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -1182,7 +1182,7 @@ static void gen_exception_internal_insn(DisasContext *s, int offset, int excp)
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception_internal(excp);
-    s->is_jmp = DISAS_JUMP;
+    s->is_jmp = DISAS_EXC;
 }
 
 static void gen_exception_insn(DisasContext *s, int offset, int excp,
@@ -1191,14 +1191,14 @@ static void gen_exception_insn(DisasContext *s, int offset, int excp,
     gen_set_condexec(s);
     gen_set_pc_im(s, s->pc - offset);
     gen_exception(excp, syn, target_el);
-    s->is_jmp = DISAS_JUMP;
+    s->is_jmp = DISAS_EXC;
 }
 
 /* Force a TB lookup after an instruction that changes the CPU state.  */
 static inline void gen_lookup_tb(DisasContext *s)
 {
     tcg_gen_movi_i32(cpu_R[15], s->pc & ~1);
-    s->is_jmp = DISAS_JUMP;
+    s->is_jmp = DISAS_EXIT;
 }
 
 static inline void gen_hlt(DisasContext *s, int imm)
@@ -4150,19 +4150,23 @@ static inline bool use_goto_tb(DisasContext *s, target_ulong dest)
 #endif
 }
 
-static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
+static void gen_goto_ptr(void)
+{
+    TCGv addr = tcg_temp_new();
+    tcg_gen_extu_i32_tl(addr, cpu_R[15]);
+    tcg_gen_lookup_and_goto_ptr(addr);
+    tcg_temp_free(addr);
+}
+
+static void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
 {
     if (use_goto_tb(s, dest)) {
         tcg_gen_goto_tb(n);
         gen_set_pc_im(s, dest);
         tcg_gen_exit_tb((uintptr_t)s->tb + n);
     } else {
-        TCGv addr = tcg_temp_new();
-
         gen_set_pc_im(s, dest);
-        tcg_gen_extu_i32_tl(addr, cpu_R[15]);
-        tcg_gen_lookup_and_goto_ptr(addr);
-        tcg_temp_free(addr);
+        gen_goto_ptr();
     }
 }
 
@@ -12095,11 +12099,14 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
         case DISAS_JUMP:
+            gen_goto_ptr();
+            break;
         default:
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(0);
             break;
         case DISAS_TB_JUMP:
+        case DISAS_EXC:
             /* nothing more to generate */
             break;
         case DISAS_WFI:
diff --git a/target/arm/translate.h b/target/arm/translate.h
index 6b2cc34..15d383d 100644
--- a/target/arm/translate.h
+++ b/target/arm/translate.h
@@ -139,6 +139,10 @@ static void disas_set_insn_syndrome(DisasContext *s, uint32_t syn)
  * custom end-of-TB code)
  */
 #define DISAS_BX_EXCRET 11
+/* For instructions which want an immediate exit to the main loop,
+ * as opposed to attempting to use lookup_and_goto_ptr.
+ */
+#define DISAS_EXIT 12
 
 #ifdef TARGET_AARCH64
 void a64_translate_init(void);
-- 
2.9.4
