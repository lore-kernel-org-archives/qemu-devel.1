Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4CFCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002AE20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 15:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEpyhl+Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002AE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP6eT-0002ZA-HY
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 11:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uq-0007YZ-Ol
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iP6Uo-00045f-QM
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:52 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:46257)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iP6Uo-00044f-0a
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 10:59:50 -0400
Received: by mail-wr1-x431.google.com with SMTP id n15so10200204wrw.13
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 07:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XDtNc199mjlu+7JCj1BafjGA6Am4dbfp5/ruylFlTXI=;
 b=bEpyhl+Zofj9zcnd/a9GYz56dm3yyb7jvDd3xdyx+b3L39nd8Nv6XoWnDIvpJS/qw/
 60r/cvkP7hPWfOf2jC9uVfO39AIQcMxZA1bqtAK0wippwkpYNFnCTYk2oVv+MBIjziBa
 g5dUUXsFD5BXISe01kv2PW84wtc11RX00+T3ABZD7/kz2RJMKCgz4jh2DYJk2mj0lMer
 QvzEucvCW3pc3Nk0o9W2YcisFUpo/ccplbomb7z6aEEbcKQ8K4IwSRnY6vXn8bAU5mUz
 Qtq6ZLD8EIktiNrQrhBAvV867ilV4ZiBbsdL4UNHZXb5to3Qqz25YRevQQFmzS3CLWA/
 EPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XDtNc199mjlu+7JCj1BafjGA6Am4dbfp5/ruylFlTXI=;
 b=L/29yWNZJ2Q00dU99QVGleQlVMdeE9IpkFKfoU4Ycr6Zyh7kcZKylmwQ177O4Nygxr
 HX3J0nw6QvU9b21dTNvPGb3Vg9FusLSExj1xVa4M40pfLIUQyOVc0/aQ8AdvQP1SvFm4
 rjtmAyKJ1abQQBBCX6eJlni1uSjVHnroTMGLCS2GVymEyNeMqdLoD+ldjHBIWZm3RyFG
 cNYLZ8621WM5o5LI3Uc+AafGAGZR0DsrDL3z480nMD7+XzXNE1M1HkgGXbcb/A8JCdiR
 YDj5NEY1+V7JocdokW7ouNuZg8/HgaAz610z7fmUu8A9OTkqemJyFpOFSMsW9Rm+qQda
 g9Kw==
X-Gm-Message-State: APjAAAWPh2QoiH4/+JZGtfenDThOUW0gFQ5mwzfhaCEZOYjvAukfvj3H
 tLSQK7u4GVRysXGqYCkI4V/dk2L5NOCo/g==
X-Google-Smtp-Source: APXvYqy5MJXtj5aqN1NMEVwr71CW8u4ln62qvsLPJ4V+OvKU/TU/Y5ITENFnI8EjnY6zxxkguIaF8g==
X-Received: by 2002:a5d:6a02:: with SMTP id m2mr16483228wru.304.1572274787861; 
 Mon, 28 Oct 2019 07:59:47 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net.
 [88.138.106.230])
 by smtp.gmail.com with ESMTPSA id 143sm14842876wmb.33.2019.10.28.07.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2019 07:59:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 09/12] exec: Cache TARGET_PAGE_MASK for TARGET_PAGE_BITS_VARY
Date: Mon, 28 Oct 2019 15:59:34 +0100
Message-Id: <20191028145937.10914-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028145937.10914-1-richard.henderson@linaro.org>
References: <20191028145937.10914-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This eliminates a set of runtime shifts.  It turns out that we
require TARGET_PAGE_MASK more often than TARGET_PAGE_SIZE, so
redefine TARGET_PAGE_SIZE based on TARGET_PAGE_MASK instead of
the other way around.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 8 ++++++--
 exec-vary.c            | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 0543359d0f..e96781a455 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -213,6 +213,7 @@ static inline void stl_phys_notdirty(AddressSpace *as, hwaddr addr, uint32_t val
 typedef struct {
     bool decided;
     int bits;
+    target_long mask;
 } TargetPageBits;
 #if defined(CONFIG_ATTRIBUTE_ALIAS) || !defined(IN_EXEC_VARY)
 extern const TargetPageBits target_page;
@@ -221,15 +222,18 @@ extern TargetPageBits target_page;
 #endif
 #ifdef CONFIG_DEBUG_TCG
 #define TARGET_PAGE_BITS   ({ assert(target_page.decided); target_page.bits; })
+#define TARGET_PAGE_MASK   ({ assert(target_page.decided); target_page.mask; })
 #else
 #define TARGET_PAGE_BITS   target_page.bits
+#define TARGET_PAGE_MASK   target_page.mask
 #endif
+#define TARGET_PAGE_SIZE   (-(int)TARGET_PAGE_MASK)
 #else
 #define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
+#define TARGET_PAGE_SIZE   (1 << TARGET_PAGE_BITS)
+#define TARGET_PAGE_MASK   ((target_long)-1 << TARGET_PAGE_BITS)
 #endif
 
-#define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
diff --git a/exec-vary.c b/exec-vary.c
index 8725fd0285..ff905f2a8f 100644
--- a/exec-vary.c
+++ b/exec-vary.c
@@ -96,6 +96,7 @@ void finalize_target_page_bits(void)
     if (init_target_page.bits == 0) {
         init_target_page.bits = TARGET_PAGE_BITS_MIN;
     }
+    init_target_page.mask = (target_long)-1 << init_target_page.bits;
     init_target_page.decided = true;
 
     /*
-- 
2.17.1


