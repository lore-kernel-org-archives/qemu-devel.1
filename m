Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106EBC7618B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32732081B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 10:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vQQcc/RH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32732081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpsGG-0007Qw-IE
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 06:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39708)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF6-0002YO-7j
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpsF4-0004Eg-1i
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:44023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpsF2-0004Bf-Tz
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 06:41:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id p13so42587674wru.10
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 03:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=VX71v+EX2x4zItmkCNQGjdxkkRKOaBoiHBHmU5C8mmY=;
 b=vQQcc/RH9uoNJcNUwJC/l2/wO450WSwrjbpzrwGju6XSPLaxKU0Jg2niKIzhBJ1j+i
 k9kl9qhv2tYOd9aoQ2z7PbtXL4lSrH5UgwxUAGyYJw/QJ2b6whbLKS7gC0sokML7QIN8
 LQxIS3VAdIUw71CJRZGaDUzcoAUrItg909WuDWeu6A4qibXuLLivDfMTeW7m54bwyALp
 FCveFbx5IKDrkc32g8UEIJPMR+Kp+Ksnv/dmCLjxf7y48uZEbVzsKLrOiY0QpxKjM5Al
 e/qf1TpA+L+nf1oHDCPqFH0/UdqYxri7KKoYhx0f3+hYLnxAcXECsB1U4B2CyJ0fonqO
 /giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=VX71v+EX2x4zItmkCNQGjdxkkRKOaBoiHBHmU5C8mmY=;
 b=i3htd9NMsn7KLo1tJuWL4+4gUGVp+8BiZLQS4JFDJjGfWDwwC3DZUy2oAMqw6b3kX/
 BhoxVXFKEUop7NmyLuudkhBXmsgkXvDm2jGDE0KwR3sG388XdLPTJixu3ntwbPFAaZQB
 u71jHEnlNj0glsxqNU8q1Fb5/17vHlG9rSr0clOGDkqcUhEz/1vH5Kf4FdLG+vEFobYX
 +nwAl/tpKoCwT2mvfyusFIs2kcZNGpL6tjChfnc4P+tZxcJMzOAbsKcTwO3WCoGtyfyP
 tMReETiOS2iILaMymRsNo5q9YVZ40R0hUkl+qvZ5EUAgw8ZC/Ik9tRaHJiZjn2uTBehH
 YkHA==
X-Gm-Message-State: APjAAAXeQL0XnxTUTdRObpvTBNiBoe/73AEgnOOLFvcqBpvm+Ex5CB4s
 omoGHXEGpxst8SxIDhZvQz0MkA==
X-Google-Smtp-Source: APXvYqxU8cfErnlEv2PdIo7q5mrqH+mVqIPChfEGpJApAVOrxQjlNhZpZzSKcApwzSA+jDnBIbPB3w==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr13766419wrq.110.1563878514687; 
 Tue, 23 Jul 2019 03:41:54 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x11sm30365330wmi.26.2019.07.23.03.41.50
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 03:41:52 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8419C1FF9D;
 Tue, 23 Jul 2019 11:36:13 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Tue, 23 Jul 2019 11:36:02 +0100
Message-Id: <20190723103612.5600-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723103612.5600-1-alex.bennee@linaro.org>
References: <20190723103612.5600-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL 13/23] buildsys: The NSIS Windows build requires
 the documentation installed
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
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

diff --git a/Makefile b/Makefile
index ecb788b2ce3..b3357691cad 100644
--- a/Makefile
+++ b/Makefile
@@ -1077,7 +1077,7 @@ installer: $(INSTALLER)
 
 INSTDIR=/tmp/qemu-nsis
 
-$(INSTALLER): $(SRC_PATH)/qemu.nsi
+$(INSTALLER): install-doc $(SRC_PATH)/qemu.nsi
 	$(MAKE) install prefix=${INSTDIR}
 ifdef SIGNCODE
 	(cd ${INSTDIR}; \
-- 
2.20.1


