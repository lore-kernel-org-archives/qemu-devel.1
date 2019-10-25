Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD4ACA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA8421D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFKRl7Sf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA8421D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNy53-0001ga-Id
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwM-0006U1-3T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwK-0006dA-Ea
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:33 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42551)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwI-0006au-D5
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:31 -0400
Received: by mail-qt1-x844.google.com with SMTP id w14so2693836qto.9
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=C1Ka5ZLtI0sImJ7QdMPIBsKCCe+cYWp1x4Ddd/XjEbY=;
 b=IFKRl7SfLyGkRHA2wCnD8Orxigbg5oSbNOHXNwR8D+0jRTEGgSqPnswZdclYiVAgVe
 B+QIirneWP1g3tK9Fg7ZxbgZI6zsjdAxd/4x3wgp7jYU6MHwzyVN4gViKVDL1wQNCuJb
 k2/6L/UpkgwvDDKzkeORzFtaX0K2LF6Ai6A+MCQSWA9zvZmPYfrH66OLl9Qq1INDb/7k
 RXOIYmopyxj8YfGxLhL83DQxXboFsYARE//POLkTkZQf6AyDJzMLBP03u8AOO1Zxd2E4
 2c4kkL6rd72rG7nAWdep1OZbAOV8qt8a2a/aRXBIX0CSp6ThZlmVLUHQ55dApCnLPhlp
 ULHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=C1Ka5ZLtI0sImJ7QdMPIBsKCCe+cYWp1x4Ddd/XjEbY=;
 b=BWMTHxeQ8wSBqmiJILPGgAzwyAZxpES5iFQw7BcjKNJxm9VpdXqw+8bEhgjQXInggZ
 HBNSmMvXoZ8GMgbc/LmST+dDuCl6XCg2AxyL35MF6Vt5auMKY+aOEtUWzo5RVuLUIPes
 d80TSOTFdbSoenVChTnWobtCs3z9seIIqu6/ZQJ3XY4HNqQSYXMFCKLYhPibaIkIZU4Z
 kiQbrXDJFRQkJgLMrVdnPIXjosky1xpaMDV44cDcHjRzHReUFEuedOxsluGAdMXG0yBK
 aSXIdRMoOHOm0lRCdqmWA13HjBAdgROEAnjEIEUuAlZPG0xNz28EahSEwaEnIJM9CqKK
 H4zw==
X-Gm-Message-State: APjAAAVjWDwCROvVJaxD6g9SATBFXSR2tfkxxkKquEsQzt+qmpQrKkFs
 iP1SSr6JYOHP7ne07Qw5J2N4U6JVs8M=
X-Google-Smtp-Source: APXvYqxETCq9IEX7Nvx7hiGBZJKXHCfr5U2MiADTJI9somL4zRJfuNoe6qIzpQeN9jxV6sYu42WKfw==
X-Received: by 2002:ac8:38a9:: with SMTP id f38mr2558976qtc.108.1572003567130; 
 Fri, 25 Oct 2019 04:39:27 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/12] linux-user/sparc: Use WREG constants in
 sparc/target_cpu.h
Date: Fri, 25 Oct 2019 07:39:13 -0400
Message-Id: <20191025113921.9412-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes a naming bug wherein we used "UREG_FP" to access the
stack pointer.  OTOH, the "UREG_FP" constant was also defined
incorrectly such that it *did* reference the stack pointer.

Note that the kernel legitimately uses the name "FP", because it
utilizes the rolled stack window in processing the system call.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/sparc/target_cpu.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/linux-user/sparc/target_cpu.h b/linux-user/sparc/target_cpu.h
index 1ffc0ae9f2..b30fbc72c4 100644
--- a/linux-user/sparc/target_cpu.h
+++ b/linux-user/sparc/target_cpu.h
@@ -41,15 +41,9 @@ static inline void cpu_set_tls(CPUSPARCState *env, target_ulong newtls)
     env->gregs[7] = newtls;
 }
 
-#ifndef UREG_I6
-#define UREG_I6        6
-#endif
-#ifndef UREG_FP
-#define UREG_FP        UREG_I6
-#endif
-
 static inline abi_ulong get_sp_from_cpustate(CPUSPARCState *state)
 {
-    return state->regwptr[UREG_FP];
+    return state->regwptr[WREG_SP];
 }
+
 #endif
-- 
2.17.1


