Received: from eggs.gnu.org ([2001:4830:134:3::10]:43969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlG-0003PX-2w
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDVlB-0007um-Qi
	for qemu-devel@nongnu.org; Tue, 01 May 2018 09:56:06 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue,  1 May 2018 15:55:45 +0200
Message-Id: <20180501135547.12414-3-laurent@vivier.eu>
In-Reply-To: <20180501135547.12414-1-laurent@vivier.eu>
References: <20180501135547.12414-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/4] m68k: Fix floatx80_lognp1 (Coverity
 CID1390587)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, Michael Tokarev <mjt@tls.msk.ru>

return the result of packFloatx80() instead of
dropping it.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180430170156.1860-1-laurent@vivier.eu>
---
 target/m68k/softfloat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/m68k/softfloat.c b/target/m68k/softfloat.c
index dffb371c71..2c069a5efb 100644
--- a/target/m68k/softfloat.c
+++ b/target/m68k/softfloat.c
@@ -334,7 +334,8 @@ floatx80 floatx80_lognp1(floatx80 a, float_status *status)
     if (aSign && aExp >= one_exp) {
         if (aExp == one_exp && aSig == one_sig) {
             float_raise(float_flag_divbyzero, status);
-            packFloatx80(aSign, floatx80_infinity.high, floatx80_infinity.low);
+            return packFloatx80(aSign, floatx80_infinity.high,
+                                floatx80_infinity.low);
         }
         float_raise(float_flag_invalid, status);
         return floatx80_default_nan(status);
-- 
2.14.3
