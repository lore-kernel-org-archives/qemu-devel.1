Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7E3C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6933520838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rG28sFKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6933520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl8Y-0003XK-Ie
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:40:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzo-0006fZ-4a
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzl-0005gr-9z
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:18 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:38357)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzl-0005d1-2O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:17 -0500
Received: by mail-wm1-x32a.google.com with SMTP id a9so991717wmj.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5mUsQje4Vxn3HIOn4m+YirZWxx0e2UfwIWtWTCNnLRg=;
 b=rG28sFKteKvDW4C56gkPydRex38f6gwl7bRyHnqhUSQwUPImCALIN5j+ya7sRPfBdu
 SkCGgUmNtfWSgvfJngqJ6cQShrXQxzcPU0OztWTctjFILlszYgdbtW0exLXg2BqmBhdw
 RrKGIWKWGzd7uWIecdua1gRcClg99GmCgvyzgNZeoTLoSRrgmMEIB7+tADSRzMlkF50H
 biBWSqkOlziwl1cySXALBnNZtfl+wgtQGiJyhYFWe2u+hYzNM0tOun2YlkcP7pFibIFR
 WnE3vFVUG0Gg733Os3OWSFvFYWWUT+yKgZieQol/K6AyjvKyMDs2RFKWDlxeFbFI1zi3
 D+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5mUsQje4Vxn3HIOn4m+YirZWxx0e2UfwIWtWTCNnLRg=;
 b=HRNOJo7ObggtSXkwdTmudvoRObtIrFU2aDj445TI4WiD8x7rpT75Zkgal2a2mWOt6f
 z50CC8LXk11s5YFHhZ+VWC9WvY0xTMjPMN+zGjwczBAId156z0tGpx/SCkZyAkRR4Afc
 Psg8y8Z7xglPuP8bwgEeQJGVTnyg9H3Y5lNBWxgnlZXkK4OMz+xJ2bHl4g6o1O1ByvPd
 KEfAhRyZHNK1mlAyUB9lvaMwwVuC5ARSb3wZo54AWtMvfU8lIk1X7DpmaCW8HgkGSIib
 QgStVhn5eaP7WL1fNynMMU6mAjz3qtyYXGMcyUgbXNsNNcvJAuPHWYSkE3TPbTnqeqZN
 1T8A==
X-Gm-Message-State: APjAAAVtvjGHbT1bSVm/oe5du0QPRspcquytijhiArI9MJKXvsz2TvWZ
 GLyUs+wxw35nZjp+eRr7gWNHeP4KlXo=
X-Google-Smtp-Source: APXvYqwQAmjq6REGNCsIHzsZjbMfeaeGjUWUEWRsEdfoG1FeBqbjOWoVHL8nsW737iWalSh6XFSwNQ==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr5662343wmi.70.1581010275290; 
 Thu, 06 Feb 2020 09:31:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/29] qapi/ui.json: Put input-send-event body text in the
 right place
Date: Thu,  6 Feb 2020 17:30:22 +0000
Message-Id: <20200206173040.17337-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32a
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In the doc comment for input-send-event, there is a multi-line
chunk of text ("The @device...take precedence") which is intended
to be the main body text describing the event. However it has
been placed after the arguments and Returns: section, which
means that the parser actually thinks that this text is
part of the "Returns" section text.

Move the body text up to the top so that the parser correctly
classifies it as body.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/ui.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index aced267a1e4..94a07318f55 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -949,13 +949,6 @@
 #
 # Send input event(s) to guest.
 #
-# @device: display device to send event(s) to.
-# @head: head to send event(s) to, in case the
-#        display device supports multiple scanouts.
-# @events: List of InputEvent union.
-#
-# Returns: Nothing on success.
-#
 # The @device and @head parameters can be used to send the input event
 # to specific input devices in case (a) multiple input devices of the
 # same kind are added to the virtual machine and (b) you have
@@ -967,6 +960,13 @@
 # are admissible, but devices with input routing config take
 # precedence.
 #
+# @device: display device to send event(s) to.
+# @head: head to send event(s) to, in case the
+#        display device supports multiple scanouts.
+# @events: List of InputEvent union.
+#
+# Returns: Nothing on success.
+#
 # Since: 2.6
 #
 # Note: The consoles are visible in the qom tree, under
-- 
2.20.1


