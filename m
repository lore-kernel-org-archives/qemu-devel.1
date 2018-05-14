Received: from eggs.gnu.org ([2001:4830:134:3::10]:52350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhj-0007md-CK
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhg-0007I5-W6
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:27 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILhg-0007G0-Pf
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:24 -0400
Received: by mail-pl0-x241.google.com with SMTP id az12-v6so8144532plb.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:11:52 -0700
Message-Id: <20180514221219.7091-2-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 01/28] fpu/softfloat: Fix conversion from
 uint64 to float128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, Petr Tesarik <ptesarik@suse.com>, qemu-stable@nongnu.org

From: Petr Tesarik <ptesarik@suse.com>

The significand is passed to normalizeRoundAndPackFloat128() as high
first, low second. The current code passes the integer first, so the
result is incorrectly shifted left by 64 bits.

This bug affects the emulation of s390x instruction CXLGBR (convert
from logical 64-bit binary-integer operand to extended BFP result).

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Message-Id: <20180511071052.1443-1-ptesarik@suse.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index bc0f52fa54..d07419324a 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3147,7 +3147,7 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
     if (a == 0) {
         return float128_zero;
     }
-    return normalizeRoundAndPackFloat128(0, 0x406E, a, 0, status);
+    return normalizeRoundAndPackFloat128(0, 0x406E, 0, a, status);
 }
 
 
-- 
2.17.0
