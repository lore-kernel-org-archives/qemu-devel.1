Received: from eggs.gnu.org ([2001:4830:134:3::10]:56471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjz-0007rx-4e
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7fjt-0002kW-3K
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:23 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:51912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7fjs-0002k1-SJ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:50:17 -0400
Received: by mail-wr0-x242.google.com with SMTP id j15so2718646wre.8
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 03:50:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 12:50:07 +0200
Message-Id: <20171026105007.31777-5-richard.henderson@linaro.org>
In-Reply-To: <20171026105007.31777-1-richard.henderson@linaro.org>
References: <20171026105007.31777-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 4/4] target/i386: Fix ANDN (bmi)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, ehabkost@redhat.com, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Richard Henderson <rth@twiddle.net>

From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

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
Message-Id: <20170713215137.5307-1-ricardo.ribalda@gmail.com>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index dd464b98b0..96cd04c6de 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -3810,7 +3810,7 @@ static void gen_sse(CPUX86State *env, DisasContext *s, int b,
                 }
                 ot = mo_64_32(s->dflag);
                 gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
-                tcg_gen_andc_tl(cpu_T0, cpu_regs[s->vex_v], cpu_T0);
+                tcg_gen_andc_tl(cpu_T0, cpu_T0, cpu_regs[s->vex_v]);
                 gen_op_mov_reg_v(ot, reg, cpu_T0);
                 gen_op_update1_cc();
                 set_cc_op(s, CC_OP_LOGICB + ot);
-- 
2.13.6
