Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B60C5B578
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239F0206E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 22:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mSO8z0/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239F0206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi4QX-0007FN-Fb
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 18:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53001)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3UC-0005Ny-R8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hi3UB-0004OG-Ug
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:05:16 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hi3UB-0004MU-Dh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 17:05:15 -0400
Received: by mail-wm1-f50.google.com with SMTP id f17so976004wme.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 14:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=sgWf2P2ycpWcgSXDYsWUTZ5BfbzfW6NVgQcaK6lwObA=;
 b=mSO8z0/N9e+5E7XIA7S/ESajHceWVQS3SOEuGdXq0LyRfeKepCcDkfMzws8pOmgYWz
 7UCtMQ3exyS3a82tHOaxx6/NqvPkar+9LedhJa1+mkBA2xRCvFTltdZPhq2z/jHHsVNy
 usuG9bSYMZhfmDUmvA7gVAEt/bL6bg1MMThQP7R92Cu2J3D2Fksd+CeeEoRBXN3uhJ/z
 2jnS0cR4A3OepuPLh9tO9WJN98tXKD0G9LQXBgJ4TYYzdK3VM9V+BcwdskhzK78UAh1H
 G2U+CkQNqxGOSvOU4J0T/+xemoZtXtuAKIwWo5drZxFf9W0hs11USIVnXHyRdrJ4EvyP
 RVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sgWf2P2ycpWcgSXDYsWUTZ5BfbzfW6NVgQcaK6lwObA=;
 b=Jt1psAB3cWuHOmi5atNVx4VbJhwImRDbk+9SnNXH/WuJbgkopcx2AqiZqEGDo1Ip/s
 sUwjB8VzCNhlBEScEB3I43owd3dRoQpKv9UoqyCMIyQgbWQcSbLx72DVaU3Oxee98qrq
 kPGIqOHsTMdPFiJLffsZRYUjqfeKL1f8ZDlJFaFIfNZ3xLjkqeMcH0nMTYqQ2LzYpk+S
 2fmg8pA/BfJFJ6FWx6QFFfiamxE096z6GqRKKLuFuHl/ytomjUCeLzqUlnTJQVKdD48i
 TRVfk8CQf63V3v9XZvdAaR3esp+9w+sZMFbq5A63QrZdu6Topx2Y6IBo/58jGXQJWzxS
 LGgQ==
X-Gm-Message-State: APjAAAWC07HpSSiZ8Hd17OJcN69Au2bDAM9n4W2ApBiN2pijutylj4jh
 PGLS+XjQVL0LZPKG1gkQvo2Au9ZDHNOARQ==
X-Google-Smtp-Source: APXvYqzByxlkcrwqMECZHtBWX9/k8NsIC4KLv5PueVMijUF1v7ACLdjsoWGApQGKdFJ/92VM7BN4vg==
X-Received: by 2002:a1c:cb43:: with SMTP id b64mr141610wmg.86.1561999219809;
 Mon, 01 Jul 2019 09:40:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o6sm26573508wra.27.2019.07.01.09.40.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 01 Jul 2019 09:40:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  1 Jul 2019 17:39:29 +0100
Message-Id: <20190701163943.22313-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701163943.22313-1-peter.maydell@linaro.org>
References: <20190701163943.22313-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.50
Subject: [Qemu-devel] [PULL 32/46] target/arm: Add copyright boilerplate
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Robert Bradford <robert.bradford@intel.com>
Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20190701132516.26392-6-philmd@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index df4276f5f6c..d3f3cb57d5f 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1,3 +1,10 @@
+/*
+ * ARM generic helpers.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "target/arm/idau.h"
-- 
2.20.1


