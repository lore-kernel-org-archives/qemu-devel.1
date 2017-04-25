Received: from eggs.gnu.org ([2001:4830:134:3::10]:33994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIq-0008Rc-AV
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIo-0000pL-Rs
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:55 -0400
Message-Id: <1493106839-10438-10-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 09/13] target/arm: optimize indirect
 branches with TCG's goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Speed up indirect branches by directly jumping to the target
if it is valid, i.e. if it is found in tb_jmp_cache.

Softmmu measurements: (see later commit for user-mode results)

Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.

- Impact on Boot time

| setup         | ARM debian boot+shutdown time | stddev |
|---------------+-------------------------------+--------|
| v2.9.0        |                         10.35 |   0.07 |
| +cross+inline |                         10.32 |   0.03 |
| +jr+inline    |                         10.59 |   0.20 |

-                            NBench, arm-softmmu (debian jessie guest). Host: Intel i7-4790K @ 4.00GHz

 1.25x +-+-------------------------------------------------------------------------------------------------------------+-+
       |                                                         +++       |                                             |
       |   cross+inline                                         ####       |                                             |
  1.2x +cross+jr+inline.........................................#++#......####.........................................+-+
       |                                                     +++#  #      #| #                                           |
       |                                  +++ +++            ****  #      #| #      +++                                  |
       |                                   | ####            *  *  #      #++#       |                                   |
 1.15x +-+................................****++#............*..*..#......#..#.....####................................+-+
       |                                  *++*  #            *  *  #      #  #     # |#                                  |
       |                                  *  *  #      +++   *  *  #      #  #     #++#                                  |
  1.1x +-+................................*..*..#.......|....*..*..#......#..#.....#..#................................+-+
       |                                  *  *  #      ####  *  *  #      #  #     #  #                         ####     |
       |                            +++   *  *  #      #++#  *  *  #      #  #     #  #                         #  #     |
       |                            ####  *  *  #      #  #  *  *  #      #  #     #  #                         #  #     |
 1.05x +-+..........................#++#..*..*..#......#..#..*..*..#...+++#..#.....#..#................+++......#..#...+-+
       |                            #  #  *  *  #      #  #  *  *  #  *****  #     #  #            +++####  *****  #     |
       |      ++++++   +++ +++      #  #  *  *  #   +++#  #  *  *  #  * | *  #     #  #            ****  #  *+++*  #     |
    1x +-++-+++++####++****###++++-+#++#+-*++*++#-+++++#-+#++*++*++#++*+-+*++#+-+++#++#-+*****###++*++*++#++*+-+*++#+-++-+
       |     *****++#  *++*++#    | #  #  *  *  #    | #  #  *  *  #  *   *  #  ****  #  *+++*++#  *  *  #  *   *  #     |
       |     *+++*  #  *  *  #  *****  #  *  *  #  *****  #  *  *  #  *   *  #  *++*  #  *   *  #  *  *  #  *   *  #     |
       |     *   *  #  *  *  #  *+++*  #  *  *  #  * | *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
 0.95x +-+...*...*..#..*..*..#..*...*..#..*..*..#..*+++*..#..*..*..#..*...*..#..*..*..#..*...*..#..*..*..#..*...*..#...+-+
       |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
       |     *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #  *  *  #  *   *  #     |
  0.9x +-+---*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###--****###--*****###---+-+
       ASSIGNMENT BITFIELD   FOURFP EMULATION   HUFFMAN   LU DECOMPOSITIONEURAL NNUMERIC SOSTRING SORT     hmean
  png: http://imgur.com/528aS76

NB. 'cross' represents the previous commit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 574cf70..d5296b1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -65,6 +65,7 @@ static TCGv_i32 cpu_R[16];
 TCGv_i32 cpu_CF, cpu_NF, cpu_VF, cpu_ZF;
 TCGv_i64 cpu_exclusive_addr;
 TCGv_i64 cpu_exclusive_val;
+static bool gen_jr;
 
 /* FIXME:  These should be removed.  */
 static TCGv_i32 cpu_F0s, cpu_F1s;
@@ -221,6 +222,7 @@ static void store_reg(DisasContext *s, int reg, TCGv_i32 var)
          */
         tcg_gen_andi_i32(var, var, s->thumb ? ~1 : ~3);
         s->is_jmp = DISAS_JUMP;
+        gen_jr = true;
     }
     tcg_gen_mov_i32(cpu_R[reg], var);
     tcg_temp_free_i32(var);
@@ -893,6 +895,7 @@ static inline void gen_bx_im(DisasContext *s, uint32_t addr)
         tcg_temp_free_i32(tmp);
     }
     tcg_gen_movi_i32(cpu_R[15], addr & ~1);
+    gen_jr = true;
 }
 
 /* Set PC and Thumb state from var.  var is marked as dead.  */
@@ -902,6 +905,7 @@ static inline void gen_bx(DisasContext *s, TCGv_i32 var)
     tcg_gen_andi_i32(cpu_R[15], var, ~1);
     tcg_gen_andi_i32(var, var, 1);
     store_cpu_field(var, thumb);
+    gen_jr = true;
 }
 
 /* Variant of store_reg which uses branch&exchange logic when storing
@@ -12034,6 +12038,16 @@ void gen_intermediate_code(CPUARMState *env, TranslationBlock *tb)
             gen_set_pc_im(dc, dc->pc);
             /* fall through */
         case DISAS_JUMP:
+            if (gen_jr) {
+                TCGv_ptr ptr = tcg_temp_new_ptr();
+
+                gen_jr = false;
+                gen_helper_lookup_tb_ptr(ptr, cpu_env, cpu_R[15]);
+                tcg_gen_goto_ptr(ptr);
+                tcg_temp_free_ptr(ptr);
+                break;
+            }
+            /* fall through */
         default:
             /* indicate that the hash table must be used to find the next TB */
             tcg_gen_exit_tb(0);
-- 
2.7.4
