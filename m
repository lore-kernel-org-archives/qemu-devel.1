Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD68C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:43:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EBC620838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iH4cPz1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EBC620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlBv-000283-4N
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:43:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43595)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl06-0006oZ-5W
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl03-0006g3-EU
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:38 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:37717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl01-0006OA-KV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:35 -0500
Received: by mail-wm1-x32f.google.com with SMTP id f129so997547wmf.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/klYbU+bqniRP71Sh9fNzl1GvlwCTSWPu2kdq/jHKgU=;
 b=iH4cPz1hfm8vkCp9iBLT6jQFV5md2N/TDCJz/BmjO8Qt+XCeemB4iSagE4yAiyYgAv
 v+XAfAJNvfxiIEbn47UL57kGhJMy/WBAZf01QXtPyH2sugVCvij6BU00/wH99jgk7Bvt
 03tEXWnOTRltbk70EurgeIhDhrte/nOKiLNtqaeVaJo2W6zBEaceHwqBHfH8Q0rN8QEU
 /jQsVSak+QD5K9623FGpOJ3YEDWHE6d0vQFHuxmZquzMFzc1qArXHo5tUbxGn5BBtFdq
 t8Vwu5DvXaU+iGmRaOPI4PrBXquFFu6THk4ZvVdB1KLWi5k3C6bbZKXsL2es8sqJ3IC9
 HdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/klYbU+bqniRP71Sh9fNzl1GvlwCTSWPu2kdq/jHKgU=;
 b=ehHVR1Bt72Sx8vz3M8TZL2zP+8B67uwndywG+FKRfPsU/8AfYzfVVnO/zvGP2m5V4U
 Vx9MRpEHI8DhUFKaiBXG68kJl/8ptIOqnJmhBjomCKOQru0apY5v2c0/APVXBG8XUJTA
 fzMYh9gZq5wnf78TEjRXAkiizkjUwwgFJzf3JsyuS76ZikuLBNx9F2mg4tzOK4NndU14
 329Q7kiGKvdcdkboPVRaXOVGYkAMJftt9Q+5OYY0TqRXWoLwD9H01UcTRk4JI8a7/cbx
 7yy5CHLgS8CHKH/lj4UAInKBNkohYZQe8H/4AjYZH68us5gB0nYR9x8Y0hJ/ftlGqUNg
 eldA==
X-Gm-Message-State: APjAAAVwcGWyyvT+4RTSIyaSqWT4MikIjqjr51sq+J/kfu6aD8WT9jm7
 NwO6+KVFfDcDvfz1NwNOwP1DjjSBLjs=
X-Google-Smtp-Source: APXvYqyTWrRnUi2EVfsRbMd1tMYIeQsORi9Kc3tPkPz7g5iRWsQbclGrFmlE5zYeSeS5PDg5nMs12Q==
X-Received: by 2002:a1c:a947:: with SMTP id s68mr5805949wme.61.1581010287744; 
 Thu, 06 Feb 2020 09:31:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 18/29] qapi/migration.json: Replace _this_ with *this*
Date: Thu,  6 Feb 2020 17:30:29 +0000
Message-Id: <20200206173040.17337-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

The MigrationInfo::setup-time documentation is the only place where
we use _this_ inline markup to mean italics.  rST doesn't recognize
that markup and emits literal underscores.  Switch to *this* instead;
for the texinfo output this will be bold, and for rST it will go back
to being italics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/migration.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index 11033b7a8e6..52f34299698 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -178,8 +178,8 @@
 #                     expected downtime in milliseconds for the guest in last walk
 #                     of the dirty bitmap. (since 1.3)
 #
-# @setup-time: amount of setup time in milliseconds _before_ the
-#              iterations begin but _after_ the QMP command is issued. This is designed
+# @setup-time: amount of setup time in milliseconds *before* the
+#              iterations begin but *after* the QMP command is issued. This is designed
 #              to provide an accounting of any activities (such as RDMA pinning) which
 #              may be expensive, but do not actually occur during the iterative
 #              migration rounds themselves. (since 1.6)
-- 
2.20.1


