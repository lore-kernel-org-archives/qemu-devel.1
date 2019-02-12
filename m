Received: from eggs.gnu.org ([209.51.188.92]:49761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ95-0002n1-A3
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQ8p-0001zk-Mi
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:58:04 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:43248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQ8n-0001qc-Ac
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 23:57:55 -0500
Received: by mail-pg1-x52c.google.com with SMTP id v28so655006pgk.10
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 20:57:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 20:57:20 -0800
Message-Id: <20190212045721.28041-24-richard.henderson@linaro.org>
In-Reply-To: <20190212045721.28041-1-richard.henderson@linaro.org>
References: <20190212045721.28041-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 23/24] target/hppa: fix dcor instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Sven Schnelle <svens@stackframe.org>

From: Sven Schnelle <svens@stackframe.org>

It looks like the operands where exchanged. HP bootrom tests the
following sequence:

0x00000000f0004064:  ldil L%-66666800,r7
0x00000000f0004068:  addi 19f,r7,r7
0x00000000f000406c:  addi -1,r0,rp
0x00000000f0004070:  addi f,r0,r4
0x00000000f0004074:  addi 1,r4,r5
0x00000000f0004078:  dcor rp,r6
0x00000000f000407c:  cmpb,<>,n r6,r7,0xf000411

This returned 0x66666661 instead of the expected 0x9999999f in QEMU.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20190211181907.2219-6-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 026ba5cb3e..b4fd307b77 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2744,7 +2744,7 @@ static bool do_dcor(DisasContext *ctx, arg_rr_cf *a, bool is_i)
     }
     tcg_gen_andi_reg(tmp, tmp, 0x11111111);
     tcg_gen_muli_reg(tmp, tmp, 6);
-    do_unit(ctx, a->t, tmp, load_gpr(ctx, a->r), a->cf, false,
+    do_unit(ctx, a->t, load_gpr(ctx, a->r), tmp, a->cf, false,
             is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
     return nullify_end(ctx);
 }
-- 
2.17.2
