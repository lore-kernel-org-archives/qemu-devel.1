Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF68C2D0E8
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:24:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5CD21556
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 23:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yw8hGYah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5CD21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHbrm-0002BP-PQ
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 19:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59089)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcd-0002r2-C1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHbcb-0001oV-Q1
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:11 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:37022)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHbca-0001m4-KA
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 19:09:09 -0400
Received: by mail-pj1-x1044.google.com with SMTP id o12so3028580pjs.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 16:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LQixDJy63XBgzN/Out1zz4zHKJbz7GOqSodi9xHGXHY=;
 b=yw8hGYahmmK5OWDdb+aXE7qdpyChrE6WKdynmHRx10QCfxGN12pxCrUM3xOHoJHocf
 IT4y1kaUnMJ9dew4pZAMz2N4TM1EZtNZzbQVsqnmOWd/YcZlllzjUD0u79NNuflhLka4
 GAJJvIIgOp+2EXGxCpzPDpXU1YG9hDIQf1zIXrSjtWXgUr3s/KJUfzv62KdgIaWgIxbB
 AXueFc4VMn5nFMMqiMwRGgxJMcvTaqdzZop4M+jQm8b0SQPw9BbDU9rqA7NVmQ66FViq
 Ozrw0/LOXg4KNlMd3HPnfgK0x3cyWmHMvdYdjDaljHPuWo1y3DP1GMbFmFF4rqR29OO9
 sNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LQixDJy63XBgzN/Out1zz4zHKJbz7GOqSodi9xHGXHY=;
 b=ZaurbdBcyCBupDO2b1C/Vn7mOify+cZ8M1UktXhUlRmCaAxGzYiJHG1Yarrzoo9mWm
 KHla0VKhmfI6lo6LfBk7OBPtfkAH2vyMhrugXYvYhs0UImPV4iw7rStNkbqJDDwpW2CV
 fcWGomZHLbuCaFaMKN9hgsM5Oqa6xHx6WVBJoV2hBfEGdbJgmK6CRL5gozJbP8UrICIT
 9rYCkTiNlsZajHayaXUJ+6XG/gas7Q6T+qO94IqBI+X4zvhXVrU8glyyQ+CNnpqarIsU
 m94zxeyujBdFe3Djd7bh+zOgNkw3Y73A7t6qUb2iLqalMF5qZUDzO7EObWZMoDKxOsI7
 B4tQ==
X-Gm-Message-State: ANhLgQ0ToKAYNiIX5d6yyNZyaYrCP8k+hwrxK2NctxJ0zuMlka31sAYE
 fkIoHxTJO0DwhkDg8BIZdHMDV+hCvuU=
X-Google-Smtp-Source: ADFU+vtaEmi+DNjWVYqLEceeThdr1eqV9TPqbXXT/gEy6i4PJ5vGbQ1bliHzNezxovdd9tFvE/YSWw==
X-Received: by 2002:a17:90a:2103:: with SMTP id
 a3mr2604118pje.181.1585264147049; 
 Thu, 26 Mar 2020 16:09:07 -0700 (PDT)
Received: from localhost.localdomain (174-21-138-234.tukw.qwest.net.
 [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id i187sm2530037pfg.33.2020.03.26.16.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 16:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 21/31] target/arm: Implement SVE2 integer absolute difference
 and accumulate long
Date: Thu, 26 Mar 2020 16:08:28 -0700
Message-Id: <20200326230838.31112-22-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 14 ++++++++++
 target/arm/sve.decode      | 12 +++++++++
 target/arm/sve_helper.c    | 24 +++++++++++++++++
 target/arm/translate-sve.c | 54 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 104 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 0e4b4c48da..b48a88135f 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2410,3 +2410,17 @@ DEF_HELPER_FLAGS_4(sve2_sqcadd_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqcadd_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqcadd_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_sqcadd_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_sabal_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sabal_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_sabal_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_uabal_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uabal_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_uabal_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 5fb4b5f977..f66a6c242f 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -70,6 +70,7 @@
 &rpr_s          rd pg rn s
 &rprr_s         rd pg rn rm s
 &rprr_esz       rd pg rn rm esz
+&rrrr_esz       rd ra rn rm esz
 &rprrr_esz      rd pg rn rm ra esz
 &rpri_esz       rd pg rn imm esz
 &ptrue          rd esz pat s
@@ -120,6 +121,10 @@
 @rdn_i8s        ........ esz:2 ...... ... imm:s8 rd:5 \
                 &rri_esz rn=%reg_movprfx
 
+# Four operand, vector element size
+@rda_rn_rm      ........ esz:2 . rm:5 ... ... rn:5 rd:5 \
+                &rrrr_esz ra=%reg_movprfx
+
 # Three operand with "memory" size, aka immediate left shift
 @rd_rn_msz_rm   ........ ... rm:5 .... imm:2 rn:5 rd:5          &rrri
 
@@ -1235,3 +1240,10 @@ CADD_rot90      01000101 .. 00000 0 11011 0 ..... .....  @rdn_rm
 CADD_rot270     01000101 .. 00000 0 11011 1 ..... .....  @rdn_rm
 SQCADD_rot90    01000101 .. 00000 1 11011 0 ..... .....  @rdn_rm
 SQCADD_rot270   01000101 .. 00000 1 11011 1 ..... .....  @rdn_rm
+
+## SVE2 integer absolute difference and accumulate long
+
+SABALB          01000101 .. 0 ..... 1100 00 ..... .....  @rda_rn_rm
+SABALT          01000101 .. 0 ..... 1100 01 ..... .....  @rda_rn_rm
+UABALB          01000101 .. 0 ..... 1100 10 ..... .....  @rda_rn_rm
+UABALT          01000101 .. 0 ..... 1100 11 ..... .....  @rda_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index a3653007ac..a0995d95c7 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1216,6 +1216,30 @@ DO_ZZZ_NTB(sve2_eoril_d, uint64_t,     , DO_EOR)
 
 #undef DO_ZZZ_NTB
 
+#define DO_ABAL(NAME, TYPE, TYPEN) \
+void HELPER(NAME)(void *vd, void *va, void *vn, void *vm, uint32_t desc) \
+{                                                              \
+    intptr_t i, opr_sz = simd_oprsz(desc);                     \
+    int sel1 = (simd_data(desc) & 1) * sizeof(TYPE);           \
+    int sel2 = (simd_data(desc) & 2) * (sizeof(TYPE) / 2);     \
+    for (i = 0; i < opr_sz; i += sizeof(TYPE)) {               \
+        TYPE nn = (TYPEN)(*(TYPE *)(vn + i) >> sel1);          \
+        TYPE mm = (TYPEN)(*(TYPE *)(vm + i) >> sel2);          \
+        TYPE aa = *(TYPE *)(va + i);                           \
+        *(TYPE *)(vd + i) = DO_ABD(nn, mm) + aa;               \
+    }                                                          \
+}
+
+DO_ABAL(sve2_sabal_h, int16_t, int8_t)
+DO_ABAL(sve2_sabal_s, int32_t, int16_t)
+DO_ABAL(sve2_sabal_d, int64_t, int32_t)
+
+DO_ABAL(sve2_uabal_h, uint16_t, uint8_t)
+DO_ABAL(sve2_uabal_s, uint32_t, uint16_t)
+DO_ABAL(sve2_uabal_d, uint64_t, uint32_t)
+
+#undef DO_ABAL
+
 #define DO_BITPERM(NAME, TYPE, OP) \
 void HELPER(NAME)(void *vd, void *vn, void *vm, uint32_t desc) \
 {                                                              \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 3b0aa86e79..c6161d2ce2 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -6240,3 +6240,57 @@ static bool trans_SQCADD_rot270(DisasContext *s, arg_rrr_esz *a)
 {
     return do_cadd(s, a, true, true);
 }
+
+static bool do_sve2_zzzz_ool(DisasContext *s, arg_rrrr_esz *a,
+                             gen_helper_gvec_4 *fn, int data)
+{
+    if (fn == NULL || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_4_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->ra),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, data, fn);
+    }
+    return true;
+}
+
+static bool do_abal(DisasContext *s, arg_rrrr_esz *a, bool uns, bool sel)
+{
+    static gen_helper_gvec_4 * const fns[2][3] = {
+        { gen_helper_sve2_sabal_h,
+          gen_helper_sve2_sabal_s,
+          gen_helper_sve2_sabal_d },
+        { gen_helper_sve2_uabal_h,
+          gen_helper_sve2_uabal_s,
+          gen_helper_sve2_uabal_d },
+    };
+
+    if (a->esz == 0) {
+        return false;
+    }
+    return do_sve2_zzzz_ool(s, a, fns[uns][a->esz - 1], sel);
+}
+
+static bool trans_SABALB(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, false, false);
+}
+
+static bool trans_SABALT(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, false, true);
+}
+
+static bool trans_UABALB(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, true, false);
+}
+
+static bool trans_UABALT(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_abal(s, a, true, true);
+}
-- 
2.20.1


