Received: from eggs.gnu.org ([2001:4830:134:3::10]:43019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKc-0003oS-EU
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhKZ-0005JV-CW
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:21:22 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:24 -0500
Message-Id: <20180723201748.25573-76-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 75/99] fpu/softfloat: Fix conversion from
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
Cc: qemu-stable@nongnu.org, Petr Tesarik <ptesarik@suse.com>, Richard Henderson <richard.henderson@linaro.org>

From: Petr Tesarik <ptesarik@suse.com>

The significand is passed to normalizeRoundAndPackFloat128() as high
first, low second. The current code passes the integer first, so the
result is incorrectly shifted left by 64 bits.

This bug affects the emulation of s390x instruction CXLGBR (convert
from logical 64-bit binary-integer operand to extended BFP result).

Cc: qemu-stable@nongnu.org
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Petr Tesarik <ptesarik@suse.com>
Message-Id: <20180511071052.1443-1-ptesarik@suse.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit 6603d50648901e8b9e6d66ec1142accf0b1df1e6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 9bcaaebe4f..a926b91864 100644
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
2.17.1
