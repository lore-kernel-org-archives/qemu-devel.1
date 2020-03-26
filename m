Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4224CC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:22:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0634220663
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJ64crcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0634220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbpf-0006Xp-44
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcU-0002V7-G1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcT-0001Zq-3G
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:02 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33179)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcS-0001Yc-T8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:01 -0400
Received: by mail-pf1-x441.google.com with SMTP id j1so3565816pfe.0
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rI8qejJNvyJMtMzOFbbZO4TRq+KeIHi8lkQl/Kjod0g=;
 b=RJ64crcLI/IiapbqkQWiQAhcVnS+EC2JxfMAlP2pfuq6LQaG4KuMeOlLm0j2ym8b1J
 WBDNEQeWBAFCsdRRKryCr/J32tu53LGaGCZAspzLYWODv6Fj/ftlPAJXTWHlhviJ1o4V
 tYSnn9owYLxT9Qjbj8rcgMP2jwIBVKNx2jbcVfcj3Vjoy93ehTz/QATOJhW48JcdiujE
 t2XuWILZcr49oH6Hgc7fNzXWHPHKZV74IYeuavftKeu7xawIursnI8kWZI5n6kij7Acy
 62i4vIGyxaWCifq5a8xXwhnTX/FXM4xPos/yBikiF0Xhu8sxWTTyMdCHbLnCea9cQrYU
 M53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rI8qejJNvyJMtMzOFbbZO4TRq+KeIHi8lkQl/Kjod0g=;
 b=rw6m/RYDqKnEHXemhgH1yJMLHN3oCGBYsZzKa0TUCaq3LQgSl6NekNC/PEbTOuRpHI
 n8AkeXBirJm0XD87dAniwxvkRnnFO0UaIyj6la3jGjz/HGfpGf0n+Y/cpRJNRnqYeWCs
 ELBUpgd88E2/fMPGp3UNSvRdXKcPgvNleUVLdI4VM+VBFyr01xW5kNv1opC9l0e6qqjN
 HF05+73pJdP69NZPpklQJkBmj5ltZIKOjrDzvum+0pzPztYzAOhZdvc4GNKAtMrmpuPx
 zkA5+B6ql9z/mIxMamESNmn/wp05VFZIb9oOrLGZLtnJvdJyIcJNfCIXlnh9yHyIpkb0
 5rKg==
X-Gm-Message-State: ANhLgQ31mKZqOmzy0ym7H3Rh38YEeBprZXwpuySSC1mNki5gRPtFD6fj
 px749Dm+7yS22IRST0DpDtYNbj19SZM=
X-Google-Smtp-Source: ADFU+vvHyh/Krk3BSeqstT31AiS82tf0RqBBBAmJzXGEvwCDnt1DkM/oPkiuHfp3N7T2wvOR0FwIWw==
X-Received: by 2002:aa7:9f94:: with SMTP id z20mr9893160pfr.261.1585264139443; 
 Thu, 26 Mar 2020 16:08:59 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:08:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/31] target/arm: Implement PMULLB and PMULLT
Date: Thu, 26 Mar 2020 16:08:22 -0700
Message-Id: <20200326230838.31112-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
 target/arm/cpu.h           | 10 ++++++++++
 target/arm/helper-sve.h    |  1 +
 target/arm/sve.decode      |  2 ++
 target/arm/translate-sve.c | 22 ++++++++++++++++++++++
 target/arm/vec_helper.c    | 26 ++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2314e3c18c..2e9d9f046d 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3855,6 +3855,16 @@ static inline bool isar_feature_aa64_sve2(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, SVEVER) != 0;
 }
 
+static inline bool isar_feature_aa64_sve2_aes(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) != 0;
+}
+
+static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) >= 2;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index c4784919d2..943839e2dc 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2371,3 +2371,4 @@ DEF_HELPER_FLAGS_4(sve2_umull_zzz_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_umull_zzz_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(sve2_pmull_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_pmull_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 2410dd85a1..04bf9e5ce8 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1204,6 +1204,8 @@ USUBWT          01000101 .. 0 ..... 010 111 ..... .....  @rd_rn_rm
 
 SQDMULLB_zzz    01000101 .. 0 ..... 011 000 ..... .....  @rd_rn_rm
 SQDMULLT_zzz    01000101 .. 0 ..... 011 001 ..... .....  @rd_rn_rm
+PMULLB          01000101 .. 0 ..... 011 010 ..... .....  @rd_rn_rm
+PMULLT          01000101 .. 0 ..... 011 011 ..... .....  @rd_rn_rm
 SMULLB_zzz      01000101 .. 0 ..... 011 100 ..... .....  @rd_rn_rm
 SMULLT_zzz      01000101 .. 0 ..... 011 101 ..... .....  @rd_rn_rm
 UMULLB_zzz      01000101 .. 0 ..... 011 110 ..... .....  @rd_rn_rm
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index c66ec9eb83..67416a25ce 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6064,6 +6064,28 @@ DO_SVE2_ZZZ_TB(SMULLT_zzz, smull_zzz, true, true)
 DO_SVE2_ZZZ_TB(UMULLB_zzz, umull_zzz, false, false)
 DO_SVE2_ZZZ_TB(UMULLT_zzz, umull_zzz, true, true)
 
+static bool do_trans_pmull(DisasContext *s, arg_rrr_esz *a, bool sel)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_gvec_pmull_q, gen_helper_sve2_pmull_h,
+        NULL,                    gen_helper_sve2_pmull_d,
+    };
+    if (a->esz == 0 && !dc_isar_feature(aa64_sve2_pmull128, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], sel);
+}
+
+static bool trans_PMULLB(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_trans_pmull(s, a, false);
+}
+
+static bool trans_PMULLT(DisasContext *s, arg_rrr_esz *a)
+{
+    return do_trans_pmull(s, a, true);
+}
+
 #define DO_SVE2_ZZZ_WTB(NAME, name, SEL2) \
 static bool trans_##NAME(DisasContext *s, arg_rrr_esz *a)       \
 {                                                               \
diff --git a/target/arm/vec_helper.c b/target/arm/vec_helper.c
index 00dc38c9db..154d32518a 100644
--- a/target/arm/vec_helper.c
+++ b/target/arm/vec_helper.c
@@ -1256,6 +1256,32 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
         d[i] = pmull_h(nn, mm);
     }
 }
+
+static uint64_t pmull_d(uint64_t op1, uint64_t op2)
+{
+    uint64_t result = 0;
+    int i;
+
+    for (i = 0; i < 32; ++i) {
+        uint64_t mask = -((op1 >> i) & 1);
+        result ^= (op2 << i) & mask;
+    }
+    return result;
+}
+
+void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
+{
+    int shift = simd_data(desc) * 32;
+    intptr_t i, opr_sz = simd_oprsz(desc);
+    uint64_t *d = vd, *n = vn, *m = vm;
+
+    for (i = 0; i < opr_sz / 8; ++i) {
+        uint64_t nn = (uint32_t)(n[i] >> shift);
+        uint64_t mm = (uint32_t)(m[i] >> shift);
+
+        d[i] = pmull_d(nn, mm);
+    }
+}
 #endif
 
 /*
-- 
2.20.1


