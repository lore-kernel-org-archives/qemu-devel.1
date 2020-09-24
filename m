Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E8CC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20EC32145D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 01:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPMwDU46"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EC32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLG1X-0006Yq-3G
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 21:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0M-0004oO-0E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:02 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:39834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLG0K-0005hR-CO
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 21:25:01 -0400
Received: by mail-pl1-x632.google.com with SMTP id y17so736384plb.6
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2020 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5CbuzJn61hBLc+FY8dWMDM+0yvJ0dAh227GS03ZS2Y4=;
 b=kPMwDU463lCbNamT3GFvdKX+kFYWHxeNz2SrIxb6WcjOhvtWJ9ooZUMhSHlg650FWq
 KWiL+eAyFNrDz8VIO1Ce2obCjDywAGT8q2+FRzBgHHdqiB+XJyiWQTTxJE2CNsn9PQGs
 Xnj0deRNlUYyiAeb5WgI18E+z1j+D7toSToF/g8QXkPDtqh3qfSnlbem+WgF00jUSfLd
 L5yn58Qqmd4u2JUd8IWtUaY1dgEhO7ekAs+aEpOVXMjh9XOon0HQrnXRFaQVODW1mgfO
 QAJ2Zb5zzgBp50hDsnOyQ2mRGbnQNLtjeK/Qr6OT1U9a56gMl2JiCGGABNRXAzec27ux
 9E8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5CbuzJn61hBLc+FY8dWMDM+0yvJ0dAh227GS03ZS2Y4=;
 b=SG08MD5ZS56VLRMwAvi25dL1V2q9LBeekhz3MKjLLkYQF0CjifJ89LKi+aEE8aBJfa
 54Ac9eu5z1/rc0UX5hXJnUoBKmOAwCsgKS6WSUwzM07Vuc9hnQUMuKUBOJcnT3sCofY2
 fnKRmS1Q4/RX0S9bAqKj6gBXjdPDdLJOsPYYsEaWFkYZ6t/fHWf1sVaCdPH4xw6UcF/W
 7yFgmimCHBp9aJ93Olr7GPsfspTGB1PCDCP3SUDNY65Eb/19+9o7CocK3K9zqaiyG4Qz
 h2f5tPfC2v+RaxszuLAOC9zBmnrmRaRrBKBG29dvcHy9gXeN0ZyYVMmnGPMsjOeNUNFP
 pd/w==
X-Gm-Message-State: AOAM532kahNiSjBkLKyyjwMTDaolzrJX9cSHXlP6E61F87G3BdkAZ/Om
 /jDddKlqjT7jz0x9OisvHeO08JST2n0I5w==
X-Google-Smtp-Source: ABdhPJwBpYf3THNTwwgwGtww+qAoQhIgAxk45E1l8OMgF4w2YyxZOZHoE7gbh+cv63nLeyDkxAu68w==
X-Received: by 2002:a17:902:b10b:b029:d1:e5e7:bdf8 with SMTP id
 q11-20020a170902b10bb02900d1e5e7bdf8mr2254153plr.43.1600910698661; 
 Wed, 23 Sep 2020 18:24:58 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k27sm938432pgm.29.2020.09.23.18.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 18:24:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/8] softfloat: Tidy a * b + inf return
Date: Wed, 23 Sep 2020 18:24:48 -0700
Message-Id: <20200924012453.659757-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924012453.659757-1-richard.henderson@linaro.org>
References: <20200924012453.659757-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
Cc: bharata@linux.ibm.com, alex.bennee@linaro.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No reason to set values in 'a', when we already
have float_class_inf in 'c', and can flip that sign.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 67cfa0fd82..9db55d2b11 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1380,9 +1380,8 @@ static FloatParts muladd_floats(FloatParts a, FloatParts b, FloatParts c,
             s->float_exception_flags |= float_flag_invalid;
             return parts_default_nan(s);
         } else {
-            a.cls = float_class_inf;
-            a.sign = c.sign ^ sign_flip;
-            return a;
+            c.sign ^= sign_flip;
+            return c;
         }
     }
 
-- 
2.25.1


