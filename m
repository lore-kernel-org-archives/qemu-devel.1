Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722FCC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02E70217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 19:04:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dG78deXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E70217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDZ3i-0005JH-V2
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 15:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmB-0002KO-RT
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYmA-000567-HO
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYmA-00051C-8C
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:46:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id r19so3926555wmh.2
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E0qQiftCyspeHjUyRAr2Q8QfbtfNGsp+y3+oeT7EpBU=;
 b=dG78deXcRnOZCK8zqV5bfi6ahzli5tGVAdNdf/NwQWqEfCCoGzcs5X54Q6BICUZKQN
 ZC1+Ib8nQm8hQetdDtWctTjIddERwZeF2SaNMR6ERHrCkkD5yK6Cv0LTdYo2cIoHYyY8
 znFo5vX/UqohgQWywFljnGs4uNhzkXLQzt5AFqsSxX1QgKByt4guDtXw9lpllllbI4SG
 ziLClRbaZwdznl9HUFlSqpBGYrn0WE0jlxLs685K+8mBAcGuCu7OIcM9xtrD5N8qRSrM
 QgxM+6Yj9kCJxG0CQI9biqQeF4HY0n88VUmUBsc0qO15nbEvcv5ogWf+/Xqa6BexxOvX
 kb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E0qQiftCyspeHjUyRAr2Q8QfbtfNGsp+y3+oeT7EpBU=;
 b=Ba8mOfHarjiW7XzXtS0vxiFTq+rneGHWf/XPDZ3lOm5zgPaKOwnV3SSUJg6InuT5Xz
 aSrtAKkeJU54v336ivNuokigbiWiRpdhPtf5V8rTrZTcXfVbkrOjyxer3wienXenHxCk
 lZToYT3S6PEa7hPFiGRSQ/BhZGVoqMX8Mp4RcAq6F9XWS5UOdGESCXk08rTs35UWezS4
 8oMh8uyoCFh+fZfe47NHTbLerWtyuBkYQ8spJqCfVgke2zSLlphzqeXjA0b7HC/ulFuA
 6zTULMqhy8H2nZ2TJLN3iu0p4GNcgJHNuqzUSgWpJmIidF/VVfseJRTt8pyEKe1GWQmj
 3aHQ==
X-Gm-Message-State: APjAAAVV2jtOKvvPgzHH2poLs6ksa//cbEYSs6e8vKM6AsjnqQx7R44w
 aW1ic+mi9PHkN70Vmwpc8Um4h7gJzVygUg==
X-Google-Smtp-Source: APXvYqyLS8KDH2aJOfux7/j0f30uxWQGvYphw9bLRIy/UPmcVAgZWuVioa5T++AB0PeuPdVoRWBO4w==
X-Received: by 2002:a1c:5411:: with SMTP id i17mr4138265wmb.170.1569523558343; 
 Thu, 26 Sep 2019 11:45:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm4886981wmc.3.2019.09.26.11.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:45:52 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 81E161FF9F;
 Thu, 26 Sep 2019 19:35:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 15/28] tests/tcg: re-enable linux-test for ppc64abi32
Date: Thu, 26 Sep 2019 19:35:40 +0100
Message-Id: <20190926183553.13895-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::333
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now we have fixed the signal delivary bug we can remove this horrible
hack from the system.

Cc: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 6b1e30e2fe..657a04f802 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -12,14 +12,6 @@ VPATH 		+= $(MULTIARCH_SRC)
 MULTIARCH_SRCS   =$(notdir $(wildcard $(MULTIARCH_SRC)/*.c))
 MULTIARCH_TESTS  =$(MULTIARCH_SRCS:.c=)
 
-# FIXME: ppc64abi32 linux-test seems to have issues but the other basic tests work
-ifeq ($(TARGET_NAME),ppc64abi32)
-BROKEN_TESTS = linux-test
-endif
-
-# Update TESTS
-TESTS		+= $(filter-out $(BROKEN_TESTS), $(MULTIARCH_TESTS))
-
 #
 # The following are any additional rules needed to build things
 #
@@ -39,3 +31,6 @@ run-test-mmap: test-mmap
 run-test-mmap-%: test-mmap
 	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<,\
 		"$< ($* byte pages) on $(TARGET_NAME)")
+
+# Update TESTS
+TESTS += $(MULTIARCH_TESTS)
-- 
2.20.1


