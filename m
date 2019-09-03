Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:56:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD46822CF8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 15:56:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufVRrbvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD46822CF8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5BAd-0006Js-QB
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 11:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Arb-00037O-OF
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:37:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5Ara-00064T-Ny
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:59 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39517)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5Ara-00063x-I8
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 11:36:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id n2so17415590wmk.4
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=kAtyZQk6NvWQZv/UvMqc94DjvSUcAjVyZvv+e5jcwsg=;
 b=ufVRrbvmnUO3sAPlmFdH4FPqyU1RViehbvFdCZQSl/XvhmTDR0sYYhiZdCKS6UWSrb
 jTvwz2b60ID/LmgS2xwWVYxeZeEtljiwi0jrDgROKf5Rd7z96x6Y3f3OK/AbUUWw9dDZ
 Wo9JU2lPNiZrmRpf2U/FwWunGjctqNarYZbodI2WoImycKSl5NYaMUeZnH9w7qL8KKWU
 Q1hBUReEr8+J5RiarcE+ZWOkhU68FErYGfEiJfZTocvVuGmmgp/cTwdkdJUkUngounfQ
 BVTl99C/J3NzveMLuGmJZXuILH19jt/Cb90vxMF+avI3kily825GnZxHAyyhFYYRJg+y
 BYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kAtyZQk6NvWQZv/UvMqc94DjvSUcAjVyZvv+e5jcwsg=;
 b=eaNTB5RGSDa4J2+wKHKWRdvJxAujriGoB1/9+DKDlP38b9c+lnwwKT+2LCh4umCUa3
 ZfAWYHxBaJrun+d5fzBwR0uqyGgRKxLWd5/gcA8OW1nVEUNZjaHYC+fAN74yXcS6kkLI
 wFLj7uP8GsBnbni2u5bocB40ghqKfDIUmc3h1siKmGUPOAufqvQfzoToOCuUPKMeh+1J
 9jWEHYjKs0ZWQH9pUvOaurVCOqkAoQdANEHS50Iz5N/7K1z1Jx0tRBQfE8DEYKRPy2Gs
 wd8d6UsMysME1c9bfQ1Zh+/8oVAcYPQ2Nk5EKRfGIorHvdTkA7Jt5w8SWg4YKn8SMuIj
 Lxtw==
X-Gm-Message-State: APjAAAWiSeEzHfVQ/w3J7tgUQXJ4wsbEMjyriyOQDlvuW1PIy2pgNqRP
 mylTHHnxXG3hfeY1VIwWJkS5umutX687uA==
X-Google-Smtp-Source: APXvYqznNKGlOSvpfldra8Epa0Fvf6owV9x3orzdP0qlSpXZUBkshe5Q2rbUpPzKxhepbk3ZnrGZaw==
X-Received: by 2002:a7b:cb03:: with SMTP id u3mr862225wmj.58.1567525017461;
 Tue, 03 Sep 2019 08:36:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a18sm24435188wrt.18.2019.09.03.08.36.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2019 08:36:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:36:31 +0100
Message-Id: <20190903153633.6651-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903153633.6651-1-peter.maydell@linaro.org>
References: <20190903153633.6651-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
Subject: [Qemu-devel] [PULL 19/21] include/exec/cpu-defs.h: fix typo
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190828165307.18321-10-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/cpu-defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
index 189709b6deb..be946ba1ce5 100644
--- a/include/exec/cpu-defs.h
+++ b/include/exec/cpu-defs.h
@@ -231,7 +231,7 @@ typedef struct CPUTLB { } CPUTLB;
 #endif  /* !CONFIG_USER_ONLY && CONFIG_TCG */
 
 /*
- * This structure must be placed in ArchCPU immedately
+ * This structure must be placed in ArchCPU immediately
  * before CPUArchState, as a field named "neg".
  */
 typedef struct CPUNegativeOffsetState {
-- 
2.20.1


