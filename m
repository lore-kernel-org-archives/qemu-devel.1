Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207C7C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFF6721D56
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evYc8kRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF6721D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKxn-0005V3-0d
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZw-00023r-5V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZr-0001S5-Pw
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34024)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZr-0001Rh-Jb
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:23 -0400
Received: by mail-wr1-x444.google.com with SMTP id z15so11841245wrl.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ct264XXsXB4Yfv0geBlQAhYKTLlUfdyjxR0wyex+U9E=;
 b=evYc8kRjczeEQH2Qs21K6yiWdgRHCSLFFTg7G5An/ZueMmnxN6NYxn8rrBpSs5w5qi
 V4gFMh/g50lqoQ0JXvp4JHES/ijuxOqOEnuQhN1FZg9xYM2A5d7tO+uFSp/jRV6Tmiq9
 FUmZWjUoMEYQJ0/0z0q8V0qnKRtNqSRx7jvs9AQlNlPbZ2lbD/mUE9+0DriYO+ywZCV+
 aixZtGL/sC0ndqMdum5rUIFDxuJgu16Js/xQH+yLSji9JR6wGtV1alHJJtP08Ly/Opdb
 dB2Rg902mS3E7/gwWWfw2fc34+X2VBcVMlV1urcK8Y803KL8Ph2Ni8zyXmDFOkXoTRM/
 sdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ct264XXsXB4Yfv0geBlQAhYKTLlUfdyjxR0wyex+U9E=;
 b=QaBaOo8Ij4HE/9j3gFf9K/zzUC4f0/SfxP6V3V9WO0CpHC0EJT1Xo3MsPkj1YQ2KEb
 2wQu28puYOwc45k2cdNG8vVn+wSqKyksdu87u2+Qk6DrqGmZTsXVRNT0Ve1b2QO/iUDu
 ye/f5hDE4xChFSv5KcQm38P+D04viUAqj+GZDLOGYs+qsX3kNW1IHWscgH7TX4ciBlSi
 rzJOWlcBmjwE34DvZFZTP7dePpjNMcxOCxyqrzWOhwWVu1l6tOFe7Iye30lUgrWl8VPe
 IbkKpiyw6uYRHV0poQSefCZfgrSNDtRBa/8jawQL/OeAgp2Do1m+FPY9It4SO5hSL2In
 6ccQ==
X-Gm-Message-State: ANhLgQ3RImsTXsUg9QYSHU7iclTscgmD9OO83V11EdblgKtCl58nW/nN
 wGZUXa/Z2MAvIgYJvQH+Y0/y21n7Ki9Fhw==
X-Google-Smtp-Source: ADFU+vumDvYcQExR5DLOSsztmBV9p8Ir90H4ctmibCMxbrSd4vAYgERPM7aDqXId1wLKKhyQmFiFJg==
X-Received: by 2002:a5d:640e:: with SMTP id z14mr7288051wru.204.1583768662427; 
 Mon, 09 Mar 2020 08:44:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 11/18] qga/qapi-schema.json: Add some headings
Date: Mon,  9 Mar 2020 15:43:58 +0000
Message-Id: <20200309154405.13548-12-peter.maydell@linaro.org>
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

Add some section headings to the QGA json; this is purely so that we
have some H1 headings, as otherwise each command ends up being
visible in the interop/ manual's table of contents.  In an ideal
world there might be a proper 'Introduction' section the way there is
in qapi/qapi-schema.json.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qga/qapi-schema.json | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index f6fcb59f34b..d026f9478cf 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1,14 +1,18 @@
 # *-*- Mode: Python -*-*
 
 ##
-#
-# General note concerning the use of guest agent interfaces:
-#
+# = General note concerning the use of guest agent interfaces
+##
+
+##
 # "unsupported" is a higher-level error than the errors that individual
 # commands might document. The caller should always be prepared to receive
 # QERR_UNSUPPORTED, even if the given command doesn't specify it, or doesn't
 # document any failure mode at all.
-#
+##
+
+##
+# = QEMU guest agent protocol commands and structs
 ##
 
 { 'pragma': { 'doc-required': true } }
-- 
2.20.1


