Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B2FC3A59E
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:24:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C870A20578
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2Nw5zeF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C870A20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycDf-0003mA-Ec
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:24:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6z-0003T1-CO
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc6y-0005gB-CQ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc6x-0005cp-55
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:43 -0400
Received: by mail-wm1-x329.google.com with SMTP id z23so4058154wmf.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=a4P1+EnRZyW9kd5p9YYGOpI9oI6W9VDq86e7pkr27ak=;
 b=G2Nw5zeFoIzsnJttWJHaYUHYl1tpxAzkyML5SeLEL/OwkAqpBcSnTXSA/+Urpx9Lo9
 0mrHt1hbvXP4VKYITFqZzX2Y2XKndJLKNwGssGBq65ls4by+gcW2nNTAjn/4pP4Ou2kM
 iwuIhNgwQDiz33DaqTdKlItkJ0HBd/nro1p7VzTj25xWpdcIKYMj6CD6T1vtfYxub1Gb
 axn7NZlTNa7RNSqP3wtxkZCuOyvDqQ2j0fBP0Uq+gVRJxMy5Y15VRcoIyR28TO+OXpTV
 kuGCybIUK0pElDyUkj+03NaqHu6YPNyFUd8LYKJklV+iXZlXwQymltQPAvSzaZv4NA3D
 I5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a4P1+EnRZyW9kd5p9YYGOpI9oI6W9VDq86e7pkr27ak=;
 b=J7x/rE97Dl/9jow2/ShAQ/0ECZ1FnCg3JIyMF46QWo8aEdQhvK13MiiSR9CQ+NKUL/
 oAPipw3M0jC9UCkd4MqdB6tOqWKQ0WNzDSgvHMrC5TQSiPI7umoMNOKaO+nTG0Eduz5/
 FgrV3Es0bZMVr55sV2Al4HfzZBMARjhRNKK1ZOXqFrWphBy2GvOPhDKtUPo6vYrO86kO
 uMv7A9zqeZ+5jy+Auc7ilmgcLoZ/y05z3VCllGCRc7LsaaCY05y/YqxXScXI5BUTt1cC
 KRCbYBrbx/mfToizDH1cdSz8tSRrVNN2qcz/CCYYM35q/urYQxszfew74JH47P4lb4/U
 hj9w==
X-Gm-Message-State: APjAAAViJG7PPfvfDyN3AN9kxjqWNnj7ZllzD9WzG2rznpy/WrHoJuUq
 3vTT76CowUXngX12IgmXT9H+tfi4kTznvw==
X-Google-Smtp-Source: APXvYqwyW2syss7CoBhVEv+TTcp+Qn/DScUgr2npA+VnVnvKdc7VrhxJV9wucUWrxYA2gpOurjjXvQ==
X-Received: by 2002:a1c:a446:: with SMTP id n67mr7171016wme.56.1565961461599; 
 Fri, 16 Aug 2019 06:17:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:09 +0100
Message-Id: <20190816131719.28244-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
Subject: [Qemu-devel] [PULL 19/29] target/arm/helper: zcr: Add build bug
 next to value range assumption
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

The current implementation of ZCR_ELx matches the architecture, only
implementing the lower four bits, with the rest RAZ/WI. This puts
a strict limit on ARM_MAX_VQ of 16. Make sure we don't let ARM_MAX_VQ
grow without a corresponding update here.

Suggested-by: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 24806c16ca2..2fd504ea7a1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5300,6 +5300,7 @@ static void zcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     int new_len;
 
     /* Bits other than [3:0] are RAZ/WI.  */
+    QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
     raw_write(env, ri, value & 0xf);
 
     /*
-- 
2.20.1


