Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72611C3A5A6
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:05:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F600208C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZyXN/4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F600208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBt7S-0001fz-1Y
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxp-0001Og-Kj
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxo-00087I-Fp
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:35789)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxo-00086q-9m
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id 205so7000264pfw.2
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=pCxJTsjXZq8g03qIiRt5SN5kChF38n16rM3czFVAxy4=;
 b=UZyXN/4HM02XXBXKBdYfIR30vcM4GkupWbmcY2LlkMUAHmmmBeT8959/HXQIQqRLvn
 RQSfrDkOSL0aoYG+0buntlYfATFUw43tiMPD0V6m1hN92R7L4oZelz00YLumXVqbJAPg
 Jjl++xhOtwhfGXX+c6KqoXfQt9lBbZNOTfQ8XYel3g5vgWopoZiudK2DvhInJUVh8w9t
 r2VUEct8B0QqNJBoGkvlqFs17Q+34I9M98VXvNmPkPPxCRzVyw0ELR77hhHePmDV+7kH
 4OSy1xPXGl1/JmerbOv71yLbHgOQZ6cBNwSts9CGDTgnBA1PxErO5RXMs9HEDV3QjKgu
 Xyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=pCxJTsjXZq8g03qIiRt5SN5kChF38n16rM3czFVAxy4=;
 b=j1SPapy3Sfci+AbATlZZtXEG7EQkQNlHGunUQcGh/GhLB3Q6yoETTfPCEwkpqhOuKM
 sC37yRDxpZJ+djaT7ogyOGRQxbkG9xgjeMqzH8O0gZFJgM8ah8JWTZ2/lhui9hwc50Zd
 jWC6lmgl/4RRZt5D51nubqxb9/gvidvLh32FXF8ENfthmj0SRMdg1nYnI0SmF08v+QkY
 sXB+pjvOVDhN0d1lOtf4YTC/DqO/tIrEz4RfCXFTziTCHlzZcIAe+c6lT/cciO9fwv0q
 /89Odx6XDOwftX+6nv1g7W6PvB00qSWRwAAjr+d+wt4R3idplIzFZM8kA2wbjCu6F051
 Yiag==
X-Gm-Message-State: APjAAAXBGHrkFh37xYwzuesLFnAD0+Wsw4AJULpjVIy8OuEVHCXQ0Goi
 9/5BAMUz/FuL0HEoJixrA3n2a/l7i4s=
X-Google-Smtp-Source: APXvYqzwUb9mGCJ4s+e+AM/oIsOt/M4ISMekTITY0T14F2N7KzF8GEfatzpu0rx8KafBAraS0JZrlA==
X-Received: by 2002:a17:90a:3b01:: with SMTP id
 d1mr13351237pjc.81.1569124506950; 
 Sat, 21 Sep 2019 20:55:06 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/20] exec: Promote TARGET_PAGE_MASK to target_long
Date: Sat, 21 Sep 2019 20:54:43 -0700
Message-Id: <20190922035458.14879-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42d
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, stefanha@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are some uint64_t uses that expect TARGET_PAGE_MASK to
extend for a 32-bit, so this must continue to be a signed type.
Define based on TARGET_PAGE_BITS not TARGET_PAGE_SIZE; this
will make a following patch more clear.

This should not have a functional effect so far.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index b11ee1f711..34d36cebca 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -225,7 +225,7 @@ extern const TargetPageBits target_page;
 #endif
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
+#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
-- 
2.17.1


