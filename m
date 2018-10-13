Received: from eggs.gnu.org ([2001:4830:134:3::10]:57874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCf-0002TE-LE
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gBTCc-0007wP-D4
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:57713)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gBTCc-0007vd-1T
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 19:20:10 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sat, 13 Oct 2018 19:19:24 -0400
Message-Id: <20181013231933.28789-5-cota@braap.org>
In-Reply-To: <20181013231933.28789-1-cota@braap.org>
References: <20181013231933.28789-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 04/13] softfloat: rename canonicalize to
 sf_canonicalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

glibc >= 2.25 defines canonicalize in commit eaf5ad0
(Add canonicalize, canonicalizef, canonicalizel., 2016-10-26).

Given that we'll be including <math.h> soon, prepare
for this by prefixing our canonicalize() with sf_ to avoid
clashing with the libc's canonicalize().

Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 fpu/softfloat.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 46ae206172..0cbb08be32 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -336,8 +336,8 @@ static inline float64 float64_pack_raw(FloatParts p)
 #include "softfloat-specialize.h"
 
 /* Canonicalize EXP and FRAC, setting CLS.  */
-static FloatParts canonicalize(FloatParts part, const FloatFmt *parm,
-                               float_status *status)
+static FloatParts sf_canonicalize(FloatParts part, const FloatFmt *parm,
+                                  float_status *status)
 {
     if (part.exp == parm->exp_max && !parm->arm_althp) {
         if (part.frac == 0) {
@@ -513,7 +513,7 @@ static FloatParts round_canonical(FloatParts p, float_status *s,
 static FloatParts float16a_unpack_canonical(float16 f, float_status *s,
                                             const FloatFmt *params)
 {
-    return canonicalize(float16_unpack_raw(f), params, s);
+    return sf_canonicalize(float16_unpack_raw(f), params, s);
 }
 
 static FloatParts float16_unpack_canonical(float16 f, float_status *s)
@@ -534,7 +534,7 @@ static float16 float16_round_pack_canonical(FloatParts p, float_status *s)
 
 static FloatParts float32_unpack_canonical(float32 f, float_status *s)
 {
-    return canonicalize(float32_unpack_raw(f), &float32_params, s);
+    return sf_canonicalize(float32_unpack_raw(f), &float32_params, s);
 }
 
 static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
@@ -544,7 +544,7 @@ static float32 float32_round_pack_canonical(FloatParts p, float_status *s)
 
 static FloatParts float64_unpack_canonical(float64 f, float_status *s)
 {
-    return canonicalize(float64_unpack_raw(f), &float64_params, s);
+    return sf_canonicalize(float64_unpack_raw(f), &float64_params, s);
 }
 
 static float64 float64_round_pack_canonical(FloatParts p, float_status *s)
-- 
2.17.1
