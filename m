Received: from eggs.gnu.org ([2001:4830:134:3::10]:59199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQp-0000uy-1Y
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQn-0002CU-1B
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:18 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fqIQm-00027R-Ou
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 09:35:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fqIQj-0000C9-EW
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 14:35:13 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 14:34:37 +0100
Message-Id: <20180816133438.17061-30-peter.maydell@linaro.org>
In-Reply-To: <20180816133438.17061-1-peter.maydell@linaro.org>
References: <20180816133438.17061-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 29/30] softfloat: Fix missing inexact for
 floating-point add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

For 0x1.0000000000003p+0 + 0x1.ffffffep+14 = 0x1.0001fffp+15
we dropped the sticky bit and so failed to raise inexact.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Message-id: 20180810193129.1556-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8cd24000814..7d63cffdeb8 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -701,7 +701,7 @@ static FloatParts addsub_floats(FloatParts a, FloatParts b, bool subtract,
             }
             a.frac += b.frac;
             if (a.frac & DECOMPOSED_OVERFLOW_BIT) {
-                a.frac >>= 1;
+                shift64RightJamming(a.frac, 1, &a.frac);
                 a.exp += 1;
             }
             return a;
-- 
2.18.0
