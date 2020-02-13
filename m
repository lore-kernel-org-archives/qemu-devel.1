Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCEDC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF5EA20659
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s0z6DGXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF5EA20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Iv1-0008KU-4l
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijz-00010Y-0B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2Ijx-0003QE-Oa
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:30 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:37695)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2Ijx-0003Mb-Eb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:29 -0500
Received: by mail-wr1-x434.google.com with SMTP id w15so7813900wru.4
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0wlRVtRJhL4sdvkTCyYM1sERkCXT4sx5Lv57A2FYC0k=;
 b=s0z6DGXxQ+Q0n7fR9h+n2+o3MJX9auAuuc8UaKzrcJfGa7cJ9tdZ2aqNju8Zfft1LP
 N4LkE9m9xM6aUUVAKFpiN+CnKEhPW6wvo2D6e1RtZFrUv0AcTHejNG4M0c9GJmCJKqEJ
 Mex+NXoY+nWEkRtI0JLzEkk4T53PGaOAIq60FWevFKPrgpkIXNl1VDye1GaAyOeXJxgA
 zyeXYLz+ZW8liLfckXp5+STqRwr1zaN/bRAes4X+ivYR45GPtFP9JqAvirE/j7+9HlDV
 c4i8twuf9H2gK8l9w8TA6871cZnq6TUB0eURjyonurk+CT5lBaTbxk4k94Sd0D+FNCHt
 Rglw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0wlRVtRJhL4sdvkTCyYM1sERkCXT4sx5Lv57A2FYC0k=;
 b=sQQtfdsCPEaG6cEk25JjFy763hHwlECJ8tHqnzHjdJHNfOMzfMWsphfCSBVE5AktHv
 FtWLK0IeDOJ3CfRvurLiqXnFzkqKZZLUHXn4CZTGS9cFs2DgUjaVmGgWJ+z8tzWksGqN
 aTlMSSLM7nhxcOmLODZhAvJgcfqw8nXKy2Z13jqflV7v+8iJqvIzIzhH7ZPCQeDFact6
 r18ZHSsYQqFOB10hSI5BxrfFqrGFUokCVEUcPe2mYGhFkXHw6rEhZbql89vzBGZnq+PR
 kL1/2b2RiCCgoUdFU22YCuIirtko1/EdxI2uM1dx7d0LP3WLKer8dcOvmYRDCay85C+G
 Xc1Q==
X-Gm-Message-State: APjAAAVqSDtm0lU2SPXxuF1jT/Qmv5vOisEQHEQBFZlXtTjC/VqIGajg
 vxKkLOSKZCv+N17ImGQfiDJRPRAGdzQ=
X-Google-Smtp-Source: APXvYqzMifq59Um0DkSaoqG4zbYSfzFJv0ayj7C3P1R+P9J9cAuKe6+AzZAv/XXawoCVhkEzP2rtkA==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr22059428wro.375.1581616647263; 
 Thu, 13 Feb 2020 09:57:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:57:26 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 27/30] qapi: Use rST markup for literal blocks
Date: Thu, 13 Feb 2020 17:56:44 +0000
Message-Id: <20200213175647.17628-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
index 13dad62f441..ea0371c33fb 100644
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
index f7ba60a5d0b..1d3fb573846 100644
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


