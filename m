Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCB7C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E83092085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 12:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbM/xu81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E83092085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzh1U-0004T3-CT
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 08:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbG-000384-JJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hzgbE-0007F4-GX
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:40504)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hzgbE-00079o-6H
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 08:17:24 -0400
Received: by mail-wm1-x32a.google.com with SMTP id v19so1412946wmj.5
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2019 05:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2gP0cx4uDplBiygD47mSUk7dLMwgty8290CfBYV8M2g=;
 b=PbM/xu81GQZ1O9iHQvI+N7LirF8vBwY5r3EJh7Z4AXMvUGumEDmKmMmrI8gaZ+0E0n
 9CThyyDMPnS1iVsbOU+SzjmxBr10OK04JZQ0pCvGwBwIiAXgvWXwlk0uDGEGD4EBjeS5
 NjhUKQPl5kmmHsZ9VYq6I8fnrYhMt/1c8Fp+nkrbNsQ7Lgx9sgGEt7IPgV57xqMAVSjC
 3dAs2c6/4n3Gzzgc3A4wYt6a1/XbTUs7FreRpuj+Vm+UaY+zjc/FwnCYunC5j6m0ADmD
 M+rvoQzb1v/D6rTJMcVy4H7wcgcvE11hfPd+GaRLC4NNRA7o4JldY4NzgRidiFcG7vhc
 bHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2gP0cx4uDplBiygD47mSUk7dLMwgty8290CfBYV8M2g=;
 b=QhI1ygIJ0nizv2LCGY8WCDmxO8ChzcDE7mvtzT/uCq67F/Td2DDRmsMUxqqodbmHFV
 lwhIWBdWMHA42YukGHu5yI4gs9pfru8LpNsW7gQppzzhxhCatrjf9bRzTGtjx+wpQeM0
 S6NkolIIPR7mNDx4fXH1kf0sU39w+5jImn1FwMsHLTC0SaHraOtcmZWmct9fsiASwm7L
 5hT+hFp6Fg+LFCpHSrGJhYDus8eZg8YHHkbiETeSMVZxbpZyTfUu0EEJSIyFJHC6kUbe
 um9SJCTgLYWPmOqqUqqCJ5fvvR+PCasUXy8BPxLQP8//s/MCEvlldwBL3hoTvrc2RfqQ
 bjPA==
X-Gm-Message-State: APjAAAVJS/kPCVIB5AtxVj3yf4s4JAuMXMBFQWIEZ0nFtHsD+Kf89UzR
 TvYpcn2ycnn08oMQ0r4h8pyGwQ==
X-Google-Smtp-Source: APXvYqwh8Y88Op2VSc5CYUsozpdKrtwPKLAn9y2mM9oiJHNc7mhtt4lmLxrhYIkJBnO5FuYYVs9YOw==
X-Received: by 2002:a1c:7511:: with SMTP id o17mr7436598wmc.23.1566217036038; 
 Mon, 19 Aug 2019 05:17:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id e9sm18030475wrm.43.2019.08.19.05.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2019 05:17:13 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 991501FF98;
 Mon, 19 Aug 2019 13:17:10 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Mon, 19 Aug 2019 13:17:05 +0100
Message-Id: <20190819121709.31597-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190819121709.31597-1-alex.bennee@linaro.org>
References: <20190819121709.31597-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
Subject: [Qemu-devel] [PULL 08/12] fpu: make softfloat-macros
 "self-contained"
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The macros use the "flags" type and to be consistent if anyone just
needs the macros we should bring in the header we need. There is an
outstanding TODO to audit the use of "flags" and replace with bool at
which point this include could be dropped.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index 3a956736742..605c4f4bc62 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -82,7 +82,7 @@ this code that are retained.
 #ifndef FPU_SOFTFLOAT_MACROS_H
 #define FPU_SOFTFLOAT_MACROS_H
 
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
-- 
2.20.1


