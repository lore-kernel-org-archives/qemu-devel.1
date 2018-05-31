Received: from eggs.gnu.org ([2001:4830:134:3::10]:41662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUv-0000t4-JK
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUu-0006Y6-M4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:13 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fOOUu-0006TM-Du
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:24:12 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fOOUh-0002ny-Nj
	for qemu-devel@nongnu.org; Thu, 31 May 2018 15:23:59 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 15:23:33 +0100
Message-Id: <20180531142357.904-2-peter.maydell@linaro.org>
In-Reply-To: <20180531142357.904-1-peter.maydell@linaro.org>
References: <20180531142357.904-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/25] target/arm: Honour FPCR.FZ in FRECPX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The FRECPX instructions should (like most other floating point operations)
honour the FPCR.FZ bit which specifies whether input denormals should
be flushed to zero (or FZ16 for the half-precision version).
We forgot to implement this, which doesn't affect the results (since
the calculation doesn't actually care about the mantissa bits) but did
mean we were failing to set the FPSR.IDC bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180521172712.19930-1-peter.maydell@linaro.org
---
 target/arm/helper-a64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index f92bdea732..c4d2a04827 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -384,6 +384,8 @@ float16 HELPER(frecpx_f16)(float16 a, void *fpstp)
         return nan;
     }
 
+    a = float16_squash_input_denormal(a, fpst);
+
     val16 = float16_val(a);
     sbit = 0x8000 & val16;
     exp = extract32(val16, 10, 5);
@@ -413,6 +415,8 @@ float32 HELPER(frecpx_f32)(float32 a, void *fpstp)
         return nan;
     }
 
+    a = float32_squash_input_denormal(a, fpst);
+
     val32 = float32_val(a);
     sbit = 0x80000000ULL & val32;
     exp = extract32(val32, 23, 8);
@@ -442,6 +446,8 @@ float64 HELPER(frecpx_f64)(float64 a, void *fpstp)
         return nan;
     }
 
+    a = float64_squash_input_denormal(a, fpst);
+
     val64 = float64_val(a);
     sbit = 0x8000000000000000ULL & val64;
     exp = extract64(float64_val(a), 52, 11);
-- 
2.17.1
