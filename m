Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962D9C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CFE208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LloJJfsA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CFE208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkLs-00012X-9W
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57854)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKh-0004dS-Lo
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:51:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkKg-00014X-OP
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:51058)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkKg-00013V-I6
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:50:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id v15so22272962wml.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1rdrIH3bm5qkuZl4p0xTWAvlSwsZzcm3Oz5u60m4FZ8=;
 b=LloJJfsA9sHBBM7peW5bhux7Tst3iGkBDy1wseASmAmsjI8YrQlcbYR6V1GgA2wPZZ
 sDvqVIcpdf6KdnZxFESbGTcQe3H15CAZxEhy5trw5RvWYc1CP0Ks8k+Kk69RyHDtd4Xy
 /FE1GBJmyJP63yHL5ylzgJ+DeRZDUA2ZKwKR/S275pZJnGChziss+WqGCASSiZ1GjmbA
 ANaH1934Ya5+hmjZ28R5hRmyuVJfhYhFIiOtVnCPepDqkZEfX5wLfy6jB8RjL4T+DR3L
 VQfFFOXBqj7WHExo7hQwQ3Hx9FOZ2EbGVvp7z8i1035rMaYnTl9EB5IPQ85OpOhbT5K0
 EkAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1rdrIH3bm5qkuZl4p0xTWAvlSwsZzcm3Oz5u60m4FZ8=;
 b=WVfJc33blBQInc+WIoBvnyD1spVNJGQgFuS8di7J6/ZPi0ffBVdHwh7ZJkr60els2c
 nhEMCiiBX1K8xZQh/mWaxwKcLzzcovJuqj0le2TaO80mzvsmCcwWm5XW2EHRcvh9bgbE
 m1DTaZWOgqNnzwTyIn13QHRgPxe+l02H9nZToq40Rg+0QSqxDG9FymxPgyxJEXRUoHvP
 4rciDJEgfbC8lIuYooYEYpqMal/5Al1PDp6uJYaMOB4+iBw7gCxCvmNjqHZjBsK/SGyP
 O9XKc5Y1B7h+sUvYlfre3G3C28pPrGc71ydC3SmCbxE+gYHImN3P/D7WHPtnWsTGeVt5
 SXEw==
X-Gm-Message-State: APjAAAWfHnDBTAVqprB+Xmeayx2rXQqCNc1UtOJuRf6N7dLaQTNBBkxT
 EpPC/uFtoBcLxgrOr03A6XfnSA==
X-Google-Smtp-Source: APXvYqwjJCTjYFCIBCznEYogriHzgdSkS6stpcKviC1YxVoRr3VWStNnZlB5TVqHfYXqtwODlgW1sw==
X-Received: by 2002:a1c:e0c4:: with SMTP id
 x187mr35258811wmg.177.1563371457347; 
 Wed, 17 Jul 2019 06:50:57 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id s10sm18975823wrt.49.2019.07.17.06.50.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:50:55 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0AB451FF9C;
 Wed, 17 Jul 2019 14:43:37 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:25 +0100
Message-Id: <20190717134335.15351-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
Subject: [Qemu-devel] [PATCH v2 13/23] buildsys: The NSIS Windows build
 requires the documentation installed
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This fixes:

  $ make installer
  [...]
  (cd /tmp/qemu-nsis; \
           for i in qemu-system-*.exe; do \
             arch=${i%.exe}; \
             arch=${arch#qemu-system-}; \
             echo Section \"$arch\" Section_$arch; \
             echo SetOutPath \"\$INSTDIR\"; \
             echo File \"\${BINDIR}\\$i\"; \
             echo SectionEnd; \
           done \
          ) >/tmp/qemu-nsis/system-emulations.nsh
  makensis -V2 -NOCD \
                   \
                  -DCONFIG_GTK="y" \
                  -DBINDIR="/tmp/qemu-nsis" \
                   \
                  -DSRCDIR="/source/qemu" \
                  -DOUTFILE="qemu-setup-4.0.90.exe" \
                  -DDISPLAYVERSION="4.0.90" \
                  /source/qemu/qemu.nsi
  File: "/tmp/qemu-nsis\qemu-doc.html" -> no files found.
  Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
     /oname=outfile one_file_only)
  Error in script "/source/qemu/qemu.nsi" on line 173 -- aborting creation process
  make: *** [Makefile:1080: qemu-setup-4.0.90.exe] Error 1

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-7-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f9791dcb827..5a462629370 100644
--- a/Makefile
+++ b/Makefile
@@ -1075,7 +1075,7 @@ installer: $(INSTALLER)
 
 INSTDIR=/tmp/qemu-nsis
 
-$(INSTALLER): $(SRC_PATH)/qemu.nsi
+$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
 	$(MAKE) install prefix=${INSTDIR}
 ifdef SIGNCODE
 	(cd ${INSTDIR}; \
-- 
2.20.1


