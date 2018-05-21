Received: from eggs.gnu.org ([2001:4830:134:3::10]:37538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKoac-0004AN-GH
	for qemu-devel@nongnu.org; Mon, 21 May 2018 13:27:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fKoab-0007Te-Nj
	for qemu-devel@nongnu.org; Mon, 21 May 2018 13:27:18 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 May 2018 18:27:12 +0100
Message-Id: <20180521172712.19930-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] target/arm: Honour FPCR.FZ in FRECPX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The FRECPX instructions should (like most other floating point operations)
honour the FPCR.FZ bit which specifies whether input denormals should
be flushed to zero (or FZ16 for the half-precision version).
We forgot to implement this, which doesn't affect the results (since
the calculation doesn't actually care about the mantissa bits) but did
mean we were failing to set the FPSR.IDC bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.17.0
