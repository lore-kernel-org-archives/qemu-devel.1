Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D6C3F2CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F532467B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y6jTuK4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F532467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7irN-000574-J9
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 11:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifG-0007bY-QS
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7ifF-0001vX-R7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:02 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46716)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7ifF-0001v6-Ku
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 11:39:01 -0500
Received: by mail-wr1-x42a.google.com with SMTP id j7so3594841wrp.13
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 08:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TTuud3NM/HeI5fDHZvld7c2Fw5CE+eUly98+A8SwQ5c=;
 b=Y6jTuK4S1tCNjjFkQ6g8ohlK3ruxxYhkpDTcnknw2KWYXDDbB0zCtAcrStuF6Q/mQ7
 wg3PqpGOnA1yY2s+KvJCu4hbgG7Nfi9R9E61Mn/leGj6QLnSW+Iog2LmtYPDYymZnaT3
 D6Hu4B6NmFYl0NE5RCCfDafmGgJYdaz474hV+wpATNu2Aahg5IfzvAMO8M/jsaVQVK16
 qMLAffEH72tQoCeaK5aCPTu2szuAUt1ukbfyIvPXfOTN6bug/LmrvLV23baKc9ME9h4N
 fGfLqFOR+5cO6Q8AkPS/qBj4K5xaTRSPxwzKdXAgy2utmVnUXHbk0Zg0Mz7vlCHrwzSD
 DdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TTuud3NM/HeI5fDHZvld7c2Fw5CE+eUly98+A8SwQ5c=;
 b=OamJRqJO9AGc5zw/i22lN9rtXtkckypJme3bU3jXOqRloVVU8k1aTLHnXP5KdgK05p
 Tad62HAs6flOO5N7k4keOnPCgpBjv9za8vYhZy7WuiF9sD2YgKuyNWUCWDjRTeLro4gE
 1mVzTg5X32WFePXKAq+nB0W9fIEILhqcM3LoupNceyIKy9sctbTzsasVgEA/2mZcm99g
 LJW6QAIJEVWz1PCh1B/MZ8Xk3PYwPDd2Uv/cPbJittL30U2IwWKwqsyym9+SJrahdq0y
 PXLfO/O0x2sg7IE0LXuo5ghUs60/2Ztq8Ok6cTDa+jsC4VmY1EQpNq0obhtESq48qR0G
 BewA==
X-Gm-Message-State: APjAAAW+8GLHpRv1m7sd82blVPKI+X5dXxeH9/QkpxDN504JXRKwdMHu
 SqTwZyXciA8gIbpRZoLwPyZ88FoKCEmGYQ==
X-Google-Smtp-Source: APXvYqyxcd00KVMLSg4G0ioAfwoHA/BAd7SNd6I6bW4aYkCVeQxCyhnF62L2QymNnf/Ef/nHeQuSMw==
X-Received: by 2002:adf:afc9:: with SMTP id y9mr5579811wrd.346.1582907940439; 
 Fri, 28 Feb 2020 08:39:00 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id c9sm13335214wrq.44.2020.02.28.08.38.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 08:38:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/33] target/arm: Remove ARM_FEATURE_VFP check from
 disas_vfp_insn
Date: Fri, 28 Feb 2020 16:38:22 +0000
Message-Id: <20200228163840.23585-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228163840.23585-1-peter.maydell@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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

From: Richard Henderson <richard.henderson@linaro.org>

We now have proper ISA checks within each trans_* function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200224222232.13807-11-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0489e0cdaa6..893911fca70 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -2652,10 +2652,6 @@ static void gen_neon_dup_high16(TCGv_i32 var)
  */
 static int disas_vfp_insn(DisasContext *s, uint32_t insn)
 {
-    if (!arm_dc_feature(s, ARM_FEATURE_VFP)) {
-        return 1;
-    }
-
     /*
      * If the decodetree decoder handles this insn it will always
      * emit code to either execute the insn or generate an appropriate
-- 
2.20.1


