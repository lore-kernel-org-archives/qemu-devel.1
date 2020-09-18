Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C8BC43465
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4582A22208
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u1SC/TkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4582A22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJM4P-0004zQ-D9
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHN-0000UF-SJ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:41 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:53496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHL-0007A2-Sg
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:38:41 -0400
Received: by mail-pj1-x1044.google.com with SMTP id t7so3624660pjd.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4IryoG8DYenziLinJYml5j3JERwzXkbcIwlI0q1lzG0=;
 b=u1SC/TkInsER5S2a0B3bOSqStzTXqdEH3wYnzWC+83OErlKJ2CcM7SiDXWDPLZb0Gn
 Ox/3WxYFCR51scwfjY5nahjVNuREkCfeQ3ByWx8yoTh9js5PCWbAVJAFEueD02T3AzTY
 sZ2K0osnBV7PCd/zrSsZnkh8n3ZwEPfLxSLoVyvqorDmz7YhfsduTVG0s0xVN363ikTP
 cmJzeoyVQ9AIf0RPK6HIxOWZj6ZBgJrlPmAPJ8KOuNlJz3nhXXjoLGUmVeVYiizTVNjW
 pdu+UK2l0DyVJ3HZQ8eW8K10JDdn7/DpOJLl1/QOjqQl8iqgmAlCurgmkK6HMeXft/lt
 tRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4IryoG8DYenziLinJYml5j3JERwzXkbcIwlI0q1lzG0=;
 b=LEB6zeLMsBb6IAT05JU7cc/sMYTM+TuK5Yh1l61XfcuhynhmJgue1WZxEP7Im7p55z
 N0zz+0DsJ7l3eU0xtU+KHRuOuxM0Zv+wB4ny+kCS3Lr1VIoQdEKuTa0Ti3glYpz3IkN1
 AdmpsF7vNpd8DCGEe7XDyaDBAWlv88OgUIU6XIUWS5AVZrg3/Drck1Hk0M/CQLvEbAx1
 7zZsNDch6jsMlAGeEJp5g2e4DZGNsuhyBo5UY5DKcUIlka3jJvSa1HvqHrRPB2jfNAc1
 bC0QFmJSzqajF2H3ytsdUi/g5r1mLGg4cbPMoLBD+A7yFwZRHXzLRVnn0qNQLpG9iPl/
 locw==
X-Gm-Message-State: AOAM53322E8buhEYTx6cSHNJ6hTaO443bcYmvJh02EyyaAvOHW/g7kGr
 74vuLlVBsM7WkPCtN8EeCtrZkrmyU9S81Q==
X-Google-Smtp-Source: ABdhPJyEsxKXXyuM15gkXwxQmbwKFTLQW2zv1cKmf58livm2H6nbOtg4dT7b8iX5l569OVK32P25ig==
X-Received: by 2002:a17:902:a701:b029:d0:89f3:28d5 with SMTP id
 w1-20020a170902a701b02900d089f328d5mr34293648plq.17.1600454318252; 
 Fri, 18 Sep 2020 11:38:38 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:38:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 34/81] target/arm: Implement SVE2 WHILERW, WHILEWR
Date: Fri, 18 Sep 2020 11:37:04 -0700
Message-Id: <20200918183751.2787647-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
v2: Fix decodetree typo
---
 target/arm/sve.decode      |  3 ++
 target/arm/translate-sve.c | 62 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index b7038f9f57..19d503e2f4 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -702,6 +702,9 @@ CTERM           00100101 1 sf:1 1 rm:5 001000 rn:5 ne:1 0000
 # SVE integer compare scalar count and limit
 WHILE           00100101 esz:2 1 rm:5 000 sf:1 u:1 lt:1 rn:5 eq:1 rd:4
 
+# SVE2 pointer conflict compare
+WHILE_ptr       00100101 esz:2 1 rm:5 001 100 rn:5 rw:1 rd:4
+
 ### SVE Integer Wide Immediate - Unpredicated Group
 
 # SVE broadcast floating-point immediate (unpredicated)
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index f1bc4c63e6..d3241ce167 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3227,6 +3227,68 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     return true;
 }
 
+static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
+{
+    TCGv_i64 op0, op1, diff, t1, tmax;
+    TCGv_i32 t2, t3;
+    TCGv_ptr ptr;
+    unsigned desc, vsz = vec_full_reg_size(s);
+
+    if (!dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    op0 = read_cpu_reg(s, a->rn, 1);
+    op1 = read_cpu_reg(s, a->rm, 1);
+
+    tmax = tcg_const_i64(vsz);
+    diff = tcg_temp_new_i64();
+
+    if (a->rw) {
+        /* WHILERW */
+        /* diff = abs(op1 - op0), noting that op0/1 are unsigned. */
+        t1 = tcg_temp_new_i64();
+        tcg_gen_sub_i64(diff, op0, op1);
+        tcg_gen_sub_i64(t1, op1, op0);
+        tcg_gen_movcond_i64(TCG_COND_LTU, diff, op0, op1, diff, t1);
+        tcg_temp_free_i64(t1);
+        /* If op1 == op0, diff == 0, and the condition is always true. */
+        tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
+    } else {
+        /* WHILEWR */
+        tcg_gen_sub_i64(diff, op1, op0);
+        /* If op0 >= op1, diff <= 0, the condition is always true. */
+        tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
+    }
+
+    /* Bound to the maximum.  */
+    tcg_gen_umin_i64(diff, diff, tmax);
+    tcg_temp_free_i64(tmax);
+
+    /* Since we're bounded, pass as a 32-bit type.  */
+    t2 = tcg_temp_new_i32();
+    tcg_gen_extrl_i64_i32(t2, diff);
+    tcg_temp_free_i64(diff);
+
+    desc = (vsz / 8) - 2;
+    desc = deposit32(desc, SIMD_DATA_SHIFT, 2, a->esz);
+    t3 = tcg_const_i32(desc);
+
+    ptr = tcg_temp_new_ptr();
+    tcg_gen_addi_ptr(ptr, cpu_env, pred_full_reg_offset(s, a->rd));
+
+    gen_helper_sve_whilel(t2, ptr, t2, t3);
+    do_pred_flags(t2);
+
+    tcg_temp_free_ptr(ptr);
+    tcg_temp_free_i32(t2);
+    tcg_temp_free_i32(t3);
+    return true;
+}
+
 /*
  *** SVE Integer Wide Immediate - Unpredicated Group
  */
-- 
2.25.1


