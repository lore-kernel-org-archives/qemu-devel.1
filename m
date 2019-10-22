Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:25:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95972184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 19:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPeUPUP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95972184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMzmF-0003Ug-1C
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 15:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzej-0002Tl-UY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iMzeh-0005Q5-KL
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:21 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iMzeh-0005Na-EC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 15:17:19 -0400
Received: by mail-wr1-x444.google.com with SMTP id a11so3238597wra.6
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ifdTWY7rA8JzLf+c4o7pX4/w+sZoXMC1jEUoG7lAHv4=;
 b=jPeUPUP6T0TNgGu6WSyoaEuW/ws6xMG3ufV7u/6Vsp3BrV0xLEedvQ5mcfkpO2DDbt
 JvAGXKz7YdkB+dxZy9ReQFLccX3feX9qd/cP/uPrLyg8e6IGl7ihM5vOlbO2xV+rjYvv
 cgEfYQWFYC0rGfX5CfG77aIb/VlDVZqLxKCosky++5hGf5dKp5QMP3sJeOaDxnqhjBCS
 CtoH5zJST4JoXvVvv+xq6FoeYBxCEfbnNaI/mAQQDdsN37MRcO/ZyI7XUyjiExImTalW
 cAw4J92rOCWLuX27LrT/+ui7uZJgYZtZhfm/7Dz9vufIRPbD+FIzAzC1NvDkVkH1++mG
 1C8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ifdTWY7rA8JzLf+c4o7pX4/w+sZoXMC1jEUoG7lAHv4=;
 b=BIc6SDj824tlPuVM0PvKAOIEmJa81D87iplX1VzuYA+Ii1CqnB5v39X6shkwpvXV7O
 89qF+2ThUH1gI2AcgUb5hd66iJksTGjIpbWj7UHTTPsPem4GFOLXDJxaRlfunUh2/a+x
 wg7JMg65/BQxHvOkJdyg6z83KTSfZXADHd7ONJD6ThrlTNTGd4M8HQzDt+mir6sEZgnI
 kPQnhRJmG5+ujmrGMbhV6usg6HZyvzFvY9YAdHxBuiTvO3Qj2fRZi6/7512J9m79mPdU
 +BDHcS1F5uEpJ2DNlTYQcnl88FJaMEC0NOZ+t3IZwSk/yaz4H2pGu/x24BsADaEQC+Mj
 BC3w==
X-Gm-Message-State: APjAAAXkevrnPJPVZ4y412N1iUbmiQsX/4eduzFwcmq2PS/IFalrWXfD
 WJOAIrL5Hb9srvpSJC+2ZXV0Fw==
X-Google-Smtp-Source: APXvYqzHxSsV236LaS9ViuVgyFPnP0sjA+pk37Cu13+vzYSAw3y2EEB2WOAkpEjVfNEQOPg/GPHjaA==
X-Received: by 2002:adf:92e7:: with SMTP id 94mr5185809wrn.199.1571771837272; 
 Tue, 22 Oct 2019 12:17:17 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m7sm20390526wrv.40.2019.10.22.12.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 12:17:14 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 833DD1FF9E;
 Tue, 22 Oct 2019 20:17:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 14/19] iotests: remove 'linux' from default supported
 platforms
Date: Tue, 22 Oct 2019 20:16:59 +0100
Message-Id: <20191022191704.6134-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022191704.6134-1-alex.bennee@linaro.org>
References: <20191022191704.6134-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, Kevin Wolf <kwolf@redhat.com>, berrange@redhat.com,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 stefanb@linux.vnet.ibm.com, John Snow <jsnow@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, Max Reitz <mreitz@redhat.com>,
 cota@braap.org, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

verify_platform will check an explicit whitelist and blacklist instead.
The default will now be assumed to be allowed to run anywhere.

For tests that do not specify their platforms explicitly, this has the effect of
enabling these tests on non-linux platforms. For tests that always specified
linux explicitly, there is no change.

For Python tests on FreeBSD at least; only seven python tests fail:
045 147 149 169 194 199 211

045 and 149 appear to be misconfigurations,
147 and 194 are the AF_UNIX path too long error,
169 and 199 are bitmap migration bugs, and
211 is a bug that shows up on Linux platforms, too.

This is at least good evidence that these tests are not Linux-only. If
they aren't suitable for other platforms, they should be disabled on a
per-platform basis as appropriate.

Therefore, let's switch these on and deal with the failures.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20191022072135.11188-2-thuth@redhat.com>
---
 tests/qemu-iotests/iotests.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 3a8f378f90d..75e64ef85be 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -869,9 +869,14 @@ def verify_protocol(supported=[], unsupported=[]):
     if not_sup or (imgproto in unsupported):
         notrun('not suitable for this protocol: %s' % imgproto)
 
-def verify_platform(supported_oses=['linux']):
-    if True not in [sys.platform.startswith(x) for x in supported_oses]:
-        notrun('not suitable for this OS: %s' % sys.platform)
+def verify_platform(supported=None, unsupported=None):
+    if unsupported is not None:
+        if any((sys.platform.startswith(x) for x in unsupported)):
+            notrun('not suitable for this OS: %s' % sys.platform)
+
+    if supported is not None:
+        if not any((sys.platform.startswith(x) for x in supported)):
+            notrun('not suitable for this OS: %s' % sys.platform)
 
 def verify_cache_mode(supported_cache_modes=[]):
     if supported_cache_modes and (cachemode not in supported_cache_modes):
@@ -933,7 +938,8 @@ def execute_unittest(output, verbosity, debug):
                                     r'Ran \1 tests', output.getvalue()))
 
 def execute_test(test_function=None,
-                 supported_fmts=[], supported_oses=['linux'],
+                 supported_fmts=[],
+                 supported_platforms=None,
                  supported_cache_modes=[], unsupported_fmts=[],
                  supported_protocols=[], unsupported_protocols=[]):
     """Run either unittest or script-style tests."""
@@ -950,7 +956,7 @@ def execute_test(test_function=None,
     verbosity = 1
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_protocol(supported_protocols, unsupported_protocols)
-    verify_platform(supported_oses)
+    verify_platform(supported=supported_platforms)
     verify_cache_mode(supported_cache_modes)
 
     if debug:
-- 
2.20.1


