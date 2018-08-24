Received: from eggs.gnu.org ([2001:4830:134:3::10]:34697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1ftByH-0000vS-Ax
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1ftByC-00020G-Gk
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:17:49 -0400
Received: from mail.sysgo.com ([176.9.12.79]:53020)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rka@sysgo.com>) id 1ftByC-0001yF-8i
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 09:17:44 -0400
From: Roman Kapl <rka@sysgo.com>
Date: Fri, 24 Aug 2018 15:17:34 +0200
Message-Id: <20180824131734.18557-1-rka@sysgo.com>
Subject: [Qemu-devel] [PATCH] tcg/i386: fix vector operations on 32-bit hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Roman Kapl <rka@sysgo.com>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

The TCG backend uses LOWREGMASK to get the low 7 bits of register numbers. This
was defined as no-op for 32-bit x86, with the assumption that we have eight
registers anyway. This assumption is not true once we have xmm regs.

Since LOWREGMASK was a no-op, xmm register indidices were wrong in opcodes and
have overflown into other opcode fields, wreaking havoc.

To trigger these problems, you can try running the "movi d8, #0x0" AArch64
instruction on 32-bit x86. "vpxor %xmm0, %xmm0, %xmm0" should be generated,
but instead TCG generated "vpxor %xmm0, %xmm0, %xmm2".

Fixes: 770c2fc7bb ("Add vector operations")
Signed-off-by: Roman Kapl <rka@sysgo.com>
---

Note: It could also be possible to add a dedicated VEC_LOWREGMASK, but I don't
think it is better or signigicantly faster.

 tcg/i386/tcg-target.inc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index a91e4f1313..436195894b 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -302,11 +302,7 @@ static inline int tcg_target_const_match(tcg_target_long val, TCGType type,
     return 0;
 }
 
-#if TCG_TARGET_REG_BITS == 64
 # define LOWREGMASK(x)	((x) & 7)
-#else
-# define LOWREGMASK(x)	(x)
-#endif
 
 #define P_EXT		0x100		/* 0x0f opcode prefix */
 #define P_EXT38         0x200           /* 0x0f 0x38 opcode prefix */
-- 
2.11.0
