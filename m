Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9FFEC76186
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7517B208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 13:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DNjKcM3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7517B208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkFd-0004up-HR
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 09:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55376)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDg-0005AI-Kt
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hnkDf-0004Xc-I7
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44888)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hnkDf-0004Wa-Ay
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 09:43:43 -0400
Received: by mail-wr1-x442.google.com with SMTP id p17so24863425wrf.11
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=InzAQhPgsiZeCvOOwtFrju7Mpg22dwWv/LSowypdtzY=;
 b=DNjKcM3ehWpslSkLygsS5OXu26seAV70RnFldajuN/vwqcBgFh8e6IB5BCCylmQRLg
 0FJG8DGz3sWUPClchgj+mud/ksF3GnqY9804CjQR7iNQyl7x3iB5/4etyUJRmV6Rhvhc
 AwEr0N+mLeVLV9PEzuqMYWRGzUIhzUeZIkX/5TRvpgd4jmaL5WHn5IkkcoysjcVOongT
 5gJ09lGbtt1URiBkBEXVsb0GxdRuJYv++M5xYD+vJNOmwsnz3zIrSrcE2LtdchzrvJRL
 caah9WhL2JII2t50/vZx4BUadWU9x7wA8EbNsOc0oZUr+pmOWAb5PAyxWin6/3H0FlB2
 1zqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=InzAQhPgsiZeCvOOwtFrju7Mpg22dwWv/LSowypdtzY=;
 b=QRqFyY25xaWjWw87V+ACUycqmyPuWJdnQFsmNTgkBRGoaxxa7Ts4XFYWXp1pfmPImA
 7cDFp0w9WAYzr7lxmRKa8pTD5wpX+UJTD2Ca1/h0iRjT8GmJnxsM5dczHVRExqQ6unQ8
 XZ09yVilLB+lh5OY6IP+0HF+3OF1eLO5A7UltpH90agB03t29CJVv+69+THR6nhZYKDp
 226nnk1SuCer4Poh1e5/bWtUHQZ1AJgwlbMwvVSpHjOqlQCnCmdpfIyFzDiKYi9LmR74
 LPYhlP0Yidf9oe3S80g4wwEgdZB6gezuTj2YZ9YF1QyP2p6Xb0Uj2mXZLiejqwPGbfeq
 7cLQ==
X-Gm-Message-State: APjAAAVanq4mDoU0oD1pR0TgWs4Jr70Ffj7V40XB7zAPKE/C/ekOEmdc
 XbKFsqMkKSTEFiH2jxndlN4y2Q==
X-Google-Smtp-Source: APXvYqy5LPBdMcAgj56MRSOxH5MiBCt40udYnlio08uIiMaFamLUoaNxbFG2JJsth66+WJrcWlmfBQ==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr44802271wrw.304.1563371022261; 
 Wed, 17 Jul 2019 06:43:42 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id k124sm37486274wmk.47.2019.07.17.06.43.37
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 06:43:38 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 91C871FF98;
 Wed, 17 Jul 2019 14:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 14:43:20 +0100
Message-Id: <20190717134335.15351-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190717134335.15351-1-alex.bennee@linaro.org>
References: <20190717134335.15351-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: [Qemu-devel] [PATCH v2 08/23] shippable: re-enable the windows
 cross builds
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The pkg.mxe.cc repo has been restored.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .shippable.yml | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index f2ffef21d11..f74a3de3ffd 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -7,11 +7,10 @@ env:
   matrix:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
-    # currently disabled as the mxe.cc repos are down
-    # - IMAGE=debian-win32-cross
-    #   TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
-    # - IMAGE=debian-win64-cross
-    #   TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
+    - IMAGE=debian-win32-cross
+      TARGET_LIST=arm-softmmu,i386-softmmu,lm32-softmmu
+    - IMAGE=debian-win64-cross
+      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.20.1


