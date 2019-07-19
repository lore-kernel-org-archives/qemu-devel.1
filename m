Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE33C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B2F2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wm7aj9VC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B2F2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPq8-00064e-Aq
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48860)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hoPpx-0005Wn-SZ
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:10:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hoPpw-0000EJ-NN
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:10:01 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:44595)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hoPpw-0000Cp-EK
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:10:00 -0400
Received: by mail-wr1-x441.google.com with SMTP id p17so31645291wrf.11
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 03:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dgMZNubiO0ugR6ooeWpNIQJoP6KamJlDRCWhG196PwE=;
 b=wm7aj9VCREcWwusk742W4RJbKZeAiv5h8YpDASo+EopQW7x55ZGDzSfswOzp0WVQ7h
 vni1uHbrgvs1U+GGo2fznAOlqiMow++P/9Bc5Ru6U6XcVLFXbzTt+ZpVARE5p5sLfJ5T
 9wTkVKlwrnoQntUa3ZHpOTO/SInIVOX7UgC+9OUBYgD2qmucXlVaW+JcKPwEjFF7pPRn
 RTNa/uDgIWv96AUuM2E5fJhEbrE1O+uduU1sp5eQ4o7wap+ulIVi//L5fwzFYXQ04M6r
 Rh5kkGevIe2sYzjNE0Boxv+kjp4oGqEeMzas9A34PIo26BajCaUAUArIWklb/3/kQQWv
 Wsvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dgMZNubiO0ugR6ooeWpNIQJoP6KamJlDRCWhG196PwE=;
 b=YKyHsRbbXmE0NX2ayINqjoCi69OrKV+k8PCeW/vLfJmzKF67/Fb6/rvy70MIWH3eyr
 STrmEJF4p+HmHsksjmi8usPf8CgHhWL2mpfRP+eHz6xW8Q9My4yqLfgJYJFH992FHmQt
 9neR6Y4gCvuw0H86S7vQHBU6yfGtDXpRizCqiSHyhAl/K+oNIgCDrVg1CyKtlnpKDgRE
 hVVW48JS0b13LAPZYplxofEZnRIjMbOm2AtdudPemaU+e47sQvGswkcdsR67U/4IXR8q
 QRN5U2pssg3xNg0QhqK4gkBOW1QZQm+bmzXwHKe53hOI3luAZxl944hkAMfnbOEo9OJY
 X1EQ==
X-Gm-Message-State: APjAAAWvW42wjiBreJxUVl+Y7mH51a4fjeXPjsIneMO/EFmB82aUOnEJ
 spQMGw0wr+lFwRl7BYbR2WrQS0WMCd6Rsw==
X-Google-Smtp-Source: APXvYqzRs1js/LXSnj1okNwzUmUR9pIJWhFO5+X1xXN5VAEGePsUwwKMqx4DUHN1/llSWxREU8/3Pg==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr55754277wru.311.1563530997900; 
 Fri, 19 Jul 2019 03:09:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm23846751wma.32.2019.07.19.03.09.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 03:09:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Jul 2019 11:09:55 +0100
Message-Id: <20190719100955.17180-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PATCH for-4.1] contrib/elf2dmp: Build download.o with
 CURL_CFLAGS
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
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

contrib/elf2dmp has a source file which uses curl/curl.h;
although we link the final executable with CURL_LIBS, we
forgot to build this source file with CURL_CFLAGS, so if
the curl header is in a place that's not already on the
system include path then it will fail to build.

Add a line specifying the cflags needed for download.o;
while we are here, bring the specification of the libs
into line with this, since using a per-object variable
setting is preferred over adding them to the final
executable link line.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I'm pretty sure this is what's causing the compile
failure described at:
https://stackoverflow.com/questions/57102476/qemu-recipe-for-target-contrib-elf2dmp-download-o-failed
I haven't actually got a setup that reproduces the error,
though, so this is tested by looking at the command lines
run on an Ubuntu setup that compiles even without the fix.

There's an argument for splitting this into two patches,
I suppose, one which just fixes the CURL_CFLAGS bug and
one which tidies the CURL_LIBS handling. But it didn't
seem worth it to me. Let me know if you'd prefer it split.
---
 Makefile                      | 1 -
 contrib/elf2dmp/Makefile.objs | 3 +++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f9791dcb827..27dabb9b1a0 100644
--- a/Makefile
+++ b/Makefile
@@ -626,7 +626,6 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-elf2dmp$(EXESUF): LIBS += $(CURL_LIBS)
 elf2dmp$(EXESUF): $(elf2dmp-obj-y)
 	$(call LINK, $^)
 
diff --git a/contrib/elf2dmp/Makefile.objs b/contrib/elf2dmp/Makefile.objs
index e3140f58cf7..15057169160 100644
--- a/contrib/elf2dmp/Makefile.objs
+++ b/contrib/elf2dmp/Makefile.objs
@@ -1 +1,4 @@
 elf2dmp-obj-y = main.o addrspace.o download.o pdb.o qemu_elf.o
+
+download.o-cflags := $(CURL_CFLAGS)
+download.o-libs   := $(CURL_LIBS)
-- 
2.20.1


