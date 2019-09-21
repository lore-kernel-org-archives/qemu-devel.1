Return-Path: <SRS0=nDBX=XQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703CFC4CEC4
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4562073F
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2019 04:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLFJL9GX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4562073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBX86-0005ML-Gq
	for qemu-devel@archiver.kernel.org; Sat, 21 Sep 2019 00:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40463)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX54-0003JE-Pt
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBX4x-0006OQ-Ja
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:07 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:36626)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBX4w-0006N3-MJ
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 00:33:03 -0400
Received: by mail-pl1-x644.google.com with SMTP id f19so4150458plr.3
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 21:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=b9hvT4KM2rHH/vsMDbpWRcPXcj5oYyVhJm17BHsajzk=;
 b=oLFJL9GXQvvNWFVixLW67J3Rg01HY92uuAArV94f51S6MObOMeWnJXllwd+xEsL2vO
 PnKCY5AMAqA++FVwJr+bHYu9nxEjIJX0i61zNr15WN2ep3jWB5BCLbZBcs1AAfiTdmrl
 b2N5vD8FF3OdLQ/XwdRev7fVcE9K0Xn2S7CHwgr046a2fOApext+cZLV0ql9TOC9Rnsd
 +XdnzVWNR9N/dnUORZr3ajHTRQOopmBDGrSnnrZLPGKmmE5XugDXCfoQ+pH81iKEgBFC
 saWGkZ6gihQUFbv2P2S2Hpn/0HJWTd1qiXklcbnzVYa1DZnch42vrsewApUC9jLiXiTh
 xfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=b9hvT4KM2rHH/vsMDbpWRcPXcj5oYyVhJm17BHsajzk=;
 b=brzTrqsA9PqRNmv2D92FqrKiwq1oLUa5jRN8bc2XFizoWzSe0RiRP62c3D/JSLq8ek
 9B5wq2FT1iEBgAfTDma9MLh1x1kB5zHW/jZ4zfFlEHxjaRQQeJuL58235ILmZG6Op10h
 d2/CzFiPimU3BQUQBjWPqu8TjDxo9hatTj5RGN656N8/8mZM9v8N9djNqpKYP1r7kz3R
 SOOSocOakTKfmKk9Y4c6/Ixi1aYj/iziiqApHfs609Nw4VmjxgOHFGCPRvKaMqXRanyh
 fd4/DtTq9UoIuih/pprHsYQg0U82Km98ORY5uNeylZCfyaN5T7ZjhllPaK1/mgaHHLBk
 tBgA==
X-Gm-Message-State: APjAAAXHty8sai8IpH5hNzKnz1RoMhaWDInYx0YFot7FGlzukydrNfB1
 wvD2ThRA4fLIoVWTU0E6RMwzL0Quv/U=
X-Google-Smtp-Source: APXvYqy8EA5lg8VpuHAUxPxOmt3seyCUUJQVkdRbM9iPfKboY8m6PrVVizqlBjw6fF/CveEaC71G+A==
X-Received: by 2002:a17:902:8d98:: with SMTP id
 v24mr18471880plo.265.1569040380988; 
 Fri, 20 Sep 2019 21:33:00 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id 193sm4179986pfc.59.2019.09.20.21.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2019 21:33:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] target/alpha: Use array for FPCR_DYN conversion
Date: Fri, 20 Sep 2019 21:32:50 -0700
Message-Id: <20190921043256.4575-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190921043256.4575-1-richard.henderson@linaro.org>
References: <20190921043256.4575-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a bit more straight-forward than using a switch statement.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/helper.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 19cda0a2db..6c1703682e 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -36,6 +36,13 @@ uint64_t cpu_alpha_load_fpcr(CPUAlphaState *env)
 
 void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
 {
+    static const uint8_t rm_map[] = {
+        [FPCR_DYN_NORMAL >> FPCR_DYN_SHIFT] = float_round_nearest_even,
+        [FPCR_DYN_CHOPPED >> FPCR_DYN_SHIFT] = float_round_to_zero,
+        [FPCR_DYN_MINUS >> FPCR_DYN_SHIFT] = float_round_down,
+        [FPCR_DYN_PLUS >> FPCR_DYN_SHIFT] = float_round_up,
+    };
+
     uint32_t fpcr = val >> 32;
     uint32_t t = 0;
 
@@ -48,22 +55,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr = fpcr;
     env->fpcr_exc_enable = ~t & FPCR_STATUS_MASK;
 
-    switch (fpcr & FPCR_DYN_MASK) {
-    case FPCR_DYN_NORMAL:
-    default:
-        t = float_round_nearest_even;
-        break;
-    case FPCR_DYN_CHOPPED:
-        t = float_round_to_zero;
-        break;
-    case FPCR_DYN_MINUS:
-        t = float_round_down;
-        break;
-    case FPCR_DYN_PLUS:
-        t = float_round_up;
-        break;
-    }
-    env->fpcr_dyn_round = t;
+    env->fpcr_dyn_round = rm_map[(fpcr & FPCR_DYN_MASK) >> FPCR_DYN_SHIFT];
 
     env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
-- 
2.17.1


