Received: from eggs.gnu.org ([2001:4830:134:3::10]:59093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDCC2-0002IW-7x
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fDCBx-0007J1-Du
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:02:26 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46417)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fDCBx-0007IX-41
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 13:02:21 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Mon, 30 Apr 2018 19:01:55 +0200
Message-Id: <20180430170156.1860-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 1/2] m68k: Fix floatx80_lognp1 (Coverity
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
Cc: Laurent Vivier <laurent@vivier.eu>

return the result of packFloatx80() instead of
dropping it.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
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
