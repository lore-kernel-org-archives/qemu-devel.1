Received: from eggs.gnu.org ([2001:4830:134:3::10]:56446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjt-0007oa-1W
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjs-0002k3-7t
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:17 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:46155)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7fjr-0002ji-O2
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:15 -0400
Received: by mail-wm0-x243.google.com with SMTP id m72so7124688wmc.1
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 03:50:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 12:50:06 +0200
Message-Id: <20171026105007.31777-4-richard.henderson@linaro.org>
In-Reply-To: <20171026105007.31777-1-richard.henderson@linaro.org>
References: <20171026105007.31777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/4] target/i386: Fix BLSR and BLSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, Richard Henderson <rth@twiddle.net>

From: Richard Henderson <rth@twiddle.net>

The implementation of these two instructions was swapped.
At the same time, unify the setup of eflags for the insn group.

Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 409b195d37..dd464b98b0 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4067,34 +4067,26 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 ot = mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
 
+                tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
                 switch (reg & 7) {
                 case 1: /* blsr By,Ey */
-                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
+                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
                     tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
-                    gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
-                    gen_op_update2_cc();
-                    set_cc_op(s, CC_OP_BMILGB + ot);
                     break;
-
                 case 2: /* blsmsk By,Ey */
-                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
-                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
-                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_cc_src);
-                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
-                    set_cc_op(s, CC_OP_BMILGB + ot);
+                    tcg_gen_subi_tl(cpu_T1, cpu_T0, 1);
+                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
                     break;
-
                 case 3: /* blsi By, Ey */
-                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
-                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
-                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_cc_src);
-                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
-                    set_cc_op(s, CC_OP_BMILGB + ot);
+                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
+                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
                     break;
-
                 default:
                     goto unknown_op;
                 }
+                tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
+                gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
+                set_cc_op(s, CC_OP_BMILGB + ot);
                 break;
 
             default:
-- 
2.13.6
