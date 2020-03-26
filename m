Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D19EC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:20:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7D8220663
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IGICM+am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D8220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbnv-0003WN-1d
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58899)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcZ-0002jY-RV
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcY-0001io-7O
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:07 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:39120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbcY-0001hL-0l
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:06 -0400
Received: by mail-pf1-x434.google.com with SMTP id d25so3539181pfn.6
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/qWmMRJyiGABbx/G2niY2yMmtnq+8Op3LMQTaXLdldI=;
 b=IGICM+amvQtPCB/7f1CwynEjtdKE7uXrktOg20btDhVHcMbqYwqCizDEjeWASh2N7A
 u6AcwMa/1X97tyi7ypnwLjU1j7eMQEXh1Nc2hu88+Xv2DHIwbS1ie8sygjfZg/URRjo7
 63RJYn/gQ868f2rPc9bbAViA2Z11qbwx7YykmUrxqVZ90O5mHpA/Tcx3RqFlHl8g59q3
 7DuCuY1/KSuTsf3MD/s1pbY5yWCfF5xHVeW9+oSyGzfw///4nBhSNTMB6uqu/EE0vsgS
 fFdZggHdsfigx+BaezIcc8nUAkOdz18BMXOWJFLcYpEgXgyKbZD8iWP873zB8c8nDeH7
 n6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/qWmMRJyiGABbx/G2niY2yMmtnq+8Op3LMQTaXLdldI=;
 b=KYRPvQLd8Vstce0ogo/Vc/IaS8i9oFFPmhlReYumWWtATMi0gFKHJyanMJA5yBpRgm
 uuWuebKlRHcSMYfDtXjEx0pUBLzMmzBzifzdag02vAHMiG8qBelHn6ATvNs/vp4C8mSU
 p/EUW6UvjbK/bSX9VvZ8ZBZZhcZ9O1sBWXa5DkhvD1nq+KivgBxqIvGhvilXS0VdI0/N
 03/HDWBQuRjTG6bN7ezY5+JTOiU7hZGFmekBS47o9qq+CVYyeTQ8np1ZZvCrygBEH7gw
 12dwqsnWUQlrIPAQOiHp5eKXX53F7FHrasaWeH/N5CPEJaYW2fEZGESRYSsWo5FORLaK
 Hlpw==
X-Gm-Message-State: ANhLgQ2EZxwwCyHzOE+LckkM98i8zbAasq4Rvv0b52S5356pYSf8dHDy
 InQZU9hGs7Cx5rGddWH6CFFLjHwLlJo=
X-Google-Smtp-Source: ADFU+vucrOX7fdVivHu37Z+LLmkFPV6+phIKoJIUv3w7eoJURFJtO1MouxAsuq8gt2qYY8Hi9J6TuQ==
X-Received: by 2002:a62:4e57:: with SMTP id c84mr12144654pfb.156.1585264144578; 
 Thu, 26 Mar 2020 16:09:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/31] target/arm: Implement SVE2 bitwise permute
Date: Thu, 26 Mar 2020 16:08:26 -0700
Message-Id: <20200326230838.31112-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326230838.31112-1-richard.henderson@linaro.org>
References: <20200326230838.31112-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::434
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
 target/arm/cpu.h           |  5 +++
 target/arm/helper-sve.h    | 15 ++++++++
 target/arm/sve.decode      |  6 ++++
 target/arm/sve_helper.c    | 73 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 36 +++++++++++++++++++
 5 files changed, 135 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2e9d9f046d..b7c7946771 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3865,6 +3865,11 @@ static inline bool isar_feature_aa64_sve2_pmull128(const ARMISARegisters *id)
     return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, AES) >= 2;
 }
 
+static inline bool isar_feature_aa64_sve2_bitperm(const ARMISARegisters *id)
+{
+    return FIELD_EX64(id->id_aa64zfr0, ID_AA64ZFR0, BITPERM) != 0;
+}
+
 /*
  * Feature tests for "does this exist in either 32-bit or 64-bit?"
  */
diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 9e894a2b55..466b01986f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2385,3 +2385,18 @@ DEF_HELPER_FLAGS_4(sve2_eoril_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_eoril_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_eoril_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_eoril_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bext_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bext_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bext_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bext_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bdep_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bdep_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bdep_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bdep_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_bgrp_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bgrp_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bgrp_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_bgrp_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 8af35e48a5..ca60e9f2ce 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1220,3 +1220,9 @@ USHLLT          01000101 .. 0 ..... 1010 11 ..... .....  @rd_rn_tszimm_shl
 
 EORBT           01000101 .. 0 ..... 10010 0 ..... .....  @rd_rn_rm
 EORTB           01000101 .. 0 ..... 10010 1 ..... .....  @rd_rn_rm
+
+## SVE2 bitwise permute
+
+BEXT            01000101 .. 0 ..... 1011 00 ..... .....  @rd_rn_rm
+BDEP            01000101 .. 0 ..... 1011 01 ..... .....  @rd_rn_rm
+BGRP            01000101 .. 0 ..... 1011 10 ..... .....  @rd_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 15ea1fd524..b5afa34efe 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1216,6 +1216,79 @@ DO_ZZZ_NTB(sve2_eoril_d, uint64_t,     , DO_EOR)
 
 #undef DO_ZZZ_NTB
 
+#define DO_BITPERM(NAME, TYPE, OP) \
+void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
+        TYPE nn = *(TYPE *)(vn + i);                           \
+        TYPE mm = *(TYPE *)(vm + i);                           \
+        *(TYPE *)(vd + i) = OP(nn, mm, sizeof(TYPE) * 8);      \
+    }                                                          \
+}
+
+static uint64_t bitextract(uint64_t data, uint64_t mask, int n)
+{
+    uint64_t res = 0;
+    int db, rb = 0;
+
+    for (db = 0; db < n; ++db) {
+        if ((mask >> db) & 1) {
+            res |= ((data >> db) & 1) << rb;
+            ++rb;
+        }
+    }
+    return res;
+}
+
+DO_BITPERM(sve2_bext_b, uint8_t, bitextract)
+DO_BITPERM(sve2_bext_h, uint16_t, bitextract)
+DO_BITPERM(sve2_bext_s, uint32_t, bitextract)
+DO_BITPERM(sve2_bext_d, uint64_t, bitextract)
+
+static uint64_t bitdeposit(uint64_t data, uint64_t mask, int n)
+{
+    uint64_t res = 0;
+    int rb, db = 0;
+
+    for (rb = 0; rb < n; ++rb) {
+        if ((mask >> rb) & 1) {
+            res |= ((data >> db) & 1) << rb;
+            ++db;
+        }
+    }
+    return res;
+}
+
+DO_BITPERM(sve2_bdep_b, uint8_t, bitdeposit)
+DO_BITPERM(sve2_bdep_h, uint16_t, bitdeposit)
+DO_BITPERM(sve2_bdep_s, uint32_t, bitdeposit)
+DO_BITPERM(sve2_bdep_d, uint64_t, bitdeposit)
+
+static uint64_t bitgroup(uint64_t data, uint64_t mask, int n)
+{
+    uint64_t resm = 0, resu = 0;
+    int db, rbm = 0, rbu = 0;
+
+    for (db = 0; db < n; ++db) {
+        uint64_t val = (data >> db) & 1;
+        if ((mask >> db) & 1) {
+            resm |= val << rbm++;
+        } else {
+            resu |= val << rbu++;
+        }
+    }
+
+    return resm | (resu << rbm);
+}
+
+DO_BITPERM(sve2_bgrp_b, uint8_t, bitgroup)
+DO_BITPERM(sve2_bgrp_h, uint16_t, bitgroup)
+DO_BITPERM(sve2_bgrp_s, uint32_t, bitgroup)
+DO_BITPERM(sve2_bgrp_d, uint64_t, bitgroup)
+
+#undef DO_BITPERM
+
 #define DO_ZZI_SHLL(NAME, TYPE, TYPEN, OP) \
 void HELPER(NAME)(void *vd, void *vn, uint32_t desc)           \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 3eaf9cbe51..375b9dc983 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6173,3 +6173,39 @@ static bool trans_USHLLT(DisasContext *s, arg_rri_esz *a)
 {
     return do_sve2_shll_tb(s, a, true, true);
 }
+
+static bool trans_BEXT(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_bext_b, gen_helper_sve2_bext_h,
+        gen_helper_sve2_bext_s, gen_helper_sve2_bext_d,
+    };
+    if (!dc_isar_feature(aa64_sve2_bitperm, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], 0);
+}
+
+static bool trans_BDEP(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_bdep_b, gen_helper_sve2_bdep_h,
+        gen_helper_sve2_bdep_s, gen_helper_sve2_bdep_d,
+    };
+    if (!dc_isar_feature(aa64_sve2_bitperm, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], 0);
+}
+
+static bool trans_BGRP(DisasContext *s, arg_rrr_esz *a)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_bgrp_b, gen_helper_sve2_bgrp_h,
+        gen_helper_sve2_bgrp_s, gen_helper_sve2_bgrp_d,
+    };
+    if (!dc_isar_feature(aa64_sve2_bitperm, s)) {
+        return false;
+    }
+    return do_sve2_zzw_ool(s, a, fns[a->esz], 0);
+}
-- 
2.20.1


