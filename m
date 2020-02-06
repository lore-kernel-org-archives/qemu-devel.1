Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06BEC33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F4D420838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caW5XHqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F4D420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izl6E-0007l3-Op
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzY-0006UO-AV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzX-0004me-Ag
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:04 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzX-0004if-3H
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:03 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so864001wmj.5
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ssc89zv9+RZLwcUi0++cKCgLk2IYFvvZeGFDNP5kcHY=;
 b=caW5XHqQfUoLTPjn917Juh1gUyb8Sk1xcneOxhzBNUuJ/IxFgEm5zWR/gtaoEEh/yY
 IWwkKvQoNaMaK/82/tsVt8Sp7Xq5NKXglFiPR3g4wbFf1qX13eEmgrpFYTO66KR9KkmO
 m24gh4zAYn0fdYGLyk5OOPp9Y+gGw3ybFH1XbHQXICBVHP14oV7RFVznta7ALaidaLSv
 VW64aQIn7dUZxcWQ18bjUT68hh9jebqWM/zcW/PdesGCcp5oY/h0ATqWArhw/qWYJlL8
 Shh0NpsyJI7kfEBJgTwfh6zcV7gT+9jdRzE9dSBW2N/1aE9RLejnjiuiDIxVajCp7hji
 qeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ssc89zv9+RZLwcUi0++cKCgLk2IYFvvZeGFDNP5kcHY=;
 b=loLO5usjUtcGQCtgFi+HvRlS3WV9Gl+0Fel0XQT5x45bZxsZTkpyKGnzsZ+UcCS9WQ
 ACnhzDeIa0rlkfV4/nzlYiW9NSfA9iPoFuzTfilGkEKFsxyGuEKLPOKnp9WkcLJIA1YT
 3K5+/2zGX+rqCCRSUbZg5GFqufsCBn8RxtlfBNdgqvxZPXJzobEn4l6ZxWQ26yd5VQ+x
 KRb/OAvwlVhiTJv4IxEbAQa0zhPA0msAF0hXT80z2ESLfzAKKGY64a7HEku9bH7dnr85
 Yk164PBwrHlh/vzqNEUAC3euR6Zua6k3fptV/c6bdlVtrb64L/hmesYQKfasC11cceD5
 a5Qw==
X-Gm-Message-State: APjAAAVK+a6Q+QrYoD2yeY3PO3EmWk/b6Kao4hfRuoiJpJpOGLl3UdY6
 cJ9GEZ0AybXemhCdfBMZisz03GvP63w=
X-Google-Smtp-Source: APXvYqx/bznWD66zjFLVdYjXQjdoMOr0wpS85eAUhQzFNbyEkSX4pIEM9Quva4pYN4lqVGaVULHPSA==
X-Received: by 2002:a1c:a947:: with SMTP id s68mr5803956wme.61.1581010261044; 
 Thu, 06 Feb 2020 09:31:01 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:30:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/29] qapi/block-core.json: Use literal block for ascii art
Date: Thu,  6 Feb 2020 17:30:18 +0000
Message-Id: <20200206173040.17337-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

The ascii-art graph in the BlockLatencyHistogramInfo
documentation doesn't render correctly in either the HTML
or the manpage output, because in both cases the whitespace
is collapsed.

Use the '|' format that emits a literal 'example' block
so the graph is displayed correctly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/block-core.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ef94a296868..372f35ee5f0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -550,13 +550,13 @@
 #        For the example above, @bins may be something like [3, 1, 5, 2],
 #        and corresponding histogram looks like:
 #
-#        5|           *
-#        4|           *
-#        3| *         *
-#        2| *         *    *
-#        1| *    *    *    *
-#         +------------------
-#             10   50   100
+# |       5|           *
+# |       4|           *
+# |       3| *         *
+# |       2| *         *    *
+# |       1| *    *    *    *
+# |        +------------------
+# |            10   50   100
 #
 # Since: 4.0
 ##
-- 
2.20.1


