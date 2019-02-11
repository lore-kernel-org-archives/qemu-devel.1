Received: from eggs.gnu.org ([209.51.188.92]:47991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGCA-0004l0-PW
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1gtGC2-0004Ga-43
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:38 -0500
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:43767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1gtGC0-00049R-3V
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 13:20:32 -0500
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Feb 2019 19:19:07 +0100
Message-Id: <20190211181907.2219-6-svens@stackframe.org>
In-Reply-To: <20190211181907.2219-2-svens@stackframe.org>
References: <20190211181907.2219-2-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 5/5] target/hppa: fix dcor instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

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
---
 target/hppa/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index d858fabd3a..69c5a558fc 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2797,7 +2797,7 @@ static DisasJumpType trans_dcor(DisasContext *ctx, uint32_t insn,
     }
     tcg_gen_andi_reg(tmp, tmp, 0x11111111);
     tcg_gen_muli_reg(tmp, tmp, 6);
-    ret = do_unit(ctx, rt, tmp, load_gpr(ctx, r2), cf, false,
+    ret = do_unit(ctx, rt, load_gpr(ctx, r2), tmp, cf, false,
                   is_i ? tcg_gen_add_reg : tcg_gen_sub_reg);
 
     return nullify_end(ctx, ret);
-- 
2.20.1
