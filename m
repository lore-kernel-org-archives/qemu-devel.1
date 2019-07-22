Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF96C76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88FAB21921
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 13:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ivZBtC0T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88FAB21921
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpYAN-00036k-N4
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 09:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47659)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9E-0007RS-N0
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hpY9D-00037o-Ia
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:41467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hpY9D-000371-CY
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 09:14:35 -0400
Received: by mail-wr1-x434.google.com with SMTP id c2so36180355wrm.8
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 06:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Hw14cIX/3NJAwOvSYtbBmj2PFTe9lFHEo4DMf5Anj/o=;
 b=ivZBtC0T4v9meXB6zStybRdUhUQ00MxzlnrhUbOVPKmnVHVWHaVYRs8Cp8WWc4AGor
 BtTRNz5y5n9JeqPI0ynz8TMkru/C+0dzZ9zM0CjqE2KlPfiZCWB1y7+hiqGZgmdb5Cr5
 99a31K19Qjta8VP3t0meiNe7NQ1lZWMBmruXAICTHmvLZSWpcf1tRAwCJYv9ZFcAJ/sL
 8L+eHRnAbR9Zoml/gE5o1R5zG5V4UXptTd5qodZaTILCQ2NOaoo2CWNGEDhXiwT08mrg
 R8W1d/K6OIgZipL7y4X1X4Cckw6m3DpmcHa4kBFEgS78R7NMFItvduDgFKqavgJgZNqM
 BG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Hw14cIX/3NJAwOvSYtbBmj2PFTe9lFHEo4DMf5Anj/o=;
 b=WBkEM7g/9NMi2fPX6vZFS+4nvrCTAeG+mgIPIqzwOVwSxhAMieMeAOQuQdZu+ktNAu
 dPEKspWKGY3Bi4Ap3m8vze51+yR1d3/5PVmwz2MLWvxSq98yfnyxN4jSSYOgXtPKa+3J
 PN+RELiUXJCzUgSfDNv9pES33mNpgBA2pMBbPveHsmbQGKFYChMMpCdjk2eRJxSRcGX/
 Ly/8Zj2W9HAZRiWIlTU6awBPBzPoM8Na/D77pe6xxnKDsuiCvTq19Nmky5WfGzQxpJ9e
 uAPdmtvy2FMEQEFnMEs4x4ubsVaPXrlNMeoUfFnh1dJaXX02YIVxBpuesW5Smqe04i26
 MRBQ==
X-Gm-Message-State: APjAAAVTY3uzgWjvg85JaA3DCp3y8xlWRnhAKFGDWsBC2GicZJ1NDy6W
 Kzw3wv335y8I4dZjrRFyuAOAVQEqMJTYZA==
X-Google-Smtp-Source: APXvYqxyrJQ0xL99dnCU0g9qhLBQDYCGirYBrPM36O7NPRKcxS4qDYjocZ352ymfeA1mfu9E7DGHRg==
X-Received: by 2002:adf:ff84:: with SMTP id j4mr71517193wrr.71.1563801274236; 
 Mon, 22 Jul 2019 06:14:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f12sm42207217wrg.5.2019.07.22.06.14.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 06:14:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 22 Jul 2019 14:14:26 +0100
Message-Id: <20190722131427.2669-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722131427.2669-1-peter.maydell@linaro.org>
References: <20190722131427.2669-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
Subject: [Qemu-devel] [PULL 4/5] configure: Clarify URL to source downloads
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

If configure detects that it's being run on a source tree which
is missing git modules, it prints an error messages suggesting
that the user downloads a correct source archive from the project
website. However https://www.qemu.org/download/ is a link to a
page with multiple tabs, with the default being the one telling
users how to get binaries from their distro. Clarify the URL
we print to include the #source anchor, so that the browser will
go directly to the source-tarball instructions.

Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190718131659.20783-1-peter.maydell@linaro.org
Suggested-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 99c64be6b74..4d991511220 100755
--- a/configure
+++ b/configure
@@ -323,7 +323,7 @@ else
         echo "to acquire QEMU source archives. Non-GIT builds are only"
         echo "supported with source archives linked from:"
         echo
-        echo "  https://www.qemu.org/download/"
+        echo "  https://www.qemu.org/download/#source"
         echo
         echo "Developers working with GIT can use scripts/archive-source.sh"
         echo "if they need to create valid source archives."
-- 
2.20.1


