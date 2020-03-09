Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF55C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D617208C3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dRqpiM4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D617208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45851 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKnm-0007bd-Ej
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40268)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZg-0001m9-QD
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBKZf-0001KZ-AZ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50571)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBKZf-0001K8-3p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:44:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id a5so21325wmb.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1Remaj1t9s0XTf3rYRZM/hkzDh6VUoyVKKSoDw94y+A=;
 b=dRqpiM4caG60iyZrtncaCBddMtHWW3mv2niLPgKLAV67o7tUGgBI4InBmBuMgPxED5
 V7Bqt+Pl5dOCEJPU8+1NvahLjtZJ33sk7RTt2dJFv4lT4FSvKXKxYYTYc2jr+hCsnry5
 y949b7AW+XhLzVan3g3tof55QhBGC+uatExgF1BsdyyabBl9z1kolwsEIeF3jipey3sf
 4csG6ssMHHrwHUvVTItR4Qj9735mkbbGlmPemM8D3kmPH9WiML8CT1gL3cXKm0BirgPT
 CWn35jGnR1OrFJZ1ioT5nkYx6HQEELsrPMrKmWQp11Wt05bvGDHF0RIa/8otUp9zKz2m
 UqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1Remaj1t9s0XTf3rYRZM/hkzDh6VUoyVKKSoDw94y+A=;
 b=ExEo5f13386040SeYK4T4WDDRwdnCtIIwzeYdMuvLFpoo5xUXnHA3ZBWQ4HKlRT254
 eyWoE2qBAAbl5l6XAVYa9Ykg/xhSAY53KxiPMH002LIN1DpUzbsWLSwYqXhkPhk7IuKN
 yr3GKx5wtfyXylsjVjymtMPU4tFUtP/u1A6qjyPnXhF2pwJun8NE1GHbmPDNiuOOp054
 NcRPS/TzUT0ml/0zysLRc2Zy9Pq3YjN82VllA0HMVocoCjbPoKudtE17b4N7SsHdvVgs
 SfWRrANDLzY4FB7z2pAQIJjUbjaM8P+5Y5o/kCZc0n2wNwV1IideUvhIsDBXPjN+GCjf
 lKDg==
X-Gm-Message-State: ANhLgQ0nGPcSVxtejaQA9LbX0QOO6wZt0AgVPcJwwQKcvPLhZZxJK9/i
 4n/0Rz933BUalbOzvAxlCHVHDUwWtUclxQ==
X-Google-Smtp-Source: ADFU+vshtcbK4LjfVuVWhQ3zpobQzarx2FNs39Vdlq3BIElfuiQ5rlWQsIXVVxphfu/2U5Eckjgmcw==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr19878558wmc.129.1583768649533; 
 Mon, 09 Mar 2020 08:44:09 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d63sm25932166wmd.44.2020.03.09.08.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 08:44:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 01/18] qapi/migration.json: Fix indentation
Date: Mon,  9 Mar 2020 15:43:48 +0000
Message-Id: <20200309154405.13548-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309154405.13548-1-peter.maydell@linaro.org>
References: <20200309154405.13548-1-peter.maydell@linaro.org>
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

Commits 6a9ad1542065ca0bd54c6 and 9004db48c080632aef23 added some
new text to qapi/migration.json which doesn't fit the stricter
indentation requirements imposed by the rST documentation generator.
Reindent those lines to the new standard.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/migration.json | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/qapi/migration.json b/qapi/migration.json
index d44d99cd786..53437636a37 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -606,18 +606,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # Since: 2.4
 ##
@@ -726,18 +726,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # Since: 2.4
 ##
@@ -881,18 +881,18 @@
 #                       Defaults to none. (Since 5.0)
 #
 # @multifd-zlib-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 9, where 0 means no compression, 1 means the best
-#          compression speed, and 9 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 9, where 0 means no compression, 1 means the best
+#                      compression speed, and 9 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # @multifd-zstd-level: Set the compression level to be used in live
-#          migration, the compression level is an integer between 0
-#          and 20, where 0 means no compression, 1 means the best
-#          compression speed, and 20 means best compression ratio which
-#          will consume more CPU.
-#          Defaults to 1. (Since 5.0)
+#                      migration, the compression level is an integer between 0
+#                      and 20, where 0 means no compression, 1 means the best
+#                      compression speed, and 20 means best compression ratio which
+#                      will consume more CPU.
+#                      Defaults to 1. (Since 5.0)
 #
 # Since: 2.4
 ##
-- 
2.20.1


