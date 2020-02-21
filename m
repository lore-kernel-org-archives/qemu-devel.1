Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66E1C35655
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:12:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D292073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cx14x+zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D292073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j586w-0006wN-Px
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:12:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5829-0006gH-3n
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5828-0002Xz-6E
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5827-0002XZ-VK
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id w15so1996689wru.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kEbZ0H6BPcwPTKlgGDMsr9sYvm7F+OeNwNzpuyE6fjM=;
 b=Cx14x+zdlr4CfYn+gZ/j2E05IpYY52A7kALoVOySYJlgoDy3AIBN6oaijZIYt12nVB
 UhBz1fz1giuPLTmf3h/xj0e5tZ7t4x3K7F/Grf5Onk6n9T4nVOYqpG+lZr3s12Zica7d
 z4DA4tLDsmGb5p7vnF0SZBdOlvJTdtVwTYn11otqkVCeXngJWxTZPhj7NwMsRFZWnQNX
 eBjhibnq68ALOi+c9wDSp++l5chHvKNLnhb5WDVJJEKRBi9XMp7N42/TGnV/qn3EU49X
 NOFoCN7XgajK5rNoJ8nfVTCwinIEOJ5WLvDI502qZeQbPQM5T0Z6JyUwFGnTMeNmtMU6
 iUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kEbZ0H6BPcwPTKlgGDMsr9sYvm7F+OeNwNzpuyE6fjM=;
 b=lXjFheqIhAArpdZv4+33teM2q35nzDrnet8feMbPYgkx4QdfadtQEvxdbcjzQJa0xU
 +dw14Hic43cTGsxcG1cfU3LrV5V+GFtlg+b4IVKBv8yboaJhnUqUJFMTzuTlpAW1nXxx
 Tk3OANhNpPNpbE1JNPfKexv4Rk4+bhX2QL8uwD0vqSnAz9BEVXfZN2jEUiJbgW1Wc70w
 EQuzTxwsgr8/uMfzWgj21PlyFKlu4w4wR0P3mch1Z7Aqb0R0JUtzqupJi88cwdSN7yq5
 gLFs821CdegumAiUVBBvwVXi3fOy22/uK4VSBwf3BftOfmE3EE7SnFVyJvk8XF6RzjZD
 LXCg==
X-Gm-Message-State: APjAAAUllbGTn/P8KAM2rYTAyIbd9j/XOPbZm/PG11U94EaIvHD/qfU8
 08NvjgS9HPHICabtzQvc2+waBunIs5J9Hw==
X-Google-Smtp-Source: APXvYqwTuXvWNsIVXXvYLenqZ09snTdL1PsxYOZSpTDMuF6gde9e4SKXoAPnhuvh0zf7yoNH/GRJkg==
X-Received: by 2002:adf:b351:: with SMTP id k17mr48286933wrd.199.1582290474574; 
 Fri, 21 Feb 2020 05:07:54 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/52] target/arm: Use bit 55 explicitly for pauth
Date: Fri, 21 Feb 2020 13:06:58 +0000
Message-Id: <20200221130740.7583-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

The psuedocode in aarch64/functions/pac/auth/Auth and
aarch64/functions/pac/strip/Strip always uses bit 55 for
extfield and do not consider if the current regime has 2 ranges.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20200216194343.21331-2-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/pauth_helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
index 9746e32bf81..b909630317e 100644
--- a/target/arm/pauth_helper.c
+++ b/target/arm/pauth_helper.c
@@ -320,7 +320,8 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
 
 static uint64_t pauth_original_ptr(uint64_t ptr, ARMVAParameters param)
 {
-    uint64_t extfield = -param.select;
+    /* Note that bit 55 is used whether or not the regime has 2 ranges. */
+    uint64_t extfield = sextract64(ptr, 55, 1);
     int bot_pac_bit = 64 - param.tsz;
     int top_pac_bit = 64 - 8 * param.tbi;
 
-- 
2.20.1


