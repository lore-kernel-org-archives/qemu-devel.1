Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C7AC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:17:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1880820714
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhI8h5Pi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1880820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbl6-0007rp-6m
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcR-0002O1-UX
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcQ-0001VK-Fu
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:59 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:33612)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcQ-0001UG-9C
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:58 -0400
Received: by mail-pl1-x643.google.com with SMTP id g18so2752886plq.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mMKWgjpLavmbt56//ygtC6ZwR2NAPw0rAnQXI9rkvA8=;
 b=hhI8h5PirpzeUyHGeWw5TyAz80KK5mgR5DlmLdJ2ACyl0WdBE2lwA+HxEqrAlstXvQ
 2LTJSsfkSCDt+nDl10GmcP6aJijm8dzs3keJexTrj9J8Ef5kMdW7UAJTD7R0Dw4BOj9G
 YV/B/qxQhh7bRnEdENfUNlRdzMaYHKJ+SE30yGk4dsILc5RQUt1XRsR7i1l5yoYmEEb9
 fPhxknTMAKFCA0WN59UwLJCC0wcblfgSPM39Oc0DI7UnYgw9xKZYhqeoGiun44p+PzxO
 uYzl1afbw/Z3tvQjbT2Z8BpXl/n3GWZUViXp0BqN/gJKfFDyEJMHxSh/s9602LKOZaWc
 49UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mMKWgjpLavmbt56//ygtC6ZwR2NAPw0rAnQXI9rkvA8=;
 b=rynQJnmg3ol28yMEWnrHz31bwu4GK5iZwL1vEBNw7RuaASCDZLQMlhWt1o1YpH3dxT
 TGgYvvm/ciKcxamJzJCLQCuLgmFCxeorYHfpYjGUmowP2Kn6AKQGmdEK/mD1+RFE/+Gy
 UWoFvKwtf2f30WWkyUS136yoRmJTvdg+M+tua/2colwa4gyHqPpsFehh6kCAXQhSDiD/
 LVJtkQVWiv2u15HBLu9hMKL7cFRNQ0oq3SD6DCpAX4Gb4dajOaCHUEBHfDZK3V0X2DQM
 rOCMoI/ylsNS94L474gdoa5bnWKmDjXMOh9hLaWD5SYZ0n/bRORq1of3wigUSd35NFfC
 LuPA==
X-Gm-Message-State: ANhLgQ0EFle4NjvudgJEyFl3O/3tQ3DUewSPX8KTn5az12b+kA1NF0q4
 f8Szgu3UufpmAbsi7OyiaiYdkkInX+k=
X-Google-Smtp-Source: ADFU+vuTJCzL3UguRr3noNGwssKrn1MkPNkM161nKOVoQx6WOwrfpkdrg9WF/QHzM3ihivyWqOMcDw==
X-Received: by 2002:a17:902:a517:: with SMTP id
 s23mr10766321plq.125.1585264136950; 
 Thu, 26 Mar 2020 16:08:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/31] target/arm: Implement SVE2 integer add/subtract wide
Date: Thu, 26 Mar 2020 16:08:20 -0700
Message-Id: <20200326230838.31112-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
 target/arm/helper-sve.h    | 16 ++++++++++++++++
 target/arm/sve.decode      | 12 ++++++++++++
 target/arm/sve_helper.c    | 30 ++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 20 ++++++++++++++++++++
 4 files changed, 78 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 475fce7f3a..6a95c6085c 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1396,6 +1396,22 @@ DEF_HELPER_FLAGS_4(sve2_uabdl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_uabdl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_uabdl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_saddw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_ssubw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uaddw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_usubw_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubw_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubw_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_ldr, TCG_CALL_NO_WG, void, env, ptr, tl, int)
 DEF_HELPER_FLAGS_4(sve_str, TCG_CALL_NO_WG, void, env, ptr, tl, int)
 
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 8d5f31bcc4..9994e1eb71 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1187,3 +1187,15 @@ UABDLT          01000101 .. 0 ..... 00 1111 ..... .....  @rd_rn_rm
 SADDLBT         01000101 .. 0 ..... 1000 00 ..... .....  @rd_rn_rm
 SSUBLBT         01000101 .. 0 ..... 1000 10 ..... .....  @rd_rn_rm
 SSUBLBT         01000101 .. 0 ..... 1000 11 ..... .....  @rd_rm_rn # SSUBLTB
+
+## SVE2 integer add/subtract wide
+
+SADDWB          01000101 .. 0 ..... 010 000 ..... .....  @rd_rn_rm
+SADDWT          01000101 .. 0 ..... 010 001 ..... .....  @rd_rn_rm
+UADDWB          01000101 .. 0 ..... 010 010 ..... .....  @rd_rn_rm
+UADDWT          01000101 .. 0 ..... 010 011 ..... .....  @rd_rn_rm
+
+SSUBWB          01000101 .. 0 ..... 010 100 ..... .....  @rd_rn_rm
+SSUBWT          01000101 .. 0 ..... 010 101 ..... .....  @rd_rn_rm
+USUBWB          01000101 .. 0 ..... 010 110 ..... .....  @rd_rn_rm
+USUBWT          01000101 .. 0 ..... 010 111 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 7d7a59f620..44503626e4 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1131,6 +1131,36 @@ DO_ZZZ_TB(sve2_uabdl_d, uint64_t, uint32_t, DO_ABD)
 
 #undef DO_ZZZ_TB
 
+#define DO_ZZZ_WTB(NAME, TYPE, TYPEN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    int sel2 = (simd_data(desc) & 1) * sizeof(TYPE);           \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
+        TYPE nn = *(TYPE *)(vn + i);                           \
+        TYPE mm = (TYPEN)(*(TYPE *)(vm + i) >> sel2);          \
+        *(TYPE *)(vd + i) = OP(nn, mm);                        \
+    }                                                          \
+}
+
+DO_ZZZ_WTB(sve2_saddw_h, int16_t, int8_t, DO_ADD)
+DO_ZZZ_WTB(sve2_saddw_s, int32_t, int16_t, DO_ADD)
+DO_ZZZ_WTB(sve2_saddw_d, int64_t, int32_t, DO_ADD)
+
+DO_ZZZ_WTB(sve2_ssubw_h, int16_t, int8_t, DO_SUB)
+DO_ZZZ_WTB(sve2_ssubw_s, int32_t, int16_t, DO_SUB)
+DO_ZZZ_WTB(sve2_ssubw_d, int64_t, int32_t, DO_SUB)
+
+DO_ZZZ_WTB(sve2_uaddw_h, uint16_t, uint8_t, DO_ADD)
+DO_ZZZ_WTB(sve2_uaddw_s, uint32_t, uint16_t, DO_ADD)
+DO_ZZZ_WTB(sve2_uaddw_d, uint64_t, uint32_t, DO_ADD)
+
+DO_ZZZ_WTB(sve2_usubw_h, uint16_t, uint8_t, DO_SUB)
+DO_ZZZ_WTB(sve2_usubw_s, uint32_t, uint16_t, DO_SUB)
+DO_ZZZ_WTB(sve2_usubw_d, uint64_t, uint32_t, DO_SUB)
+
+#undef DO_ZZZ_WTB
+
 /* Two-operand reduction expander, controlled by a predicate.
  * The difference between TYPERED and TYPERET has to do with
  * sign-extension.  E.g. for SMAX, TYPERED must be signed,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index accb74537b..fb214360bf 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6054,3 +6054,23 @@ DO_SVE2_ZZZ_TB(UABDLT, uabdl, true, true)
 
 DO_SVE2_ZZZ_TB(SADDLBT, saddl, false, true)
 DO_SVE2_ZZZ_TB(SSUBLBT, ssubl, false, true)
+
+#define DO_SVE2_ZZZ_WTB(NAME, name, SEL2) \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)       \
+{                                                               \
+    static gen_helper_gvec_3 * const fns[4] = {                 \
+        NULL,                       gen_helper_sve2_##name##_h, \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d, \
+    };                                                          \
+    return do_sve2_zzw_ool(s, a, fns[a->esz], SEL2);            \
+}
+
+DO_SVE2_ZZZ_WTB(SADDWB, saddw, false)
+DO_SVE2_ZZZ_WTB(SADDWT, saddw, true)
+DO_SVE2_ZZZ_WTB(SSUBWB, ssubw, false)
+DO_SVE2_ZZZ_WTB(SSUBWT, ssubw, true)
+
+DO_SVE2_ZZZ_WTB(UADDWB, uaddw, false)
+DO_SVE2_ZZZ_WTB(UADDWT, uaddw, true)
+DO_SVE2_ZZZ_WTB(USUBWB, usubw, false)
+DO_SVE2_ZZZ_WTB(USUBWT, usubw, true)
-- 
2.20.1


