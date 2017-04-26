Received: from eggs.gnu.org ([2001:4830:134:3::10]:49647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3GMU-0000em-7M
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3GMS-0000Oq-Bj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 02:23:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 26 Apr 2017 02:23:22 -0400
Message-Id: <1493187803-4510-10-git-send-email-cota@braap.org>
In-Reply-To: <1493187803-4510-1-git-send-email-cota@braap.org>
References: <1493187803-4510-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 09/10] target/i386: optimize indirect
 branches
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

Speed up indirect branches by jumping to the target if it is valid.

Softmmu measurements (see later commit for user-mode numbers):

Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.

-                  SPECint06 (test set), x86_64-softmmu (Ubuntu 16.04 guest). Host: Intel i7-4790K @ 4.00GHz

 2.4x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                                                                  |
      |   cross                                                                                                          |
 2.2x +cross+jr..........................................................................+++...........................+-+
      |                                                                                   |                              |
      |                                                                               +++ |                              |
   2x +-+..............................................................................|..|............................+-+
      |                                                                                |  |                              |
      |                                                                                |  |                              |
 1.8x +-+..............................................................................|####...........................+-+
      |                                                                                |# |#                             |
      |                                                                              **** |#                             |
 1.6x +-+............................................................................*.|*.|#...........................+-+
      |                                                                              * |* |#                             |
      |                                                                              * |* |#                             |
 1.4x +-+.......................................................................+++..*.|*.|#...........................+-+
      |                                                      ++++++             #### * |*++#             +++             |
      |                        +++                            |  |              #++# *++*  #          +++ |              |
 1.2x +-+......................###.....####....+++............|..|...........****..#.*..*..#....####...|.###.....####..+-+
      |        +++          **** #  ****  #    ####          ***###          *++*  # *  *  #    #++#  ****|#  +++#++#    |
      |    ****###     +++  *++* #  *++*  #  ++#  #    ####  *|* |#     +++  *  *  # *  *  #  ***  #  *| *|#  ****  #    |
   1x +-++-*++*++#++***###++*++*+#++*+-*++#+****++#++***++#+-*+*++#-+****##++*++*-+#+*++*-+#++*+*++#++*-+*+#++*++*++#-++-+
      |    *  *  #  * *  #  *  * #  *  *  # *  *  #  * *  #  *|* |#  *++* #  *  *  # *  *  #  * *  #  *  * #  *  *  #    |
      |    *  *  #  * *  #  *  * #  *  *  # *  *  #  * *  #  *+*++#  *  * #  *  *  # *  *  #  * *  #  *  * #  *  *  #    |
 0.8x +-+--****###--***###--****##--****###-****###--***###--***###--****##--****###-****###--***###--****##--****###--+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/DU36YFU

NB. 'cross' represents the previous commit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index a065271..3bd80c0 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4988,7 +4988,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_push_v(s, cpu_T1);
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 3: /* lcall Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5006,7 +5006,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                       tcg_const_i32(dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -5014,7 +5015,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             }
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 5: /* ljmp Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5029,7 +5030,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 gen_op_movl_seg_T0_vm(R_CS);
                 gen_op_jmp_v(cpu_T1);
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 6: /* push Ev */
             gen_push_v(s, cpu_T0);
@@ -6409,7 +6411,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(cpu_T0);
         gen_bnd_jmp(s);
-        gen_eob(s);
+        gen_jr(s, cpu_T0);
         break;
     case 0xc3: /* ret */
         ot = gen_pop_T0(s);
@@ -6417,7 +6419,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(cpu_T0);
         gen_bnd_jmp(s);
-        gen_eob(s);
+        gen_jr(s, cpu_T0);
         break;
     case 0xca: /* lret im */
         val = cpu_ldsw_code(env, s->pc);
-- 
2.7.4
