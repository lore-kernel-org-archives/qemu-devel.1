Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50759C7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E77122400
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eH2WthkL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E77122400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsB1-0003GL-UI
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37867)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9f-00062l-Li
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hps9e-0007Qe-EW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:51654)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hps9e-0007Ps-6M
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:36:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id 207so37997938wma.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HQyqOz02G3bFziBv9m62IDtJiMAsZS66su/354KrNr8=;
 b=eH2WthkLzyGU16o9xEWncuRO4tvUzNNBDoLToReS6mv5R8SiGxMd7WitV8HyWr8dt6
 tF8vIsmgcPs65EERTAHBrBRyMwSG1TCj9yfMyaVEi0uxVJuD536Ehi3r/oCxChyWi3Kh
 4HfnF3FhhRUPo1sHJaliaDfCjvvDa8y94WgHIEhWoBmlePvoZH/zcsN3ilezH2+ciTAY
 NUeJKwAsTcwyB7SH/Z5vO+7OapuyGrfNCR/DERBpUtKZ+Vd4+f+oOb4OOlhCL+p6+Pr7
 p0LSQHmnTVpbZWMZ8z6vp+Mt6XoWduSrdxeJX2jm7h2UiRxUv56ZqAAGWx5c1wCta9gH
 0Sqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HQyqOz02G3bFziBv9m62IDtJiMAsZS66su/354KrNr8=;
 b=azvYwQ5dSsOGy+Em5PO/1Sm6xGlpjHl7yjppVlwBEt2imBbE5WOhI085pbZK6JU/qd
 JPOrN6qUpLo7RWpIsOjzGfNRia067loXPZ8iwAtxKk0yK7EA77JYLix9tOv6LwctcYef
 SCwGP7vmPDnWPJ+2vAphjGXuEmfjkCt+gfyBZ1dFVQMXLgcWqdPaDflla9es3O020Vzr
 AqKbH/HPW13aMYbFr2ZbYx/Fbyk6cSbY2MI+zNlSYBTfC9a49HloAccoaoIz3E61Fh1M
 tu9sZq1gjViAxdPgVSfYqptHuOBjaog5iL4qZZIyJqEQj1i2QPqDeBYg76s7NsOFWEdp
 fNZA==
X-Gm-Message-State: APjAAAWJowbNq56SCA57Cfs0UOghslq8A/KcLI2LmxoZEgzXobrADvDe
 2UJpEW98eZN20IhiBtDkKgepIg==
X-Google-Smtp-Source: APXvYqxQZRpr8Jq2Xf256NV9rIMBni3Dfqih0egDcFY8nA0ce9bMujLCQUit46ziOsXFmwypLrrBDQ==
X-Received: by 2002:a05:600c:230c:: with SMTP id
 12mr66522064wmo.166.1563878181134; 
 Tue, 23 Jul 2019 03:36:21 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x83sm43239980wmb.42.2019.07.23.03.36.16
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:36:19 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5B2261FF9B;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:00 +0100
Message-Id: <20190723103612.5600-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
Subject: [Qemu-devel] [PULL 11/23] tests/docker: Set the correct
 cross-PKG_CONFIG_PATH in the MXE images
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

This silents a bunch of warnings while compiling the Slirp objects:

 $ make
 [...]
   CC      slirp/src/tftp.o
 Package glib-2.0 was not found in the pkg-config search path.
 Perhaps you should add the directory containing `glib-2.0.pc'
 to the PKG_CONFIG_PATH environment variable
 No package 'glib-2.0' found
   CC      slirp/src/udp6.o
 Package glib-2.0 was not found in the pkg-config search path.
 Perhaps you should add the directory containing `glib-2.0.pc'
 to the PKG_CONFIG_PATH environment variable
 No package 'glib-2.0' found
 [...]

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190715174817.18981-5-philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/docker/dockerfiles/debian-win32-cross.docker b/tests/docker/dockerfiles/debian-win32-cross.docker
index 77f5cc45e92..dc74ce7e0e0 100644
--- a/tests/docker/dockerfiles/debian-win32-cross.docker
+++ b/tests/docker/dockerfiles/debian-win32-cross.docker
@@ -11,6 +11,9 @@ ENV TARGET i686
 
 ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
 
+ENV PKG_CONFIG_PATH \
+    $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
+
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
diff --git a/tests/docker/dockerfiles/debian-win64-cross.docker b/tests/docker/dockerfiles/debian-win64-cross.docker
index 3908c5abc42..df7bfce7eab 100644
--- a/tests/docker/dockerfiles/debian-win64-cross.docker
+++ b/tests/docker/dockerfiles/debian-win64-cross.docker
@@ -11,6 +11,9 @@ ENV TARGET x86-64
 
 ENV PATH $PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/bin
 
+ENV PKG_CONFIG_PATH \
+    $PKG_CONFIG_PATH:/usr/lib/mxe/usr/$TARGET-w64-mingw32.shared/lib/pkgconfig
+
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
     apt-get install -y --no-install-recommends \
         mxe-$TARGET-w64-mingw32.shared-bzip2 \
-- 
2.20.1


