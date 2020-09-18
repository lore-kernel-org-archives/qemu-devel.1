Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A0C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E3CB21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OB9XYUM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3CB21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMIG-0002fo-KA
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI8-0000yJ-TO
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:28 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHv-0007EG-Fw
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:28 -0400
Received: by mail-pf1-x442.google.com with SMTP id z18so4009941pfg.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9SaDxjAes0OJRLPIkAIggjDGEtTmMvajhiHB5LibM7I=;
 b=OB9XYUM7ZUCJLaOBUQwdrQ2aT8rlTYih4sTelB8UIFhi9c3i0IP+4RAn5DpDlKVdoE
 09ETP74f1Twkg1RJ1KY2GfmL4PUCwaRHTbo2xHSj10P4/ZNAgI5QdzK0Y8l1mEgsyrI+
 Trnmqm0KfcEM9xliYZCLrcluRXWnyiTiZBQSFB7OQA2ez8/gnNrBOrasdHwilbi2CIHA
 5onAVGaXxPOpuufDfnEhONWucIQMNMPApp4ffd+0+2MwpgU9bPIUo3D3gZi0eMpV7k+i
 upvquRGJvswP3byKoEwMfxjsguZdx1GdInSdhyE+9DJ370Q++3BIMuRicURhimtysyUH
 oXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9SaDxjAes0OJRLPIkAIggjDGEtTmMvajhiHB5LibM7I=;
 b=KcHwKKIH/TRRHLn0PreS5Zznw0v8QII4bIAQac/WqKMdc8KvjdIENLNwW9NvItqMYy
 JWiQS3VS7Jt59axmwpc3LH85TqOGvdavXUuivQXzsB3fMkAYYlhUHN9x7uXxhC9rJ/X5
 Q9Qgmcefx5CiFjc/9skuw84prA7MyOOPqDAAO+PaHYKvsuw0vQJuByLZPd3K4irHXazw
 +HhB7sVjW1giqC54w0qjvbQV89QosNge0LSEoaMPFHG5AIVUl7+l8N6xnun9rLS6tPfb
 yl/X5W/lBqA+50pdpIQ3I0q3Xwuyfhn6g84pDCD97mNx8kHG3m0FVNJdA+6/GzDu3/0g
 Uu6Q==
X-Gm-Message-State: AOAM531Z7LSYkoddpCrOGLd/WctHbus69DaizoCXpHngp8rCPAQbi0I+
 gK7j2Gpu59yetV7CDfQYHy18b+mNzkteBg==
X-Google-Smtp-Source: ABdhPJx0+ByJNnXbxdhIUgB3Aiz1IgqP1Wtpjo3zOCdWLzeJiiehBz1gewBl1ZfbMXO53f11h5Ez0g==
X-Received: by 2002:a62:2985:0:b029:142:2501:34d6 with SMTP id
 p127-20020a6229850000b0290142250134d6mr16933373pfp.47.1600454352836; 
 Fri, 18 Sep 2020 11:39:12 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 60/81] target/arm: Implement SVE2 saturating multiply
 (indexed)
Date: Fri, 18 Sep 2020 11:37:30 -0700
Message-Id: <20200918183751.2787647-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
 target/arm/helper-sve.h    | 5 +++++
 target/arm/sve.decode      | 6 ++++++
 target/arm/sve_helper.c    | 3 +++
 target/arm/translate-sve.c | 5 +++++
 4 files changed, 19 insertions(+)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
index d11598a75a..ff85e1327b 100644
--- a/target/arm/helper-sve.h
+++ b/target/arm/helper-sve.h
@@ -2693,3 +2693,8 @@ DEF_HELPER_FLAGS_4(sve2_smull_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
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
index 80449cc569..926fe98eb5 100644
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
index 39e5160e25..c30aed211f 100644
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


