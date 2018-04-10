Received: from eggs.gnu.org ([2001:4830:134:3::10]:56527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5mJO-00046Q-Ls
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f5mJN-0006J9-Ub
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:59:22 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:44248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f5mJN-0006Ip-Bc
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 01:59:21 -0400
Received: by mail-pf0-x244.google.com with SMTP id p15so7356372pff.11
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 22:59:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Apr 2018 15:59:12 +1000
Message-Id: <20180410055912.934-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12] fpu: Fix rounding mode for
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
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org

We incorrectly passed in the current rounding mode
instead of float_round_to_zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---

Found while runnning SVE RISU tests; it should be visible with the
right set of inputs to AdvSIMD RISU tests.


r~

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
2.14.3
