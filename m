Received: from eggs.gnu.org ([2001:4830:134:3::10]:52480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhv-0007yG-E4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fILhu-0007mc-BS
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:39 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:40995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fILhu-0007km-5E
	for qemu-devel@nongnu.org; Mon, 14 May 2018 18:12:38 -0400
Received: by mail-pf0-x242.google.com with SMTP id v63-v6so6663117pfk.8
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 15:12:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 14 May 2018 15:12:02 -0700
Message-Id: <20180514221219.7091-12-richard.henderson@linaro.org>
In-Reply-To: <20180514221219.7091-1-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 11/28] target/arm: squash FZ16 behaviour for
 conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

From: Alex Bennée <alex.bennee@linaro.org>

The ARM ARM specifies FZ16 is suppressed for conversions. Rather than
pushing this logic into the softfloat code we can simply save the FZ
state and temporarily disable it for the softfloat call.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
v4
  - float16_to_floatX squished the wrong softfloat bit for FZ16;
    need to adjust input denormals in this case.
---
 target/arm/helper.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a1c1dc5bbe..e05c7230d4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11542,22 +11542,54 @@ uint32_t HELPER(set_neon_rmode)(uint32_t rmode, CPUARMState *env)
 /* Half precision conversions.  */
 float32 HELPER(vfp_fcvt_f16_to_f32)(float16 a, void *fpstp, uint32_t ahp_mode)
 {
-    return float16_to_float32(a, !ahp_mode, fpstp);
+    /* Squash FZ16 to 0 for the duration of conversion.  In this case,
+     * it would affect flushing input denormals.
+     */
+    float_status *fpst = fpstp;
+    flag save = get_flush_inputs_to_zero(fpst);
+    set_flush_inputs_to_zero(false, fpst);
+    float32 r = float16_to_float32(a, !ahp_mode, fpst);
+    set_flush_inputs_to_zero(save, fpst);
+    return r;
 }
 
 float16 HELPER(vfp_fcvt_f32_to_f16)(float32 a, void *fpstp, uint32_t ahp_mode)
 {
-    return float32_to_float16(a, !ahp_mode, fpstp);
+    /* Squash FZ16 to 0 for the duration of conversion.  In this case,
+     * it would affect flushing output denormals.
+     */
+    float_status *fpst = fpstp;
+    flag save = get_flush_to_zero(fpst);
+    set_flush_to_zero(false, fpst);
+    float16 r = float32_to_float16(a, !ahp_mode, fpst);
+    set_flush_to_zero(save, fpst);
+    return r;
 }
 
 float64 HELPER(vfp_fcvt_f16_to_f64)(float16 a, void *fpstp, uint32_t ahp_mode)
 {
-    return float16_to_float64(a, !ahp_mode, fpstp);
+    /* Squash FZ16 to 0 for the duration of conversion.  In this case,
+     * it would affect flushing input denormals.
+     */
+    float_status *fpst = fpstp;
+    flag save = get_flush_inputs_to_zero(fpst);
+    set_flush_inputs_to_zero(false, fpst);
+    float64 r = float16_to_float64(a, !ahp_mode, fpst);
+    set_flush_inputs_to_zero(save, fpst);
+    return r;
 }
 
 float16 HELPER(vfp_fcvt_f64_to_f16)(float64 a, void *fpstp, uint32_t ahp_mode)
 {
-    return float64_to_float16(a, !ahp_mode, fpstp);
+    /* Squash FZ16 to 0 for the duration of conversion.  In this case,
+     * it would affect flushing output denormals.
+     */
+    float_status *fpst = fpstp;
+    flag save = get_flush_to_zero(fpst);
+    set_flush_to_zero(false, fpst);
+    float16 r = float64_to_float16(a, !ahp_mode, fpst);
+    set_flush_to_zero(save, fpst);
+    return r;
 }
 
 #define float32_two make_float32(0x40000000)
-- 
2.17.0
