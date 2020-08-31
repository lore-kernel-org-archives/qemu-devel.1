Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B60C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769A120719
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fWDvkaHN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769A120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmkr-0002Z5-L5
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL7-00068l-GR
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:25 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:37258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmL5-00068A-RH
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:07:25 -0400
Received: by mail-pf1-x42f.google.com with SMTP id w7so810460pfi.4
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qeeRN7V1Ip0PITMIEYpKMKFZ3d7CJpkC0dYLX2jwgUk=;
 b=fWDvkaHNWVTmg/ogFKneZXCk6GgVH0R2L6pr8hUXl/jZhCgEb0szhhhs6gXPVM4WbO
 Ap9cv4K3BPlqDhRFBydkoa9+heccZOOzwj/FEPXsdv5ufMcWidndJ3bX1BxdLzTODjN1
 d9mBdQcVKdVoBprz4uXsIDCeQpLzlGtRToG35nM055zj1jSkRZ8Wr8ONqsjuveHv6EVE
 Nnfaa+pBKX4KOy06uSGz3a7L86U8F7HvD0N1mSvkbcpQQZ5GLyR8OtLoMENDEmNbiyn2
 7vv/FdIxbD78Mipf36+nYGrWUkUw0H+LYG78r9niytQmIH5vd7E1z3InqVMoBKuFJC9J
 DJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qeeRN7V1Ip0PITMIEYpKMKFZ3d7CJpkC0dYLX2jwgUk=;
 b=Kc1d86uw3FxnFxkWKM/crSrRV1VC07FKE996Y9sMjPryEOrp1X4jOImult+C0hkE0W
 FE2dPjWMGnyxIp76mTrJXdCWN+ibVn9y6pQSOA2fT6UyXhcOy25AUg33XMmFejbuETHb
 j/xt/xFqK7DjTAuPXTGSCwwmFZAn1W4eXek3rBV9d97VsNtuvXhjXPcKIQ/EZTJxo6Jr
 rhaUs7b/iZgsdaikr8UOO33CchdTPp+nc/L+osOasRjS1gKSMpedFH5zB6UvuDW0PGVy
 srhmlIjWlNTKQ3MA3Qg3C3v2KGNUdRTbwUUdcVl1lo9f0ZXoQEQFawR2LjbXWCEwkuDO
 kcqw==
X-Gm-Message-State: AOAM531jg1DjqTVPd8ErwB/ALUeFMJ9U8loAmwfOy4QvoxEcabgMo0qW
 aDxDnbk9iRa0Gqfs+BkYCAS23f5i1Q13dQ==
X-Google-Smtp-Source: ABdhPJw4NYpyzobAMT0+goFWvXvVGk7rykuYHRIumQjUhVbWG3UmtDzhxwRzSsKkbEEuYVqgB37W7A==
X-Received: by 2002:a62:2bcc:: with SMTP id r195mr1855521pfr.123.1598890042225; 
 Mon, 31 Aug 2020 09:07:22 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:07:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/76] tcg: Add tcg_get_insn_start_param
Date: Mon, 31 Aug 2020 09:05:43 -0700
Message-Id: <20200831160601.833692-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MicroBlaze will shortly need to update a parameter in place.
Add an interface to read to match that for write.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index d40c925d04..15da46131b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -777,11 +777,26 @@ static inline TCGv_i32 TCGV_HIGH(TCGv_i64 t)
 }
 #endif
 
+static inline TCGArg tcg_get_insn_param(TCGOp *op, int arg)
+{
+    return op->args[arg];
+}
+
 static inline void tcg_set_insn_param(TCGOp *op, int arg, TCGArg v)
 {
     op->args[arg] = v;
 }
 
+static inline target_ulong tcg_get_insn_start_param(TCGOp *op, int arg)
+{
+#if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
+    return tcg_get_insn_param(op, arg);
+#else
+    return tcg_get_insn_param(op, arg * 2) |
+           (tcg_get_insn_param(op, arg * 2 + 1) << 32);
+#endif
+}
+
 static inline void tcg_set_insn_start_param(TCGOp *op, int arg, target_ulong v)
 {
 #if TARGET_LONG_BITS <= TCG_TARGET_REG_BITS
-- 
2.25.1


