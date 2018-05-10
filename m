Received: from eggs.gnu.org ([2001:4830:134:3::10]:46181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5W-0002FW-Nq
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fGi5V-0004UI-Hz
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:14 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fGi5V-0004Tl-9k
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:42:13 -0400
Received: by mail-wm0-x244.google.com with SMTP id y189-v6so3199508wmc.3
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 02:42:13 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 10 May 2018 10:42:06 +0100
Message-Id: <20180510094206.15354-6-alex.bennee@linaro.org>
In-Reply-To: <20180510094206.15354-1-alex.bennee@linaro.org>
References: <20180510094206.15354-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 5/5] target/arm: squash FZ16 behaviour for
 conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The ARM ARM specifies FZ16 is suppressed for conversions. Rather than
pushing this logic into the softfloat code we can simply save the FZ
state and temporarily disable it for the softfloat call.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4dd28bb70c..17147be58b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11459,12 +11459,20 @@ uint32_t HELPER(set_neon_rmode)(uint32_t rmode, CPUARMState *env)
 /* Half precision conversions.  */
 static float32 do_fcvt_f16_to_f32(float16 a, float_status *s, bool ahp)
 {
-    return float16_to_float32(a, !ahp, s);
+    flag save_flush_to_zero = s->flush_to_zero;
+    set_flush_to_zero(false, s);
+    float32 r = float16_to_float32(a, !ahp, s);
+    set_flush_to_zero(save_flush_to_zero, s);
+    return r;
 }
 
 static float16 do_fcvt_f32_to_f16(float32 a, float_status *s, bool ahp)
 {
-    return float32_to_float16(a, !ahp, s);
+    flag save_flush_to_zero = s->flush_to_zero;
+    set_flush_to_zero(false, s);
+    float16 r = float32_to_float16(a, !ahp, s);
+    set_flush_to_zero(save_flush_to_zero, s);
+    return float16_val(r);
 }
 
 float32 HELPER(neon_fcvt_f16_to_f32)(float16 a, void *fpstp, uint32_t ahp_mode)
@@ -11494,13 +11502,21 @@ float16 HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
 float64 HELPER(vfp_fcvt_f16_to_f64)(float16 a, void *fpstp, uint32_t ahp_mode)
 {
     float_status *fpst = fpstp;
-    return float16_to_float64(a, !ahp_mode, fpst);
+    flag save_flush_to_zero = fpst->flush_to_zero;
+    set_flush_to_zero(false, fpst);
+    float64 r = float16_to_float64(a, !ahp_mode, fpst);
+    set_flush_to_zero(save_flush_to_zero, fpst);
+    return r;
 }
 
 float16 HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
 {
     float_status *fpst = fpstp;
-    return float64_to_float16(a, !ahp_mode, fpst);
+    flag save_flush_to_zero = fpst->flush_to_zero;
+    set_flush_to_zero(false, fpst);
+    float16 r = float64_to_float16(a, !ahp_mode, fpst);
+    set_flush_to_zero(save_flush_to_zero, fpst);
+    return float16_val(r);
 }
 
 #define float32_two make_float32(0x40000000)
-- 
2.17.0
