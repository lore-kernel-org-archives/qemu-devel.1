Received: from eggs.gnu.org ([2001:4830:134:3::10]:52763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVMe2-0006m6-6l
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVMdy-0001JG-QR
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:45:54 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dVMdy-0001Is-La
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 14:45:50 -0400
Received: by mail-qk0-x242.google.com with SMTP id q66so5198764qki.1
	for <qemu-devel@nongnu.org>; Wed, 12 Jul 2017 11:45:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed, 12 Jul 2017 08:45:40 -1000
Message-Id: <20170712184540.12352-1-rth@twiddle.net>
In-Reply-To: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
References: <CAPybu_0+enKVGf-bZHrkvWQ8reFtJnkKC=sucr2aaZ_DidaHNA@mail.gmail.com>
Subject: [Qemu-devel] [PATCH] target/i386: Fix BLSR and BLSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ricardo.ribalda@gmail.com, ehabkost@redhat.com, pbonzini@redhat.com

The implementation of these two instructions was swapped.
At the same time, unify the setup of eflags for the insn group.

Reported-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 8365a6d..087a2e6 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -4029,36 +4029,27 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                     goto illegal_op;
                 }
                 ot = mo_64_32(s->dflag);
-                gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
+                gen_ldst_modrm(env, s, modrm, ot, OR_TMP1, 0);
 
                 switch (reg & 7) {
                 case 1: /* blsr By,Ey */
-                    tcg_gen_neg_tl(cpu_T1, cpu_T0);
+                    tcg_gen_subi_tl(cpu_T0, cpu_T1, 1);
                     tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
                     gen_op_mov_reg_v(ot, s->vex_v, cpu_T0);
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
+                    tcg_gen_subi_tl(cpu_T0, cpu_T1, 1);
+                    tcg_gen_xor_tl(cpu_T0, cpu_T0, cpu_T1);
                     break;
-
                 case 3: /* blsi By, Ey */
-                    tcg_gen_mov_tl(cpu_cc_src, cpu_T0);
-                    tcg_gen_subi_tl(cpu_T0, cpu_T0, 1);
-                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_cc_src);
-                    tcg_gen_mov_tl(cpu_cc_dst, cpu_T0);
-                    set_cc_op(s, CC_OP_BMILGB + ot);
+                    tcg_gen_neg_tl(cpu_T0, cpu_T1);
+                    tcg_gen_and_tl(cpu_T0, cpu_T0, cpu_T1);
                     break;
-
                 default:
                     goto unknown_op;
                 }
+                gen_op_update2_cc();
+                set_cc_op(s, CC_OP_BMILGB + ot);
                 break;
 
             default:
-- 
2.9.4
