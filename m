Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC36C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14722218AF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 23:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoEDfWuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14722218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB5yU-0004lz-FY
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 19:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5sD-0006N2-Si
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iB5sC-0000or-Do
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:05 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iB5sC-0000ob-8X
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 19:30:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id c17so2740479pgg.4
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 16:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=eTxCu2cA0J5WLFUs9gnavWyyP8aOc6nLl3OMieDyOi4=;
 b=xoEDfWuROv4YFw1LWKYMRw2b9hAAwTGmud08hZSU5t1+yR/CkGrEmolBOqpNUU/6bU
 EnH1o4MNLUHLkiittMyysm+wsy4b+fPUPAM2R5asjkTqQU5xNm3PF+LqS7uwsi4Y3gaC
 40JESRBLKt0WSFFa82fu09B4QkLWX7Z1OTZR779n8HeXfQLHtHssmxJ75/uKWR0/Pnco
 jURXiY/bDMgGUaUeSr27SL+7rCsSqg5z4QkARxJHCXHkYdUvkx+afuyY4LSzGIdpGPpa
 zAFtn/bR1WtTSq6WhQNJZY0W5IFJJ0VDbRSlce858WUlAc/HJFdZN3roEWSEREdaUnOw
 AVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=eTxCu2cA0J5WLFUs9gnavWyyP8aOc6nLl3OMieDyOi4=;
 b=tQJLi2n3R9f42dpJsR0qY27H/10lVOHAsN8G61IDZGI9NIpSdZMzIolqWKTDPNP3x9
 ADE7c9UiXB1CQTBTkxK6u3BEAxzeoUe6l0WQx8lX4zbbhob3D86Bk9OMjv/yvjanlLKw
 gMz+VvkjYZf/yMzV7fzJoVEZ8ZwP6WsewtKw6bg0fNF1IFDvqsgUsoulDiKgpfdOfL2b
 pXm6ePVxvwB3oYOEHa4W3HaAdqtL5b6lhNCh9CfZQSU+TcqrxGZCQa0AxV0YAc+gzJM5
 cBG4ZvJe24XumciI705wR/bM7jy3X+rdkUemGKKmBUukN2lohVA6J/InWaXIZ/Lq8EEv
 XUtw==
X-Gm-Message-State: APjAAAUAkL9lv6ySwnEaRbEe/ZftExSjgN9eLB9QRHFXEv1+71LGTP5v
 O6HaWT99cht2Z1Huitv2qKQgCst+/AM=
X-Google-Smtp-Source: APXvYqwwhF8uJe8zv+kLWI3rt2GaSs+KwcKFLVz3pJwN1s8gAMhlaji3y9pamKrXkACHXqv0/Ra51g==
X-Received: by 2002:a63:1b66:: with SMTP id b38mr11652296pgm.54.1568935802877; 
 Thu, 19 Sep 2019 16:30:02 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h8sm103340pfo.64.2019.09.19.16.30.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2019 16:30:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
Date: Thu, 19 Sep 2019 16:29:52 -0700
Message-Id: <20190919232952.6382-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190919232952.6382-1-richard.henderson@linaro.org>
References: <20190919232952.6382-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: pbonzini@redhat.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This eliminates a set of runtime shifts.  It turns out that we
require TARGET_PAGE_MASK more often than TARGET_PAGE_SIZE, so
redefine TARGET_PAGE_SIZE based on TARGET_PAGE_MASK instead of
the other way around.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 8 ++++++--
 exec-vary.c            | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 5246770271..2db73c7a27 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -213,19 +213,23 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 typedef struct {
     bool decided;
     int bits;
+    target_long mask;
 } TargetPageBits;
 extern const TargetPageBits target_page;
 # ifdef CONFIG_DEBUG_TCG
 #  define TARGET_PAGE_BITS (assert(target_page.decided), target_page.bits)
+#  define TARGET_PAGE_MASK (assert(target_page.decided), target_page.mask)
 # else
 #  define TARGET_PAGE_BITS target_page.bits
+#  define TARGET_PAGE_MASK target_page.mask
 # endif
+# define TARGET_PAGE_SIZE  ((int)-TARGET_PAGE_MASK)
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
+#define TARGET_PAGE_SIZE   (1 << TARGET_PAGE_BITS)
+#define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
 #endif
 
-#define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) \
     (((addr) + ~TARGET_PAGE_MASK) & TARGET_PAGE_MASK)
 
diff --git a/exec-vary.c b/exec-vary.c
index 67cdf57a9c..26daf281f2 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -83,5 +83,6 @@ void finalize_target_page_bits(void)
         init_target_page.bits = TARGET_PAGE_BITS_MIN;
     }
     init_target_page.decided = true;
+    init_target_page.mask = (target_long)-1 << init_target_page.bits;
 #endif
 }
-- 
2.17.1


