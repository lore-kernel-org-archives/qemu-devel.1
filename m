Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB1AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7AE21852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 04:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CSYU8Rr4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7AE21852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmBf-00088J-Lg
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 00:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8i-0001zL-Q9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:00 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlm8h-0002Hv-AV
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:27:00 -0400
Received: by mail-pf1-x441.google.com with SMTP id 23so2174695pfw.10
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YQT2lykC9j0XvNzXk1cacc8eLU/nCOsDG3gfH9CfOaw=;
 b=CSYU8Rr41A7Ji/+sJysXjdq6sahwavipxOLdglB/D186VXaz+DyAMdwtkYwVKfNkBe
 9rRcuOwpICyDnk9itl1h9jr0nL1DgzFhHxEk2pLYG3VAryE0IC5BaRnbeoqjPAXjQQnR
 NzrRPDeIVUlfTPw6mA3BHr7Hjs/Do8dFrm7sDZMgRD+tvwHzlGTWpxOaGaSGGyTa61yQ
 7+N1qfETL6IcsiOYa746jbbOrpEw5jmSMVs9VUiN6znNafRI8QziPKLokGY33DcXnnQb
 Q5oQn5AipHHwvJ5fcvmHBJCqX194enXumIlz1uokbrvrrKAnEjLnGvWlY6AA6aIpU1A5
 a2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YQT2lykC9j0XvNzXk1cacc8eLU/nCOsDG3gfH9CfOaw=;
 b=p4uRdeDYgwtn6pnQ828oBo/ycb+cK6zm5r1GTwCIst1qL7zu4Mbvs87zufFfE+AiCl
 SDRQBenNQ1QkYKRzyG4V+6/6MZj//cFWAKe2CchKHqFCoeK/ClVcOO9FF3MERZzpS+U0
 SrsHmBYdG/b4DgNgFz0eaDyX8uozc4ZXwfFWwwWs5ehD9FRFJFfaDs+qWZDW2UDOHOGj
 hlnG13AKjY8zC6J69NvEmVS8yMnK4DsiaiP3wDW4bsAAZIUe97qjhV4bhDUfviBuFUAb
 waH9NCHYh+1FdU8e/U2iLgmCkSWYY7wHVzQovWczr7A3YZP00zEapMwIFsYhNEXskHCa
 tRxg==
X-Gm-Message-State: AOAM531V3hv+/LrO8crEDyDdsRH2/wcQS04SPBpvme27K7ccThX43sHk
 O30Nz3S+G46mjPSrOQJCQ2GL6nvQ5GY=
X-Google-Smtp-Source: ABdhPJzVQoUKomvxAYH9cLkmRDd+UBXMOEJcXzLaLCsrdtVy7lbw2alono+AMJxDHdej5sywDqHHCg==
X-Received: by 2002:a63:f711:: with SMTP id x17mr1845839pgh.79.1592454417654; 
 Wed, 17 Jun 2020 21:26:57 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o16sm1162035pgg.57.2020.06.17.21.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:26:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 008/100] target/arm: Use tcg_gen_gvec_bitsel for
 trans_SEL_pppp
Date: Wed, 17 Jun 2020 21:25:12 -0700
Message-Id: <20200618042644.1685561-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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

The gvec operation was added after the initial implementation
of the SEL instruction and was missed in the conversion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 6d1a69c365..741f4d8b32 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -1188,34 +1188,19 @@ static bool trans_EOR_pppp(DisasContext *s, arg_rprr_s *a)
     return do_pppp_flags(s, a, &op);
 }
 
-static void gen_sel_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
-{
-    tcg_gen_and_i64(pn, pn, pg);
-    tcg_gen_andc_i64(pm, pm, pg);
-    tcg_gen_or_i64(pd, pn, pm);
-}
-
-static void gen_sel_pg_vec(unsigned vece, TCGv_vec pd, TCGv_vec pn,
-                           TCGv_vec pm, TCGv_vec pg)
-{
-    tcg_gen_and_vec(vece, pn, pn, pg);
-    tcg_gen_andc_vec(vece, pm, pm, pg);
-    tcg_gen_or_vec(vece, pd, pn, pm);
-}
-
 static bool trans_SEL_pppp(DisasContext *s, arg_rprr_s *a)
 {
-    static const GVecGen4 op = {
-        .fni8 = gen_sel_pg_i64,
-        .fniv = gen_sel_pg_vec,
-        .fno = gen_helper_sve_sel_pppp,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    };
-
     if (a->s) {
         return false;
     }
-    return do_pppp_flags(s, a, &op);
+    if (sve_access_check(s)) {
+        unsigned psz = pred_gvec_reg_size(s);
+        tcg_gen_gvec_bitsel(MO_8, pred_full_reg_offset(s, a->rd),
+                            pred_full_reg_offset(s, a->pg),
+                            pred_full_reg_offset(s, a->rn),
+                            pred_full_reg_offset(s, a->rm), psz, psz);
+    }
+    return true;
 }
 
 static void gen_orr_pg_i64(TCGv_i64 pd, TCGv_i64 pn, TCGv_i64 pm, TCGv_i64 pg)
-- 
2.25.1


