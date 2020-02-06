Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4078C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C6E20659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hj+8A4MG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C6E20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlC4-0002cK-QK
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izl09-0006uu-AE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izl08-00071R-5Q
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:41 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:42904)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izl07-0006xa-V3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id k11so8181586wrd.9
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=r46aBihEOGQbzY2WpFB3AupNkAhrK/38I7UbJd+jXYs=;
 b=hj+8A4MGp5X+dxRQ1rF1O0gSrKg3TP0Jn6m+dX9hjIgl9pmrFNY9FA+vqDwmNG77pc
 JfbSerHKFnq9kWU2fypJ60cipFsCpMssa44FDAGclNeb8Uxn+Qbscy2/1+M74rmXWrig
 WU8UC6PcJo/2QIN5KMWIO45Ak21Lzgy4l/5pb+GxWIHVmcC9Srg9EbhK61zMb9x4bmpR
 kz+eDrixeMP5SuURsHPp5q6zWRqtfEFS4fIZq6FkQ8SNj9lUQaVo1PgHZvgKjgm6zXFE
 8QIKihCxs4pQV72PhC/C8yfjZtq+9r5SESDhfsZGTwmrmHoNEh7vMtiyRXMP1/9PSpiQ
 jQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=r46aBihEOGQbzY2WpFB3AupNkAhrK/38I7UbJd+jXYs=;
 b=Ej7sM9/2M+YnS2MQRgCTEDT/FgOVHIDiXBEjd4l0VRDnjkzipM6kurdM20wJkUAPUp
 1PTvdqMETzJcfFghsW30k48STIOpPKsCZXjViDbZtz3/Zu/ogLiOyR73PaIiu8krlhbM
 0tuRSNMYPp/EtgtOSfB2A7xQLAboMeR/W9Mz4zJhAbNXZgyMq09mi2Cmxg+DcZro+a2m
 CgiiWSZvPXcBi4hv4yCwIpcuoUN7WX/6vx+OYgSYG/sjM1muBaGoIB1w9gzfsuiY3iGe
 QFWpyBnKdKPB8qiV55+PkePIsKvFo+JKdP7005Ern3+F+cQe5qpglp07UYlti6ve0Mcs
 M8mg==
X-Gm-Message-State: APjAAAWKkkDDMHEJucoOKWYUbFwd9BArU8nENtJhkB37Ml/dmDKStUrN
 T1n1AR9mcAcPUGceEAFGPxYkIF6nkFk=
X-Google-Smtp-Source: APXvYqzs0mvO5/zCHku5GsDQ7WHZeSJuxfGbkWshMkIbAOhIsGAA5+4iqrCHVSlPmDax262hKE6Q3A==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr5226789wrr.204.1581010298564; 
 Thu, 06 Feb 2020 09:31:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 26/29] qapi: Use rST markup for literal blocks
Date: Thu,  6 Feb 2020 17:30:37 +0000
Message-Id: <20200206173040.17337-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42b
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
index 092cd8f13d9..ea0371c33fb 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -550,13 +550,15 @@
 #        For the example above, @bins may be something like [3, 1, 5, 2],
 #        and corresponding histogram looks like:
 #
-# |       5|           *
-# |       4|           *
-# |       3| *         *
-# |       2| *         *    *
-# |       1| *    *    *    *
-# |        +------------------
-# |            10   50   100
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


