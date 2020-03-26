Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19589C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D850D206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HRM0aHtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D850D206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYXA-0004sM-15
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYL0-0007YV-DW
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKy-00020e-Cm
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:46 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:37531)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKy-0001zr-8m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:38:44 -0400
Received: by mail-qk1-x744.google.com with SMTP id x3so8183740qki.4
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/Oka1mxILvyuoj14dGrBGiB3Vaw9bR7aF51DMk7Mc7Y=;
 b=HRM0aHtX9XzKKaBtcp9xrOqzXaPK85Kuc0zw3RVZe0EVdYJ28xZ9pGheMW9LZkfEA7
 Q/i2UW95LqEBxmzgUAufKTBnAiFvSNwY1GxM4ziwBARtk7dSfAf3xxTyb/PY0s7jw1Em
 3OJ+P/fdtlrdWQIGNqXvrxgoYDVK1THOVvSPkSEdNHoLQm5Tkp6jBCAKN16pwMtnS9l6
 bumCj8khBLapy0IabiyYoOESF1QOs8K65rs4svHNuYhr6VufMrw+v/wkQAtnPyXIi6xm
 sEzDnxHIV2tU0a6W6tTGORbd170mVrIEYq3IwIFZ5idteNnBRo8KNDwxXcgM64lriID7
 DcbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/Oka1mxILvyuoj14dGrBGiB3Vaw9bR7aF51DMk7Mc7Y=;
 b=r7dzyas7QEOO/RAiM65DXZI+QS+A1zZfcGHBqOs4/BX4D0cyPnqrCYKmleLvW0EX5t
 6YNihOiL2oNoIzExhNjXFVtc2Io54wm2ZEI4e1RnWi65mPwmOevaArKTmd3ya4G6+D/T
 4vD/YlKu/dH3klK74eBW9+cogeQo15ngYqFw2kjJQ0IYNvxTv2BxpGPwQbz5arE0xu5Y
 fZpa/AfwjXLXnWVRBYUp8AjWuvUe42CLHdB4XpD0Inbvh0Y5TXCRaHA/FOd9Jj6mhuKU
 h+0Gd9A/voV8SllZig4nr6fpUg2GE/7RayWGp4AT/8TQBciLsDv0807fg9Ne+aRroZ6i
 CbWA==
X-Gm-Message-State: ANhLgQ23Tn6cS6Jt4tmGxh2ZFBjsDcMFrIeufslh+jZPWcX+UugorPYB
 VJDXZvND2u0BNvcq4XGBvVTnUtxYdesbhA==
X-Google-Smtp-Source: ADFU+vv+MeQ2sTf7Zw6myfRgBd8q+ClIWe2bSwjeyB9cwkL3rWg0qiYE4iQ8Q3UWQFCR69X6K4Y+7A==
X-Received: by 2002:a05:620a:100b:: with SMTP id
 z11mr9784686qkj.382.1585251522276; 
 Thu, 26 Mar 2020 12:38:42 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:38:41 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 50/74] m68k: convert to cpu_interrupt_request
Date: Thu, 26 Mar 2020 15:31:32 -0400
Message-Id: <20200326193156.4322-51-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
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
Cc: robert.foley@linaro.org, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>, "Emilio G. Cota" <cota@braap.org>,
 peter.puhov@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Cc: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9445fcd6df..c09c7a9b14 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -33,7 +33,7 @@ static void m68k_cpu_set_pc(CPUState *cs, vaddr value)
 
 static bool m68k_cpu_has_work(CPUState *cs)
 {
-    return cs->interrupt_request & CPU_INTERRUPT_HARD;
+    return cpu_interrupt_request(cs) & CPU_INTERRUPT_HARD;
 }
 
 static void m68k_set_feature(CPUM68KState *env, int feature)
-- 
2.17.1


