Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C22C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D649D20409
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrEbMv9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D649D20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbub-0006aQ-25
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcY-0002gA-HA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcW-0001gc-Uf
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:06 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b]:33342)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcW-0001f9-OI
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id j1so3565885pfe.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wrW/Tw+fzY4lh5Sk9yEJSGX1ZVgOSoYBH6s+EdHCLNI=;
 b=BrEbMv9x6I4UYjjt578PfVTp5NTnY4KulJP7eMueszsSXLHs4JDW+q4ZAyAKMqjTvF
 puiyrdvzPlBAiwdmNIIW1JgZLQmwqpf1HQKpYe4XIxCo3h9yH+fI7WwaV+24LQbbvXKC
 Cf5caroStFOxthkkauY/DLdJ8IMtUoSB5P6dBHYvMcLzDBtEiNN2lmQLmLRgNHnZDPF4
 pUrvZXk3D9HSnOqtg2j8GE6Tay3hCT9rwg++eGWXhJvY+mPa8diiJOPxO7ndFZY8E4HX
 FOT4oD8TMq52Ue57ktHpOuzDAYRTLU1prnFWQ80j78ucP0Sz1Anr6S18LF5vQSXNtL/2
 Qgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wrW/Tw+fzY4lh5Sk9yEJSGX1ZVgOSoYBH6s+EdHCLNI=;
 b=rSdPbr7VZ6IQJmG+Y5Vvr6cKzBxYxtx1gV7GG+H1/z1owLV7EJNt5mFXwW8oNN6p09
 X0UWFdh308weFUqGW6pAVRo5DfvVEXI/AOKRJENwZ+cTaAS/km0WRGvKwRm8HvIiJXat
 jkinAPpRW8olzqOxMutjo6flmvBpmyA+ga0qGurI6vwy4gbALL1oKbw34oY4Bp/emHNo
 RQp+7XD8lftfmLiiNer+lvhBHxQxfmdVixojoIph8mVKDDk5KQKflh90yDcSXiD1krpV
 Fnyvh/AKG/wVCwzaD81wN52tyE1DMJukxOkB0p+85oFp0gwoVb1f55cNauEDvZnKeS0P
 w9sQ==
X-Gm-Message-State: ANhLgQ0xh8miLRqarlJKmc3m3IdJZP7VengMUQE3tRkmjOd/1p90+8uc
 Jmq92qy4RxZnapSnB4Kw4UZ1jJAFTv4=
X-Google-Smtp-Source: ADFU+vuhWlYBnjC1nZMAKFmHHvViUNV5mVwls0R2Fyf4gizmiEGDRcS4Xt3SLPXzti6BOUxTGMxlLg==
X-Received: by 2002:a62:3305:: with SMTP id z5mr11968336pfz.297.1585264143340; 
 Thu, 26 Mar 2020 16:09:03 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/31] target/arm: Implement SVE2 bitwise exclusive-or
 interleaved
Date: Thu, 26 Mar 2020 16:08:25 -0700
Message-Id: <20200326230838.31112-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42b
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    |  5 +++++
 target/arm/sve.decode      |  5 +++++
 target/arm/sve_helper.c    | 20 ++++++++++++++++++++
 target/arm/translate-sve.c | 19 +++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 9c0c41ba80..9e894a2b55 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2380,3 +2380,8 @@ DEF_HELPER_FLAGS_3(sve2_sshll_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_ushll_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_ushll_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve2_ushll_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_eoril_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_eoril_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_eoril_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_eoril_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 36ef9de563..8af35e48a5 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1215,3 +1215,8 @@ SSHLLB          01000101 .. 0 ..... 1010 00 ..... .....  @rd_rn_tszimm_shl
 SSHLLT          01000101 .. 0 ..... 1010 01 ..... .....  @rd_rn_tszimm_shl
 USHLLB          01000101 .. 0 ..... 1010 10 ..... .....  @rd_rn_tszimm_shl
 USHLLT          01000101 .. 0 ..... 1010 11 ..... .....  @rd_rn_tszimm_shl
+
+## SVE2 bitwise exclusive-or interleaved
+
+EORBT           01000101 .. 0 ..... 10010 0 ..... .....  @rd_rn_rm
+EORTB           01000101 .. 0 ..... 10010 1 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index e0a701c446..15ea1fd524 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1196,6 +1196,26 @@ DO_ZZZ_WTB(sve2_usubw_d, uint64_t, uint32_t, DO_SUB)
 
 #undef DO_ZZZ_WTB
 
+#define DO_ZZZ_NTB(NAME, TYPE, H, OP)                                   \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc)          \
+{                                                                       \
+    intptr_t i, opr_sz = simd_oprsz(desc);                              \
+    intptr_t sel1 = extract32(desc, SIMD_DATA_SHIFT, 1) * sizeof(TYPE); \
+    intptr_t sel2 = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(TYPE); \
+    for (i = 0; i < opr_sz; i += 2 * sizeof(TYPE)) {                    \
+        TYPE nn = *(TYPE *)(vn + H(i + sel1));                          \
+        TYPE mm = *(TYPE *)(vm + H(i + sel2));                          \
+        *(TYPE *)(vd + H(i + sel1)) = OP(nn, mm);                       \
+    }                                                                   \
+}
+
+DO_ZZZ_NTB(sve2_eoril_b, uint8_t, H1, DO_EOR)
+DO_ZZZ_NTB(sve2_eoril_h, uint16_t, H1_2, DO_EOR)
+DO_ZZZ_NTB(sve2_eoril_s, uint32_t, H1_4, DO_EOR)
+DO_ZZZ_NTB(sve2_eoril_d, uint64_t,     , DO_EOR)
+
+#undef DO_ZZZ_NTB
+
 #define DO_ZZI_SHLL(NAME, TYPE, TYPEN, OP) \
 void HELPER(NAME)(void *vd, void *vn, uint32_t desc)           \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 9873b83feb..3eaf9cbe51 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6064,6 +6064,25 @@ DO_SVE2_ZZZ_TB(SMULLT_zzz, smull_zzz, true, true)
 DO_SVE2_ZZZ_TB(UMULLB_zzz, umull_zzz, false, false)
 DO_SVE2_ZZZ_TB(UMULLT_zzz, umull_zzz, true, true)
 
+static bool do_eor_tb(DisasContext *s, arg_rrr_esz *a, bool sel1)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_eoril_b, gen_helper_sve2_eoril_h,
+        gen_helper_sve2_eoril_s, gen_helper_sve2_eoril_d,
+    };
+    return do_sve2_zzw_ool(s, a, fns[a->esz], (!sel1 << 1) | sel1);
+}
+
+static bool trans_EORBT(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_eor_tb(s, a, false);
+}
+
+static bool trans_EORTB(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_eor_tb(s, a, true);
+}
+
 static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
 {
     static gen_helper_gvec_3 * const fns[4] = {
-- 
2.20.1


