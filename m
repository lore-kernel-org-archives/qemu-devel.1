Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD96C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:10:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD9620658
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGx1bq/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD9620658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbe2-0004ld-Ag
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcP-0002Ho-U3
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcO-0001RV-7Z
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:57 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcO-0001QH-0u
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:08:56 -0400
Received: by mail-pj1-x1042.google.com with SMTP id v13so3096993pjb.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gLLGScFvDeYfc9yE8BUZTiwCqKsBUzUDnFzQPSPVdVg=;
 b=wGx1bq/f3pT24xZnCyWWby/2e7Fcd8f8s5MWQuZEvEAK9iCT4FPslEJKW5CIhu7xl+
 lcZRNe3a8tPFMKFWteMKa3Xb5f/gzWh0RLj2ASFGwHmSi4Irelfp4cKsVjZz7DDqS1cV
 NbAUQxVtu2SIy2yqsGvh3uFU4MrRaIcEE/rjatHT5i4ODvVX4Xsblk/GLGaR/ee/72Ue
 vlW0pkXrpAQPUFNzIjK9ubzpKzNHZQWINeWoUWetGzwe0wYV+DdblK4llS9LKkclIIso
 CeDviFHLDg/U5jZ5/BaF6SoLclIgBb1BPOzpSB8tToNr0x+Zmd4piAfIHqV8BCB6Gx6d
 f2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gLLGScFvDeYfc9yE8BUZTiwCqKsBUzUDnFzQPSPVdVg=;
 b=mX/h29+Irp+ZNccp/Ij7N5xI6hBD4WO31bP7FHh+/1Xm+tOPX6SBHtcdnFjd1QXyNe
 IOGdfzmDVlzzLJbltUur7qwTCqBHkzm3mVaahvoDeNV9ltHiQOgP5zrSA2iudEwCFs5O
 g394ASBku8fzG46J8oef73WZR9n5VVPAxvhgBsuBgRmqBbBL+bc1Yl48caG8iDg+PyiI
 j8BZXTL+EfrvvpVu9nroJnaiKm4DTOk2mNzsQQEf1gYRfUjxhcnaNDRqSlZxH6TjboUp
 YzDzkt4zFTEanYwx9w4AoV8rLtKVLKZQBTdMfr8XZTLRbYxPn82l7FW2SqQOu4tkj/b4
 RGiw==
X-Gm-Message-State: ANhLgQ2u4QIrDDKFF2UKiwNbD/JuMAjXNWbQsKqY1QePRv7Hii9B73i+
 JqNhII4gXZtwtip2VpN3LvV8Bxs5HVI=
X-Google-Smtp-Source: ADFU+vv/ZdUyeOOyoGNwWFcLtpCIVJusCO35PRiglJ//iBe0Lqs/tDxgjwv0RyWxKtv1mWvrOB+bDw==
X-Received: by 2002:a17:902:6bc8:: with SMTP id
 m8mr10234014plt.223.1585264134560; 
 Thu, 26 Mar 2020 16:08:54 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/31] target/arm: Implement SVE2 integer add/subtract long
Date: Thu, 26 Mar 2020 16:08:18 -0700
Message-Id: <20200326230838.31112-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
 target/arm/helper-sve.h    | 24 ++++++++++++++++++++
 target/arm/sve.decode      | 19 ++++++++++++++++
 target/arm/sve_helper.c    | 43 +++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 46 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 368185944a..475fce7f3a 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -1372,6 +1372,30 @@ DEF_HELPER_FLAGS_5(sve_ftmad_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve_ftmad_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2_saddl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_saddl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_ssubl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_ssubl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sabdl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sabdl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sabdl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uaddl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uaddl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_usubl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_usubl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_uabdl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uabdl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_uabdl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve_ldr, TCG_CALL_NO_WG, void, env, ptr, tl, int)
 DEF_HELPER_FLAGS_4(sve_str, TCG_CALL_NO_WG, void, env, ptr, tl, int)
 
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 86aee38668..a239fd3479 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1161,3 +1161,22 @@ SUQADD          01000100 .. 011 100 100 ... ..... .....  @rdn_pg_rm
 USQADD          01000100 .. 011 101 100 ... ..... .....  @rdn_pg_rm
 SQSUB_zpzz      01000100 .. 011 110 100 ... ..... .....  @rdm_pg_rn # SQSUBR
 UQSUB_zpzz      01000100 .. 011 111 100 ... ..... .....  @rdm_pg_rn # UQSUBR
+
+#### SVE2 Widening Integer Arithmetic
+
+## SVE2 integer add/subtract long
+
+SADDLB          01000101 .. 0 ..... 00 0000 ..... .....  @rd_rn_rm
+SADDLT          01000101 .. 0 ..... 00 0001 ..... .....  @rd_rn_rm
+UADDLB          01000101 .. 0 ..... 00 0010 ..... .....  @rd_rn_rm
+UADDLT          01000101 .. 0 ..... 00 0011 ..... .....  @rd_rn_rm
+
+SSUBLB          01000101 .. 0 ..... 00 0100 ..... .....  @rd_rn_rm
+SSUBLT          01000101 .. 0 ..... 00 0101 ..... .....  @rd_rn_rm
+USUBLB          01000101 .. 0 ..... 00 0110 ..... .....  @rd_rn_rm
+USUBLT          01000101 .. 0 ..... 00 0111 ..... .....  @rd_rn_rm
+
+SABDLB          01000101 .. 0 ..... 00 1100 ..... .....  @rd_rn_rm
+SABDLT          01000101 .. 0 ..... 00 1101 ..... .....  @rd_rn_rm
+UABDLB          01000101 .. 0 ..... 00 1110 ..... .....  @rd_rn_rm
+UABDLT          01000101 .. 0 ..... 00 1111 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index bee00eaa44..7d7a59f620 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1088,6 +1088,49 @@ DO_ZZW(sve_lsl_zzw_s, uint32_t, uint64_t, H1_4, DO_LSL)
 #undef DO_ZPZ
 #undef DO_ZPZ_D
 
+/*
+ * Three-operand expander, unpredicated, in which the two inputs are
+ * selected from the top or bottom half of the wide column.
+ */
+#define DO_ZZZ_TB(NAME, TYPE, TYPEN, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    int sel1 = (simd_data(desc) & 1) * sizeof(TYPE);           \
+    int sel2 = (simd_data(desc) & 2) * (sizeof(TYPE) / 2);     \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
+        TYPE nn = (TYPEN)(*(TYPE *)(vn + i) >> sel1);          \
+        TYPE mm = (TYPEN)(*(TYPE *)(vm + i) >> sel2);          \
+        *(TYPE *)(vd + i) = OP(nn, mm);                        \
+    }                                                          \
+}
+
+DO_ZZZ_TB(sve2_saddl_h, int16_t, int8_t, DO_ADD)
+DO_ZZZ_TB(sve2_saddl_s, int32_t, int16_t, DO_ADD)
+DO_ZZZ_TB(sve2_saddl_d, int64_t, int32_t, DO_ADD)
+
+DO_ZZZ_TB(sve2_ssubl_h, int16_t, int8_t, DO_SUB)
+DO_ZZZ_TB(sve2_ssubl_s, int32_t, int16_t, DO_SUB)
+DO_ZZZ_TB(sve2_ssubl_d, int64_t, int32_t, DO_SUB)
+
+DO_ZZZ_TB(sve2_sabdl_h, int16_t, int8_t, DO_ABD)
+DO_ZZZ_TB(sve2_sabdl_s, int32_t, int16_t, DO_ABD)
+DO_ZZZ_TB(sve2_sabdl_d, int64_t, int32_t, DO_ABD)
+
+DO_ZZZ_TB(sve2_uaddl_h, uint16_t, uint8_t, DO_ADD)
+DO_ZZZ_TB(sve2_uaddl_s, uint32_t, uint16_t, DO_ADD)
+DO_ZZZ_TB(sve2_uaddl_d, uint64_t, uint32_t, DO_ADD)
+
+DO_ZZZ_TB(sve2_usubl_h, uint16_t, uint8_t, DO_SUB)
+DO_ZZZ_TB(sve2_usubl_s, uint32_t, uint16_t, DO_SUB)
+DO_ZZZ_TB(sve2_usubl_d, uint64_t, uint32_t, DO_SUB)
+
+DO_ZZZ_TB(sve2_uabdl_h, uint16_t, uint8_t, DO_ABD)
+DO_ZZZ_TB(sve2_uabdl_s, uint32_t, uint16_t, DO_ABD)
+DO_ZZZ_TB(sve2_uabdl_d, uint64_t, uint32_t, DO_ABD)
+
+#undef DO_ZZZ_TB
+
 /* Two-operand reduction expander, controlled by a predicate.
  * The difference between TYPERED and TYPERET has to do with
  * sign-extension.  E.g. for SMAX, TYPERED must be signed,
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 21dfb2455a..ee8a6fd912 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6005,3 +6005,49 @@ DO_SVE2_ZPZZ(SQSUB_zpzz, sqsub)
 DO_SVE2_ZPZZ(UQSUB_zpzz, uqsub)
 DO_SVE2_ZPZZ(SUQADD, suqadd)
 DO_SVE2_ZPZZ(USQADD, usqadd)
+
+/*
+ * SVE2 Widening Integer Arithmetic
+ */
+
+static bool do_sve2_zzw_ool(DisasContext *s, arg_rrr_esz *a,
+                            gen_helper_gvec_3 *fn, int data)
+{
+    if (fn == NULL || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, data, fn);
+    }
+    return true;
+}
+
+#define DO_SVE2_ZZZ_TB(NAME, name, SEL1, SEL2) \
+static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)               \
+{                                                                       \
+    static gen_helper_gvec_3 * const fns[4] = {                         \
+        NULL,                       gen_helper_sve2_##name##_h,         \
+        gen_helper_sve2_##name##_s, gen_helper_sve2_##name##_d,         \
+    };                                                                  \
+    return do_sve2_zzw_ool(s, a, fns[a->esz], (SEL2 << 1) | SEL1);      \
+}
+
+DO_SVE2_ZZZ_TB(SADDLB, saddl, false, false)
+DO_SVE2_ZZZ_TB(SSUBLB, ssubl, false, false)
+DO_SVE2_ZZZ_TB(SABDLB, sabdl, false, false)
+
+DO_SVE2_ZZZ_TB(UADDLB, uaddl, false, false)
+DO_SVE2_ZZZ_TB(USUBLB, usubl, false, false)
+DO_SVE2_ZZZ_TB(UABDLB, uabdl, false, false)
+
+DO_SVE2_ZZZ_TB(SADDLT, saddl, true, true)
+DO_SVE2_ZZZ_TB(SSUBLT, ssubl, true, true)
+DO_SVE2_ZZZ_TB(SABDLT, sabdl, true, true)
+
+DO_SVE2_ZZZ_TB(UADDLT, uaddl, true, true)
+DO_SVE2_ZZZ_TB(USUBLT, usubl, true, true)
+DO_SVE2_ZZZ_TB(UABDLT, uabdl, true, true)
-- 
2.20.1


