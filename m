Received: from eggs.gnu.org ([2001:4830:134:3::10]:48133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fPxNp-00071F-Au
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1fPxNm-0004fx-8q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:51:21 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:42141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1fPxNm-0004fj-2y
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 17:51:18 -0400
Received: by mail-io0-x234.google.com with SMTP id r24-v6so797500ioh.9
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 14:51:17 -0700 (PDT)
From: John Arbuckle <programmingkidx@gmail.com>
Date: Mon,  4 Jun 2018 17:51:02 -0400
Message-Id: <20180604215102.11002-1-programmingkidx@gmail.com>
Subject: [Qemu-devel] [PATCH v2] tcg-target.inc.c: Use byte form of xgetbv
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

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
v2 changes:
- Fixed a spacing issue in the asm() function.

 tcg/i386/tcg-target.inc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 5357909fff..09141fa8e0 100644
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
+            asm(".byte 0x0f, 0x01, 0xd0" : "=a" (xcrl), "=d" (xcrh) : "c" (0));
             if ((xcrl & 6) == 6) {
                 have_avx1 = (c & bit_AVX) != 0;
                 have_avx2 = (b7 & bit_AVX2) != 0;
-- 
2.14.3 (Apple Git-98)
