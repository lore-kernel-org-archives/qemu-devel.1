Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B77DC4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:12:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8B924650
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eQSzHAVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8B924650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j71Ai-0002CY-9z
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40701)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j718g-0007DV-Ak
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j718f-00067T-9q
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:30 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52080)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j718f-00066o-3d
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:10:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id t23so276429wmi.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 10:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qFnkfoP8m+qXflyejUwS/Vipa7DcI1oKmkPYEaLcY/E=;
 b=eQSzHAVFumHhzYdBXmXaE+cLeTGQO0bIkGTK6aArG9UlqWjheMpZwpKL2FFgVCBK2A
 jrTISFiiSo7GVEZzZb5FDb5B10PDCEK94WFe8EA11eFdDJOjDVKNmt7Qjj/SQqpZtOTS
 naulW5shQLyMIwS/Sxe4vvJG1Jg03fulYxnAADa2iP7OMVL0l8A9VV302ePNKILWztuv
 tNfhuOBrR2YUAUidiH5j3D4e8QeGaYjxNb96U7k2pLCYi3foTMLgEVcWoyOfXUGlhibb
 WLQU+7ENJcHPPwKfrmyh7MfDZE+lGhk/Q1/QpCOfhCMGX6qJJoNyLwOz4pKCOe0QT/Y/
 HcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qFnkfoP8m+qXflyejUwS/Vipa7DcI1oKmkPYEaLcY/E=;
 b=XFaUy3J3bRx4pL/8RsNBeFafvuvcunxhJxFA6R8c9gksh5lLWm+9zLSOf019L0BS/1
 yJPRM1BhQsMW8pY2yjNctX8hfvyQKzKX391V5mVHtxjWzFQMsGli0xyGrXARm3zSqaNx
 JZIkhXif3ppme0BvSG6lnnzQAZ2HAmOfPDoxFvwLHGSs+jhdv7GSQQy+IysgFK+5EH4g
 9bkg0/yXkh97DHLicjXTIfn58vG4WVOQkKsE6m/HCVs/jfGqKtOrlkiBIuXu+KiWmUbQ
 a3eYjb79KCcqdoVP2Xxd3D43jEVMs3vEL1jk/KQvFGess+Z+krQNeSvHvVQ00jEVt4xl
 l8wA==
X-Gm-Message-State: APjAAAWIa0OoF5RNBuD1ydb2iUnuc5WAqRmWcxWhgS7ODr85Bf1rQT/t
 UBEOtQWpaUhjmlMugg8lZZzkIw==
X-Google-Smtp-Source: APXvYqyU7dH6wL9d0FysM1K0oct/PLODu+U5CObWBIGDNsmE1uCTxo0a9lj/QQUm2E0m1Jup4eHpJw==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr132561wmi.70.1582740628019;
 Wed, 26 Feb 2020 10:10:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm4411073wrq.63.2020.02.26.10.10.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 10:10:23 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1EC1B1FF90;
 Wed, 26 Feb 2020 18:10:21 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/4] accel/tcg: only USE_STATIC_CODE_GEN_BUFFER on 32 bit
 hosts
Date: Wed, 26 Feb 2020 18:10:19 +0000
Message-Id: <20200226181020.19592-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226181020.19592-1-alex.bennee@linaro.org>
References: <20200226181020.19592-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no particular reason to use a static codegen buffer on 64 bit
hosts as we have address space to burn. Allow the common CONFIG_USER
case to use the mmap'ed buffers like SoftMMU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/translate-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5b66af783b5..4ce5d1b3931 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -892,11 +892,12 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
     }
 }
 
-#if defined(CONFIG_USER_ONLY)
-/* Currently it is not recommended to allocate big chunks of data in
-   user mode. It will change when a dedicated libc will be used.  */
-/* ??? 64-bit hosts ought to have no problem mmaping data outside the
-   region in which the guest needs to run.  Revisit this.  */
+#if defined(CONFIG_USER_ONLY) && TCG_TARGET_REG_BITS == 32
+/*
+ * For user mode on smaller 32 bit systems we may run into trouble
+ * allocating big chunks of data in the right place. On these systems
+ * we utilise a static code generation buffer directly in the binary.
+ */
 #define USE_STATIC_CODE_GEN_BUFFER
 #endif
 
-- 
2.20.1


