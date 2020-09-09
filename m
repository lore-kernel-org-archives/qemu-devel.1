Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFDFC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EB7A2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hAK0Do5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB7A2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFntz-0006GD-J6
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnK-0007mO-NA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:02 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:32979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnJ-0002CQ-3V
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:02 -0400
Received: by mail-pf1-x444.google.com with SMTP id c196so693319pfc.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iyDgOefakgRBrjZznHAuamMZUpzKL16pwL2bnPHHK48=;
 b=hAK0Do5spTeLBpcjH1zbZnLmevMIGLZHITacCU6QDmG5LQ8kVAg/3lFCR8Ph3pfl4A
 lqfkKU+uBT8KEn1yaso9g5RnpJq+Oj+6oIvRSNHDJD2LX76GiVOU5NE3s9jpmVDKep9/
 i31QPQKDyjMgvYHk2C8qD7bPq61N14ypsmIzzMHydMqMtrjlA/BkxptxP3hw9ROfr/S1
 IpEhWdgO6qRRhGE6wdD7augNQQG9/rn46nU4d0+z9ow7AHM+3BuyySGEgG2lXqhjVkcO
 kG28hp2gsiR9UThKflrYFH4Al16Nj433qED8bSa3RCQy8ZO9MlDMPjB+erXbtxLtzGBI
 6XhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iyDgOefakgRBrjZznHAuamMZUpzKL16pwL2bnPHHK48=;
 b=EnsT2fhghcHOBxwjwd2D0dY19g2Rt6Qxg6L95dyNVJTA8UQJ/lKDkVT0VZdJVJqShK
 mw2zSHpUvaC3VlwpoJZyQYn0hgxaR3n3H3LpgFdJ404XdTM74zciuYoXyljWOhlz2Ceg
 iV11AdNrnEAiIt3qHOCHW9wfbQ+2NWZwxzNxUp/r6uybXLpUf+ZaAPvXV8/dyIQOaVJi
 tc39svkuC0SfaUjbHhx+CjzCQK3QPM1S+OMRH0IkgoS5+eG50AgjlbOKndSSdmzJtq9o
 auHIwSZ55OEvUI8I2JnIReeRs+P3d1E7JbuOfJBBYSkqMXfBXm6ak0TC4HBvBEwyDW/L
 0OMA==
X-Gm-Message-State: AOAM530fpVGK9iEOSOZbHvNmNI1smzlmrNxCi5qeLTmHS/FAVwJvWkXX
 TQUhAPK4QrHBdz5evH81IJLPnrPkpBOqcg==
X-Google-Smtp-Source: ABdhPJyFdCHo3oP1SyfkmE8yP0gQ86gRKDcMXnDFtQ0EuDmghY9b9cro5PZtDK0G9oRrsHF3K6gV4g==
X-Received: by 2002:a17:902:a715:b029:d0:89f3:28cf with SMTP id
 w21-20020a170902a715b02900d089f328cfmr1436203plq.11.1599610619447; 
 Tue, 08 Sep 2020 17:16:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:16:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 08/43] tcg: Fix generation of dupi_vec for 32-bit host
Date: Tue,  8 Sep 2020 17:16:12 -0700
Message-Id: <20200909001647.532249-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The definition of INDEX_op_dupi_vec is that it operates on
units of tcg_target_ulong -- in this case 32 bits.  It does
not work to use this for a uint64_t value that happens to be
small enough to fit in tcg_target_ulong.

Fixes: d2fd745fe8b
Fixes: db432672dc5
Cc: qemu-stable@nongnu.org
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index ed6fb55fe1..cdbf11c573 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -252,10 +252,10 @@ TCGv_vec tcg_const_ones_vec_matching(TCGv_vec m)
 
 void tcg_gen_dup64i_vec(TCGv_vec r, uint64_t a)
 {
-    if (TCG_TARGET_REG_BITS == 32 && a == deposit64(a, 32, 32, a)) {
-        do_dupi_vec(r, MO_32, a);
-    } else if (TCG_TARGET_REG_BITS == 64 || a == (uint64_t)(int32_t)a) {
+    if (TCG_TARGET_REG_BITS == 64) {
         do_dupi_vec(r, MO_64, a);
+    } else if (a == dup_const(MO_32, a)) {
+        do_dupi_vec(r, MO_32, a);
     } else {
         TCGv_i64 c = tcg_const_i64(a);
         tcg_gen_dup_i64_vec(MO_64, r, c);
@@ -280,7 +280,11 @@ void tcg_gen_dup8i_vec(TCGv_vec r, uint32_t a)
 
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec r, uint64_t a)
 {
-    do_dupi_vec(r, MO_REG, dup_const(vece, a));
+    if (vece == MO_64) {
+        tcg_gen_dup64i_vec(r, a);
+    } else {
+        do_dupi_vec(r, MO_REG, dup_const(vece, a));
+    }
 }
 
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
-- 
2.25.1


