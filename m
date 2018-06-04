Received: from eggs.gnu.org ([2001:4830:134:3::10]:36197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fPwl8-0002Ra-EL
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fPwl5-00029D-75
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:11:22 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:38626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fPwl5-00028x-32
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:11:19 -0400
Received: by mail-it0-x241.google.com with SMTP id v83-v6so757917itc.3
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 14:11:18 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon,  4 Jun 2018 17:11:06 -0400
Message-Id: <20180604211106.4442-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH] tcg-target.inc.c: Use byte form of xgetbv
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: John Arbuckle <programmingkidx@gmail.com>

The assembler in most versions of Mac OS X is pretty old and does not support
the xgetbv instruction. To go around this problem the raw encoding of the
instruction is used instead.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
 tcg/i386/tcg-target.inc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5357909..82e004a 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -3501,7 +3501,11 @@ static void tcg_target_init(TCGContext *s)
            sure of not hitting invalid opcode.  */
         if (c & bit_OSXSAVE) {
             unsigned xcrl, xcrh;
-            asm ("xgetbv" : "=a" (xcrl), "=d" (xcrh) : "c" (0));
+            /*
+             * The xgetbv instruction is not available to older versions of the 
+             * assembler, so we encode the instruction manually.
+             */
+            asm (".byte 0x0f, 0x01, 0xd0": "=a" (xcrl), "=d" (xcrh) : "c" (0));
             if ((xcrl & 6) == 6) {
                 have_avx1 = (c & bit_AVX) != 0;
                 have_avx2 = (b7 & bit_AVX2) != 0;
-- 
2.10.2
