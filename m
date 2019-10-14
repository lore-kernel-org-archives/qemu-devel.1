Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D51ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:10:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C462084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixzKDEDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C462084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyF8-00034r-Jc
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvQ-0007PQ-0z
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvO-00069e-JN
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:03 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35669)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvO-000676-9t
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:02 -0400
Received: by mail-wr1-x444.google.com with SMTP id v8so19151213wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m4scFyBAux7omI9dWRwoni82M9uy+xh8rsre9KWj8Gc=;
 b=ixzKDEDqwTfH2etxANMqaOVs1pohVls0R5oSxR4AItQcP65hF/1gn8eyJpQyNmR/qy
 Ow0NiVv15FZLuDw+6UV4gM17Yj9ayWZYLeljmkH6l4RkdlD/AmwoYodIiRWdQfv1Yhqz
 e6Yjseq5yZgVd5PHNtM868lt4Wr/QmfUWkdRyjw89hW4XxnwItjM5pBGZ4LBgZYtOxK9
 tOp/zzk5+P5HJ2Z73Fz0/WMWau9brkPoI+526urBDXvmHAHTTPnvaXl6IMdrNgslNkBU
 w/IoLmrOALBWd9906EO0vSlfz0bqVJ0UW711SU3HRUXpZpX4Zpx9y5Qpl4yxHUFh+NhN
 LOBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m4scFyBAux7omI9dWRwoni82M9uy+xh8rsre9KWj8Gc=;
 b=cn3J6ZWccHz3M7K5RjAt3veHjCFTeuy8wuuGBTn0IZIgfgh0HfjoeJ5YAWW2JkRfe+
 yiHdnloaa6n5Ko32BL1M0Fy7rYdVOstUClzey8C78o5UVUBKYfj79cXDoeJtPD8ayxtx
 6bHr5MG8WuELpbOElb9iHOt6b0R3dp8lk2LG+stHveXeFU7k+OgcWLj94I27n4NqEBQo
 2MqAOQu7Q89fRIsCd3RI7SELLRMWJaC+DpG9VcthriUwfQowHEEUbO7VxwpXY9Z0pMxz
 BOuTfdhvVxu7SLW2oitw2ko7Wo9AkU0L3DNKcty8Vkajv0ATqrlmMVZqgpE89+QkDllF
 F2Sw==
X-Gm-Message-State: APjAAAVmkw7RZJMmppf02b8/eftt+1F6rD8FgJMIohLz98DSPbW+SPoT
 m9GPkx+v5MpnLEGCBiGBv4IUQg==
X-Google-Smtp-Source: APXvYqz1XadoZ813nmRYolYLZqLi/w3+CcDbTPZaTYAJXCQX7UJUuGzXXIs5y3lnkzMJkq7FPF89xA==
X-Received: by 2002:a5d:50c9:: with SMTP id f9mr24181232wrt.36.1571050200337; 
 Mon, 14 Oct 2019 03:50:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm14980217wmb.33.2019.10.14.03.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:49:55 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB45F1FFAC;
 Mon, 14 Oct 2019 11:49:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 24/55] target/arm: fetch code with translator_ld
Date: Mon, 14 Oct 2019 11:49:17 +0100
Message-Id: <20191014104948.4291-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
---
v4
  - use translator_ld like the rest of them
---
 target/arm/arm_ldst.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/target/arm/arm_ldst.h b/target/arm/arm_ldst.h
index 5e0ac8bef0..45edb108f6 100644
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


