Received: from eggs.gnu.org ([2001:4830:134:3::10]:51475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTudi-0000E3-3i
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTude-0002Lo-Nz
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:06 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:41327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTude-0002LI-Gy
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:44:02 -0400
Received: by mail-pg0-x241.google.com with SMTP id l65-v6so4852853pgl.8
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 12:44:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 15 Jun 2018 09:43:36 -1000
Message-Id: <20180615194354.12489-2-richard.henderson@linaro.org>
In-Reply-To: <20180615194354.12489-1-richard.henderson@linaro.org>
References: <20180615194354.12489-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 01/19] tcg/i386: Use byte form of xgetbv
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, John Arbuckle <programmingkidx@gmail.com>

From: John Arbuckle <programmingkidx@gmail.com>

The assembler in most versions of Mac OS X is pretty old and does not
support the xgetbv instruction.  To go around this problem, the raw
encoding of the instruction is used instead.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
Message-Id: <20180604215102.11002-1-programmingkidx@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.inc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5357909fff..0d0ff524b7 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3501,7 +3501,10 @@ static void tcg_target_init(TCGContext *s)
            sure of not hitting invalid opcode.  */
         if (c & bit_OSXSAVE) {
             unsigned xcrl, xcrh;
-            asm ("xgetbv" : "=a" (xcrl), "=d" (xcrh) : "c" (0));
+            /* The xgetbv instruction is not available to older versions of
+             * the assembler, so we encode the instruction manually.
+             */
+            asm(".byte 0x0f, 0x01, 0xd0" : "=a" (xcrl), "=d" (xcrh) : "c" (0));
             if ((xcrl & 6) == 6) {
                 have_avx1 = (c & bit_AVX) != 0;
                 have_avx2 = (b7 & bit_AVX2) != 0;
-- 
2.17.1
