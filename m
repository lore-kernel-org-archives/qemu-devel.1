Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6744C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B75120714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nPxpTUTX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B75120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbjE-0005B6-NB
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcL-00026u-R4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcI-0001Jg-IO
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:53 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:55236)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcI-0001J4-9Y
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:50 -0400
Received: by mail-pj1-x1044.google.com with SMTP id np9so3088352pjb.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jC3lzQRoD9FYu6PU7hez8Vvm2StpyVGzvHCSmbTwtC4=;
 b=nPxpTUTXZgSbtkfAVT1ucMgmZz4RroG/rSKGEVdxBMA0DjxMpyk4u1jpMy3WY0c6iH
 YQYoikICQPy9ls+eZlB+NCluAq773ZUu0kRzyjKuGPgBioQYxdwBa1yZHzhgUliRjcer
 7durjlmiTkTy/KPMqxibQ1k7ynzRCkePuIsY6e1yGLPN0heS7wPMID6+ge2f5JUNZ7Yg
 x7/j18ZgELxd7fvXzdLtMLDOukWV7dhnuFaBtKfY78WIkUaRt3D+yuxJz9EQ4fF3Yqyq
 95cKTTcrf6LpuNmvvAkwR34bozawG/7EfH+HfVBCoEcex0a1b+cVbrvYYcrPQ+WVDqBW
 NSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jC3lzQRoD9FYu6PU7hez8Vvm2StpyVGzvHCSmbTwtC4=;
 b=qxdCtDNwb6OnJucKh6DMfITDyXb3Iw3M+3+AKFAAGIivM/4SOX/N3vd7WTIS0MB8Ts
 4shctRVgl99/ansN5c6O8kJJQUv/U1Ub2kyjMuEe30ED8ittxUBd6YszwkSLLAPWDRYy
 1yw0CRQjFr1WBIqh233V27Pfhm51h9Ydd6AqSAdO32EulEMiN5B+rEkmRmkHi9pLnvdm
 iC0cYxoZ66l4SgjLpZ5bnADiYNEoNDKh10rm8ZdBniJkHb1J1OesaB4s4JXK1CckQZME
 qdEETQt0eNXRdlb90XHkLA8kLENK+lpWDoyQ4DuK8EIhI8h1qrXpw7Dgf1CBSKcvAh6D
 Hqjw==
X-Gm-Message-State: ANhLgQ2KjfPhlzXZI41NZAFtBrDryDsMOiuCzGQEhBjXRscrkz1AF6Fd
 0Elq367xnT4gj2tDYnEzMylWqfz+Mxs=
X-Google-Smtp-Source: ADFU+vvDmP4jM8JgQtkPvRUSdXzDBov/5PMCVlbI+rguK/3aFgTiPCksWbI0VnIgYyjf6nDxEvdZug==
X-Received: by 2002:a17:902:5984:: with SMTP id
 p4mr10599828pli.43.1585264127804; 
 Thu, 26 Mar 2020 16:08:47 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/31] target/arm: Split out saturating/rounding shifts from
 neon
Date: Thu, 26 Mar 2020 16:08:13 -0700
Message-Id: <20200326230838.31112-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Split these operations out into a header that can be shared
between neon and sve.  The "sat" pointer acts both as a boolean
for control of saturating behavior and controls the difference
in behavior between neon and sve -- QC bit or no QC bit.

Implement right-shift rounding as

    tmp = src >> (shift - 1);
    dst = (tmp >> 1) + (tmp & 1);

This is the same number of instructions as the current

    tmp = 1 << (shift - 1);
    dst = (src + tmp) >> shift;

without any possibility of intermediate overflow.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vec_internal.h | 161 ++++++++++++
 target/arm/neon_helper.c  | 507 +++++++-------------------------------
 2 files changed, 244 insertions(+), 424 deletions(-)
 create mode 100644 target/arm/vec_internal.h

diff --git a/target/arm/vec_internal.h b/target/arm/vec_internal.h
new file mode 100644
index 0000000000..0d1f9c86c8
--- /dev/null
+++ b/target/arm/vec_internal.h
@@ -0,0 +1,161 @@
+/*
+ * ARM AdvSIMD / SVE Vector Helpers
+ *
+ * Copyright (c) 2020 Linaro
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef TARGET_ARM_VEC_INTERNALS_H
+#define TARGET_ARM_VEC_INTERNALS_H
+
+static inline int32_t do_sqrshl_bhs(int32_t src, int8_t shift, int bits,
+                                    bool round, uint32_t *sat)
+{
+    if (shift <= -bits) {
+        /* Rounding the sign bit always produces 0. */
+        if (round) {
+            return 0;
+        }
+        return src >> 31;
+    } else if (shift < 0) {
+        if (round) {
+            src >>= -shift - 1;
+            return (src >> 1) + (src & 1);
+        }
+        return src >> -shift;
+    } else if (shift < bits) {
+        int32_t val = src << shift;
+        if (bits == 32) {
+            if (!sat || val >> shift == src) {
+                return val;
+            }
+        } else {
+            int32_t extval = sextract32(val, 0, bits);
+            if (!sat || val == extval) {
+                return extval;
+            }
+        }
+    } else if (!sat || src == 0) {
+        return 0;
+    }
+
+    *sat = 1;
+    return (1u << (bits - 1)) - (src >= 0);
+}
+
+static inline uint32_t do_uqrshl_bhs(uint32_t src, int8_t shift, int bits,
+                                     bool round, uint32_t *sat)
+{
+    if (shift <= -(bits + round)) {
+        return 0;
+    } else if (shift < 0) {
+        if (round) {
+            src >>= -shift - 1;
+            return (src >> 1) + (src & 1);
+        }
+        return src >> -shift;
+    } else if (shift < bits) {
+        uint32_t val = src << shift;
+        if (bits == 32) {
+            if (!sat || val >> shift == src) {
+                return val;
+            }
+        } else {
+            uint32_t extval = extract32(val, 0, bits);
+            if (!sat || val == extval) {
+                return extval;
+            }
+        }
+    } else if (!sat || src == 0) {
+        return 0;
+    }
+
+    *sat = 1;
+    return MAKE_64BIT_MASK(0, bits);
+}
+
+static inline int32_t do_suqrshl_bhs(int32_t src, int8_t shift, int bits,
+                                     bool round, uint32_t *sat)
+{
+    if (src < 0) {
+        *sat = 1;
+        return 0;
+    }
+    return do_uqrshl_bhs(src, shift, bits, round, sat);
+}
+
+static inline int64_t do_sqrshl_d(int64_t src, int8_t shift,
+                                  bool round, uint32_t *sat)
+{
+    if (shift <= -64) {
+        /* Rounding the sign bit always produces 0. */
+        if (round) {
+            return 0;
+        }
+        return src >> 63;
+    } else if (shift < 0) {
+        if (round) {
+            src >>= -shift - 1;
+            return (src >> 1) + (src & 1);
+        }
+        return src >> -shift;
+    } else if (shift < 64) {
+        int64_t val = src << shift;
+        if (!sat || val >> shift == src) {
+            return val;
+        }
+    } else if (!sat || src == 0) {
+        return 0;
+    }
+
+    *sat = 1;
+    return src < 0 ? INT64_MIN : INT64_MAX;
+}
+
+static inline uint64_t do_uqrshl_d(uint64_t src, int8_t shift,
+                                   bool round, uint32_t *sat)
+{
+    if (shift <= -(64 + round)) {
+        return 0;
+    } else if (shift < 0) {
+        if (round) {
+            src >>= -shift - 1;
+            return (src >> 1) + (src & 1);
+        }
+        return src >> -shift;
+    } else if (shift < 64) {
+        uint64_t val = src << shift;
+        if (!sat || val >> shift == src) {
+            return val;
+        }
+    } else if (!sat || src == 0) {
+        return 0;
+    }
+
+    *sat = 1;
+    return UINT64_MAX;
+}
+
+static inline int64_t do_suqrshl_d(int64_t src, int8_t shift,
+                                   bool round, uint32_t *sat)
+{
+    if (src < 0) {
+        *sat = 1;
+        return 0;
+    }
+    return do_uqrshl_d(src, shift, round, sat);
+}
+
+#endif /* TARGET_ARM_VEC_INTERNALS_H */
diff --git a/target/arm/neon_helper.c b/target/arm/neon_helper.c
index c7a8438b42..e6481a5764 100644
--- a/target/arm/neon_helper.c
+++ b/target/arm/neon_helper.c
@@ -11,6 +11,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "fpu/softfloat.h"
+#include "vec_internal.h"
 
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
@@ -604,496 +605,154 @@ NEON_VOP(abd_s32, neon_s32, 1)
 NEON_VOP(abd_u32, neon_u32, 1)
 #undef NEON_FN
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if (tmp >= (ssize_t)sizeof(src1) * 8 || \
-        tmp <= -(ssize_t)sizeof(src1) * 8) { \
-        dest = 0; \
-    } else if (tmp < 0) { \
-        dest = src1 >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-    }} while (0)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, src2, 16, false, NULL))
 NEON_VOP(shl_u16, neon_u16, 2)
 #undef NEON_FN
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if (tmp >= (ssize_t)sizeof(src1) * 8) { \
-        dest = 0; \
-    } else if (tmp <= -(ssize_t)sizeof(src1) * 8) { \
-        dest = src1 >> (sizeof(src1) * 8 - 1); \
-    } else if (tmp < 0) { \
-        dest = src1 >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-    }} while (0)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, src2, 16, false, NULL))
 NEON_VOP(shl_s16, neon_s16, 2)
 #undef NEON_FN
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if ((tmp >= (ssize_t)sizeof(src1) * 8) \
-        || (tmp <= -(ssize_t)sizeof(src1) * 8)) { \
-        dest = 0; \
-    } else if (tmp < 0) { \
-        dest = (src1 + (1 << (-1 - tmp))) >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-    }} while (0)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, src2, 8, true, NULL))
 NEON_VOP(rshl_s8, neon_s8, 4)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, src2, 16, true, NULL))
 NEON_VOP(rshl_s16, neon_s16, 2)
 #undef NEON_FN
 
-/* The addition of the rounding constant may overflow, so we use an
- * intermediate 64 bit accumulator.  */
-uint32_t HELPER(neon_rshl_s32)(uint32_t valop, uint32_t shiftop)
+uint32_t HELPER(neon_rshl_s32)(uint32_t val, uint32_t shift)
 {
-    int32_t dest;
-    int32_t val = (int32_t)valop;
-    int8_t shift = (int8_t)shiftop;
-    if ((shift >= 32) || (shift <= -32)) {
-        dest = 0;
-    } else if (shift < 0) {
-        int64_t big_dest = ((int64_t)val + (1 << (-1 - shift)));
-        dest = big_dest >> -shift;
-    } else {
-        dest = val << shift;
-    }
-    return dest;
+    return do_sqrshl_bhs(val, shift, 32, true, NULL);
 }
 
-/* Handling addition overflow with 64 bit input values is more
- * tricky than with 32 bit values.  */
-uint64_t HELPER(neon_rshl_s64)(uint64_t valop, uint64_t shiftop)
+uint64_t HELPER(neon_rshl_s64)(uint64_t val, uint64_t shift)
 {
-    int8_t shift = (int8_t)shiftop;
-    int64_t val = valop;
-    if ((shift >= 64) || (shift <= -64)) {
-        val = 0;
-    } else if (shift < 0) {
-        val >>= (-shift - 1);
-        if (val == INT64_MAX) {
-            /* In this case, it means that the rounding constant is 1,
-             * and the addition would overflow. Return the actual
-             * result directly.  */
-            val = 0x4000000000000000LL;
-        } else {
-            val++;
-            val >>= 1;
-        }
-    } else {
-        val <<= shift;
-    }
-    return val;
+    return do_sqrshl_d(val, shift, true, NULL);
 }
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if (tmp >= (ssize_t)sizeof(src1) * 8 || \
-        tmp < -(ssize_t)sizeof(src1) * 8) { \
-        dest = 0; \
-    } else if (tmp == -(ssize_t)sizeof(src1) * 8) { \
-        dest = src1 >> (-tmp - 1); \
-    } else if (tmp < 0) { \
-        dest = (src1 + (1 << (-1 - tmp))) >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-    }} while (0)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, src2, 8, true, NULL))
 NEON_VOP(rshl_u8, neon_u8, 4)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, src2, 16, true, NULL))
 NEON_VOP(rshl_u16, neon_u16, 2)
 #undef NEON_FN
 
-/* The addition of the rounding constant may overflow, so we use an
- * intermediate 64 bit accumulator.  */
-uint32_t HELPER(neon_rshl_u32)(uint32_t val, uint32_t shiftop)
+uint32_t HELPER(neon_rshl_u32)(uint32_t val, uint32_t shift)
 {
-    uint32_t dest;
-    int8_t shift = (int8_t)shiftop;
-    if (shift >= 32 || shift < -32) {
-        dest = 0;
-    } else if (shift == -32) {
-        dest = val >> 31;
-    } else if (shift < 0) {
-        uint64_t big_dest = ((uint64_t)val + (1 << (-1 - shift)));
-        dest = big_dest >> -shift;
-    } else {
-        dest = val << shift;
-    }
-    return dest;
+    return do_uqrshl_bhs(val, shift, 32, true, NULL);
 }
 
-/* Handling addition overflow with 64 bit input values is more
- * tricky than with 32 bit values.  */
-uint64_t HELPER(neon_rshl_u64)(uint64_t val, uint64_t shiftop)
+uint64_t HELPER(neon_rshl_u64)(uint64_t val, uint64_t shift)
 {
-    int8_t shift = (uint8_t)shiftop;
-    if (shift >= 64 || shift < -64) {
-        val = 0;
-    } else if (shift == -64) {
-        /* Rounding a 1-bit result just preserves that bit.  */
-        val >>= 63;
-    } else if (shift < 0) {
-        val >>= (-shift - 1);
-        if (val == UINT64_MAX) {
-            /* In this case, it means that the rounding constant is 1,
-             * and the addition would overflow. Return the actual
-             * result directly.  */
-            val = 0x8000000000000000ULL;
-        } else {
-            val++;
-            val >>= 1;
-        }
-    } else {
-        val <<= shift;
-    }
-    return val;
+    return do_uqrshl_d(val, shift, true, NULL);
 }
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if (tmp >= (ssize_t)sizeof(src1) * 8) { \
-        if (src1) { \
-            SET_QC(); \
-            dest = ~0; \
-        } else { \
-            dest = 0; \
-        } \
-    } else if (tmp <= -(ssize_t)sizeof(src1) * 8) { \
-        dest = 0; \
-    } else if (tmp < 0) { \
-        dest = src1 >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-        if ((dest >> tmp) != src1) { \
-            SET_QC(); \
-            dest = ~0; \
-        } \
-    }} while (0)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, src2, 8, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_u8, neon_u8, 4)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, src2, 16, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_u16, neon_u16, 2)
-NEON_VOP_ENV(qshl_u32, neon_u32, 1)
 #undef NEON_FN
 
-uint64_t HELPER(neon_qshl_u64)(CPUARMState *env, uint64_t val, uint64_t shiftop)
+uint32_t HELPER(neon_qshl_u32)(CPUARMState *env, uint32_t val, uint32_t shift)
 {
-    int8_t shift = (int8_t)shiftop;
-    if (shift >= 64) {
-        if (val) {
-            val = ~(uint64_t)0;
-            SET_QC();
-        }
-    } else if (shift <= -64) {
-        val = 0;
-    } else if (shift < 0) {
-        val >>= -shift;
-    } else {
-        uint64_t tmp = val;
-        val <<= shift;
-        if ((val >> shift) != tmp) {
-            SET_QC();
-            val = ~(uint64_t)0;
-        }
-    }
-    return val;
+    return do_uqrshl_bhs(val, shift, 32, false, env->vfp.qc);
 }
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if (tmp >= (ssize_t)sizeof(src1) * 8) { \
-        if (src1) { \
-            SET_QC(); \
-            dest = (uint32_t)(1 << (sizeof(src1) * 8 - 1)); \
-            if (src1 > 0) { \
-                dest--; \
-            } \
-        } else { \
-            dest = src1; \
-        } \
-    } else if (tmp <= -(ssize_t)sizeof(src1) * 8) { \
-        dest = src1 >> 31; \
-    } else if (tmp < 0) { \
-        dest = src1 >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-        if ((dest >> tmp) != src1) { \
-            SET_QC(); \
-            dest = (uint32_t)(1 << (sizeof(src1) * 8 - 1)); \
-            if (src1 > 0) { \
-                dest--; \
-            } \
-        } \
-    }} while (0)
+uint64_t HELPER(neon_qshl_u64)(CPUARMState *env, uint64_t val, uint64_t shift)
+{
+    return do_uqrshl_d(val, shift, false, env->vfp.qc);
+}
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, src2, 8, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_s8, neon_s8, 4)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, src2, 16, false, env->vfp.qc))
 NEON_VOP_ENV(qshl_s16, neon_s16, 2)
-NEON_VOP_ENV(qshl_s32, neon_s32, 1)
 #undef NEON_FN
 
-uint64_t HELPER(neon_qshl_s64)(CPUARMState *env, uint64_t valop, uint64_t shiftop)
+uint32_t HELPER(neon_qshl_s32)(CPUARMState *env, uint32_t val, uint32_t shift)
 {
-    int8_t shift = (uint8_t)shiftop;
-    int64_t val = valop;
-    if (shift >= 64) {
-        if (val) {
-            SET_QC();
-            val = (val >> 63) ^ ~SIGNBIT64;
-        }
-    } else if (shift <= -64) {
-        val >>= 63;
-    } else if (shift < 0) {
-        val >>= -shift;
-    } else {
-        int64_t tmp = val;
-        val <<= shift;
-        if ((val >> shift) != tmp) {
-            SET_QC();
-            val = (tmp >> 63) ^ ~SIGNBIT64;
-        }
-    }
-    return val;
+    return do_sqrshl_bhs(val, shift, 32, false, env->vfp.qc);
 }
 
-#define NEON_FN(dest, src1, src2) do { \
-    if (src1 & (1 << (sizeof(src1) * 8 - 1))) { \
-        SET_QC(); \
-        dest = 0; \
-    } else { \
-        int8_t tmp; \
-        tmp = (int8_t)src2; \
-        if (tmp >= (ssize_t)sizeof(src1) * 8) { \
-            if (src1) { \
-                SET_QC(); \
-                dest = ~0; \
-            } else { \
-                dest = 0; \
-            } \
-        } else if (tmp <= -(ssize_t)sizeof(src1) * 8) { \
-            dest = 0; \
-        } else if (tmp < 0) { \
-            dest = src1 >> -tmp; \
-        } else { \
-            dest = src1 << tmp; \
-            if ((dest >> tmp) != src1) { \
-                SET_QC(); \
-                dest = ~0; \
-            } \
-        } \
-    }} while (0)
-NEON_VOP_ENV(qshlu_s8, neon_u8, 4)
-NEON_VOP_ENV(qshlu_s16, neon_u16, 2)
+uint64_t HELPER(neon_qshl_s64)(CPUARMState *env, uint64_t val, uint64_t shift)
+{
+    return do_sqrshl_d(val, shift, false, env->vfp.qc);
+}
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_suqrshl_bhs(src1, src2, 8, false, env->vfp.qc))
+NEON_VOP_ENV(qshlu_s8, neon_s8, 4)
 #undef NEON_FN
 
-uint32_t HELPER(neon_qshlu_s32)(CPUARMState *env, uint32_t valop, uint32_t shiftop)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_suqrshl_bhs(src1, src2, 16, false, env->vfp.qc))
+NEON_VOP_ENV(qshlu_s16, neon_s16, 2)
+#undef NEON_FN
+
+uint32_t HELPER(neon_qshlu_s32)(CPUARMState *env, uint32_t val, uint32_t shift)
 {
-    if ((int32_t)valop < 0) {
-        SET_QC();
-        return 0;
-    }
-    return helper_neon_qshl_u32(env, valop, shiftop);
+    return do_suqrshl_bhs(val, shift, 32, false, env->vfp.qc);
 }
 
-uint64_t HELPER(neon_qshlu_s64)(CPUARMState *env, uint64_t valop, uint64_t shiftop)
+uint64_t HELPER(neon_qshlu_s64)(CPUARMState *env, uint64_t val, uint64_t shift)
 {
-    if ((int64_t)valop < 0) {
-        SET_QC();
-        return 0;
-    }
-    return helper_neon_qshl_u64(env, valop, shiftop);
+    return do_suqrshl_d(val, shift, false, env->vfp.qc);
 }
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if (tmp >= (ssize_t)sizeof(src1) * 8) { \
-        if (src1) { \
-            SET_QC(); \
-            dest = ~0; \
-        } else { \
-            dest = 0; \
-        } \
-    } else if (tmp < -(ssize_t)sizeof(src1) * 8) { \
-        dest = 0; \
-    } else if (tmp == -(ssize_t)sizeof(src1) * 8) { \
-        dest = src1 >> (sizeof(src1) * 8 - 1); \
-    } else if (tmp < 0) { \
-        dest = (src1 + (1 << (-1 - tmp))) >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-        if ((dest >> tmp) != src1) { \
-            SET_QC(); \
-            dest = ~0; \
-        } \
-    }} while (0)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, src2, 8, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_u8, neon_u8, 4)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_uqrshl_bhs(src1, src2, 16, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_u16, neon_u16, 2)
 #undef NEON_FN
 
-/* The addition of the rounding constant may overflow, so we use an
- * intermediate 64 bit accumulator.  */
-uint32_t HELPER(neon_qrshl_u32)(CPUARMState *env, uint32_t val, uint32_t shiftop)
+uint32_t HELPER(neon_qrshl_u32)(CPUARMState *env, uint32_t val, uint32_t shift)
 {
-    uint32_t dest;
-    int8_t shift = (int8_t)shiftop;
-    if (shift >= 32) {
-        if (val) {
-            SET_QC();
-            dest = ~0;
-        } else {
-            dest = 0;
-        }
-    } else if (shift < -32) {
-        dest = 0;
-    } else if (shift == -32) {
-        dest = val >> 31;
-    } else if (shift < 0) {
-        uint64_t big_dest = ((uint64_t)val + (1 << (-1 - shift)));
-        dest = big_dest >> -shift;
-    } else {
-        dest = val << shift;
-        if ((dest >> shift) != val) {
-            SET_QC();
-            dest = ~0;
-        }
-    }
-    return dest;
+    return do_uqrshl_bhs(val, shift, 32, true, env->vfp.qc);
 }
 
-/* Handling addition overflow with 64 bit input values is more
- * tricky than with 32 bit values.  */
-uint64_t HELPER(neon_qrshl_u64)(CPUARMState *env, uint64_t val, uint64_t shiftop)
+uint64_t HELPER(neon_qrshl_u64)(CPUARMState *env, uint64_t val, uint64_t shift)
 {
-    int8_t shift = (int8_t)shiftop;
-    if (shift >= 64) {
-        if (val) {
-            SET_QC();
-            val = ~0;
-        }
-    } else if (shift < -64) {
-        val = 0;
-    } else if (shift == -64) {
-        val >>= 63;
-    } else if (shift < 0) {
-        val >>= (-shift - 1);
-        if (val == UINT64_MAX) {
-            /* In this case, it means that the rounding constant is 1,
-             * and the addition would overflow. Return the actual
-             * result directly.  */
-            val = 0x8000000000000000ULL;
-        } else {
-            val++;
-            val >>= 1;
-        }
-    } else { \
-        uint64_t tmp = val;
-        val <<= shift;
-        if ((val >> shift) != tmp) {
-            SET_QC();
-            val = ~0;
-        }
-    }
-    return val;
+    return do_uqrshl_d(val, shift, true, env->vfp.qc);
 }
 
-#define NEON_FN(dest, src1, src2) do { \
-    int8_t tmp; \
-    tmp = (int8_t)src2; \
-    if (tmp >= (ssize_t)sizeof(src1) * 8) { \
-        if (src1) { \
-            SET_QC(); \
-            dest = (typeof(dest))(1 << (sizeof(src1) * 8 - 1)); \
-            if (src1 > 0) { \
-                dest--; \
-            } \
-        } else { \
-            dest = 0; \
-        } \
-    } else if (tmp <= -(ssize_t)sizeof(src1) * 8) { \
-        dest = 0; \
-    } else if (tmp < 0) { \
-        dest = (src1 + (1 << (-1 - tmp))) >> -tmp; \
-    } else { \
-        dest = src1 << tmp; \
-        if ((dest >> tmp) != src1) { \
-            SET_QC(); \
-            dest = (uint32_t)(1 << (sizeof(src1) * 8 - 1)); \
-            if (src1 > 0) { \
-                dest--; \
-            } \
-        } \
-    }} while (0)
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, src2, 8, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_s8, neon_s8, 4)
+#undef NEON_FN
+
+#define NEON_FN(dest, src1, src2) \
+    (dest = do_sqrshl_bhs(src1, src2, 16, true, env->vfp.qc))
 NEON_VOP_ENV(qrshl_s16, neon_s16, 2)
 #undef NEON_FN
 
-/* The addition of the rounding constant may overflow, so we use an
- * intermediate 64 bit accumulator.  */
-uint32_t HELPER(neon_qrshl_s32)(CPUARMState *env, uint32_t valop, uint32_t shiftop)
+uint32_t HELPER(neon_qrshl_s32)(CPUARMState *env, uint32_t val, uint32_t shift)
 {
-    int32_t dest;
-    int32_t val = (int32_t)valop;
-    int8_t shift = (int8_t)shiftop;
-    if (shift >= 32) {
-        if (val) {
-            SET_QC();
-            dest = (val >> 31) ^ ~SIGNBIT;
-        } else {
-            dest = 0;
-        }
-    } else if (shift <= -32) {
-        dest = 0;
-    } else if (shift < 0) {
-        int64_t big_dest = ((int64_t)val + (1 << (-1 - shift)));
-        dest = big_dest >> -shift;
-    } else {
-        dest = val << shift;
-        if ((dest >> shift) != val) {
-            SET_QC();
-            dest = (val >> 31) ^ ~SIGNBIT;
-        }
-    }
-    return dest;
+    return do_sqrshl_bhs(val, shift, 32, true, env->vfp.qc);
 }
 
-/* Handling addition overflow with 64 bit input values is more
- * tricky than with 32 bit values.  */
-uint64_t HELPER(neon_qrshl_s64)(CPUARMState *env, uint64_t valop, uint64_t shiftop)
+uint64_t HELPER(neon_qrshl_s64)(CPUARMState *env, uint64_t val, uint64_t shift)
 {
-    int8_t shift = (uint8_t)shiftop;
-    int64_t val = valop;
-
-    if (shift >= 64) {
-        if (val) {
-            SET_QC();
-            val = (val >> 63) ^ ~SIGNBIT64;
-        }
-    } else if (shift <= -64) {
-        val = 0;
-    } else if (shift < 0) {
-        val >>= (-shift - 1);
-        if (val == INT64_MAX) {
-            /* In this case, it means that the rounding constant is 1,
-             * and the addition would overflow. Return the actual
-             * result directly.  */
-            val = 0x4000000000000000ULL;
-        } else {
-            val++;
-            val >>= 1;
-        }
-    } else {
-        int64_t tmp = val;
-        val <<= shift;
-        if ((val >> shift) != tmp) {
-            SET_QC();
-            val = (tmp >> 63) ^ ~SIGNBIT64;
-        }
-    }
-    return val;
+    return do_sqrshl_d(val, shift, true, env->vfp.qc);
 }
 
 uint32_t HELPER(neon_add_u8)(uint32_t a, uint32_t b)
-- 
2.20.1


