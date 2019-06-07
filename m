Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A931AC2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3774A20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bJLVZZVv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3774A20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEuv-0005qx-8P
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36533)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEs6-00050x-Pr
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEs3-00016i-3P
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:25:30 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34396)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZEs2-00010N-Pp
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:25:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so2198019wrn.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b53jbJsnq7vGq2viFuNl1rJj7DUNUyXcQI95wx3KSG8=;
 b=bJLVZZVve9x7KsGINygsnLYl5+ga2Mq9tuFY75bDFVSB9rBym94fFOI2fq7+RiLPYu
 Fwzjet+l0MUKzjX0FK45b6gXwIkVMmunKCDjqJu6jlsCyWo5DJlX284fGtbDcNp6BGYg
 lgIVpnfwyHGriow+g9pwWTnEaE0XxoabpcWER6GYgbhbMLX1Fdrk6+MNxOrrB7IRunB+
 F4vCgMnx3umcwgaC09fyBZtZSbMB04p9AscBZGDBLYU2T93wo+HoxkL5ilvFGyswp2Kh
 P6mnsPwUgaI+LEsrewwE4ZSM0p8FUsTVfLwQRg1KBlA/wjUVg2MIdtauaZe1+gBtSaka
 Hz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=b53jbJsnq7vGq2viFuNl1rJj7DUNUyXcQI95wx3KSG8=;
 b=i5B2Hi9GYzvDxpOL0I2/PL+8zBNT7bByO/9tFQgqpmZKj+gS5jp6rF7XpJ2dEpnocT
 WkLSVwqbRWlejK4/Of6aPpQwHVDvy2HrCMn6LZnYPBHkbwWJ6YJPs+qXQWdGSbhXQ1pr
 hM9mDTLH1wYMA6G4/FYJXExwiE9USqFyZPFm0AcL0fFbGAXNMq1NlYNJ76PYoLnsuzV4
 NH/FZ4iVBE90/eHU3gtt/9uPY9ccbdw8mq/G6PnlWBvrgxeHDbPxWTW1SwqvlQPsW3JC
 vYqtoIainvOOGr1IfqGvHzRW9f5a10LZoYR7aJvABiD7Lm+E91yLULSOmLFvslJmJ/9S
 iKOA==
X-Gm-Message-State: APjAAAWOE/zCL1cSv1/keFlMKjt/+6X+DLUxQNZqIdiZB6qf5RYTYxAz
 e2osF+D9NX8UTCIAc8g/ON6HFcmm83reYA==
X-Google-Smtp-Source: APXvYqxiQE8muxicDDs5CQB4pmyw6HkPheIJIHnXHvUbqqiZm0hf8ATEbWLXWlnxt5JGHacVaqPHeg==
X-Received: by 2002:adf:c614:: with SMTP id n20mr21042373wrg.17.1559913923884; 
 Fri, 07 Jun 2019 06:25:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z6sm1978765wrw.2.2019.06.07.06.25.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 06:25:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 14:25:21 +0100
Message-Id: <20190607132521.9637-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [RISU PATCH] risu: Include <sys/user.h> on ppc64
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
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To build the C parts of risu for ppc64le with recent glibc/kernel
headers, we need to include sys/user.h to avoid a compile error,
because sys/ucontext.h defines a struct which includes a pointer
to 'struct pt_regs' but does not provide a definition of that struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I need this to be able to do the ppc64le cross-build on my
Ubuntu Bionic x86-64 system.

 risu_ppc64.c         | 2 ++
 risu_reginfo_ppc64.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/risu_ppc64.c b/risu_ppc64.c
index 83f8d1f..a3028f7 100644
--- a/risu_ppc64.c
+++ b/risu_ppc64.c
@@ -11,6 +11,8 @@
  *     based on Peter Maydell's risu_arm.c
  *****************************************************************************/
 
+#include <sys/user.h>
+
 #include "risu.h"
 
 void advance_pc(void *vuc)
diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
index f9d2f0d..071c951 100644
--- a/risu_reginfo_ppc64.c
+++ b/risu_reginfo_ppc64.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <math.h>
 #include <stdlib.h>
+#include <sys/user.h>
 
 #include "risu.h"
 #include "risu_reginfo_ppc64.h"
-- 
2.20.1


