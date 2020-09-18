Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C095C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:44:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57E121D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 19:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXoEylwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57E121D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJMJ4-0003O4-Kb
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 15:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLI7-0000to-6K
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:27 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:41044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kJLHo-0007Dd-AU
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:39:23 -0400
Received: by mail-pg1-x543.google.com with SMTP id y1so3976513pgk.8
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 11:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ubmLqueedmlYGL75RBWrWqOt2/2zwwVKDDZSU+bMx/Y=;
 b=fXoEylwy1B37nMDqxlmcELoNNiE5a9We1itCOrLEgA6D1pQO8s3ReRPdVfevZsMH7p
 7KwXo/VgAxeB1javwMwZ389qhKbmVdYPaos/vULmDrqtcyPJMh0n8YcLe7dDpXfHD4ZK
 rSBlTG7U7czIjcAv3FQM2osae/Q27dJW9+BODQtOeC+FlLO+LWZdclM9Jn7MeQQXAzcI
 yJxc1RXzKCOiL579/uw8S4AAAq+2WOcolmfn6JpZuhlRi/BcflpT3tRlg6R20evvcWXA
 3Eh3b75WJW2cfs814n4d/6RqhsC+VTV8bggwcQq5V2vybzLsuxwjaao2VL5Gu1rHBnEw
 HLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ubmLqueedmlYGL75RBWrWqOt2/2zwwVKDDZSU+bMx/Y=;
 b=Q0h/FNWT7xR1kzGSsTkYsxJAN+GkOGV00VudCeQjfkQEsfw1kqpmgG6AzEWCMSKfBf
 c3MHRTGHY1ElAlOyipsvu44YIfKT98gmFTsSfQRFq9kIvYVlvLbpGpdl0/yokOKXRrH8
 hrC8KuMMzy3uPTt0UVSFg7IWWh6bpus6z+ZF/5XDzY0XbOiBl9XDYckKd27iMIvWWQW8
 w7SVYAZr48XTaNqvHEu/q9NESCWwN/uyMoRqOWbM6nd2oqtuv/v25z9J22uzDObTSi8B
 er9Lzn3fk5y2xv0K4qNpN4bbYS8b76i2CBPwZNA7sEwJaPdKqzCKzF5wRtPjANzQCO4s
 7bMQ==
X-Gm-Message-State: AOAM5304cW5Ho15p5OWJDi131AaPgqsFn7iaJJTpNcUM1S8mBb64Se19
 9dbOZQyZr8Gy3PYKX3Vwkjl9L+0yoEYpbg==
X-Google-Smtp-Source: ABdhPJyhmAfkRXdnRffrMHMaBH5yvt9A5znsYzKL7jegd45xeNXvkdMLrru2vHxzThn8eMSfcwzBrg==
X-Received: by 2002:aa7:869a:0:b029:142:2501:34d1 with SMTP id
 d26-20020aa7869a0000b0290142250134d1mr17696070pfo.42.1600454345619; 
 Fri, 18 Sep 2020 11:39:05 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id f4sm3680723pfj.147.2020.09.18.11.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 11:39:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 55/81] target/arm: Implement SVE2 integer multiply (indexed)
Date: Fri, 18 Sep 2020 11:37:25 -0700
Message-Id: <20200918183751.2787647-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918183751.2787647-1-richard.henderson@linaro.org>
References: <20200918183751.2787647-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve.decode      |  7 +++++++
 target/arm/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index ea6ec5f198..fa0a572da6 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -777,12 +777,19 @@ MUL_zzi         00100101 .. 110 000 110 ........ .....          @rdn_i8s
 DOT_zzzz        01000100 1 sz:1 0 rm:5 00000 u:1 rn:5 rd:5 \
                 ra=%reg_movprfx
 
+#### SVE Multiply - Indexed
+
 # SVE integer dot product (indexed)
 SDOT_zzxw_s     01000100 .. 1 ..... 000000 ..... .....          @rrxr_s
 SDOT_zzxw_d     01000100 .. 1 ..... 000000 ..... .....          @rrxr_d
 UDOT_zzxw_s     01000100 .. 1 ..... 000001 ..... .....          @rrxr_s
 UDOT_zzxw_d     01000100 .. 1 ..... 000001 ..... .....          @rrxr_d
 
+# SVE2 integer multiply (indexed)
+MUL_zzx_h       01000100 .. 1 ..... 111110 ..... .....          @rrx_h
+MUL_zzx_s       01000100 .. 1 ..... 111110 ..... .....          @rrx_s
+MUL_zzx_d       01000100 .. 1 ..... 111110 ..... .....          @rrx_d
+
 # SVE floating-point complex add (predicated)
 FCADD           01100100 esz:2 00000 rot:1 100 pg:3 rm:5 rd:5 \
                 rn=%reg_movprfx
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 7c50298302..90f0b1ff9b 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -3817,6 +3817,10 @@ static bool trans_DOT_zzzz(DisasContext *s, arg_DOT_zzzz *a)
     return true;
 }
 
+/*
+ * SVE Multiply - Indexed
+ */
+
 static bool do_zzxz_ool(DisasContext *s, arg_rrxr_esz *a,
                         gen_helper_gvec_4 *fn)
 {
@@ -3840,6 +3844,32 @@ DO_RRXR(trans_UDOT_zzxw_d, gen_helper_gvec_udot_idx_h)
 
 #undef DO_RRXR
 
+static bool do_sve2_zzx_ool(DisasContext *s, arg_rrx_esz *a,
+                            gen_helper_gvec_3 *fn)
+{
+    if (fn == NULL || !dc_isar_feature(aa64_sve2, s)) {
+        return false;
+    }
+    if (sve_access_check(s)) {
+        unsigned vsz = vec_full_reg_size(s);
+        tcg_gen_gvec_3_ool(vec_full_reg_offset(s, a->rd),
+                           vec_full_reg_offset(s, a->rn),
+                           vec_full_reg_offset(s, a->rm),
+                           vsz, vsz, a->index, fn);
+    }
+    return true;
+}
+
+#define DO_SVE2_RRX(NAME, FUNC) \
+    static bool NAME(DisasContext *s, arg_rrx_esz *a)  \
+    { return do_sve2_zzx_ool(s, a, FUNC); }
+
+DO_SVE2_RRX(trans_MUL_zzx_h, gen_helper_gvec_mul_idx_h)
+DO_SVE2_RRX(trans_MUL_zzx_s, gen_helper_gvec_mul_idx_s)
+DO_SVE2_RRX(trans_MUL_zzx_d, gen_helper_gvec_mul_idx_d)
+
+#undef DO_SVE2_RRX
+
 /*
  *** SVE Floating Point Multiply-Add Indexed Group
  */
-- 
2.25.1


