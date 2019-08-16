Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75507C3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:30:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448752086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egHZSJvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448752086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycJ6-0002PB-V3
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35407)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc72-0003Ve-5p
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc71-0005jY-7F
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:40450)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6y-0005eJ-Qq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:45 -0400
Received: by mail-wm1-x32f.google.com with SMTP id v19so4058206wmj.5
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9JJ/qi1KooqArepu9cu8DTevmHirJk1gOv6Hyhc2xNE=;
 b=egHZSJvmVgHj99KtTQXsGVeci0ggETKR+qx/BUM/0Fxtd5lRgpn7p09nx8wjZb39r6
 KtlJ64kIHshsGNph7PhjeIvBz/1OHNnnRsSuylJZ788H4aeKXjF9lUPDGGtB25/k+hmh
 IVQCjvYj3KAzbg5HydlRfTts4Ov2p4N3fTI8TahXLtio3X4MoioSW/PVDkR69WFG8ut2
 oDA7Wa/0F/XZIbtq8p90BTP+ASucK8f1ydmFR+wdloPBzZDaz3JtOxRdzjvHE0Hilr+i
 8hixCqGEzxs50MlYx+P+LO6fTts+OJFwbDbb3XXkm2nVCKWY7OK0TckHpFRFdQZaLhxx
 sZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9JJ/qi1KooqArepu9cu8DTevmHirJk1gOv6Hyhc2xNE=;
 b=YvSAYzvP753sP5ANMj3IqyOGs0ZJ3wV7txsUAdWXoj/bqRXEtxSh3nAbcqe2+oxezK
 fGkicLcYg9dPfNFMc8D8S6nIz0yYXK6OgspzpD1pwNX65Loa24dtvjv1/Nr4gvQDR/ZI
 xDFjFWa4bYF6OJhG0WRVTy+YWQHL+J3NViQ4YpcIdq/+BhK7llX2g7QuuKPSHLj/BTxl
 5u2DeMdZ/iwVlfpZr/8mHNeQnq4y6VYviARZYKGbq4l+wJHK9fXMtQZgZ2ib/OHjuD9X
 JRiyMLYlGz+3667MQQt8sTp2bFd9JNJSQnZbX/3fBTVaqk+0NLjkKJqsWTrXvoAS14q7
 yE4A==
X-Gm-Message-State: APjAAAXbGXQaCA4VIygDxBlJJJfHaJB7la3XCPBX+PciaFT29PI9g4rm
 H0ge+qKXwVajJSbBM/wwNmz5VUGmG24mtA==
X-Google-Smtp-Source: APXvYqzFhM9wH3guM+Em5pcHSe9S20Q0XA68LMWV3YhOhJZc2cor8OSGCxDVZPgH/C3le9b6HA61dg==
X-Received: by 2002:a05:600c:d9:: with SMTP id
 u25mr7583365wmm.26.1565961462424; 
 Fri, 16 Aug 2019 06:17:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:10 +0100
Message-Id: <20190816131719.28244-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
Subject: [Qemu-devel] [PULL 20/29] target/arm/cpu: Use div-round-up to
 determine predicate register array size
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

From: Andrew Jones <drjones@redhat.com>

Unless we're guaranteed to always increase ARM_MAX_VQ by a multiple of
four, then we should use DIV_ROUND_UP to ensure we get an appropriate
array size.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index d12c7460859..ab5d58a9d41 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -195,7 +195,7 @@ typedef struct ARMVectorReg {
 #ifdef TARGET_AARCH64
 /* In AArch32 mode, predicate registers do not exist at all.  */
 typedef struct ARMPredicateReg {
-    uint64_t p[2 * ARM_MAX_VQ / 8] QEMU_ALIGNED(16);
+    uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
 } ARMPredicateReg;
 
 /* In AArch32 mode, PAC keys do not exist at all.  */
-- 
2.20.1


