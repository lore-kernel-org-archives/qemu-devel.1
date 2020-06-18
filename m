Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D4AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:56:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEAA92186A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u88K4zYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEAA92186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmb5-0002r6-Uy
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmC9-0001tA-7F
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:35 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:33292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmC7-00037a-BF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:30:32 -0400
Received: by mail-pl1-x62d.google.com with SMTP id 35so1925331ple.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ylJBHmSfj4JtXqK4GBqpIAj/fR40J32bvTEmKBrV0sk=;
 b=u88K4zYw6JUY92v7WuqGCY3UA2tJNuj379678d6tRyAtf7qgylBqedP1p5Vba0r0ph
 buWTpeLP+7uBI8EYpwBScnT7T0Hy315Ec4rLrhrj2WqihuxX9saL0K6rujfT6hgOapsF
 Sk0EQFY+aAVC4WnNETMMaEld6u+Ll+6+5JQS0U7Nj9X3sz2t8tcLF6uyXnPEAwaPeRD3
 vsCNJjngZk9JjqRDo/aWZvWiLvRWArF/GEz9sSexzekLnwV1TPSCy3/GhFVxIEQzzo/G
 KpwTtlLwRveDJP4QWPKyyQw/B7lnwv8CmsLXG6FIouw6q8yqY30E3rkZ+3SLGtbDKLTP
 Ey4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ylJBHmSfj4JtXqK4GBqpIAj/fR40J32bvTEmKBrV0sk=;
 b=VGCOFSPYck8/3yx1OSIwW671Ulg6QKGYNyJ5dJO6iI5n2iYmH0hI5IOVkd2B8FSutd
 Mnp3/ajDRkmo+M9Rlf+rITCHSBNK/tU0JUJmVgYGFTs+DCQWAMzKhvpp+F81tyTpOsOy
 u15CoCLlT7Xymk3HbIEyqgBA1gN9NdkeDTPuyL1ieGkUbqoLYje+S98LgLw+zyRqUJjA
 AiQ7z/V6YeHbqzV9lUi0ntxQJKcdd9OvCa9Rx7S0JIHJH0TxAGeC1QrQoogkcvEEBJcn
 efQ0npUclGQrQoSi78b3aSSMlr3ZGiKlv0pXOO9weH2IxxTV/KPYCsQBcaIFHDiAkn+6
 U5WQ==
X-Gm-Message-State: AOAM532A/7lldqaL89hHU9tort1THvSA2SiXqd66XEeJ3BLcwDToJFlf
 Npv5F8W12otr5pUvH7em/sW6O/yAGbo=
X-Google-Smtp-Source: ABdhPJz0IKTkdJO4VYkVoWyjhsEgcG6lCskL8VUDg/o7RmWB8gqqXyEG4cEM2QM7PUKD3OpMGz9ZaQ==
X-Received: by 2002:a17:902:7208:: with SMTP id
 ba8mr2176186plb.217.1592454629380; 
 Wed, 17 Jun 2020 21:30:29 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i191sm1298861pfe.99.2020.06.17.21.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:30:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 052/100] target/arm: Implement SVE2 integer multiply-add
 long
Date: Wed, 17 Jun 2020 21:25:56 -0700
Message-Id: <20200618042644.1685561-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/arm/helper-sve.h    | 28 ++++++++++++++
 target/arm/sve.decode      | 11 ++++++
 target/arm/sve_helper.c    | 18 +++++++++
 target/arm/translate-sve.c | 76 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index f85b7be12e..8fc8b856e7 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2085,3 +2085,31 @@ DEF_HELPER_FLAGS_5(sve2_sqdmlsl_zzzw_s, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_sqdmlsl_zzzw_d, TCG_CALL_NO_RWG,
                    void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_smlal_zzzw_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_smlal_zzzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_smlal_zzzw_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_umlal_zzzw_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlal_zzzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlal_zzzw_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_smlsl_zzzw_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_smlsl_zzzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_smlsl_zzzw_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_5(sve2_umlsl_zzzw_h, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlsl_zzzw_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_5(sve2_umlsl_zzzw_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index 177b3cc803..19c5013ddd 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -1351,3 +1351,14 @@ SQDMLSLBT       01000100 .. 0 ..... 00001 1 ..... .....  @rda_rn_rm
 
 SQRDMLAH_zzzz   01000100 .. 0 ..... 01110 0 ..... .....  @rda_rn_rm
 SQRDMLSH_zzzz   01000100 .. 0 ..... 01110 1 ..... .....  @rda_rn_rm
+
+## SVE2 integer multiply-add long
+
+SMLALB_zzzw     01000100 .. 0 ..... 010 000 ..... .....  @rda_rn_rm
+SMLALT_zzzw     01000100 .. 0 ..... 010 001 ..... .....  @rda_rn_rm
+UMLALB_zzzw     01000100 .. 0 ..... 010 010 ..... .....  @rda_rn_rm
+UMLALT_zzzw     01000100 .. 0 ..... 010 011 ..... .....  @rda_rn_rm
+SMLSLB_zzzw     01000100 .. 0 ..... 010 100 ..... .....  @rda_rn_rm
+SMLSLT_zzzw     01000100 .. 0 ..... 010 101 ..... .....  @rda_rn_rm
+UMLSLB_zzzw     01000100 .. 0 ..... 010 110 ..... .....  @rda_rn_rm
+UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4c8b0fe9f1..dbf378d214 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1308,6 +1308,24 @@ DO_ZZZW_ACC(sve2_uabal_h, uint16_t, uint8_t, H1_2, H1, DO_ABD)
 DO_ZZZW_ACC(sve2_uabal_s, uint32_t, uint16_t, H1_4, H1_2, DO_ABD)
 DO_ZZZW_ACC(sve2_uabal_d, uint64_t, uint32_t,     , H1_4, DO_ABD)
 
+DO_ZZZW_ACC(sve2_smlal_zzzw_h, int16_t, int8_t, H1_2, H1, DO_MUL)
+DO_ZZZW_ACC(sve2_smlal_zzzw_s, int32_t, int16_t, H1_4, H1_2, DO_MUL)
+DO_ZZZW_ACC(sve2_smlal_zzzw_d, int64_t, int32_t,     , H1_4, DO_MUL)
+
+DO_ZZZW_ACC(sve2_umlal_zzzw_h, uint16_t, uint8_t, H1_2, H1, DO_MUL)
+DO_ZZZW_ACC(sve2_umlal_zzzw_s, uint32_t, uint16_t, H1_4, H1_2, DO_MUL)
+DO_ZZZW_ACC(sve2_umlal_zzzw_d, uint64_t, uint32_t,     , H1_4, DO_MUL)
+
+#define DO_NMUL(N, M)  -(N * M)
+
+DO_ZZZW_ACC(sve2_smlsl_zzzw_h, int16_t, int8_t, H1_2, H1, DO_NMUL)
+DO_ZZZW_ACC(sve2_smlsl_zzzw_s, int32_t, int16_t, H1_4, H1_2, DO_NMUL)
+DO_ZZZW_ACC(sve2_smlsl_zzzw_d, int64_t, int32_t,     , H1_4, DO_NMUL)
+
+DO_ZZZW_ACC(sve2_umlsl_zzzw_h, uint16_t, uint8_t, H1_2, H1, DO_NMUL)
+DO_ZZZW_ACC(sve2_umlsl_zzzw_s, uint32_t, uint16_t, H1_4, H1_2, DO_NMUL)
+DO_ZZZW_ACC(sve2_umlsl_zzzw_d, uint64_t, uint32_t,     , H1_4, DO_NMUL)
+
 #undef DO_ZZZW_ACC
 
 #define DO_XTNB(NAME, TYPE, OP) \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 28dc89c3a4..054c9d4799 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -7141,3 +7141,79 @@ static bool trans_SQRDMLSH_zzzz(DisasContext *s, arg_rrrr_esz *a)
     };
     return do_sve2_zzzz_ool(s, a, fns[a->esz], 0);
 }
+
+static bool do_smlal_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        NULL,                         gen_helper_sve2_smlal_zzzw_h,
+        gen_helper_sve2_smlal_zzzw_s, gen_helper_sve2_smlal_zzzw_d,
+    };
+    return do_sve2_zzzz_ool(s, a, fns[a->esz], sel);
+}
+
+static bool trans_SMLALB_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_smlal_zzzw(s, a, false);
+}
+
+static bool trans_SMLALT_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_smlal_zzzw(s, a, true);
+}
+
+static bool do_umlal_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        NULL,                         gen_helper_sve2_umlal_zzzw_h,
+        gen_helper_sve2_umlal_zzzw_s, gen_helper_sve2_umlal_zzzw_d,
+    };
+    return do_sve2_zzzz_ool(s, a, fns[a->esz], sel);
+}
+
+static bool trans_UMLALB_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_umlal_zzzw(s, a, false);
+}
+
+static bool trans_UMLALT_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_umlal_zzzw(s, a, true);
+}
+
+static bool do_smlsl_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        NULL,                         gen_helper_sve2_smlsl_zzzw_h,
+        gen_helper_sve2_smlsl_zzzw_s, gen_helper_sve2_smlsl_zzzw_d,
+    };
+    return do_sve2_zzzz_ool(s, a, fns[a->esz], sel);
+}
+
+static bool trans_SMLSLB_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_smlsl_zzzw(s, a, false);
+}
+
+static bool trans_SMLSLT_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_smlsl_zzzw(s, a, true);
+}
+
+static bool do_umlsl_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sel)
+{
+    static gen_helper_gvec_4 * const fns[] = {
+        NULL,                         gen_helper_sve2_umlsl_zzzw_h,
+        gen_helper_sve2_umlsl_zzzw_s, gen_helper_sve2_umlsl_zzzw_d,
+    };
+    return do_sve2_zzzz_ool(s, a, fns[a->esz], sel);
+}
+
+static bool trans_UMLSLB_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_umlsl_zzzw(s, a, false);
+}
+
+static bool trans_UMLSLT_zzzw(DisasContext *s, arg_rrrr_esz *a)
+{
+    return do_umlsl_zzzw(s, a, true);
+}
-- 
2.25.1


