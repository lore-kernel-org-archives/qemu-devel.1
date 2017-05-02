Received: from eggs.gnu.org ([2001:4830:134:3::10]:59464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOK-0001nk-QF
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOJ-0001cj-KF
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:20 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOJ-0001cR-Eh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:19 -0400
Received: by mail-qk0-x244.google.com with SMTP id u68so7539189qkd.2
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:45 -0700
Message-Id: <20170502192300.2124-11-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 10/25] target/i386: optimize indirect
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
Cc: cota@braap.org

From: "Emilio G. Cota" <cota@braap.org>

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

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-11-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index ea113fe..674ec96 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4996,7 +4996,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             gen_push_v(s, cpu_T1);
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 3: /* lcall Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5014,7 +5014,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                       tcg_const_i32(dflag - 1),
                                       tcg_const_i32(s->pc - s->cs_base));
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
@@ -5022,7 +5023,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
             }
             gen_op_jmp_v(cpu_T0);
             gen_bnd_jmp(s);
-            gen_eob(s);
+            gen_jr(s, cpu_T0);
             break;
         case 5: /* ljmp Ev */
             gen_op_ld_v(s, ot, cpu_T1, cpu_A0);
@@ -5037,7 +5038,8 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 gen_op_movl_seg_T0_vm(R_CS);
                 gen_op_jmp_v(cpu_T1);
             }
-            gen_eob(s);
+            tcg_gen_ld_tl(cpu_tmp4, cpu_env, offsetof(CPUX86State, eip));
+            gen_jr(s, cpu_tmp4);
             break;
         case 6: /* push Ev */
             gen_push_v(s, cpu_T0);
@@ -6417,7 +6419,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(cpu_T0);
         gen_bnd_jmp(s);
-        gen_eob(s);
+        gen_jr(s, cpu_T0);
         break;
     case 0xc3: /* ret */
         ot = gen_pop_T0(s);
@@ -6425,7 +6427,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(cpu_T0);
         gen_bnd_jmp(s);
-        gen_eob(s);
+        gen_jr(s, cpu_T0);
         break;
     case 0xca: /* lret im */
         val = cpu_ldsw_code(env, s->pc);
-- 
2.9.3
