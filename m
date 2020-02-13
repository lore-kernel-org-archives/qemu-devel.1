Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8E2C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616EC20659
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vy69K30E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616EC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2IvL-0000Vc-HK
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijz-00010f-7R
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijy-0003Qf-8E
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:31 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijx-0003OE-MC
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:29 -0500
Received: by mail-wm1-x344.google.com with SMTP id p9so7260530wmc.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ct264XXsXB4Yfv0geBlQAhYKTLlUfdyjxR0wyex+U9E=;
 b=vy69K30E8Tpow7RS6CiPJZqBqe3hGrvGx7JEt2rZiJfq/XEKyKSoqJgM7cqQNWy0om
 R8K2ScwnoNun3EBxvPvmqW7dvHS7mih3M5T9uQOyuxxObnvdWTUQv9fIULodbx54Dr38
 A8qYoI3czQtXZPGK5pvLqJprf3r7Z3KEaDoZt9XZ3rsvmIlUVhRN3Adq7735fQKJmEP5
 cN+y+CK6d7sPv8LviGHGRQdB/BBQ96d7n/YUt70ASj9dEzPDXARADZMOpBBBdM3bOmIk
 WWZNhgIWKPqwbVLZLdJ4dscdfG0MpO0vmjpjmX6kaEAj4sNSUM7z0+lLnkL2DMFhtBR4
 1j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ct264XXsXB4Yfv0geBlQAhYKTLlUfdyjxR0wyex+U9E=;
 b=PVHYjbT7gcpBoA80MLMl1+OrU/jrfsjt6MJLUwtqY1SQL6cQOWaP9zUOz2sZgbcPTL
 oX2eWmUUM4w4s3ey4oQeooTsnKyfwT9OnQZpzyoYtuFcXSg2BZWqMOo1AE/ocTo24FaF
 /aAbEt070XAUUWZKoQ8YEfiWjLXIy2C5ewZ/WqBvbFKf1exlEcX22vlrpkDulGBGTypu
 1csONl1FrYfGVzxYhIsvwET7b1lRlAo/PdWKLliOj8PTHYY21HMIjZl4DCHRzRvBlFFo
 f7BM1WB14QrZpy8Hje2lLD+5KitTPchdHQNxcai1yhyVL93123hGpZihDFR38H+Xtr+K
 JIGQ==
X-Gm-Message-State: APjAAAXtjJEhP2pLEfkgTlZJgvP2jGV8uDFZXpk6eM3fbabvbP1ZXF6C
 Z1vZArjktW9XT2MrKZ/DVJnYFio6Rag=
X-Google-Smtp-Source: APXvYqzWMKxWaYMNG0D1Yi5KNLoRFDPgWALnrabznY45XJjxyvlu0s55ePaCXVt8nFcUlRyOsfvZ8Q==
X-Received: by 2002:a05:600c:2301:: with SMTP id
 1mr7090137wmo.147.1581616648392; 
 Thu, 13 Feb 2020 09:57:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/30] qga/qapi-schema.json: Add some headings
Date: Thu, 13 Feb 2020 17:56:45 +0000
Message-Id: <20200213175647.17628-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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


