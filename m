Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A0C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7596E208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gCalxzOK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7596E208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKs4-00058a-I8
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZj-0001oN-Ut
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZi-0001Lk-4o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:15 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43263)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZh-0001L8-TM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:14 -0400
Received: by mail-wr1-x444.google.com with SMTP id v9so11801686wrf.10
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rbxvM6zBsEyzHKe8nAvY0XhamX4FQe6hP23LCjFR3Y0=;
 b=gCalxzOKcZIo2PLP2rf8J/e6wKLB/lOa9oJ9DT7ZR8GEnZs+lMBlStAVNRYoqApTSH
 FJvsil4DjT6Aist5+MEhfm/n/eLthC7gTpgdvqvSdTnEGjcN0MNJh2sgBf0LLbwTi0nf
 xnfyyT4w/iKmiRfx9PyRKFKvAR+efeX7q8CpDv57Vkcx8hRdFEGXqX+Cd4YO0iSAbvku
 makHky/Wls/RZOjIe0mU9rnii4QiehXPbsMSZ92mzpIcHHOnE6Bf7sV4CzC9+5lLFB65
 FTmQahM+biEuKPbBV5XvLqD4jKrq0Q9U9u30xm/k9HCYiv+G7stZ021kII/1pY7f/iMA
 6WJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rbxvM6zBsEyzHKe8nAvY0XhamX4FQe6hP23LCjFR3Y0=;
 b=mkGDuwOLuSutxaUlrDFR9Nh8J0bI3lou7UuOUMEK9cbDCnM99Z5YOJU677DJpNmL5h
 SwCIgWWjrVCKaeweMqcImwvoopObH+uv1+yNcADur37r8gHwonEPblDPZImMvvYfynlC
 KjtW9KFhyycleMr5xfD3avO3dDcoONXGzQuD7yVGHdZEVt3zJdcH2eo6qs1Ih29wViab
 krsZN+7IcQQXDvGwpIacmsgHDr0tozFFZEEy/ta4VdvIFvuviDMVGfIIpCjsQaE/G08v
 lbj6B3OcjiNzNtsAxfCOU3dVS71em87Jy/VTwfU1T3JeEacjPm3x1A3eSnmDtC93SN/C
 80kg==
X-Gm-Message-State: ANhLgQ0iyWa0ELStebY6CLbYkG5WLcdOMpoRsuDiFOY5146bZe18IttP
 OPzec4qeWCVv1LkDLiLUU3K8ksYDnMDOLg==
X-Google-Smtp-Source: ADFU+vuWR2DlNsyb6fh83RJXvzdWdFh7wN1LQPOWkroPFEuQyRtxQvzDJdBYzb75eWRNs58Khc3q1A==
X-Received: by 2002:a5d:6141:: with SMTP id y1mr20572150wrt.146.1583768651950; 
 Mon, 09 Mar 2020 08:44:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/18] qapi/machine.json: Escape a literal '*' in doc
 comment
Date: Mon,  9 Mar 2020 15:43:50 +0000
Message-Id: <20200309154405.13548-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

For rST, '*' is a kind of inline markup (for emphasis), so
"*-softmmu" is a syntax error because of the missing closing '*'.
Escape the '*' with a '\'.

The texinfo document generator will leave the '\' in the
output, which is not ideal, but that generator is going to
go away in a subsequent commit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/machine.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 6c11e3cf3a4..58580602524 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -12,7 +12,7 @@
 #
 # The comprehensive enumeration of QEMU system emulation ("softmmu")
 # targets. Run "./configure --help" in the project root directory, and
-# look for the *-softmmu targets near the "--target-list" option. The
+# look for the \*-softmmu targets near the "--target-list" option. The
 # individual target constants are not documented here, for the time
 # being.
 #
-- 
2.20.1


