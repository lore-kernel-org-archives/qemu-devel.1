Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CB9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A01421852
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 05:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFSgBMdq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A01421852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlmmW-0005nb-BI
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 01:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDc-00052T-Tr
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:10 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:39533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jlmDZ-0003QS-S6
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 00:32:03 -0400
Received: by mail-pj1-x1044.google.com with SMTP id h95so2081355pje.4
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 21:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h0utKIwCKTuggRlCHgceRrXUBl35CiLU8leCzjyjWWY=;
 b=iFSgBMdqnJdmi5kpFjyfZCBQN9woj3F68bRlZvAkjtgzJ1sYm0vY3I9SHabFKMuqdf
 qgalhN7xZv2jYZtwAvSrIshGt+svMWcZpn2nSv0rl+sK3RSQ/qMggPq3c78udhcwuaDa
 Yox+vpBWgaagnhJ+G/HxJwd10556d7bLvOqDvXyHZCx52xDqpDjILBH4wtPefTfIzM7/
 2asCqxxtABHQeKd2fruNqkdCx+LcM/dqwiA0ODc9HEMTBgNl/lxclQg/YB6hJGGnV3/7
 0vHFQ+9wgY0FS2OV9kguVOXVkupX9X3byn8u7Y/Iqje7oeCeeWq1Ox5Iteg1f4K5bVB5
 /vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h0utKIwCKTuggRlCHgceRrXUBl35CiLU8leCzjyjWWY=;
 b=a5vIaYG32pfd2a9Jis3KeWVnZ0AgBiq9G6b3fDEgt28NTWdELQ5e9N2ODhgLRd0tqb
 +5nyEA4siIFCChCurKRkej78CYGIGdhCVUYwk6SeOlAe9p2lThDBj9E1Sq/ljF8qwfSH
 WXFrBfJdw8rvE06Kbp8SYrro9RT6eJWrtz6vEMuUv8+oy6IXgPiteXhN2ociTZ4DXU9S
 uRN2aSVxqWfXs0YptbR0c9Ex6IvCFDjMjsd38pXPZ2IteTSpnW/9x8Ce6j6OO+eib7Tz
 jtWs6P0tNM+X3Y2r8kzwap3y5z8llLTFtBWRwSre0fgQJ0/kk+EcFpRCBrjBklONwo1C
 Uaeg==
X-Gm-Message-State: AOAM533KlP2JGse2jGpsJOGrBvnihr0I0j308mtt3LeR4sINwYUDiqyP
 T0DN7Wn51oNdp26HxfdJseSP6uf+kqI=
X-Google-Smtp-Source: ABdhPJwxOLSQGMh1HL4COHspr7mIwHYOuw11pfBYFTfOp0WNafW3n7te3xhBGh6IuGbKKwqx+K7Nzg==
X-Received: by 2002:a17:90a:e50b:: with SMTP id
 t11mr2417984pjy.109.1592454720220; 
 Wed, 17 Jun 2020 21:32:00 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id s15sm1162840pgv.5.2020.06.17.21.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 21:31:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 074/100] target/arm: Use helper_gvec_ml{a,
 s}_idx_* for aa64 advsimd
Date: Wed, 17 Jun 2020 21:26:18 -0700
Message-Id: <20200618042644.1685561-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618042644.1685561-1-richard.henderson@linaro.org>
References: <20200618042644.1685561-1-richard.henderson@linaro.org>
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
 target/arm/translate-a64.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a3135754ce..5ef6ecfbf1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13053,6 +13053,40 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             return;
         }
         break;
+
+    case 0x10: /* MLA */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_4 * const fns[3] = {
+                gen_helper_gvec_mla_idx_h,
+                gen_helper_gvec_mla_idx_s,
+                gen_helper_gvec_mla_idx_d,
+            };
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               vec_full_reg_offset(s, rd),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
+
+    case 0x14: /* MLS */
+        if (!is_long && !is_scalar) {
+            static gen_helper_gvec_4 * const fns[3] = {
+                gen_helper_gvec_mls_idx_h,
+                gen_helper_gvec_mls_idx_s,
+                gen_helper_gvec_mls_idx_d,
+            };
+            tcg_gen_gvec_4_ool(vec_full_reg_offset(s, rd),
+                               vec_full_reg_offset(s, rn),
+                               vec_full_reg_offset(s, rm),
+                               vec_full_reg_offset(s, rd),
+                               is_q ? 16 : 8, vec_full_reg_size(s),
+                               index, fns[size - 1]);
+            return;
+        }
+        break;
     }
 
     if (size == 3) {
-- 
2.25.1


