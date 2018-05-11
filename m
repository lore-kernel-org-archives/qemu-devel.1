Received: from eggs.gnu.org ([2001:4830:134:3::10]:51830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ptesarik@suse.com>) id 1fH2EU-0004F8-Nx
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ptesarik@suse.com>) id 1fH2ES-0006t6-Iq
	for qemu-devel@nongnu.org; Fri, 11 May 2018 03:12:50 -0400
From: Petr Tesarik <ptesarik@suse.com>
Date: Fri, 11 May 2018 09:10:52 +0200
Message-Id: <20180511071052.1443-1-ptesarik@suse.com>
Subject: [Qemu-devel] [PATCH 1/1] Fix conversion from uint64 to float128
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Petr Tesarik <ptesarik@suse.com>, qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>

The significand is passed to normalizeRoundAndPackFloat128() as high
first, low second. The current code passes the integer first, so the
result is incorrectly shifted left by 64 bits.

This bug affects the emulation of s390x instruction CXLGBR (convert
from logical 64-bit binary-integer operand to extended BFP result).

Cc: qemu-stable@nongnu.org
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 70e0c40a1c..386805475b 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -3139,7 +3139,7 @@ float128 uint64_to_float128(uint64_t a, float_status *status)
     if (a == 0) {
         return float128_zero;
     }
-    return normalizeRoundAndPackFloat128(0, 0x406E, a, 0, status);
+    return normalizeRoundAndPackFloat128(0, 0x406E, 0, a, status);
 }
 
 
-- 
2.13.6
