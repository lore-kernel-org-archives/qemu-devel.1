Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA087FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B40E7214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7iit7GE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40E7214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL616-0003Yd-KN
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:40:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dl-00088E-Su
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iL5dk-0005UY-Eb
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iL5dk-0005UA-8M
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:16:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id v17so2489104wml.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m4scFyBAux7omI9dWRwoni82M9uy+xh8rsre9KWj8Gc=;
 b=d7iit7GETkguplVjVDK03X4AncYDzTUIS06y+tddHAa7DpB0mxXcW95msDS4wuBsW1
 tcc8Gorj54E8srltNxdoPb+LFFR31jKTAxyk7Qxigr8eVRgktV3Te2TWy6IG9Zrl7xbY
 3HEBezqm4cR6GmSgzzMzeDQzpZ0JOzivxmt6cHosXFrY8aBt6pDm17muDBvdLPk7ojFL
 /MsIj5gmBU37jH375hw0spuZCcuZnv41jwLjBHOQhi5+EOQ44Jj955XTsE5pm9Fy5/FN
 dPxsjbJe1g0YKZnmYk0OSbnfNFg7yXgvjb7t5yyrUQDE844LfNFO6k429xX5twsPR6yS
 XwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m4scFyBAux7omI9dWRwoni82M9uy+xh8rsre9KWj8Gc=;
 b=Kegx+JXwEzWS8bT3oUducbNjuXzPNz9ivMIlj6U137gv+8Qb41rUEprGpnnNZHsmMl
 7QmH3w6kvEKLvR3QSU0/dqcI3UIw0oi8HxRJquD3gnqYFjWDvzkdhgneI8h+SfvlZNnV
 Sq8q5xYX7R1oxJmoUwUOVu7WSexaivaaAzHjemPL0fXd4LyINqsw6BstJPn1o4VV9qF6
 n/tI4dz8e2msI8hbSHiB0jDSwMK3B6eeadekq7Ecfe+b7+GtiS+Ne6/+M9FyGjNpqaUt
 71nn4TJqdR/9EtGXE0lpQ+lkMLNGg5aizUOxW/DooNcuXxv5yE4RyMJzGldYasSWFevu
 +VOA==
X-Gm-Message-State: APjAAAVRVf2qKYmhoxFUxQ8yzW/e3dhhfZZ6uOQ0ve906rG9qjGsWcl0
 igsHRYNJFSkhUqgtvUAq596KiA==
X-Google-Smtp-Source: APXvYqwKMZmJzdQB01zDATdEaXOB9G828q/TS3NNZJM5JHsD/kCiniqG6r12QiSGRUfbIud0eHUaIQ==
X-Received: by 2002:a1c:6308:: with SMTP id x8mr2901372wmb.140.1571318187069; 
 Thu, 17 Oct 2019 06:16:27 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u4sm3062810wmg.41.2019.10.17.06.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:16:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 207D01FFAB;
 Thu, 17 Oct 2019 14:16:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v6 23/54] target/arm: fetch code with translator_ld
Date: Thu, 17 Oct 2019 14:15:44 +0100
Message-Id: <20191017131615.19660-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017131615.19660-1-alex.bennee@linaro.org>
References: <20191017131615.19660-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


