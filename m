Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE49C35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74AF521744
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9okzY0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74AF521744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6au5-00078D-KR
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apa-0006sL-8x
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:05:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apW-0005KP-Bs
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:05:02 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6apW-0005KA-4q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:58 -0500
Received: by mail-wr1-x442.google.com with SMTP id v4so2012959wrs.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ct264XXsXB4Yfv0geBlQAhYKTLlUfdyjxR0wyex+U9E=;
 b=A9okzY0Z0810WgmCdZy9+pPunrM2gq7VOkPqeMwQiN1H8OxYZitFfR1fyA55UkaBAG
 MDZ/gndSJr2y3eATJOZlNyR2KXAGRQjfleVTV9Pps8wjMyw57SgxeHXmvadc9sbbD2AV
 bEA/bJhMuLOfEeZO+z94fv6dSdsIzmkj5ME63aZQn6fnYgfYaSwPPGfRKtHAWgce0vhb
 e1NUSsxihI5EeMzkBTyUEDq7dUBN0HVUyDULMt7t/9ksMrb2jf6iCrZCSxXFFfxT1BSu
 qCowRnaKKzq7TmZUbmTyBGTt2OPkOpRP2BOj5ATbsmLLAoNlltFsj2yjpOzHlBInptIS
 7kCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ct264XXsXB4Yfv0geBlQAhYKTLlUfdyjxR0wyex+U9E=;
 b=XkZZ/CAymXeVdxIj5tCRwgcsylt91zNBYFRm6c1BMONSnhTWa+2/BY65yuvEKwEJPy
 dKTIiwL6ixis3lil17G8wx2zK9pVoFB7BGU3hlLY8t8PzeO3+/w3pdDcS70MOgGYgdOg
 jySBO74e16WMvXQMYdHNQeh4YsEpEO0hz7gXocxtfu8Ze5njtiq+LhVDDBRLwZ5KQwpN
 SN4LVNh/KbAxT4WNubhdsTTXE5KIxzJqes2ZkR81JM8oeAvN2FF7STuhcHHKBs9/ruxO
 oHHrQc1iV7osC2oJDAW8fPMBh1PeIGRocZySerFop2rX3AgbX/ke2NyMUul388MoenTv
 DlsA==
X-Gm-Message-State: APjAAAXvgklPNFoGc3UAkK7iGhRec/caOKVIGsW7egoteacZMhLtnrbx
 G4uLfZKbSk8GyPh/YTFsnfp4R5v2lPuUfA==
X-Google-Smtp-Source: APXvYqyy0BRSbES5IcsPtMWYPx2IOEkqlinv/Ia20uk5XvmQ2OyJmiSdsmBYVWOnlrtq/hcJiu0RSQ==
X-Received: by 2002:adf:efc4:: with SMTP id i4mr16582406wrp.225.1582639496845; 
 Tue, 25 Feb 2020 06:04:56 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f127sm4322136wma.4.2020.02.25.06.04.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:04:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/12] qga/qapi-schema.json: Add some headings
Date: Tue, 25 Feb 2020 14:04:35 +0000
Message-Id: <20200225140437.20609-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org>
References: <20200225140437.20609-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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


