Received: from eggs.gnu.org ([2001:4830:134:3::10]:34004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIq-0008Sb-O1
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d2vIp-0000pb-1b
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:54:28 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 25 Apr 2017 03:53:58 -0400
Message-Id: <1493106839-10438-13-git-send-email-cota@braap.org>
In-Reply-To: <1493106839-10438-1-git-send-email-cota@braap.org>
References: <1493106839-10438-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 12/13] target/i386: optimize indirect
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

The appended minimizes exits to the exec loop for indirect branches.
By using the gen_jr helper, we can remain in TCG mode as long as
the indirect branch target is found in tb_jmp_cache.

This should improve performance for workloads that have a high
hit rate in tb_jmp_cache.

Softmmu Measurements: (see user-mode measurements in later commit)

Note: baseline (i.e. speedup == 1x) is QEMU v2.9.0.

-                   SPECint06 (test set), x86_64-softmmu (Ubuntu 16.04 guest). Host: Intel i7-4790K @ 4.00GHz

 2.2x +-+--------------------------------------------------------------------------------------------------------------+-+
      |                                                                                  +++                             |
      |   cross+inline                                                                    |                              |
   2x +cross+jr+inline................................................................+++.|............................+-+
      |                                                                                |  |                              |
      |                                                                                |  |                              |
      |                                                                                |  |                              |
 1.8x +-+..............................................................................|..|............................+-+
      |                                                                                |####                             |
      |                                                                                |# |#                             |
 1.6x +-+............................................................................****.|#...........................+-+
      |                                                                              * |* |#                             |
      |                                                                              * |* |#                             |
      |                                                                              * |* |#                             |
 1.4x +-+.......................................................................+++..*.|*.|#...........................+-+
      |                                                      +++                 |   * |*++#             +++             |
      |                        +++                            |                 #### * |*  #          +++ |              |
 1.2x +-+......................###.............+++............|.+++.............#++#.*++*..#...........|..|............+-+
      |                     +++# #     +++      |             |  |            ++#  # *  *  #     +++  ****##     ####    |
      |     ++####          **** #  +++####    ####          *** |           ****  # *  *  #  ++####  *| *|#  ****++#    |
      |    ****++#  ++####  *  * #  ****  #  ++#| #  ++####  *|*###  ****##  *  *  # *  *  #  *** |#  *++*+#  *++*  #    |
   1x +-++-*++*++#++***+-#++*++*+#++*+-*++#+****++#++***++#+-*+*++#-+*++*+#++*++*-+#+*++*-+#++*+*++#++*-+*+#++*++*++#-++-+
      |    *  *  #  * *  #  *  * #  *  *  # *++*  #  * *  #  *+* |#  *  * #  *  *  # *  *  #  * *  #  *  * #  *  *  #    |
      |    *  *  #  * *  #  *  * #  *  *  # *  *  #  * *  #  * *++#  *  * #  *  *  # *  *  #  * *  #  *  * #  *  *  #    |
 0.8x +-+--****###--***###--****##--****###-****###--***###--***###--****##--****###-****###--***###--****##--****###--+-+
         astar   bzip2      gcc   gobmk h264ref   hmmlibquantum      mcf omnetpperlbench   sjengxalancbmk   hmean
  png: http://imgur.com/aSXm0qh

NB. 'cross' represents the previous commit.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/i386/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 9982a2d..0b4e1e1 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4991,7 +4991,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_push_v(s, cpu_T1);
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 3: /* lcall Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5009,7 +5009,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                       tcg_const_i32(dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -5017,7 +5018,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             }
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 5: /* ljmp Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5032,7 +5033,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 gen_op_movl_seg_T0_vm(R_CS);
                 gen_op_jmp_v(cpu_T1);
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 6: /* push Ev */
             gen_push_v(s, cpu_T0);
@@ -6412,7 +6414,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(cpu_T0);
         gen_bnd_jmp(s);
-        gen_eob(s);
+        gen_jr(s, cpu_T0);
         break;
     case 0xc3: /* ret */
         ot = gen_pop_T0(s);
@@ -6420,7 +6422,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
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
