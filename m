Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB1CC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD9C2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 15:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCnz51+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD9C2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47672 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMBs-0005Gb-6N
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 11:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haMAL-00045v-KG
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haMAE-0004h4-CJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:24:56 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haMAD-0004fS-5B
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 11:24:49 -0400
Received: by mail-wr1-x442.google.com with SMTP id m3so9649413wrv.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 08:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IgI2nYXtMTWQuZTo46tbwj7ydKAr5pCkN5Cp13BKZXc=;
 b=qCnz51+ce5UAT3cU/HBxcMyxzpuW93Q1N12QYcGSKlRM07DR04484zdYuU3HjOecOj
 EW2lVW+ZLhVzrrm3t2cMfcgNShY6gY2z1KKf6VpE2xiEXH4R5gpgYueviLZlCisZLntV
 ZU5aWioqaRl6aMdDeCjT2v1G0ReqwgzM6FP5mypdlQBT5a73OAiLdL99Z0kWySw7kHr8
 ivvLR1+WCJyHoSS4gdsJ+dVBy9PEY2WqbmGGsdpx7CIZ1RcI5GSZdmT6u56nhjZOv/Ne
 p0zHpRdt77Akj4QGPgh+EzGFGzJiPcaE1xMvcQ/w5Ws2hLUMHPG9VCilEKand1+H8IyY
 59Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IgI2nYXtMTWQuZTo46tbwj7ydKAr5pCkN5Cp13BKZXc=;
 b=VwSrV6n1M9CvO7ybIcC3yFwWG6VbclhA48YYfK65Z4LBevmV115Wtln2WKeH3KOd1r
 wKvZT7T3PVySSCtCkle3xT+5HBhXlspoIG41DJf4fm99p7O+RWbp3hxw+sI6FisuUJmG
 I41GxU/7Ai83+CwpTb8JM7sTUULV+bj6HjdbQrwHMNIU5VwU/vZFwzvJ+vTGxiIxkj15
 Edx0OMuowyhScsUdHA01WcSIS2cphDGDOuX1DetcJUt7vtBnvBiDgkNGzvHTVwH+vaV0
 Z7Q+ZDmPwPE/Xh0WfIifPVQ3bohEbY2FW0v/rJD1mZSz5PvIk5jOe1FYKI592gXu18p3
 hWAg==
X-Gm-Message-State: APjAAAU6cy7V1wPF4NPvN2w4a2vemquB5ffS5PaSw4TlcBNfXgIWB0Xt
 Jg2eSusP1u0xfzCH8+HblUgDJdvWDYkDow==
X-Google-Smtp-Source: APXvYqxkxhB+Bxei8PVYb4jshaBR+NAv2hfcQcGFDSdU/PXALPxcVyRcz6TRL/KH9W5u7GmYWg0bUw==
X-Received: by 2002:a05:6000:1289:: with SMTP id
 f9mr7319935wrx.125.1560180287503; 
 Mon, 10 Jun 2019 08:24:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b203sm11945920wmd.41.2019.06.10.08.24.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jun 2019 08:24:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 10 Jun 2019 16:24:43 +0100
Message-Id: <20190610152444.20859-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190610152444.20859-1-peter.maydell@linaro.org>
References: <20190610152444.20859-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH 1/2] docs/specs/index.rst: Fix minor syntax
 issues
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The docs/specs/index.rst has a couple of minor issues which
we didn't notice because we weren't building the manual:
 * the ToC entry for the new PPC XIVE docs points to
   a nonexistent file
 * the initial comment needs to be marked by '..', not '.',
   or it will appear in the output
 * the title doesn't match the capitialization used by
   the existing interop or devel manuals, and uses
   'full-system emulation' rather than the 'system emulation'
   that the interop manual title uses

Fix these minor issues before we start trying to build the manual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/specs/index.rst | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/docs/specs/index.rst b/docs/specs/index.rst
index 2e927519c2e..40adb97c5eb 100644
--- a/docs/specs/index.rst
+++ b/docs/specs/index.rst
@@ -1,8 +1,8 @@
-. This is the top level page for the 'specs' manual
+.. This is the top level page for the 'specs' manual
 
 
-QEMU full-system emulation guest hardware specifications
-========================================================
+QEMU System Emulation Guest Hardware Specifications
+===================================================
 
 
 Contents:
@@ -10,4 +10,5 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
-   xive
+   ppc-xive
+   ppc-spapr-xive
-- 
2.20.1


