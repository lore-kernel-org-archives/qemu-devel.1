Received: from eggs.gnu.org ([2001:4830:134:3::10]:37834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAQ-00074z-KN
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAP-00008S-Ff
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:22 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAO-00005F-Oj
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:21 -0400
Received: by mail-wr0-x241.google.com with SMTP id t6-v6so6664963wrq.13
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:16 +0200
Message-Id: <1530216310-52873-7-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 06/60] target/i386: Fix BLSR and BLSI
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

The implementation of these two instructions was swapped.
At the same time, unify the setup of eflags for the insn group.

Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
Message-Id: <20170712192902.15493-1-rth@twiddle.net>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 697a918..c918494 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4059,34 +4059,26 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
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
1.8.3.1
