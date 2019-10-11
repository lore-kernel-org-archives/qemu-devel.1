Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5818C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:54:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 684192064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 13:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxMkP3cu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 684192064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvNG-0001y7-3f
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 09:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvIz-0005Qr-Oy
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iIvIy-0003qA-NH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:05 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:38264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iIvIy-0003pw-Jz
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:50:04 -0400
Received: by mail-yw1-xc41.google.com with SMTP id s6so3496237ywe.5
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o8+XY/UcseGCyRDxlQOhrRq4L82DVUKd4GlR/wFLdGQ=;
 b=XxMkP3cuC45PymTfi2IKBDZt8J4WXEa/gzYz/z/Au1ZuaM/U+Wh2+/Z6pXS41OU/Bu
 yWa539MQMIWZrGmU10sEDGYBRQ1KQ8l/vADphQ+MWVVeeEh0CJaUngIckbrX0HkJLI+p
 0VhWb5Puue2V10/LNoEfVIjOhgIe38THpT51yu0iUH+saSuLZJsNT9hHC5AThQZP4sL8
 Y8BNI5sPGcXAiFy2pQsjOrHoQAajSpaGoRYnJodvF2mIVval+f1rvyDfy7xZqStgE9/Q
 4O5GzKPSepeAPP/MxobLIKi5vnAfLdSgOyM/tGQOFOVXiVt8ustM9ZHEfg9rMFwihxi4
 Q/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o8+XY/UcseGCyRDxlQOhrRq4L82DVUKd4GlR/wFLdGQ=;
 b=XAP9MF1bEVgnj0y/Xfn60uEflGWfYNuN31+K8cr+/dWCLFFg0dsdQGMwSJ+QAxGSdD
 ShBdvgNdTp4z/SqcYfS+OHuTGIXQYODh45xZj6E6G6AafLUKRD3YXcj9Wx0byj66tBxR
 Hptejj9Y5uZFiYIfFhjExS4GVSl8m2BnSeJwEwVAL5g6LfqI/HRORaRpow9B/VdmlQV8
 y7NvsdAGipiIzdH9dkmkpfJyhodvRMrYdGObZrDR9iR3T/9PwkjMHsb3xnbT6ySTZLRd
 oJpvSCcGz2LrnLtdMULCL0nDXTI3AT5yL4Ae93Yh8luVHOHpK0xnEyDppd7g1zCdUhDp
 g4wg==
X-Gm-Message-State: APjAAAVX7PoOeR5MMeD+/2rORX5ub+EPFsZFSzHQ7vRgr+d60PmXCGZG
 c6Fo9JYuk1A34+eLUbbToTELJdi4bC8=
X-Google-Smtp-Source: APXvYqyTW7mvFoj9QpTGBkVlKuSz9CjzQ2lMMBm2/x1ADm38nOjsWw1vFexuTj8ypcHYt1Z5/O/PAQ==
X-Received: by 2002:a81:c8c:: with SMTP id 134mr2583852ywm.205.1570801803665; 
 Fri, 11 Oct 2019 06:50:03 -0700 (PDT)
Received: from cloudburst.gateway.pace.com (67.216.151.25.pool.hargray.net.
 [67.216.151.25])
 by smtp.gmail.com with ESMTPSA id f68sm2534000ywb.96.2019.10.11.06.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2019 06:50:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 08/22] target/arm: Implement the GMI instruction
Date: Fri, 11 Oct 2019 09:47:30 -0400
Message-Id: <20191011134744.2477-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011134744.2477-1-richard.henderson@linaro.org>
References: <20191011134744.2477-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-a64.h    | 1 +
 target/arm/mte_helper.c    | 6 ++++++
 target/arm/translate-a64.c | 6 ++++++
 3 files changed, 13 insertions(+)

diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 268c114b79..31f848ca03 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -109,3 +109,4 @@ DEF_HELPER_FLAGS_3(mte_check3, TCG_CALL_NO_WG, i64, env, i64, i32)
 DEF_HELPER_FLAGS_3(irg, TCG_CALL_NO_RWG, i64, env, i64, i64)
 DEF_HELPER_FLAGS_4(addg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
 DEF_HELPER_FLAGS_4(subg, TCG_CALL_NO_RWG_SE, i64, env, i64, i32, i32)
+DEF_HELPER_FLAGS_2(gmi, TCG_CALL_NO_RWG_SE, i64, i64, i64)
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index c3edc51bba..251dfff1e1 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -254,3 +254,9 @@ uint64_t HELPER(subg)(CPUARMState *env, uint64_t ptr,
 
     return address_with_allocation_tag(ptr - offset, rtag);
 }
+
+uint64_t HELPER(gmi)(uint64_t ptr, uint64_t mask)
+{
+    int tag = allocation_tag_from_addr(ptr);
+    return mask | (1ULL << tag);
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 26aee0c1c9..4184d65d97 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -5188,6 +5188,12 @@ static void disas_data_proc_2src(DisasContext *s, uint32_t insn)
         gen_helper_irg(cpu_reg_sp(s, rd), cpu_env,
                        cpu_reg_sp(s, rn), cpu_reg(s, rm));
         break;
+    case 5: /* GMI */
+        if (sf == 0 || !dc_isar_feature(aa64_mte_insn_reg, s)) {
+            goto do_unallocated;
+        }
+        gen_helper_gmi(cpu_reg(s, rd), cpu_reg_sp(s, rn), cpu_reg(s, rm));
+        break;
     case 8: /* LSLV */
         handle_shift_reg(s, A64_SHIFT_TYPE_LSL, sf, rm, rn, rd);
         break;
-- 
2.17.1


