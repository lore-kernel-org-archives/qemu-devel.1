Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A602CA9EBC
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:37:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A16C21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 14:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fD6MAh+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A16C21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO0iq-0002lb-Rl
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 10:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44369)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tl-00059k-Jx
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iO0Tk-0001fA-A6
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:13 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833]:43331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iO0Tk-0001ey-4c
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 10:22:12 -0400
Received: by mail-qt1-x833.google.com with SMTP id t20so3429934qtr.10
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nmU+yKlQiV860VrF5+z5rPYXmAQaQLmhxeuYjoE3BVY=;
 b=fD6MAh+bxQtMs/bJ07nmJGgn+oDCqxJ3K69D7N5gASS2Wak5SmbB0ZdAHG915UuQyr
 FbNZO09QWFqkVDiip+Sw8pTmuv/Z1fyfXH6cKxSOTeYfS274MyaBQuq2w2VwjC/dzRrW
 fFsIAtZHAEeRpyPgwrTzeqgh5USBmkvHyJ6yxNO4/2+Tiz2DaiPVDGGuZfI2DuNHyKAD
 5o9ck4DomF1Td5+RWZMLdQjwJtDF/5C00XgCqAIRCMpcTzJhMx5e6y6dsXQ7G/Mq+WN3
 1qIWYlbXJAD0y0/m6FYUEDUhOWVg1XQrvzaeJLNqrNcW0l4ZaBXbV4jD8ENqJWvMdWSW
 VURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nmU+yKlQiV860VrF5+z5rPYXmAQaQLmhxeuYjoE3BVY=;
 b=G/cBSFIl4JRQHGzNIXpkNcxojwqcFC0dviBKhUD9DXvfIqNYhuoXUg+msZGqkahpTt
 8OXSymRJS7cO1kDjI3Yj9cSsKXka1CpljqOEyqc9JuYKDMFQKpZjKxJFeKgBhYWZ2g0H
 4clBw+LiV/7KU68KLWs15VjCIVUG9tLJ8AUjAh4NHwRXu8CRzTLs31JNuePYw6ciY6Dd
 +qTSoRCSlNpS05so9AwgeQmYDmhjbZNJRBXLvnjCCf3t+JHhpY8P0aYMD2azPTTvmAOL
 E4JXIbrP6vLXNEPEtxD7P19v9hWl+RwNot8viv/6RrH8FJXAXLcXWtR3LtLt9x9hF2o0
 /Tng==
X-Gm-Message-State: APjAAAViWsn7zN/SBy/nOSTzOyKjpSYzzNAmL7vMyzBC5lKdIIfiQMee
 OsRsjFjbxFX1r9IvN01F17yd1cJ2aVE=
X-Google-Smtp-Source: APXvYqwnO2mSa2lI1rYtBMy/nTFTipy6azLQoJPRGTVwBzOya8dGnL/SYymx0EuVjPEGxSRIwL5ZUA==
X-Received: by 2002:a0c:fe02:: with SMTP id x2mr3309774qvr.117.1572013331146; 
 Fri, 25 Oct 2019 07:22:11 -0700 (PDT)
Received: from localhost.localdomain (rrcs-172-254-253-50.nyc.biz.rr.com.
 [172.254.253.50])
 by smtp.gmail.com with ESMTPSA id q17sm1137050qtq.58.2019.10.25.07.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 07:22:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] exec: Promote TARGET_PAGE_MASK to target_long
Date: Fri, 25 Oct 2019 10:21:55 -0400
Message-Id: <20191025142159.12459-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191025142159.12459-1-richard.henderson@linaro.org>
References: <20191025142159.12459-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::833
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

There are some uint64_t uses that expect TARGET_PAGE_MASK to
extend for a 32-bit, so this must continue to be a signed type.
Define based on TARGET_PAGE_BITS not TARGET_PAGE_SIZE; this
will make a following patch more clear.

This should not have a functional effect so far.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d3e4660d50..ba6d3306bf 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -229,7 +229,7 @@ extern TargetPageBits target_page;
 #endif
 
 #define TARGET_PAGE_SIZE (1 << TARGET_PAGE_BITS)
-#define TARGET_PAGE_MASK ~(TARGET_PAGE_SIZE - 1)
+#define TARGET_PAGE_MASK ((target_long)-1 << TARGET_PAGE_BITS)
 #define TARGET_PAGE_ALIGN(addr) ROUND_UP((addr), TARGET_PAGE_SIZE)
 
 /* Using intptr_t ensures that qemu_*_page_mask is sign-extended even
-- 
2.17.1


