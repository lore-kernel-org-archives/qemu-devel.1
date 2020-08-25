Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBABC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:32:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46B0C206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="io4EfYM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B0C206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgYK-0002OR-F4
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg45-0000A1-CU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:40604)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg41-00020D-SW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id k18so8291036pfp.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p+iYZfUiWvOiZ4jhf/t12sD37PNbPvTJo79LCNu2vXI=;
 b=io4EfYM/haayGe07qpmymqfOoSYgk0enlR6YVoFxG47PQAnAZGSUqKwUkarcHjJ0xz
 dO4IE0QQ4xJ/m2l9h3wL+9M4dNy+Euj8JDSNHbhJUy+eIZnCMN+77NNI4fhVN7vX3N8v
 LA0UGte2w2mQLDxUUEo+p3Sq5wb3n3IiDJlcHt22rXbzeveHKOyIuOWKd+/dAk3GnGPP
 Bv5P/AU3hCFT0cL5yj8dnCiXKrI/mz4J150+3nC7moxCEXOTbeONqovkgAvfGFSsUqFk
 XC4o+wZbyXnWB4FNFB0mZDBPXiSho2ZVJInJO2mCol1VT57/7wuHIG9mGSDUsOQCeH7x
 xgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p+iYZfUiWvOiZ4jhf/t12sD37PNbPvTJo79LCNu2vXI=;
 b=QZTqCDycaroVdbWWslXcCDtUYRDGnwK5bjRTvMFIlBG4AvB/Mwo2RUIWkGU8CMEvRO
 DWHrwNVdn40jrCXltPtyaInTjsUqp3zfJSdjiO52RxsijYyLGh2voKNWHOUdAdIcuBN/
 zWtrMRYgfUm1Qy4iWkfUsdBioq2oSKtYgCD5unAgbZ3KPJjzMsQUN7U0N7TKI31TdqER
 bCogYog9JXiw0LrdCylraSmioODNHJrPMfwoAnAp718N2np7WYsTQLXtJP+XuSqJ4Er9
 Mokf0EeG24oapCcYbZcALrPP1on3y7+FxM64WjAQrjzZFdncrsbkqaAjlhss9p24601q
 zZ9g==
X-Gm-Message-State: AOAM530sgp6VhaRAHL9dxKX0SZpPAc4OxdruCZPPAkjQsLq+9EXq5a5i
 GcSPspYxS4j2stOEUFrUPOzEkEOUjP8p8Q==
X-Google-Smtp-Source: ABdhPJxsTURja4q3SnaYjQxtZ7PtjHaZufXKF6WoA8mADnjEecKQsr15HGhU8K+y6mPxFwSbsrY8oQ==
X-Received: by 2002:aa7:925a:: with SMTP id 26mr5753679pfp.6.1598389263561;
 Tue, 25 Aug 2020 14:01:03 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 57/77] tcg: Add tcg_get_insn_start_param
Date: Tue, 25 Aug 2020 13:59:30 -0700
Message-Id: <20200825205950.730499-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MicroBlaze will shortly need to update a parameter in place.
Add an interface to read to match that for write.

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


