Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C82C2BA16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:48:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B7520659
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgTL/Pb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B7520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLjt-0001lk-8T
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55428)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKLjD-00015Q-3s
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKLjB-000092-Ek
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:47:18 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33836)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKLjB-0008TO-3l
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:47:17 -0400
Received: by mail-wm1-x341.google.com with SMTP id c195so2037785wme.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u+FnfsREkBRJl3VAFQFO7/rhMNP/gbYDcVI3CY4e8PE=;
 b=PgTL/Pb0SOeEMDUp0NePfinYOOQkE3a5HBzVeobNPbfD7pksOAt0+qo33w3g8H9Q1s
 K/BZ6BWnj5tSACiupDysAKCT1gg9cuEkTTZkWWCj7UfQLWA2xhihx0Lo0dg5corp3G0E
 9Neib7BRaRow0rg65Qck4lSUhyEc4R1ITpyERggUM5CZh7Mrukko7ORx/eN05loK+2F1
 a2NxeVK3XXYXt2XEmFckciNGBraiVsRs5qk8dGcd4gj5koeHh/+r8AypCR6TaUdXsNPA
 482mSP5nLlm1dAky6ve/n9Pq67kKb3bw4liAMNzOSZw+sg8XQv1zDs7ZVXZZAkko6yEw
 oaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=u+FnfsREkBRJl3VAFQFO7/rhMNP/gbYDcVI3CY4e8PE=;
 b=TzN/h5f/Q9AgIcBg62NjXXwcxiIuIhRUmrVArzYvfHJpgWE/+xU0u8jruRzTlQxy2c
 dl4qNoe9kJ8TUDDajLq9SUCnv3pb1naboR430pvihsvN1HYRnj22rGkMq1qRsGvx9WUF
 9w5RSyzjeWR1JibvQAJb5mR32MuVp/JgJEUgKW2151n0nC2UmY4qdi99RCB2ZGslDYX0
 vbMRfCWFf/NdZKbAfUpCwQKSul4eUlXVJo4aXhMUhalOleb74c4UhRSLszZAzj0tu65c
 c1x9ETbxOOfVt7j0M2gW+ChGoo5DzrFJahGGC1rJdnnxlFOZHqsz2vjjMLev2qFJ8oYo
 6Bxw==
X-Gm-Message-State: AGi0PuZMnxP0ofOmoccm5R0bDDu+HjTZ7wTbIfzYhkFPPsrqCIFvSLBH
 lWLkVcTkyg36lFsX9eKdcrec1A==
X-Google-Smtp-Source: APiQypJqpWBfRLylBDmEr2pEKkhCqUBhOBditRJXfMhu0VjkX/XVqkjHdawGGgjfr6TCVt7xkmX+Qw==
X-Received: by 2002:a1c:bb56:: with SMTP id l83mr1855836wmf.144.1585918034297; 
 Fri, 03 Apr 2020 05:47:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id u17sm12896255wri.45.2020.04.03.05.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 05:47:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH for-5.0] hw/gpio/aspeed_gpio.c: Don't directly include assert.h
Date: Fri,  3 Apr 2020 13:47:12 +0100
Message-Id: <20200403124712.24826-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove a direct include of assert.h -- this is already
provided by qemu/osdep.h, and it breaks our rule that the
first include must always be osdep.h.

In particular we must get the assert() macro via osdep.h
to avoid compile failures on mingw (see the comment in
osdep.h where we redefine assert() for that platform).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Reported via a random comment on our github mirror...
we should probably do a proper clean-includes run post-5.0.

 hw/gpio/aspeed_gpio.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 41e11ea9b04..e52fcfd9a03 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -6,8 +6,6 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <assert.h>
-
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "qemu/log.h"
-- 
2.20.1


