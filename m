Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42426ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DFBC2084B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bjm7HNau"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DFBC2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyHD-0005l6-1i
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvU-0007XH-MH
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iJxvT-0006Hm-E5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:08 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50315)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iJxvT-0006GK-7v
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:50:07 -0400
Received: by mail-wm1-x343.google.com with SMTP id 5so16761805wmg.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bN4XmGTG9/FatEh/7FtZa/B9CvFqCRZ6R/2X2ZutnFU=;
 b=bjm7HNaujfIiQwunUt3Oir/dBUL78Uo1Fh7DuPuLOMBoUNax9PKvxw0PU/STqGvvaI
 gjct/iBy2Z8XQ63InA2K+iYUOk4jiVf46oC4mxEDgP7u4vnp89GJ4VrIyqWaLVwgSVk5
 UOvXb6gRJfQPAU/H9a9RHsCsDenU0jA2kSqCDbvycij+ek/PMYgaIFk+ebkI6diLe6xL
 9aOighsAaFOBGWtnWPjPGMTs4+T/xVBGCeajQVIvg+xDpavrSe/B23gMMumjAmr1LzgZ
 AetesW3SU3XbUSgwNSZLo2BPScPx7CIuuyYYLQm6HBZLTGIwzqTy4vwsxeYmEIYhIhag
 oD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bN4XmGTG9/FatEh/7FtZa/B9CvFqCRZ6R/2X2ZutnFU=;
 b=eA+k5U3m51UfonygSCHeRQ49IdCqhnjnom4AlvUfkKhtzTCUTn5yR26NBOUPDbw5ow
 Tbailo0kzEp7NcX0Jv9fzh/RzCi65Ry8blMhNq/k9C0tEtVczUaXUG/y8oE2WCde3d7a
 BjEoeDqmmU5Lc4n66Rrnn0FEOrFITlq+KU9Chd+CzgPOX7IiSbwx01DqtQXcq3cQbDE9
 lhUS5Hhf2QCjQ/LXencIs5QGM4Y8frG8NclyBuEAPSRjf9ofq0wV5e776tDCq0NjRNyH
 pAZzHlx7fkgCcDMaoAHahePMEUBFAAE8xwKw4V9oHNhRqeoyNhETxujHJUqrGc9OPzLf
 CeSg==
X-Gm-Message-State: APjAAAVw+/pdHzLgmTVTSrrVwOGhiIUvuCcMZZS5hXAs/qI9xTrkp97P
 2BZVP6kLDKq2PbS4jrqDNORJnSFGP/o=
X-Google-Smtp-Source: APXvYqzXCqUmQshn3QNmxHDOkfkz/8/4unnaDwzc95iC10JJsf3plnByOD0LJWlLr5Kwmw28T0VmwQ==
X-Received: by 2002:a1c:5f09:: with SMTP id t9mr15395842wmb.124.1571050206167; 
 Mon, 14 Oct 2019 03:50:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b7sm19111097wrx.56.2019.10.14.03.50.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 03:50:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1BCA91FFD6;
 Mon, 14 Oct 2019 11:50:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v5 50/55] include/exec: wrap cpu_ldst.h in CONFIG_TCG
Date: Mon, 14 Oct 2019 11:49:43 +0100
Message-Id: <20191014104948.4291-51-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014104948.4291-1-alex.bennee@linaro.org>
References: <20191014104948.4291-1-alex.bennee@linaro.org>
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
Cc: robert.foley@futurewei.com,
 Richard Henderson <richard.henderson@linaro.org>, peter.puhov@futurewei.com,
 aaron@os.amperecomputing.com, cota@braap.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This gets around a build problem with --disable-tcg.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 47a071fee0..e74cf980e9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -22,7 +22,9 @@
 
 #include "cpu.h"
 #include "exec/tb-context.h"
+#ifdef CONFIG_TCG
 #include "exec/cpu_ldst.h"
+#endif
 #include "sysemu/cpus.h"
 
 /* allow to see translation results - the slowdown should be negligible, so we leave it */
-- 
2.20.1


