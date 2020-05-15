Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7084C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83E462078C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 14:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IL4BxIWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E462078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZbFe-0005yx-6y
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 10:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbCv-0000be-Sd
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34593)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jZbCv-0003rS-3y
 for qemu-devel@nongnu.org; Fri, 15 May 2020 10:21:01 -0400
Received: by mail-wr1-x443.google.com with SMTP id y3so3808812wrt.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YD8Dvuo5pUfHRMo8RpEeRFbdBBgINC3AFc9P3kqEPfY=;
 b=IL4BxIWVkbgjozh8pyu59eUNZoYCsRxcoX9jcmSXkrX6RP+zFcp5HFQrlD3uBNVEiP
 LvuBWuQAEBZN20CzSjE8u6TjIZU1B4gau5IfQTqCw6vQ3BmjxTu/+HVEAJO6fKK//MrR
 JkQ6Uto1eSdpCUOXg1C8/SNW2pN1+UK8MzNq8G3NHIIzwa4/U1IF2SMmNy43+ZwZ6s5J
 8t9DrDotDulXrbrEEzgUQpjtbNY12TKcffzDF7TvYlcKT0nciyPGhoRp20uzoTd0f/Wo
 BQdAfTTTGNn8wkiBxN84EkUbpxJTFsoeI97ENMhxnDeok1UKYslRjDBdB2SntLeAMqYq
 ZmwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YD8Dvuo5pUfHRMo8RpEeRFbdBBgINC3AFc9P3kqEPfY=;
 b=rl2EwtHYGq/8FBjcchZb7cB3JTUGm+cd7w0VKnFLNc9JSHE9GnALAjF1UVJr3jDTG9
 gTHTOZhLfMEXXoKaQxxD+yo9vUnApTyp93haEujntHBWliIKfUxW/+blYs9Q1eY8e8nf
 enQPOPgDblXF0yH3IQ+9eeIx9cNC22rMPWIQyUXPkeVxI90V2E17AOneuRGrqzfwRF5N
 89/0HIJE8XvbBFWbJcrovib2nhB+x6etwJLNEYWI6xdsmKbBCEq5s8C1LYSY1CJcpPS8
 OiFrNSB0bL1bXJs69DLEdvwEelDZHLG3jP5fhXIjBhCgQQGEww4whqqMDvDWrD+RgljQ
 kK1A==
X-Gm-Message-State: AOAM5338JacGWsJWxHSmIsS/8B/H2RF37l/UtMs/FpHGDh2xKegSwPDT
 3iVdeJh1q4QJhwQWS2zhB3Vh5wc3CLnqmQ==
X-Google-Smtp-Source: ABdhPJwlRkIdrEQ8RGCnh2cceKI7lyF4AwYTEyTGutdK+S7QU/6InZcPPpp+oZJcrtqLsS+ToQPpmw==
X-Received: by 2002:adf:80a3:: with SMTP id 32mr4472357wrl.199.1589552459820; 
 Fri, 15 May 2020 07:20:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s14sm3738327wmh.18.2020.05.15.07.20.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 07:20:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 01/10] target/arm: Remove unused GEN_NEON_INTEGER_OP macro
Date: Fri, 15 May 2020 15:20:47 +0100
Message-Id: <20200515142056.21346-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200515142056.21346-1-peter.maydell@linaro.org>
References: <20200515142056.21346-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The GEN_NEON_INTEGER_OP macro is no longer used; remove it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Between Richard's cleanup and mine we deleted all the uses of this,
but since neither series on its own was sufficient to delete all
of them we failed to remove the macro definition when it finally
became unused.
---
 target/arm/translate.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4c9bb8b5ac0..c8296116d4b 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3034,29 +3034,6 @@ static inline void gen_neon_rsb(int size, TCGv_i32 t0, TCGv_i32 t1)
     default: return 1; \
     }} while (0)
 
-#define GEN_NEON_INTEGER_OP(name) do { \
-    switch ((size << 1) | u) { \
-    case 0: \
-        gen_helper_neon_##name##_s8(tmp, tmp, tmp2); \
-        break; \
-    case 1: \
-        gen_helper_neon_##name##_u8(tmp, tmp, tmp2); \
-        break; \
-    case 2: \
-        gen_helper_neon_##name##_s16(tmp, tmp, tmp2); \
-        break; \
-    case 3: \
-        gen_helper_neon_##name##_u16(tmp, tmp, tmp2); \
-        break; \
-    case 4: \
-        gen_helper_neon_##name##_s32(tmp, tmp, tmp2); \
-        break; \
-    case 5: \
-        gen_helper_neon_##name##_u32(tmp, tmp, tmp2); \
-        break; \
-    default: return 1; \
-    }} while (0)
-
 static TCGv_i32 neon_load_scratch(int scratch)
 {
     TCGv_i32 tmp = tcg_temp_new_i32();
-- 
2.20.1


