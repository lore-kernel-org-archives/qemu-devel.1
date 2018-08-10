Received: from eggs.gnu.org ([2001:4830:134:3::10]:59128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8Q-0002Se-0r
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1foD8P-0005fV-B5
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:42 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1foD8P-0005f2-5O
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 15:31:41 -0400
Received: by mail-pg1-x543.google.com with SMTP id r1-v6so4829227pgp.11
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 12:31:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 10 Aug 2018 12:31:29 -0700
Message-Id: <20180810193129.1556-7-richard.henderson@linaro.org>
In-Reply-To: <20180810193129.1556-1-richard.henderson@linaro.org>
References: <20180810193129.1556-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 6/6] softfloat: Fix missing inexact for
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, alex.bennee@linaro.org

For 0x1.0000000000003p+0 + 0x1.ffffffep+14 = 0x1.0001fffp+15
we dropped the sticky bit and so failed to raise inexact.

Reported-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 8cd2400081..7d63cffdeb 100644
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
2.17.1
