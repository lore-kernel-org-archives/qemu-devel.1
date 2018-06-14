Received: from eggs.gnu.org ([2001:4830:134:3::10]:36786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyP-0006pu-OJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyN-0005fI-3u
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:57 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:39031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyM-0005ex-Tw
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:31:55 -0400
Received: by mail-pg0-x241.google.com with SMTP id w12-v6so3362539pgc.6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:31:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:30 -1000
Message-Id: <20180614193147.29680-2-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 01/18] tcg/i386: Use byte form of xgetbv
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
