Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB734C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8777E2186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aQU7b8EL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8777E2186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmhQ-0000X1-O3
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDa-00051G-Jh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:02 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:39869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDY-0003QB-S3
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:02 -0400
Received: by mail-pg1-x52f.google.com with SMTP id v11so2335877pgb.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uh25IryyBgTydEavQvVCQKXEdVtE18t2Gvuw5xD4xd8=;
 b=aQU7b8ELJs18n8cu9YFaO+3gqUGpTqbWZBXNT/Vt0D0Km0NeFEYKg/WslnRkva95+z
 4omIDXBvHvqNOa9DjHVpnjcLxpyYQDU/rGfKVuL5e19f4dR0x8+0/y9ASC0syaJ+DhWX
 hat5dmXRQsalz5LlTf3Joar6GzWIRvktEDhNwhqlxe5ZNL/APGf8f+ryP2PPwjosdBFZ
 CzRRebLRqurxtssRZcLJGsVXCm8GcVKZnHf8WLwnvwtkUm+DQ9dj8WRPihrr9tsHTQE6
 4K4ejVZ9fcVQNXcJy24p72vThps9N9HbMN2PkTtYyg1zYxFhuudB3uxzelcYxU3VnKvV
 EXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uh25IryyBgTydEavQvVCQKXEdVtE18t2Gvuw5xD4xd8=;
 b=Qk4hj5TRV7SjkIjVZ7AXThrUkadwg13e2D8fWWJHCuFgdWRrN0svr5SXjYZ6Fn+m7z
 jKwb9z1qcrbRbkKUpYP2r4sj3TNAYP2GJdyRLo+1GiB7YBuHhmWmZ8ScGvBR0rawCBKl
 KUtUSZm5lfR6Q6fakpoOLIMztkeKBk2E6I5DIU8bghAU1ciLWQ93G14ICFxyaD4yljAu
 l5WuFLI20qt3lFu4NFxKfSnjfqIFmjpKdAEkz7QuZFwuQ63jwHzL4DBXVzF8GGV8ipAr
 rruGNt6sNuJ4D1ALJpV1GZoOK6+wRFnVjrOrP5TzlxwM0Vw8zGGpLECoZnJ+hOdTkb3N
 msGQ==
X-Gm-Message-State: AOAM532iX+3cyx8J1gZhF/oK95HpGMVBGpZSxvxRsXIJrd8ReL8ffiXx
 BgMkCjuLPEe7vHcVLc9e4NHBuUyn4rg=
X-Google-Smtp-Source: ABdhPJwpiRxO6s7pDlvDgBEQZQmServHvgXpLr8OadqdX0QKOV1Q/Nn1hbOVtP2lrNNp12vwga878A==
X-Received: by 2002:a63:5a58:: with SMTP id k24mr1720931pgm.1.1592454719058;
 Wed, 17 Jun 2020 21:31:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm1162840pgv.5.2020.06.17.21.31.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 073/100] target/arm: Implement SVE2 integer multiply-add
 (indexed)
Date: Wed, 17 Jun 2020 21:26:17 -0700
Message-Id: <20200618042644.1685561-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-arm@nongnu.org, steplong@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h        | 14 ++++++++++++++
 target/arm/sve.decode      |  8 ++++++++
 target/arm/translate-sve.c | 23 +++++++++++++++++++++++
 target/arm/vec_helper.c    | 25 +++++++++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index ce81a16a58..7964d299f6 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -793,6 +793,20 @@ DEF_HELPER_FLAGS_4(gvec_mul_idx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_mul_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_5(gvec_mla_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mla_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(gvec_mls_idx_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(gvec_mls_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
 #include "helper-sve.h"
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index fa0a572da6..467a93052f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -785,6 +785,14 @@ SDOT_zzxw_d     01000100 .. 1 ..... 000000 ..... .....          @rrxr_d
 UDOT_zzxw_s     01000100 .. 1 ..... 000001 ..... .....          @rrxr_s
 UDOT_zzxw_d     01000100 .. 1 ..... 000001 ..... .....          @rrxr_d
 
+# SVE2 integer multiply-add (indexed)
+MLA_zzxz_h      01000100 .. 1 ..... 000010 ..... .....          @rrxr_h
+MLA_zzxz_s      01000100 .. 1 ..... 000010 ..... .....          @rrxr_s
+MLA_zzxz_d      01000100 .. 1 ..... 000010 ..... .....          @rrxr_d
+MLS_zzxz_h      01000100 .. 1 ..... 000011 ..... .....          @rrxr_h
+MLS_zzxz_s      01000100 .. 1 ..... 000011 ..... .....          @rrxr_s
+MLS_zzxz_d      01000100 .. 1 ..... 000011 ..... .....          @rrxr_d
+
 # SVE2 integer multiply (indexed)
 MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
 MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index dd2cd22061..0fb88f4aa5 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3870,6 +3870,29 @@ DO_SVE2_RRX(trans_MUL_zzx_d, gen_helper_gvec_mul_idx_d)
 
 #undef DO_SVE2_RRX
 
+static bool do_sve2_zzxz_ool(DisasContext *s, arg_rrxr_esz *a,
+                             gen_helper_gvec_4 *fn)
+{
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    return do_zzxz_ool(s, a, fn);
+}
+
+#define DO_SVE2_RRXR(NAME, FUNC) \
+    static bool NAME(DisasContext *s, arg_rrxr_esz *a)  \
+    { return do_sve2_zzxz_ool(s, a, FUNC); }
+
+DO_SVE2_RRXR(trans_MLA_zzxz_h, gen_helper_gvec_mla_idx_h)
+DO_SVE2_RRXR(trans_MLA_zzxz_s, gen_helper_gvec_mla_idx_s)
+DO_SVE2_RRXR(trans_MLA_zzxz_d, gen_helper_gvec_mla_idx_d)
+
+DO_SVE2_RRXR(trans_MLS_zzxz_h, gen_helper_gvec_mls_idx_h)
+DO_SVE2_RRXR(trans_MLS_zzxz_s, gen_helper_gvec_mls_idx_s)
+DO_SVE2_RRXR(trans_MLS_zzxz_d, gen_helper_gvec_mls_idx_d)
+
+#undef DO_SVE2_RRXR
+
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 08eadf06fc..fb8596c1fd 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -883,6 +883,31 @@ DO_MUL_IDX(gvec_mul_idx_d, uint64_t, )
 
 #undef DO_MUL_IDX
 
+#define DO_MLA_IDX(NAME, TYPE, OP, H) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, void *va, uint32_t desc)   \
+{                                                                          \
+    intptr_t i, j, oprsz = simd_oprsz(desc), segment = 16 / sizeof(TYPE);  \
+    intptr_t idx = simd_data(desc);                                        \
+    TYPE *d = vd, *n = vn, *m = vm, *a = va;                               \
+    for (i = 0; i < oprsz / sizeof(TYPE); i += segment) {                  \
+        TYPE mm = m[H(i + idx)];                                           \
+        for (j = 0; j < segment; j++) {                                    \
+            d[i + j] = a[i + j] OP n[i + j] * mm;                          \
+        }                                                                  \
+    }                                                                      \
+    clear_tail(d, oprsz, simd_maxsz(desc));                                \
+}
+
+DO_MLA_IDX(gvec_mla_idx_h, uint16_t, +, H2)
+DO_MLA_IDX(gvec_mla_idx_s, uint32_t, +, H4)
+DO_MLA_IDX(gvec_mla_idx_d, uint64_t, +,   )
+
+DO_MLA_IDX(gvec_mls_idx_h, uint16_t, -, H2)
+DO_MLA_IDX(gvec_mls_idx_s, uint32_t, -, H4)
+DO_MLA_IDX(gvec_mls_idx_d, uint64_t, -,   )
+
+#undef DO_MLA_IDX
+
 #define DO_FMUL_IDX(NAME, TYPE, H) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, void *stat, uint32_t desc) \
 {                                                                          \
-- 
2.25.1


