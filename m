Received: from eggs.gnu.org ([2001:4830:134:3::10]:39616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOT-0003VP-Ug
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOR-0005ia-Vr
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:05 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:32906)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIiOR-0005bE-NA
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:03 -0400
Received: by mail-pf0-x234.google.com with SMTP id a20-v6so745363pfo.0
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:26:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 May 2018 15:25:25 -0700
Message-Id: <20180515222540.9988-14-richard.henderson@linaro.org>
In-Reply-To: <20180515222540.9988-1-richard.henderson@linaro.org>
References: <20180515222540.9988-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 13/28] target/arm: Use floatX_silence_nan
 when we have already checked for SNaN
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.c |  6 +++---
 target/arm/helper.c     | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 4f8034c513..6f0eb83661 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -376,7 +376,7 @@ float16 HELPER(frecpx_f16)(float16 a, void *fpstp)
         float16 nan = a;
         if (float16_is_signaling_nan(a, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            nan = float16_maybe_silence_nan(a, fpst);
+            nan = float16_silence_nan(a, fpst);
         }
         if (fpst->default_nan_mode) {
             nan = float16_default_nan(fpst);
@@ -405,7 +405,7 @@ float32 HELPER(frecpx_f32)(float32 a, void *fpstp)
         float32 nan = a;
         if (float32_is_signaling_nan(a, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            nan = float32_maybe_silence_nan(a, fpst);
+            nan = float32_silence_nan(a, fpst);
         }
         if (fpst->default_nan_mode) {
             nan = float32_default_nan(fpst);
@@ -434,7 +434,7 @@ float64 HELPER(frecpx_f64)(float64 a, void *fpstp)
         float64 nan = a;
         if (float64_is_signaling_nan(a, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            nan = float64_maybe_silence_nan(a, fpst);
+            nan = float64_silence_nan(a, fpst);
         }
         if (fpst->default_nan_mode) {
             nan = float64_default_nan(fpst);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 238a3ceba8..e05c7230d4 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -11731,7 +11731,7 @@ float16 HELPER(recpe_f16)(float16 input, void *fpstp)
         float16 nan = f16;
         if (float16_is_signaling_nan(f16, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            nan = float16_maybe_silence_nan(f16, fpst);
+            nan = float16_silence_nan(f16, fpst);
         }
         if (fpst->default_nan_mode) {
             nan =  float16_default_nan(fpst);
@@ -11779,7 +11779,7 @@ float32 HELPER(recpe_f32)(float32 input, void *fpstp)
         float32 nan = f32;
         if (float32_is_signaling_nan(f32, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            nan = float32_maybe_silence_nan(f32, fpst);
+            nan = float32_silence_nan(f32, fpst);
         }
         if (fpst->default_nan_mode) {
             nan =  float32_default_nan(fpst);
@@ -11827,7 +11827,7 @@ float64 HELPER(recpe_f64)(float64 input, void *fpstp)
         float64 nan = f64;
         if (float64_is_signaling_nan(f64, fpst)) {
             float_raise(float_flag_invalid, fpst);
-            nan = float64_maybe_silence_nan(f64, fpst);
+            nan = float64_silence_nan(f64, fpst);
         }
         if (fpst->default_nan_mode) {
             nan =  float64_default_nan(fpst);
@@ -11926,7 +11926,7 @@ float16 HELPER(rsqrte_f16)(float16 input, void *fpstp)
         float16 nan = f16;
         if (float16_is_signaling_nan(f16, s)) {
             float_raise(float_flag_invalid, s);
-            nan = float16_maybe_silence_nan(f16, s);
+            nan = float16_silence_nan(f16, s);
         }
         if (s->default_nan_mode) {
             nan =  float16_default_nan(s);
@@ -11970,7 +11970,7 @@ float32 HELPER(rsqrte_f32)(float32 input, void *fpstp)
         float32 nan = f32;
         if (float32_is_signaling_nan(f32, s)) {
             float_raise(float_flag_invalid, s);
-            nan = float32_maybe_silence_nan(f32, s);
+            nan = float32_silence_nan(f32, s);
         }
         if (s->default_nan_mode) {
             nan =  float32_default_nan(s);
@@ -12013,7 +12013,7 @@ float64 HELPER(rsqrte_f64)(float64 input, void *fpstp)
         float64 nan = f64;
         if (float64_is_signaling_nan(f64, s)) {
             float_raise(float_flag_invalid, s);
-            nan = float64_maybe_silence_nan(f64, s);
+            nan = float64_silence_nan(f64, s);
         }
         if (s->default_nan_mode) {
             nan =  float64_default_nan(s);
-- 
2.17.0
