Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F050CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:41:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23F92070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cV1M6LmQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23F92070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxye-00023C-E7
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45029)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwK-0006P3-Fl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iNxwI-0006bz-Dl
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:31 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:46897)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iNxwF-0006aB-4Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:39:28 -0400
Received: by mail-qt1-x843.google.com with SMTP id u22so2655588qtq.13
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RPOooG/qzrYvwV59r2e90DUXAtJHgbXT1XUOCv1dvV0=;
 b=cV1M6LmQloVXfRNGHYBEq9bDKP2ivRdJ6N+l3OuK1HiIU3y4jGzYiDX8DtK90JJx+s
 wbCWHRhjced+ZAQB2xM6CCqv/CUM+DvQYt779ygR68lu78mF54CHRO8CXKzEOmP6WC0l
 oqXzU/nWrIXpWl9TWOUYW52UD+STUeLAdA65TqArbYNZ2rvzo+R60sDEwgJ5EDEPa8n9
 gO+RkeKbx6KzxrrImNfWCP+ywn7PJM8WivhweEUUAHjlWqSAhoM1RyM3qpJkBGAWm4GL
 e4O7AWOqhbPUvn7G0zvAvRmd0mrLJKGEK1jrEMLM+BjHsLmIHJEwLJAb0H96rDUmCBoJ
 c5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RPOooG/qzrYvwV59r2e90DUXAtJHgbXT1XUOCv1dvV0=;
 b=LMwgb+RtvNGNC1H0cfjF5CGATKi/cuga0p9zRq1YcMUUQByb5300kpvYvsX6mMU2ie
 MsoL5oADZCJRpBpGARkPcDwaJk80s6/VQ26aAjgVgiUZ+UJSCrtR0GF9HJwl8RR8vEH9
 QQE6K7YU3PnQsAOSLfu8VGjqw+U4x8g7r0vt+B2uW6v5gc4JNzn6SVw7EPPzO/e/BjKK
 T6jgHrjE27q2V8aeun+sogm7OCxf27S1fu/0L6vSYPSslV8uQml1DrTlKHexqP7YeBPi
 qlTAx9UxbWEb+YjMuWkc/XtyFEF5hx0xhKIxaihyDS6XozGTY0cY/svyzg8Z5Y8yNt1W
 3Tpg==
X-Gm-Message-State: APjAAAWQ6fv/u7+tYQYrD+JkZsgfwZola73nunlWCjL4qiFjB7tlfVTQ
 Hrj5CB1kg0+6eJJBalLF0aYFquUw12I=
X-Google-Smtp-Source: APXvYqwNbANUFzw6mQhHvQ0EaHU3iJBwfsI8okv1Bkv+36bKkNVZGjyMVfx8jsTDv8Ol/EKFYYnDng==
X-Received: by 2002:a0c:e60e:: with SMTP id z14mr2787832qvm.124.1572003564979; 
 Fri, 25 Oct 2019 04:39:24 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id x38sm1473335qtc.64.2019.10.25.04.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:39:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/12] tests/tcg/multiarch/linux-test: Fix error check for
 shmat
Date: Fri, 25 Oct 2019 07:39:11 -0400
Message-Id: <20191025113921.9412-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025113921.9412-1-richard.henderson@linaro.org>
References: <20191025113921.9412-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

The error indicator for this syscall is -1, not 0.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux-test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
index fa4243fc04..673d7c8a1c 100644
--- a/tests/tcg/multiarch/linux-test.c
+++ b/tests/tcg/multiarch/linux-test.c
@@ -503,8 +503,9 @@ static void test_shm(void)
 
     shmid = chk_error(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0777));
     ptr = shmat(shmid, NULL, 0);
-    if (!ptr)
+    if (ptr == (void *)-1) {
         error("shmat");
+    }
 
     memset(ptr, 0, SHM_SIZE);
 
-- 
2.17.1


