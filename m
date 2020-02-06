Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D329C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF77920659
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 17:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHlsM+6G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF77920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izlAN-00073t-14
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 12:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzq-0006gn-LL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1izkzp-0005u0-DG
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:22 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36304)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1izkzp-0005pG-1s
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 12:31:21 -0500
Received: by mail-wr1-x443.google.com with SMTP id z3so8228132wru.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 09:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=m5b9v0wuyKNqpWeOyE8xHUhMyipBnsQwnLNyYq9bu2Y=;
 b=NHlsM+6GKSfqkkIZs/4+vH/wpV1UgzEoUMaEzfX+Xn82TVAneYAqk/tP8MbED6IOb5
 fU1zA2qJQO2a3npsfqeYM8x/xmGwxRMHgdT7QPDo6/zhCQ4p9jGVy/G/7Hs2IIXAKIlQ
 TNtpcnsrs+Yl/NQh8RIatMNxt42iG2b8P42gBmla5x4zYfnjwJpDq76xkglDtnXtyBtw
 Bp8qHYFm0QE3QQcmoyQ9uJd0Xu7g65reuHRDqMEhlGqskGeOHf3ay/CKUuvtVZOreSEk
 AVgIsB8BQpo3KfEqKaktziMLXAmI1hpFLeJNz6/26hjcMuQJVOPHtdnvTddFjZfSsGCa
 XUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=m5b9v0wuyKNqpWeOyE8xHUhMyipBnsQwnLNyYq9bu2Y=;
 b=hkeu7OfpgULivdqRaElw96L2S+NV5AiI3F8ecB3MZLomhK7nl5bMqZiRET/41I0Bd3
 8iRWT5gsQKKkTbQ6Crxua+iG9bHdEQRcb0SZHeJNKqtZVH94DAVxxvhklXEeupzBE4SA
 WqkRPK3zqd4KpDdqOwdVxvLal7aJF5jzsSOJHGUgmvEmewmXZH9pf2c7zCOqGTXNVODS
 zDGwl29JKyJqvImzfNJ+YMWkAN+4NahaRzSS6sxh0m1DRjIO0fvhh1qi63f238SqZ6Fi
 Hfu5RuaNIhYeoU1gFRk78ZvEqC0g47PvcdCHbLdB05ethOGdF3j0grt0ZLhDf7m+y9j6
 CWhQ==
X-Gm-Message-State: APjAAAVQd8b9JN3dc687HYVtviMJmRZz8YIi3LHXhZXJRf5u/qIF0JVi
 b8wg1yASqJOgI8dxLBjbQouXEWzENOU=
X-Google-Smtp-Source: APXvYqwygZGtUp/kAk7I3N5HU5387unoP3GLTPMtfkKLcpOSDYM5158fYciQ+EBJ22mzHR7pU9XS2w==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr4940464wro.202.1581010279331; 
 Thu, 06 Feb 2020 09:31:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w15sm5204214wrs.80.2020.02.06.09.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 09:31:18 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/29] qapi/ui.json: Avoid `...' texinfo style quoting
Date: Thu,  6 Feb 2020 17:30:24 +0000
Message-Id: <20200206173040.17337-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206173040.17337-1-peter.maydell@linaro.org>
References: <20200206173040.17337-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Avoid texinfo style quoting with `...', because rST treats it
as a syntax error. Use '...' instead, as we do in other
doc comments. This looks OK in texinfo, and rST formats it as
paired-quotation-marks.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/ui.json | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/qapi/ui.json b/qapi/ui.json
index 6da52b81143..92d409c32c8 100644
--- a/qapi/ui.json
+++ b/qapi/ui.json
@@ -12,16 +12,16 @@
 #
 # Sets the password of a remote display session.
 #
-# @protocol: `vnc' to modify the VNC server password
-#            `spice' to modify the Spice server password
+# @protocol: 'vnc' to modify the VNC server password
+#            'spice' to modify the Spice server password
 #
 # @password: the new password
 #
 # @connected: how to handle existing clients when changing the
-#             password.  If nothing is specified, defaults to `keep'
-#             `fail' to fail the command if clients are connected
-#             `disconnect' to disconnect existing clients
-#             `keep' to maintain existing clients
+#             password.  If nothing is specified, defaults to 'keep'
+#             'fail' to fail the command if clients are connected
+#             'disconnect' to disconnect existing clients
+#             'keep' to maintain existing clients
 #
 # Returns: Nothing on success
 #          If Spice is not enabled, DeviceNotFound
@@ -43,16 +43,16 @@
 #
 # Expire the password of a remote display server.
 #
-# @protocol: the name of the remote display protocol `vnc' or `spice'
+# @protocol: the name of the remote display protocol 'vnc' or 'spice'
 #
 # @time: when to expire the password.
-#        `now' to expire the password immediately
-#        `never' to cancel password expiration
-#        `+INT' where INT is the number of seconds from now (integer)
-#        `INT' where INT is the absolute time in seconds
+#        'now' to expire the password immediately
+#        'never' to cancel password expiration
+#        '+INT' where INT is the number of seconds from now (integer)
+#        'INT' where INT is the absolute time in seconds
 #
 # Returns: Nothing on success
-#          If @protocol is `spice' and Spice is not active, DeviceNotFound
+#          If @protocol is 'spice' and Spice is not active, DeviceNotFound
 #
 # Since: 0.14.0
 #
-- 
2.20.1


