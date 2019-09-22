Return-Path: <SRS0=thrq=XR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10910C3A5A2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:00:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5FD220820
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2019 04:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8p780Cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5FD220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBt3A-0006WZ-Kz
	for qemu-devel@archiver.kernel.org; Sun, 22 Sep 2019 00:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxr-0001RP-0N
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBsxp-00087o-LR
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:10 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:37467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBsxp-00087S-Fn
 for qemu-devel@nongnu.org; Sat, 21 Sep 2019 23:55:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id y5so6991129pfo.4
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2019 20:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=W4TalZMvNpabdLXEj4HQqHc5U6U5Ly8Q0gdLiyGbKsA=;
 b=x8p780CbKob8dCvUE8xsXqi57cfTErXtuStAryUfGLUqg/cWctViWjMIT5FCgyEWMS
 GNZ+WzMu9NypWIRV+NZSJTeQqzQciAN85seJulHg7T0HRND2P0kZ05LDfJIu3LLVlpgf
 lYzE4WjfcGy+aw23zqavaHJby5kleoTv8TcEzjImuEXr0WlZaU49OQ+P3oIbxkrQwwJh
 6WZreK1W92wyLgkZpsXfSjznqULoe28tEDtkBQpOkcDKMqMlxDhPiIAYmcjm29U72A2m
 +fUeNyJXTZgW4r13JVhKlc8NykNi+8BWvaytKJBlQ2bbipFSdX+ygRK9o7FEen6M110o
 HIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=W4TalZMvNpabdLXEj4HQqHc5U6U5Ly8Q0gdLiyGbKsA=;
 b=mjTOw1Okb6uEOcwRYTCBZSDptKqA+P3kNwExtI235zTtIQtAhl6cgm0iFVgAuyEOGw
 JKTiwhSO+OSb6l8YDqYkIXV6Ae44izLA7sobKfXvkn1WTlCPFh7apqoF034gBkQutrrK
 YZ3aPvCkRXCgi7fQPwRaktvFd/4ohKLqm+FLW6+iFtQoC5joEZPUdDW9RteBeQUuz3J0
 pEcRKgRMpxzvXSucDipXVSd9Rt2nT2KqSVgU9ZBFXIoHbJng+6tv31PW45ouAMhIGdVg
 tiW0KAKt108iG2A/fiPS9w/SNUpcPpdSBJW9hqpwDTNoYS4YWpE38mYp0cA2NCcuV/qv
 aTfQ==
X-Gm-Message-State: APjAAAVLzcUdztQJn90Zg+WH7gKjotXcrazieon99cR/snNvSPVoNVfj
 y+nGwHC0XoFnHoRNMTzdUCaxxNYIszY=
X-Google-Smtp-Source: APXvYqzkfAToL0YdiMVuFTu0prnaQvypNNkX/4KkPHPU47ontsbSZNFI5HODLJKzMdB8sVnbkhhFwQ==
X-Received: by 2002:a63:724e:: with SMTP id c14mr23828003pgn.120.1569124508144; 
 Sat, 21 Sep 2019 20:55:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z4sm6452921pjt.17.2019.09.21.20.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Sep 2019 20:55:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 06/20] exec: Tidy TARGET_PAGE_ALIGN
Date: Sat, 21 Sep 2019 20:54:44 -0700
Message-Id: <20190922035458.14879-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190922035458.14879-1-richard.henderson@linaro.org>
References: <20190922035458.14879-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42f
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

Use TARGET_PAGE_MASK twice instead of TARGET_PAGE_SIZE once.
This is functionally identical, but will help a following patch.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 34d36cebca..5246770271 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -226,7 +226,8 @@ extern const TargetPageBits target_page;
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_ALIGN(addr) (((addr) + TARGET_PAGE_SIZE - 1) & TARGET_PAGE_MASK)
+#define TARGET_PAGE_ALIGN(addr) \
+    (((addr) + ~TARGET_PAGE_MASK) & TARGET_PAGE_MASK)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
  * when intptr_t is 32-bit and we are aligning a long long.
-- 
2.17.1


