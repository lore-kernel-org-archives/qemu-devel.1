Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5883C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D9C22208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7abj4+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D9C22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJME9-0007Ul-12
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:39:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLIA-000131-Vz
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:31 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:34500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI2-0007GG-0Y
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:30 -0400
Received: by mail-pj1-x1033.google.com with SMTP id s14so4600306pju.1
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=egH0xasIOAz9Z6IwlRMxrw/89U1wEaObGVqcH5V7c9M=;
 b=M7abj4+fHWWP2lYJIvZLb4aPG1MzQ69wWNxSMOKZ0PX7y9vZgqETR49ZR/GKYLnres
 JYI0goQ8xyhg1A/Tcn3ySkr/3mdgD3IspE3sC5bxypmY43HpA1oBmjRGcTjwZq/Cfi5X
 sriDPcys0m9QEsYmKlY+hWDqwIQWgBTYPwBP3wlzyzFSZdhwAgdY6JpIhVcDp7ejWQyL
 1QSQ7zcLH4kG/zU3YM6KUzTfpsNXO1celZxeyxt5t+zyW9tkwb/s9/5iMM2VC510WJkg
 IgZ1u+uApffp6w4siSkCGtHTJI4T0/M1bh0HE6B5KZsGxgaRO3j9Kufr0hmmmkFzkqHd
 jt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=egH0xasIOAz9Z6IwlRMxrw/89U1wEaObGVqcH5V7c9M=;
 b=XuG30uph2cbldUhqGbHKtLsnIJjmj91V8zloiQOPI9Jq0/I8+Xq/vC7Xz4HCP2/9TE
 EUoErCp/iCbhtRS+aHsQSqdlZ67jucSvJwEm9PjVv3yDX5tDGJ/gtVCqFoT6YLMp89VW
 XyFsC4anvtOZ/xh5tnca42kP65kqAzEqUOjR1+c8PCCkF7Ma/qVUdgrsYKrrVhBoez0h
 /Z4Bunh44VFbTHZmPXRAD5br675QByMbgQPIC8pDHJmW7Hr5xuI/GpIvHGANsjOZwWEk
 5rCjzciFnEpvqBtr9ZGn1y4iJBR6EnzHCTlpPI7uQtbRe9QjOa9FxSiKPrq+JZpozPji
 ERWg==
X-Gm-Message-State: AOAM5333iRafqfxCnSknxDEB30Ieg7DH2/uq9BON7U/M5SZ9Y4efq269
 VFcyIx83qA1J+BfkB/WaGxn9yWyKRsjalw==
X-Google-Smtp-Source: ABdhPJxi0GbsJga4Z3Y9GZPUrNjhm6NYsAD03x+qnMC3z8Wb/s/DrtqLZJgAySIqoyu/OYb1ieOAtw==
X-Received: by 2002:a17:90b:a51:: with SMTP id
 gw17mr14714220pjb.118.1600454358930; 
 Fri, 18 Sep 2020 11:39:18 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 64/81] target/arm: Implement SVE2 complex integer
 multiply-add (indexed)
Date: Fri, 18 Sep 2020 11:37:34 -0700
Message-Id: <20200918183751.2787647-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |   9 +++
 target/arm/sve.decode      |  12 ++++
 target/arm/sve_helper.c    | 142 +++++++++++++++++++++++++++++++------
 target/arm/translate-sve.c |  38 +++++++---
 4 files changed, 169 insertions(+), 32 deletions(-)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 90872fa0e6..671b3a8804 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2715,3 +2715,12 @@ DEF_HELPER_FLAGS_5(sve2_umlsl_idx_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_umlsl_idx_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_cmla_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_cmla_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sqrdcmlah_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index da77ad689f..e8011fe91b 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -825,6 +825,18 @@ SQDMLSLB_zzxw_d 01000100 .. 1 ..... 0011.0 ..... .....          @rrxw_d
 SQDMLSLT_zzxw_s 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_s
 SQDMLSLT_zzxw_d 01000100 .. 1 ..... 0011.1 ..... .....          @rrxw_d
 
+# SVE2 complex integer multiply-add (indexed)
+CMLA_zzxz_h     01000100 10 1 index:2 rm:3 0110 rot:2 rn:5 rd:5 \
+                ra=%reg_movprfx
+CMLA_zzxz_s     01000100 11 1 index:1 rm:4 0110 rot:2 rn:5 rd:5 \
+                ra=%reg_movprfx
+
+# SVE2 complex saturating integer multiply-add (indexed)
+SQRDCMLAH_zzxz_h  01000100 10 1 index:2 rm:3 0111 rot:2 rn:5 rd:5 \
+                  ra=%reg_movprfx
+SQRDCMLAH_zzxz_s  01000100 11 1 index:1 rm:4 0111 rot:2 rn:5 rd:5 \
+                  ra=%reg_movprfx
+
 # SVE2 multiply-add long (indexed)
 SMLALB_zzxw_s   01000100 .. 1 ..... 1000.0 ..... .....          @rrxw_s
 SMLALB_zzxw_d   01000100 .. 1 ..... 1000.0 ..... .....          @rrxw_d
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index f71df89cb7..b2f24d5cfd 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1466,34 +1466,132 @@ void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
     }                                                           \
 }
 
-#define do_cmla(N, M, A, S) (A + (N * M) * (S ? -1 : 1))
+static int8_t do_cmla_b(int8_t n, int8_t m, int8_t a, bool sub)
+{
+    return n * m * (sub ? -1 : 1) + a;
+}
 
-DO_CMLA(sve2_cmla_zzzz_b, uint8_t, H1, do_cmla)
-DO_CMLA(sve2_cmla_zzzz_h, uint16_t, H2, do_cmla)
-DO_CMLA(sve2_cmla_zzzz_s, uint32_t, H4, do_cmla)
-DO_CMLA(sve2_cmla_zzzz_d, uint64_t,   , do_cmla)
+static int16_t do_cmla_h(int16_t n, int16_t m, int16_t a, bool sub)
+{
+    return n * m * (sub ? -1 : 1) + a;
+}
 
-#define DO_SQRDMLAH_B(N, M, A, S) \
-    do_sqrdmlah_b(N, M, A, S, true)
-#define DO_SQRDMLAH_H(N, M, A, S) \
-    ({ uint32_t discard; do_sqrdmlah_h(N, M, A, S, true, &discard); })
-#define DO_SQRDMLAH_S(N, M, A, S) \
-    ({ uint32_t discard; do_sqrdmlah_s(N, M, A, S, true, &discard); })
-#define DO_SQRDMLAH_D(N, M, A, S) \
-    do_sqrdmlah_d(N, M, A, S, true)
+static int32_t do_cmla_s(int32_t n, int32_t m, int32_t a, bool sub)
+{
+    return n * m * (sub ? -1 : 1) + a;
+}
 
-DO_CMLA(sve2_sqrdcmlah_zzzz_b, int8_t, H1, DO_SQRDMLAH_B)
-DO_CMLA(sve2_sqrdcmlah_zzzz_h, int16_t, H2, DO_SQRDMLAH_H)
-DO_CMLA(sve2_sqrdcmlah_zzzz_s, int32_t, H4, DO_SQRDMLAH_S)
-DO_CMLA(sve2_sqrdcmlah_zzzz_d, int64_t,   , DO_SQRDMLAH_D)
+static int64_t do_cmla_d(int64_t n, int64_t m, int64_t a, bool sub)
+{
+    return n * m * (sub ? -1 : 1) + a;
+}
+
+DO_CMLA(sve2_cmla_zzzz_b, uint8_t, H1, do_cmla_b)
+DO_CMLA(sve2_cmla_zzzz_h, uint16_t, H2, do_cmla_h)
+DO_CMLA(sve2_cmla_zzzz_s, uint32_t, H4, do_cmla_s)
+DO_CMLA(sve2_cmla_zzzz_d, uint64_t,   , do_cmla_d)
+
+static int8_t do_sqrdcmlah_b(int8_t n, int8_t m, int8_t a, bool sub)
+{
+    return do_sqrdmlah_b(n, m, a, sub, true);
+}
+
+static int16_t do_sqrdcmlah_h(int16_t n, int16_t m, int16_t a, bool sub)
+{
+    uint32_t discard;
+    return do_sqrdmlah_h(n, m, a, sub, true, &discard);
+}
+
+static int32_t do_sqrdcmlah_s(int32_t n, int32_t m, int32_t a, bool sub)
+{
+    uint32_t discard;
+    return do_sqrdmlah_s(n, m, a, sub, true, &discard);
+}
+
+static int64_t do_sqrdcmlah_d(int64_t n, int64_t m, int64_t a, bool sub)
+{
+    return do_sqrdmlah_d(n, m, a, sub, true);
+}
+
+DO_CMLA(sve2_sqrdcmlah_zzzz_b, int8_t, H1, do_sqrdcmlah_b)
+DO_CMLA(sve2_sqrdcmlah_zzzz_h, int16_t, H2, do_sqrdcmlah_h)
+DO_CMLA(sve2_sqrdcmlah_zzzz_s, int32_t, H4, do_sqrdcmlah_s)
+DO_CMLA(sve2_sqrdcmlah_zzzz_d, int64_t,   , do_sqrdcmlah_d)
 
-#undef DO_SQRDMLAH_B
-#undef DO_SQRDMLAH_H
-#undef DO_SQRDMLAH_S
-#undef DO_SQRDMLAH_D
-#undef do_cmla
 #undef DO_CMLA
 
+static void do_cmla_idx_h(int16_t *d, int16_t *n, int16_t *m,
+                          int16_t *a, uint32_t desc,
+                          int16_t (*fn)(int16_t, int16_t, int16_t, bool))
+{
+    intptr_t i, j, oprsz = simd_oprsz(desc);
+    int rot = extract32(desc, SIMD_DATA_SHIFT, 2);
+    int idx = extract32(desc, SIMD_DATA_SHIFT + 2, 2) * 2;
+    int sel_a = rot & 1, sel_b = sel_a ^ 1;
+    bool sub_r = rot == 1 || rot == 2;
+    bool sub_i = rot >= 2;
+
+    for (i = 0; i < oprsz / 2; i += 16 / 2) {
+        int16_t elt2_a = m[H2(i + idx + sel_a)];
+        int16_t elt2_b = m[H2(i + idx + sel_b)];
+
+        for (j = 0; j < 16 / 2; j += 2) {
+            int16_t elt1_a = n[H2(i + j + sel_a)];
+
+            d[H2(i + j)] = fn(elt1_a, elt2_a, a[H2(i + j)], sub_r);
+            d[H2(i + j + 1)] = fn(elt1_a, elt2_b, a[H2(i + j + 1)], sub_i);
+        }
+    }
+}
+
+void HELPER(sve2_cmla_idx_h)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    do_cmla_idx_h(vd, vn, vm, va, desc, do_cmla_h);
+}
+
+void HELPER(sve2_sqrdcmlah_idx_h)(void *vd, void *vn, void *vm,
+                                  void *va, uint32_t desc)
+{
+    do_cmla_idx_h(vd, vn, vm, va, desc, do_sqrdcmlah_h);
+}
+
+static void do_cmla_idx_s(int32_t *d, int32_t *n, int32_t *m,
+                          int32_t *a, uint32_t desc,
+                          int32_t (*fn)(int32_t, int32_t, int32_t, bool))
+{
+    intptr_t i, j, oprsz = simd_oprsz(desc);
+    int rot = extract32(desc, SIMD_DATA_SHIFT, 2);
+    int idx = extract32(desc, SIMD_DATA_SHIFT + 2, 2) * 2;
+    int sel_a = rot & 1, sel_b = sel_a ^ 1;
+    bool sub_r = rot == 1 || rot == 2;
+    bool sub_i = rot >= 2;
+
+    for (i = 0; i < oprsz / 4; i += 16 / 4) {
+        int32_t elt2_a = m[H4(i + idx + sel_a)];
+        int32_t elt2_b = m[H4(i + idx + sel_b)];
+
+        for (j = 0; j < 16 / 4; j += 2) {
+            int32_t elt1_a = n[H4(i + j + sel_a)];
+
+            d[H4(i + j)] = fn(elt1_a, elt2_a, a[H4(i + j)], sub_r);
+            d[H4(i + j + 1)] = fn(elt1_a, elt2_b, a[H4(i + j + 1)], sub_i);
+        }
+    }
+}
+
+void HELPER(sve2_cmla_idx_s)(void *vd, void *vn, void *vm,
+                             void *va, uint32_t desc)
+{
+    do_cmla_idx_s(vd, vn, vm, va, desc, do_cmla_s);
+}
+
+void HELPER(sve2_sqrdcmlah_idx_s)(void *vd, void *vn, void *vm,
+                                  void *va, uint32_t desc)
+{
+    do_cmla_idx_s(vd, vn, vm, va, desc, do_sqrdcmlah_s);
+}
+
 #define DO_ZZXZ(NAME, TYPE, H, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc) \
 {                                                                       \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 248fe4de42..4628198b76 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3821,21 +3821,21 @@ static bool trans_DOT_zzzz(DisasContext *s, arg_DOT_zzzz *a)
  * SVE Multiply - Indexed
  */
 
-static bool do_zzxz_data(DisasContext *s, arg_rrxr_esz *a,
+static bool do_zzxz_data(DisasContext *s, int rd, int rn, int rm, int ra,
                          gen_helper_gvec_4 *fn, int data)
 {
     if (fn == NULL) {
         return false;
     }
     if (sve_access_check(s)) {
-        gen_gvec_ool_zzzz(s, fn, a->rd, a->rn, a->rm, a->ra, data);
+        gen_gvec_ool_zzzz(s, fn, rd, rn, rm, ra, data);
     }
     return true;
 }
 
 #define DO_RRXR(NAME, FUNC) \
     static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
-    { return do_zzxz_data(s, a, FUNC, a->index); }
+    { return do_zzxz_data(s, a->rd, a->rn, a->rm, a->ra, FUNC, a->index); }
 
 DO_RRXR(trans_SDOT_zzxw_s, gen_helper_gvec_sdot_idx_b)
 DO_RRXR(trans_SDOT_zzxw_d, gen_helper_gvec_sdot_idx_h)
@@ -3899,18 +3899,18 @@ DO_SVE2_RRX_TB(trans_SQDMULLT_zzx_d, gen_helper_sve2_sqdmull_idx_d, true)
 
 #undef DO_SVE2_RRX_TB
 
-static bool do_sve2_zzxz_data(DisasContext *s, arg_rrxr_esz *a,
-                              gen_helper_gvec_4 *fn, int data)
+static bool do_sve2_zzxz_data(DisasContext *s, int rd, int rn, int rm,
+                              int ra, gen_helper_gvec_4 *fn, int data)
 {
     if (!dc_isar_feature(aa64_sve2, s)) {
         return false;
     }
-    return do_zzxz_data(s, a, fn, data);
+    return do_zzxz_data(s, rd, rn, rm, ra, fn, data);
 }
 
 #define DO_SVE2_RRXR(NAME, FUNC) \
-    static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
-    { return do_sve2_zzxz_data(s, a, FUNC, a->index); }
+static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
+{ return do_sve2_zzxz_data(s, a->rd, a->rn, a->rm, a->ra, FUNC, a->index); }
 
 DO_SVE2_RRXR(trans_MLA_zzxz_h, gen_helper_gvec_mla_idx_h)
 DO_SVE2_RRXR(trans_MLA_zzxz_s, gen_helper_gvec_mla_idx_s)
@@ -3931,8 +3931,11 @@ DO_SVE2_RRXR(trans_SQRDMLSH_zzxz_d, gen_helper_sve2_sqrdmlsh_idx_d)
 #undef DO_SVE2_RRXR
 
 #define DO_SVE2_RRXR_TB(NAME, FUNC, TOP) \
-    static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
-    { return do_sve2_zzxz_data(s, a, FUNC, (a->index << 1) | TOP); }
+static bool NAME(DisasContext *s, arg_rrxr_esz *a)           \
+{                                                            \
+    return do_sve2_zzxz_data(s, a->rd, a->rn, a->rm, a->ra,  \
+                             FUNC, (a->index << 1) | TOP);   \
+}
 
 DO_SVE2_RRXR_TB(trans_SQDMLALB_zzxw_s, gen_helper_sve2_sqdmlal_idx_s, false)
 DO_SVE2_RRXR_TB(trans_SQDMLALB_zzxw_d, gen_helper_sve2_sqdmlal_idx_d, false)
@@ -3966,6 +3969,21 @@ DO_SVE2_RRXR_TB(trans_UMLSLT_zzxw_d, gen_helper_sve2_umlsl_idx_d, true)
 
 #undef DO_SVE2_RRXR_TB
 
+#define DO_SVE2_RRXR_ROT(NAME, FUNC) \
+static bool trans_##NAME(DisasContext *s, arg_##NAME *a)       \
+{                                                              \
+    return do_sve2_zzxz_data(s, a->rd, a->rn, a->rm, a->ra,    \
+                             FUNC, (a->index << 2) | a->rot);  \
+}
+
+DO_SVE2_RRXR_ROT(CMLA_zzxz_h, gen_helper_sve2_cmla_idx_h)
+DO_SVE2_RRXR_ROT(CMLA_zzxz_s, gen_helper_sve2_cmla_idx_s)
+
+DO_SVE2_RRXR_ROT(SQRDCMLAH_zzxz_h, gen_helper_sve2_sqrdcmlah_idx_h)
+DO_SVE2_RRXR_ROT(SQRDCMLAH_zzxz_s, gen_helper_sve2_sqrdcmlah_idx_s)
+
+#undef DO_SVE2_RRXR_ROT
+
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
-- 
2.25.1


