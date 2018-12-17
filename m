Received: from eggs.gnu.org ([2001:4830:134:3::10]:37274)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqbo-0002Y7-Rf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:58:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqa2-00008P-E6
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:59 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:45113)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqa2-00007h-42
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:58 -0500
Received: by mail-wr1-x42b.google.com with SMTP id t6so11595125wrr.12
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:56:58 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:41 +0000
Message-Id: <20181217105650.27361-7-alex.bennee@linaro.org>
In-Reply-To: <20181217105650.27361-1-alex.bennee@linaro.org>
References: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 06/15] softfloat: rename canonicalize to
 sf_canonicalize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

From: "Emilio G. Cota" <cota@braap.org>

glibc >= 2.25 defines canonicalize in commit eaf5ad0
(Add canonicalize, canonicalizef, canonicalizel., 2016-10-26).

Given that we'll be including <math.h> soon, prepare
for this by prefixing our canonicalize() with sf_ to avoid
clashing with the libc's canonicalize().

Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Tested-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index e1eef954e6..ecdc00c633 100644
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
