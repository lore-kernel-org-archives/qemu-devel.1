Received: from eggs.gnu.org ([2001:4830:134:3::10]:56897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDR-0007uj-G1
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDQ-0000jA-Lz
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:37 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1f5sDQ-0000iH-Ej
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:17:36 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1f5sDP-0007eE-Bu
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 13:17:35 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 13:17:24 +0100
Message-Id: <20180410121724.8549-13-peter.maydell@linaro.org>
In-Reply-To: <20180410121724.8549-1-peter.maydell@linaro.org>
References: <20180410121724.8549-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 12/12] fpu: Fix rounding mode for
 floatN_to_uintM_round_to_zero
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

We incorrectly passed in the current rounding mode
instead of float_round_to_zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20180410055912.934-1-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 fpu/softfloat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 6e16284e66..b46dccc63e 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1486,8 +1486,8 @@ uint ## isz ## _t float ## fsz ## _to_uint ## isz ## _round_to_zero     \
  (float ## fsz a, float_status *s)                                      \
 {                                                                       \
     FloatParts p = float ## fsz ## _unpack_canonical(a, s);             \
-    return round_to_uint_and_pack(p, s->float_rounding_mode,            \
-                                 UINT ## isz ## _MAX, s);               \
+    return round_to_uint_and_pack(p, float_round_to_zero,               \
+                                  UINT ## isz ## _MAX, s);              \
 }
 
 FLOAT_TO_UINT(16, 16)
-- 
2.16.2
