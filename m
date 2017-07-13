Received: from eggs.gnu.org ([2001:4830:134:3::10]:43297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVm1Q-00085w-8m
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ricardo.ribalda@gmail.com>) id 1dVm1N-0000jx-6o
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:51:44 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:35617)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ricardo.ribalda@gmail.com>)
	id 1dVm1M-0000jV-VW
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 17:51:41 -0400
Received: by mail-lf0-x241.google.com with SMTP id z78so6762908lff.2
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 14:51:40 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Thu, 13 Jul 2017 23:51:37 +0200
Message-Id: <20170713215137.5307-1-ricardo.ribalda@gmail.com>
Subject: [Qemu-devel] [PATCH] target/i386: Fix ANDN (bmi)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, ehabkost@redhat.com, pbonzini@redhat.com
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

Operands on ANDN are swapped.

Tested with the following function:

long test_andn(long v1, long v2){
	return (~v1 & v2);
}

Compiled with:

gcc kk.c -mbmi -O3 -Wall

0000000000000910 <test_andn>:
 910:c4 e2 c0 f2 c6       	andn   %rsi,%rdi,%rax
 915:c3                   	retq
 916:66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
 91d:00 00 00

and

gcc kk.c -march=native -O3 -Wall

0000000000000930 <test_andn>:
 930:   48 f7 d7                not    %rdi
 933:   48 89 f8                mov    %rdi,%rax
 936:   48 21 f0                and    %rsi,%rax
 939:   c3                      retq
 93a:   66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

The test showed than -mbmi version behaved differently than the
-march native version.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 203623ef884c..1f39b497c19a 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3774,7 +3774,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 }
                 ot = mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                tcg_gen_andc_tl(cpu_T0, cpu_regs[s->vex_v], cpu_T0);
+                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_regs[s->vex_v]);
                 gen_op_mov_reg_v(ot, reg, cpu_T0);
                 gen_op_update1_cc();
                 set_cc_op(s, CC_OP_LOGICB + ot);
-- 
2.13.2
