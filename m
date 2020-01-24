Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2455BC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:31:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E585A2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 17:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKF4oxnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E585A2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv2nu-00013M-2g
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 12:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55081)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iv2mP-0000AS-Jc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:30:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iv2mO-0000v6-EE
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:30:01 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54355)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iv2mO-0000rv-7v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 12:30:00 -0500
Received: by mail-wm1-x343.google.com with SMTP id g1so226079wmh.4
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tb/hBOQ/Z9evM7DGTBEiJ196hd0t4e21Je7XZaNWrmU=;
 b=iKF4oxnWP84MlYolKGatOyonemJkmGoaSaAr03QZ+jEFV/fPGwHDv3joyiKk8BtchE
 MXq0aHW0nRB3CkrWaTO0CHfJ1m9GqwjyskLYnW+ZTiLRw4v1579ch1aVjpMjH0NH+pI3
 M0i78E8p7kTSi1yar2CRqdKMI2ldgtejlHSuoZjrTboG4c3uuTTo5mfge4tiXXDIuDZ7
 nzxa3i1nSmmtD24cDUDAQzHd7cZOQaOcKDBtT0jmRJMkBAC43XCGDsLISaY2IpURuWtP
 VNrnD/zFHFBlfGI+l5pZWe/vpncXg+5n7iGbY0joVERzrNJ357VwbwE12QTSZEP6l1NV
 gqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=tb/hBOQ/Z9evM7DGTBEiJ196hd0t4e21Je7XZaNWrmU=;
 b=NfpGW+xNSerhTY6spyJbQJt0rnGZQ2dLOnzj5eS6o6Hs9U9s1gxgJBPvxgnO5U86qC
 0Q7XbE40mCm5E2rMcyW7n3NgsFZs0o4arE9NqEPFq2AnNSli6Icn2+KQNOjX5cPmzLrA
 o/kMDY2NAE1Rph7bJg1u/lAE7JG0YsVG7x8n7IahF4EldkEC35wcZ9yRDNbsOKkI9zmi
 4ShuiTdT2j+/GKG0gMM2KuNBbF2X1RcfMLBgyIsf16FCx6mx/olijDgeS6nwKU00vrxL
 pJlpEPgZ+4nB2hfQUKJ0ijWbqNtVHhM3OI8EU+FRiofKUBzYpJzTOjdUhkhrCZuPNAW/
 eEdQ==
X-Gm-Message-State: APjAAAXe9tP8UK7NUGKPzOS0hmDyICgZS6B7kXBAjIp3olq3zWBRpAFo
 t7Jojv1rtvJvFIfo77JtQVpisw==
X-Google-Smtp-Source: APXvYqzprLQgzsPoOViMeaJTy2NsMFrgToy5Mi9igaT59v6tbvyEN1q4wMHhg2cSALLFQJvdkTBpEQ==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr246049wmf.133.1579886997665;
 Fri, 24 Jan 2020 09:29:57 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x11sm7501504wmg.46.2020.01.24.09.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 09:29:57 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm/arm-semi: Don't let the guest close
 stdin/stdout/stderr
Date: Fri, 24 Jan 2020 17:29:54 +0000
Message-Id: <20200124172954.28481-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The guest can use the semihosting API to open a handle
corresponding to QEMU's own stdin, stdout, or stderr.
When the guest closes this handle, we should not
close the underlying host stdin/stdout/stderr
the way we would do if the handle corresponded to
a host fd we'd opened on behalf of the guest in SYS_OPEN.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/arm-semi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/target/arm/arm-semi.c b/target/arm/arm-semi.c
index 788fe61b51a..8718fd01948 100644
--- a/target/arm/arm-semi.c
+++ b/target/arm/arm-semi.c
@@ -403,6 +403,15 @@ static uint32_t host_closefn(ARMCPU *cpu, GuestFD *gf)
 {
     CPUARMState *env = &cpu->env;
 
+    /*
+     * Only close the underlying host fd if it's one we opened on behalf
+     * of the guest in SYS_OPEN.
+     */
+    if (gf->hostfd == STDIN_FILENO ||
+        gf->hostfd == STDOUT_FILENO ||
+        gf->hostfd == STDERR_FILENO) {
+        return 0;
+    }
     return set_swi_errno(env, close(gf->hostfd));
 }
 
-- 
2.20.1


