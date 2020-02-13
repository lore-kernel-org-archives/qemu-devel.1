Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F42C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7836206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5uW4ITj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7836206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2InM-0005MT-12
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjY-0000JQ-NO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2IjX-0002WQ-4w
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:04 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:43693)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2IjW-0002TL-UX
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 12:57:03 -0500
Received: by mail-wr1-x42d.google.com with SMTP id r11so7776296wrq.10
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 09:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4JzfbSfaGdZz4al+lIjrQuS06F81QxSYycFR01GlxW8=;
 b=t5uW4ITj/cw5tMyjge1kQlVt5gRdlEpwv57S6oX3TLm/Go14RT+R4TZNWDz2hnYvsK
 uplfLm4aGKSSOPLXcA/ATvvx62aw3PzhRtUKEVIUZjpkRoas6vC+0VJLjVkmsrc27/6x
 nZFf+Q7fOUPOgSzrY0EnNkVf5dHoHRZoN8Ofeddf9NvrDb7O6SgpbT4+eQTiQ7+Obp26
 eEoM7pN2V8ne04LEU6XIP6KPRaSsJvvkI08YKVGxfdGhIA1/9MQEd9twz0hWKkmSI1Oi
 aoYuBawSyo7c1JRE9i6hNiAhYRHTjER7sl3XBFOPmWwS6MZ94uNJFs2ys/EuCDX3TFbF
 k8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4JzfbSfaGdZz4al+lIjrQuS06F81QxSYycFR01GlxW8=;
 b=eyNiTaGZVBH+7Bd+T1DkCwNdSSY5d14LXHYNshkkZX+C4Ayx8RA02ZgRWz7mK+Tu4e
 c0tNev8RvLVhNPiN4wsHclQNeanRskCdO6TnfDOq3lOPrCoUQUf8FaoVtDzw2GznqA89
 Sf6gHeYz90xiAN9wnFJff+xrv0sWiPVa8v5dKIoA6DShuTV7PBLeB/G35e4NwDnGAGxC
 tiDT5Pk4t6FB/5nKz3CZs7w3lSuLPut2dPDpvYwP5udDB+4rwQJkf7UAvUZYmcDWBxPj
 LBwU459CbbDb/C3CBXKp47J4tp3xCDNyg1G5ipL3OXQH6HArxMF1MQtyjPWIlxRoIZyM
 3qgA==
X-Gm-Message-State: APjAAAWOo1qWx0IlPRQGc2A84aD6+YEB56czYrKCCn3qigPEYrpaEMHL
 dPIQceVIETflwdms8YTu+Cm71ZYiZPY=
X-Google-Smtp-Source: APXvYqyKj1rSYYrLvD2U51SDhrigyhTuQXBsIdOYZd/q8wyErv3fh/JAgD3vMUIJ8rn9dArBhhizfg==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr22422198wrq.125.1581616619927; 
 Thu, 13 Feb 2020 09:56:59 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p26sm3692913wmc.24.2020.02.13.09.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 09:56:59 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 07/30] qapi/block-core.json: Use literal block for ascii art
Date: Thu, 13 Feb 2020 17:56:24 +0000
Message-Id: <20200213175647.17628-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213175647.17628-1-peter.maydell@linaro.org>
References: <20200213175647.17628-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42d
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

The ascii-art graph in the BlockLatencyHistogramInfo documentation
doesn't render correctly, because the whitespace is collapsed.

Use the '|' format that emits a literal 'example' block so the graph
is displayed correctly.

Strictly the texinfo generated is still wrong because each line
goes into its own @example environment, but it renders better
than what we had before.

Fixing this rendering is a necessary prerequisite for the rST
generator, which otherwise complains about the inconsistent
indentation in the ascii-art graph.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v1->v2: tweaked commit message, made graph still line up
with preceding paragraph text
---
 qapi/block-core.json | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index ef94a296868..db9ca688d49 100644
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
+# |      5|           *
+# |      4|           *
+# |      3| *         *
+# |      2| *         *    *
+# |      1| *    *    *    *
+# |       +------------------
+# |           10   50   100
 #
 # Since: 4.0
 ##
-- 
2.20.1


