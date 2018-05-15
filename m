Received: from eggs.gnu.org ([2001:4830:134:3::10]:39664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOY-0003a6-Lx
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fIiOX-0006Zb-6s
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:10 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:43388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fIiOX-0006SX-0a
	for qemu-devel@nongnu.org; Tue, 15 May 2018 18:26:09 -0400
Received: by mail-pl0-x242.google.com with SMTP id c41-v6so858715plj.10
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 15:26:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 15 May 2018 15:25:29 -0700
Message-Id: <20180515222540.9988-18-richard.henderson@linaro.org>
In-Reply-To: <20180515222540.9988-1-richard.henderson@linaro.org>
References: <20180515222540.9988-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v6 17/28] target/mips: Remove
 floatX_maybe_silence_nan from conversions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

This is now handled properly by the generic softfloat code.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@mips.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/msa_helper.c | 4 ----
 target/mips/op_helper.c  | 2 --
 2 files changed, 6 deletions(-)

diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index 8fb7a369ca..c74e3cdc65 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -1615,7 +1615,6 @@ static inline float16 float16_from_float32(int32_t a, flag ieee,
       float16 f_val;
 
       f_val = float32_to_float16((float32)a, ieee, status);
-      f_val = float16_maybe_silence_nan(f_val, status);
 
       return a < 0 ? (f_val | (1 << 15)) : f_val;
 }
@@ -1625,7 +1624,6 @@ static inline float32 float32_from_float64(int64_t a, float_status *status)
       float32 f_val;
 
       f_val = float64_to_float32((float64)a, status);
-      f_val = float32_maybe_silence_nan(f_val, status);
 
       return a < 0 ? (f_val | (1 << 31)) : f_val;
 }
@@ -1636,7 +1634,6 @@ static inline float32 float32_from_float16(int16_t a, flag ieee,
       float32 f_val;
 
       f_val = float16_to_float32((float16)a, ieee, status);
-      f_val = float32_maybe_silence_nan(f_val, status);
 
       return a < 0 ? (f_val | (1 << 31)) : f_val;
 }
@@ -1646,7 +1643,6 @@ static inline float64 float64_from_float32(int32_t a, float_status *status)
       float64 f_val;
 
       f_val = float32_to_float64((float64)a, status);
-      f_val = float64_maybe_silence_nan(f_val, status);
 
       return a < 0 ? (f_val | (1ULL << 63)) : f_val;
 }
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 798cdad030..9025f42366 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -2700,7 +2700,6 @@ uint64_t helper_float_cvtd_s(CPUMIPSState *env, uint32_t fst0)
     uint64_t fdt2;
 
     fdt2 = float32_to_float64(fst0, &env->active_fpu.fp_status);
-    fdt2 = float64_maybe_silence_nan(fdt2, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return fdt2;
 }
@@ -2790,7 +2789,6 @@ uint32_t helper_float_cvts_d(CPUMIPSState *env, uint64_t fdt0)
     uint32_t fst2;
 
     fst2 = float64_to_float32(fdt0, &env->active_fpu.fp_status);
-    fst2 = float32_maybe_silence_nan(fst2, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return fst2;
 }
-- 
2.17.0
