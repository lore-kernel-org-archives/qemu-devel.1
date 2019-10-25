Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE892CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:18:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8052F206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLIDlxNU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8052F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtrs-0007XE-Rf
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:18:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMr-0007nU-57
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtMp-000384-R6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:37 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:52999)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtMp-00037V-K4
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:46:35 -0400
Received: by mail-wm1-x329.google.com with SMTP id p21so785890wmg.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U/q1GG1kwgwOT4ErsA8UxTYQsC7aPfxd1sGDgtCJFgc=;
 b=KLIDlxNUJlIxZFmWN1MrzXnVXNZPTZlJuSNIKa5NtxLSL7TcSOy5XqPrMYB2nzCrWA
 N6kWE1j7IcD335igkmzUbRz4akfz0FgvyEt5AunuEAr/QQpnGW8Ow78gAR/NqFMzdSaE
 qJb7LBP/9/IvAob81XZx2mynxOqUf8TnxU3fYz5Xy7sN11hjzuey+D46PXD3AFtSzp2s
 MkYUPVhzz9HYXW93AW/N3zmnl1WsG7DryHH/oHnW4GnDvvGUOXh0S2AI6TVb4q7rWfDZ
 A5zM4zaWxxG1n3B7n195XV5Me5zhMQ3qtA4TFqriyQfBvdpWapNi2xVS3BzjhFKuFH+y
 /f8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U/q1GG1kwgwOT4ErsA8UxTYQsC7aPfxd1sGDgtCJFgc=;
 b=nirL+tCPnS8KQeM1QKgC6UBWW+bSQhVbrR1Adll2t4uxsLkUeNQ2djTmK2OdXHUbYY
 VNjni0RpYTC0gWXseLBnR7KGNP4murckrwve8s2i8g86UZpusCMprKFvfzGcJU4sI+vr
 JHUkEcrJb+2qFCREi/4ACVfO6JAN96yVetYLx+NO8Q1u2mgBUss2TkqgiSOLfTz/dr4j
 Lf4dXuI9sXeyepnNnfy1Fn1laBcZ3x61+qaE+rjllPYbXqAS0Jy7WpfUJTkfRzsjq+d3
 0fbj26TZ7u1ARapsEvmG1qCynhoj+X+kehYwH5i90l1Gz+CShKDj59HSw5hrQ8019PXp
 XjIg==
X-Gm-Message-State: APjAAAVTpmGoTKTWS33vw9Sfjf3fVdIEZuKBKQA2SFv/QYTCSk6dUZwS
 o+UY+CCTuBgIVLZVMDzswiXpFQ==
X-Google-Smtp-Source: APXvYqyNW8dDd865W+xXQSxmxspC1fOaxCLWwmXvUzxZL3k7mLHFjRm35V19IU3U4/AxPKOkQkjFWQ==
X-Received: by 2002:a1c:7e57:: with SMTP id z84mr1964935wmc.84.1571985994414; 
 Thu, 24 Oct 2019 23:46:34 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q25sm2634668wra.3.2019.10.24.23.46.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:46:33 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93FBE1FFC0;
 Fri, 25 Oct 2019 07:37:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 40/73] target/arm: fetch code with translator_ld
Date: Fri, 25 Oct 2019 07:36:40 +0100
Message-Id: <20191025063713.23374-41-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Now the arm_ld*_code functions are only used at translate time we can
just pass down to translator_ld functions.

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: convert from plugin_insn_append to translator_ld]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 5e0ac8bef06..45edb108f6a 100644
--- a/target/arm/arm_ldst.h
+++ b/target/arm/arm_ldst.h
@@ -20,25 +20,20 @@
 #ifndef ARM_LDST_H
 #define ARM_LDST_H
 
-#include "exec/cpu_ldst.h"
+#include "exec/translator.h"
 #include "qemu/bswap.h"
 
 /* Load an instruction and return it in the standard little-endian order */
 static inline uint32_t arm_ldl_code(CPUARMState *env, target_ulong addr,
                                     bool sctlr_b)
 {
-    uint32_t insn = cpu_ldl_code(env, addr);
-    if (bswap_code(sctlr_b)) {
-        return bswap32(insn);
-    }
-    return insn;
+    return translator_ldl_swap(env, addr, bswap_code(sctlr_b));
 }
 
 /* Ditto, for a halfword (Thumb) instruction */
 static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
                                      bool sctlr_b)
 {
-    uint16_t insn;
 #ifndef CONFIG_USER_ONLY
     /* In big-endian (BE32) mode, adjacent Thumb instructions have been swapped
        within each word.  Undo that now.  */
@@ -46,11 +41,7 @@ static inline uint16_t arm_lduw_code(CPUARMState *env, target_ulong addr,
         addr ^= 2;
     }
 #endif
-    insn = cpu_lduw_code(env, addr);
-    if (bswap_code(sctlr_b)) {
-        return bswap16(insn);
-    }
-    return insn;
+    return translator_lduw_swap(env, addr, bswap_code(sctlr_b));
 }
 
 #endif
-- 
2.20.1


