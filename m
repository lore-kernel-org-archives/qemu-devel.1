Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73806C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:07:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D8520828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 16:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEKRq8iD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D8520828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKwK-00033u-G0
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 12:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZs-0001ub-Tv
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZq-0001Rb-Tm
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:23 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39299)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZq-0001Qz-H1
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:22 -0400
Received: by mail-wr1-x434.google.com with SMTP id r15so6771172wrx.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MdwVWEG8hNJRFTkFaf2CNe1RBfSUpiMOo7qqDUbXW8o=;
 b=gEKRq8iDoAqZkWTBvkuHXwNHCY68GM5AzQAThXtkGZWNiT4Y3xvqtEq9m7VFX/ZzBw
 wR13w7QPQyolMqockjEHsOvxRLU/Widh3owIt+YZUvt/WfFkLkeUabMFdO0oNZWFdDrP
 ImqIV2VFLJHya5g8I8UFCDgKWVc5QrcE59SXPRsgImT8tWtaQ6U/0g5RZbFTO0rMqHWx
 gkCv6yObbKfa6T1HEvZd6dXK1EYCGnZS8KP4TvctZ3FC2y5/TI79Wf82nzTwxiqUYWxT
 QooF+DSTD6XPt9/us2tAu/Egyja6VBLgmzkKRXZ7KUFdPOPaUkrheQed4W7LGwf9zipt
 1Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MdwVWEG8hNJRFTkFaf2CNe1RBfSUpiMOo7qqDUbXW8o=;
 b=ErxjfL6zI3Siq9WvwkprXzKI7bk/RO43pg2bRYVwlbSAmrhfRSRbSiRqI7+FuJUGUe
 ukPqKRW7Pb38YLmsUR4cLIk/r8yfpDL//Awua9e0/G//PHZdwwp+kg065eRVWnCCaW86
 BRTrlpRR3QJ6zX/RWG2er7e+z4X1IF3065/BEZPZY+7daldBYhadctt31/obOHQObBZR
 AhhpTAX7u6ERbpvPI+LjsYFaMmtv4d9XkEFB5/eyXfpp31lB6r8aQnuIV1OZeUDhKQXn
 aHw36wU3cNy77NZZe+u4voQ/MJ4ibMlir7OlpozddUcy6WGRT3i6Wm7HjUVxJ5RMsSHi
 FcWw==
X-Gm-Message-State: ANhLgQ3nYfFDfWeBZHtxFCDotZDtRC+QJGjVtN9yvBeR2oAnXn1ygCF9
 TYK+y1icYoeUVi/CUlQRPQ1qhLc2lP3t+w==
X-Google-Smtp-Source: ADFU+vsgdDwT0ukFvqOXftOTGTRnFvkqi1ICSrDx80fDr/iOG58ZKccaCUv350y6IXTFHbch8rDUUQ==
X-Received: by 2002:adf:e9c4:: with SMTP id l4mr9747058wrn.421.1583768661252; 
 Mon, 09 Mar 2020 08:44:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 10/18] qapi: Use rST markup for literal blocks
Date: Mon,  9 Mar 2020 15:43:57 +0000
Message-Id: <20200309154405.13548-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
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


