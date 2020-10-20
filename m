Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37247C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:24:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72AD22223C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csfqae+4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72AD22223C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuQg-0008PG-BP
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu13-0005CQ-GJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUu11-0003vi-J1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 11:57:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id c77so2329457wmd.4
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 08:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=8KRcR896eTNIkcAGmEKMZi3H1fH2UuiC+mfMQfLP/y4=;
 b=csfqae+4soZWwe2Qt9jYbebR9/DLwOXST/hzsr5BHWWsfDxvIdaGtaiTSSU1wbr6M5
 Ew0jANFUT0V4XzCjXhcegnPWj/lTjN7Mf3pPHxNOaVf8OZTJi3iGAcmThkEuDXFe4Bzb
 JMdI4NkddRGVrpnPAFQoqvPAnsIci3iJ71ceOwvHRl1EqGuygmcLKc3Wv8oQCWX0oPS9
 wQRRtYGAZdwRpDd2RLAFZOgt7GfpjGIoYwC1exFshigrXAQwcAMVq3t5vFX2kD+4n6qo
 rkhEpoVo4uv+Pl0lqPrCRemfUpFFykGZPZZBp2gX57Qu+5cwoRwjXB1SEIAAV4y8xg9l
 8dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8KRcR896eTNIkcAGmEKMZi3H1fH2UuiC+mfMQfLP/y4=;
 b=JCGcsUYTbP8dU/WY0435yJbPGJ4ER8eIeeDc7tDHORdAA4XcRJeJboEukGiWMbAN4W
 Z0bFrXhMmnqk4Ru/nOVPxCnXKLcEknh5cyeCkU4L2lBJTjFVj9dBOpETfM7Nb+H2EYsh
 4n78Eb6k6Nva+f0YYXffFG0gIYIHpiNcZlIAxsTXyrEdqIw5CdfsUUDygWG2iCbFtW3h
 f2gBzC9N72rhcLus7uEc4xm6U3kN0xUaI/WrpQPMhbTYWu1g9BUycL3SDWjrQR5mf0LN
 o74lGlTV+w2EGa2eZxwFOYNZiXN4y6h9txdVPYG2F3t589LOgNqLZlwZGz1SJi1BS+GA
 bExw==
X-Gm-Message-State: AOAM531EtbxU8BXzlo/cxaVN/NBhsuyVmo8TOBvkzHJjgDPe2+K2ZFzf
 f9V3wDwk/3OlMvjFS3PLdgDcr9fNIFtWBA==
X-Google-Smtp-Source: ABdhPJyllytvVLzUxYolgxYCwnWhCawhs+fGmLSCz5GZ+28cIjGDybUAsUnTwZffjbyPTPfwDYTjag==
X-Received: by 2002:a7b:c345:: with SMTP id l5mr3586958wmj.123.1603209453793; 
 Tue, 20 Oct 2020 08:57:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id v6sm3780205wrp.69.2020.10.20.08.57.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 08:57:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/41] target/arm: Implement v8.1M conditional-select insns
Date: Tue, 20 Oct 2020 16:56:37 +0100
Message-Id: <20201020155656.8045-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020155656.8045-1-peter.maydell@linaro.org>
References: <20201020155656.8045-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v8.1M brings four new insns to M-profile:
 * CSEL  : Rd = cond ? Rn : Rm
 * CSINC : Rd = cond ? Rn : Rm+1
 * CSINV : Rd = cond ? Rn : ~Rm
 * CSNEG : Rd = cond ? Rn : -Rm

Implement these.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20201019151301.2046-4-peter.maydell@linaro.org
---
 target/arm/t32.decode  |  3 +++
 target/arm/translate.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/target/arm/t32.decode b/target/arm/t32.decode
index 7069d821fde..d8454bd814e 100644
--- a/target/arm/t32.decode
+++ b/target/arm/t32.decode
@@ -90,6 +90,9 @@ SBC_rrri         1110101 1011 . .... 0 ... .... .... ....     @s_rrr_shi
 }
 RSB_rrri         1110101 1110 . .... 0 ... .... .... ....     @s_rrr_shi
 
+# v8.1M CSEL and friends
+CSEL             1110101 0010 1 rn:4 10 op:2 rd:4 fcond:4 rm:4
+
 # Data-processing (register-shifted register)
 
 MOV_rxrr         1111 1010 0 shty:2 s:1 rm:4 1111 rd:4 0000 rs:4 \
diff --git a/target/arm/translate.c b/target/arm/translate.c
index d8729e42c48..9f2201ca577 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -8262,6 +8262,66 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
     return true;
 }
 
+/* v8.1M CSEL/CSINC/CSNEG/CSINV */
+static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
+{
+    TCGv_i32 rn, rm, zero;
+    DisasCompare c;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_V8_1M)) {
+        return false;
+    }
+
+    if (a->rm == 13) {
+        /* SEE "Related encodings" (MVE shifts) */
+        return false;
+    }
+
+    if (a->rd == 13 || a->rd == 15 || a->rn == 13 || a->fcond >= 14) {
+        /* CONSTRAINED UNPREDICTABLE: we choose to UNDEF */
+        return false;
+    }
+
+    /* In this insn input reg fields of 0b1111 mean "zero", not "PC" */
+    if (a->rn == 15) {
+        rn = tcg_const_i32(0);
+    } else {
+        rn = load_reg(s, a->rn);
+    }
+    if (a->rm == 15) {
+        rm = tcg_const_i32(0);
+    } else {
+        rm = load_reg(s, a->rm);
+    }
+
+    switch (a->op) {
+    case 0: /* CSEL */
+        break;
+    case 1: /* CSINC */
+        tcg_gen_addi_i32(rm, rm, 1);
+        break;
+    case 2: /* CSINV */
+        tcg_gen_not_i32(rm, rm);
+        break;
+    case 3: /* CSNEG */
+        tcg_gen_neg_i32(rm, rm);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    arm_test_cc(&c, a->fcond);
+    zero = tcg_const_i32(0);
+    tcg_gen_movcond_i32(c.cond, rn, c.value, zero, rn, rm);
+    arm_free_cc(&c);
+    tcg_temp_free_i32(zero);
+
+    store_reg(s, a->rd, rn);
+    tcg_temp_free_i32(rm);
+
+    return true;
+}
+
 /*
  * Legacy decoder.
  */
-- 
2.20.1


