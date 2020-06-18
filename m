Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F740C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2CC21852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q3GfpA32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2CC21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmmk-0006N9-1N
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDs-000566-6i
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:20 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534]:40347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDm-0003RY-2n
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:19 -0400
Received: by mail-pg1-x534.google.com with SMTP id e18so2336699pgn.7
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2k09KZLKxxubfLx07Dg5rpiql7TmODwkIvovmRwVXYU=;
 b=q3GfpA32hJRG4jPhOvzfXSicOmxiZHOClJ1+BZN2jbwQ0KIuAEbrz7wO0nirsHn4/d
 IPmNHSvXEoSPt6mxeT9/a3Ci6Dnv9slpO+yi4rVTqC3JQ7f8hVEM4dGwjw7PfvAD95w5
 3syWjzzJhGZOhXzz9HkpZWoEv6WpYXSaZ+2lngGqgPO8hav28kZKLKM6zavee5B6K6VB
 MeXf7QlCEvENDMIkgcoGga2fRH8uPKLsZPhzblcQA3F/1lAcZxk238DidL/pcpWhRUyL
 t4ZNTQVuF6btatHjpa2eqk0nIow5g3l8uWxG6wsNZUu3XQjjYL1Vz4Zp5j/wpYg5q1Kf
 pWcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2k09KZLKxxubfLx07Dg5rpiql7TmODwkIvovmRwVXYU=;
 b=U2BDcRKT9ekgTe8MYF5+NSMHk5ZJoGjWvrk9TaMnLrXkxqw3MobwDxOCSUeLPQG0SN
 yKAwjg0yDsLAy9Qs+WDFmYB9j6joGELYACKRNIBGUotVtg/ZYsCFUNGPoRXL1Liq2e7c
 ZeIYqBqAQ2o4oZZq2Ywlko78g2C7UYVqDjaM4Uw39RhiGW3GDskuTionpoWMGBDtEIRb
 me9owCRe8K6Zk9xaXybKil4U+qr5Hn0bBw823g/bW1SSRqC92w6Fw59nwFXLa/nN3IxX
 rnuUdVdPS6p3eAj+rpRgOC6jsjB+sYw3yaNHZ/jML3MorTeJ5kXeKSbelGRkyTPwzptN
 AHwg==
X-Gm-Message-State: AOAM531PWvLfvc6jmdnFVy6oO9ZSx+2SlXkLWlhhESIZCAFpy7OJH2VS
 epYgy0mU1V2MHiuicN40gr19XvEAdIY=
X-Google-Smtp-Source: ABdhPJwnrmB+S3zIosA7GdF6O7m3fmJSV2qpCfWlf5uPpAnDZ1mUTdx2EvY+6wQYwDott5YEtoUHmg==
X-Received: by 2002:a62:7a4a:: with SMTP id v71mr1993648pfc.35.1592454725900; 
 Wed, 17 Jun 2020 21:32:05 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm1162840pgv.5.2020.06.17.21.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:32:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 078/100] target/arm: Implement SVE2 saturating multiply
 (indexed)
Date: Wed, 17 Jun 2020 21:26:22 -0700
Message-Id: <20200618042644.1685561-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
 target/arm/helper-sve.h    | 5 +++++
 target/arm/sve.decode      | 6 ++++++
 target/arm/sve_helper.c    | 3 +++
 target/arm/translate-sve.c | 5 +++++
 4 files changed, 19 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index 91cce85f17..e8e616a247 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2205,3 +2205,8 @@ DEF_HELPER_FLAGS_4(sve2_smull_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_smull_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_umull_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_umull_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_4(sve2_sqdmull_idx_s, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2_sqdmull_idx_d, TCG_CALL_NO_RWG,
+                   void, ptr, ptr, ptr, i32)
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index f0a4d86428..400940a18d 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -835,6 +835,12 @@ UMULLB_zzx_d    01000100 .. 1 ..... 1101.0 ..... .....          @rrxl_d
 UMULLT_zzx_s    01000100 .. 1 ..... 1101.1 ..... .....          @rrxl_s
 UMULLT_zzx_d    01000100 .. 1 ..... 1101.1 ..... .....          @rrxl_d
 
+# SVE2 saturating multiply (indexed)
+SQDMULLB_zzx_s  01000100 .. 1 ..... 1110.0 ..... .....          @rrxl_s
+SQDMULLB_zzx_d  01000100 .. 1 ..... 1110.0 ..... .....          @rrxl_d
+SQDMULLT_zzx_s  01000100 .. 1 ..... 1110.1 ..... .....          @rrxl_s
+SQDMULLT_zzx_d  01000100 .. 1 ..... 1110.1 ..... .....          @rrxl_d
+
 # SVE2 integer multiply (indexed)
 MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
 MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index 4aff792345..52a235826c 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -1581,6 +1581,9 @@ DO_ZZX(sve2_smull_idx_d, int64_t, int32_t,     , H1_4, DO_MUL)
 DO_ZZX(sve2_umull_idx_s, uint32_t, uint16_t, H1_4, H1_2, DO_MUL)
 DO_ZZX(sve2_umull_idx_d, uint64_t, uint32_t,     , H1_4, DO_MUL)
 
+DO_ZZX(sve2_sqdmull_idx_s, int32_t, int16_t, H1_4, H1_2, do_sqdmull_s)
+DO_ZZX(sve2_sqdmull_idx_d, int64_t, int32_t,     , H1_4, do_sqdmull_d)
+
 #undef DO_ZZX
 
 #define DO_BITPERM(NAME, TYPE, OP) \
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index d8bb877ba5..4246d721d9 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3884,6 +3884,11 @@ DO_SVE2_RRX_TB(trans_UMULLB_zzx_d, gen_helper_sve2_umull_idx_d, false)
 DO_SVE2_RRX_TB(trans_UMULLT_zzx_s, gen_helper_sve2_umull_idx_s, true)
 DO_SVE2_RRX_TB(trans_UMULLT_zzx_d, gen_helper_sve2_umull_idx_d, true)
 
+DO_SVE2_RRX_TB(trans_SQDMULLB_zzx_s, gen_helper_sve2_sqdmull_idx_s, false)
+DO_SVE2_RRX_TB(trans_SQDMULLB_zzx_d, gen_helper_sve2_sqdmull_idx_d, false)
+DO_SVE2_RRX_TB(trans_SQDMULLT_zzx_s, gen_helper_sve2_sqdmull_idx_s, true)
+DO_SVE2_RRX_TB(trans_SQDMULLT_zzx_d, gen_helper_sve2_sqdmull_idx_d, true)
+
 #undef DO_SVE2_RRX_TB
 
 static bool do_sve2_zzxz_data(DisasContext *s, arg_rrxr_esz *a,
-- 
2.25.1


