Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B2C35E04
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F13C2084E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w79gtH5S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F13C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6b4z-0005WR-Lr
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apY-0006q1-U9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:05:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j6apV-0005K3-3D
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:05:00 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:41336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j6apU-0005JZ-Te
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:04:57 -0500
Received: by mail-wr1-x436.google.com with SMTP id v4so2012872wrs.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MdwVWEG8hNJRFTkFaf2CNe1RBfSUpiMOo7qqDUbXW8o=;
 b=w79gtH5SNijde6DCZVIBA8S5/L2vGg1f+cTC4KRGN09Z6/EdTn2Skd1y3jA4rTwODi
 2gmJwraalL0NlybFYJsxCSJz0p8JekbD+3lyLBfhz+S6MkZku//jv5QNg+/fPHgbi37G
 zoyZw/OFczQCrTaTVApJoH4ZrxwwU7ugfs7DhD0sqlcuAa+FwMRgbLmgUUTPXo3d+zBI
 hlDknMOzoXHin/ONTStqtNGRshSYfo/GE68KyrK8JPYD76L22SLoaw8bJwa+YSEoDlWU
 osZST5EAWs1/KA4dgazdDHL6jS0VJzMmgZekcItNaO1Cyrc94TOEzGlK/Ki1zv9DmIfs
 L3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MdwVWEG8hNJRFTkFaf2CNe1RBfSUpiMOo7qqDUbXW8o=;
 b=I/eShAVbJ7ih5uUdLsdePoeqOhT0g+G7boqUI4C3yKurFKyL2zhvKO+P/k259ENpr7
 xOTnZ17GlF8AmIE0Suu7ZcF0b7/FXYyR1lrvVk2l4Q62nl+oZN3Lo2nZ+vM/apijcq72
 Vb3b1UGRxUzgKQ0LnTeQpiW+Q7g66cVVRrF3wsMTdPO6qaRwJ5xY6HNM7eS1T7sZnnmC
 02eTShCyeGIZIQvKQd9xGBEvJgOpA0SyestHgjMrtpltxL99FY4fokVGBzkYb8YhuJ3i
 4oSC77eRtHeTMWxIYGx20eUw5OnwxP5CnAbaPHZLNwINd9/xixtoWsoDpxM5AWyY6tUB
 H8cQ==
X-Gm-Message-State: APjAAAURXrK1q/vDzZpn0GYE+MkR7BrYJ+YtKDGsbq6EJwoquJsxjY4H
 PYva0C+6rJkaA8uK4gwiapE7DOQmBIxiPg==
X-Google-Smtp-Source: APXvYqxItp8SlDevQ5svz2yGlP0xIuFCG+gE6T1dwfz1l4zhDDY3xkvh2cWHRDAITjtZTkjrohLNIw==
X-Received: by 2002:adf:9486:: with SMTP id 6mr14586521wrr.341.1582639495587; 
 Tue, 25 Feb 2020 06:04:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f127sm4322136wma.4.2020.02.25.06.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 06:04:54 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 09/12] qapi: Use rST markup for literal blocks
Date: Tue, 25 Feb 2020 14:04:34 +0000
Message-Id: <20200225140437.20609-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225140437.20609-1-peter.maydell@linaro.org>
References: <20200225140437.20609-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

There are exactly two places in our json doc comments where we
use the markup accepted by the texi doc generator where a '|' in
the first line of a doc comment means the line should be emitted
as a literal block (fixed-width font, whitespace preserved).

Since we use this syntax so rarely, instead of making the rST
generator support it, instead just convert the two uses to
rST-format literal blocks, which are indented and introduced
with '::'.

(The rST generator doesn't complain about the old style syntax,
it just emits it with the '|' and with the whitespace not
preserved, which looks odd, but means we can safely leave this
change until after we've stopped generating texinfo.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json  | 16 +++++++++-------
 qapi/qapi-schema.json |  6 ++++--
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 85e27bb61f4..0c9c21927f9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -550,13 +550,15 @@
 #        For the example above, @bins may be something like [3, 1, 5, 2],
 #        and corresponding histogram looks like:
 #
-# |      5|           *
-# |      4|           *
-# |      3| *         *
-# |      2| *         *    *
-# |      1| *    *    *    *
-# |       +------------------
-# |           10   50   100
+# ::
+#
+#        5|           *
+#        4|           *
+#        3| *         *
+#        2| *         *    *
+#        1| *    *    *    *
+#         +------------------
+#             10   50   100
 #
 # Since: 4.0
 ##
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index ff5aea59451..440fece703f 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -22,8 +22,10 @@
 #
 # Example:
 #
-# | -> data issued by the Client
-# | <- Server data response
+# ::
+#
+#   -> data issued by the Client
+#   <- Server data response
 #
 # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
 # detailed information on the Server command and response formats.
-- 
2.20.1


