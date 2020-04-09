Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F3C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0297B2074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 21:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iokV08AR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0297B2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMea0-0007Vo-2X
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 17:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWZ-0002G5-GQ
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jMeWY-0005rQ-9n
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:47 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:47076)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jMeWY-0005qa-46
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 17:15:46 -0400
Received: by mail-wr1-x433.google.com with SMTP id f13so7119786wrm.13
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NsgGnaK6H7tXZSUowxzbNGfoZoXPun4GYcBXJ76FIg0=;
 b=iokV08ARsSiWllJ9cOA3WSv7O7YlPfESa/gnZ4Jr2a14wQsD5Mju2H6CgmQnJwU2iW
 b5zuJTJk7+PJ137KF9mgQ1QQhiReONIFhcd/iCVjQRLo9kWeyYw+6HurYjHLvHofSGPc
 af6EnETKMHmGLkZZwDEKxtC/e0E+lUCAKM465sZhnde7FZ4H/gRHcWu2wXBllMxb97Am
 22DzvRGM7sxdvoDUmwFIU2OTJF5vKzMMR0WoSYdKJj4r/D69Nc1c7b0pWjgJitgeqV6m
 lLK0/KiW0XEmmnpg1GNsffZbQiTykkj/xz408UGAOpXFFJzR5XaiuhgMukAKIWHgLkxn
 JMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NsgGnaK6H7tXZSUowxzbNGfoZoXPun4GYcBXJ76FIg0=;
 b=fOtwgNaBosP5xHT00ghex701f6s1qAh1UyQ7DtJFvqs4r8rKWfFoybs3vxQ28zRPDZ
 VFHVvHqiVzRKLqSZs7jYEmCJZwyxD45zpgVeZRcHDQ8Rf9Ay41TJGJ4Xh/AC7w8BP0Qv
 7pYezF3/ejpEpGPuuNLJ7uB4SasO2+nqEXeasAgFQImjbtnxA36tyqFCD6jTkbpQcqts
 WXl3FiqAEMQPPTwBCGPodXykuN7vCEv4fMrVVMnB2J142xhMHBltIHaPhuGRQqnzBoZ8
 czSCc9PIYVUF9sLAWrc3FXHLMFx6ikWUPmlxKkue9evDemQSMHG9viVlb4nD44RsN+1e
 7rmA==
X-Gm-Message-State: AGi0PuarxtZFEeACruNd6L+r65bcXNn9M9r1jPw3tets3MqoBkGwY7JJ
 7ImJOx5e2RFOTZRZxXMowGgr4w==
X-Google-Smtp-Source: APiQypKoFD1XjBzu3LhzxvXwnZt5npJILuC62nU6zdHnVpG7eurJAW8SeitIbGFMV7841ambAvUPuw==
X-Received: by 2002:adf:e94a:: with SMTP id m10mr1130808wrn.324.1586466945102; 
 Thu, 09 Apr 2020 14:15:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o9sm36693010wru.29.2020.04.09.14.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 14:15:41 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0FA191FF9A;
 Thu,  9 Apr 2020 22:15:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 11/11] .travis.yml: Build OSX 10.14 with Xcode 10.0
Date: Thu,  9 Apr 2020 22:15:29 +0100
Message-Id: <20200409211529.5269-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200409211529.5269-1-alex.bennee@linaro.org>
References: <20200409211529.5269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Travis recently made a change which generates various warnings
such [*]:

    CC      utils.o
  In file included from cs.c:11:
  In file included from /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/stdio.h:64:
  /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h:93:16: warning: pointer is missing a nullability type specifier (_Nonnull, _Nullable, or _Null_unspecified) [-Wnullability-completeness]
          unsigned char   *_base;
                          ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/_stdio.h:93:16: note: insert '_Nullable' if the pointer may be null
          unsigned char   *_base;
                          ^
                            _Nullable

We only aim to support MacOS 10.14 and 10.15. 10.14 comes with
Xcode 10.0. These warnings are not emitted with this Xcode version,
so switch back to it.

[*] https://travis-ci.org/github/qemu/qemu/jobs/673000302#L1387

Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200409190618.7402-1-philmd@redhat.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 2fd63eceaac..7c92206ea33 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -272,12 +272,12 @@ jobs:
 
     # MacOSX builds - cirrus.yml also tests some MacOS builds including latest Xcode
 
-    - name: "OSX Xcode 10.3"
+    - name: "OSX 10.14 (Xcode 10.0)"
       env:
         - BASE_CONFIG="--disable-docs --enable-tools"
         - CONFIG="--target-list=i386-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,x86_64-softmmu"
       os: osx
-      osx_image: xcode10.3
+      osx_image: xcode10
       compiler: clang
       addons:
         homebrew:
-- 
2.20.1


