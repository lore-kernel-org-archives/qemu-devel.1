Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B4CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:40:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93F20206E3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 11:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bAaNGyfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93F20206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOJQH-0000xS-KY
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 07:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJNE-0006ru-Vp
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:17 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:46063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOJND-0007c6-7k
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 07:37:16 -0400
Received: by mail-wr1-x42c.google.com with SMTP id x14so1424080wrl.12
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N7PPeJC1OKIM9JRPrmuXjCWYgS6MY37EMLWsGNtfzJI=;
 b=bAaNGyfKqAYikHag9Fu3ERFv6pRoFX29e6p+mD/FOTKbkvmM3NHRXcvYKFBllRAmvG
 I7H3bStcDBAzAUFVtiPP5K2MUj113bVPz35UoXvCTDxw1WcJja3Olyl7h8cKl+pM/8Iy
 KXJKMC6TZWJH6ejyYo9T5CXGTYD00jlI+ppWJ2KUc7n9RkJO/s02HgS7y7Aq36keVafK
 /IShS9MuE4K5U9XiLe02aJI/TBOx2pjayx3KFQHVPbKWpLYSBugix+L/hl2nJx9fDnzX
 Lxv+vdYe4HHabhQLnzSIHHktthD3lST8FceFP3mIp1jRDZiT3LEboyVaDP+2AKT/4e5T
 JiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N7PPeJC1OKIM9JRPrmuXjCWYgS6MY37EMLWsGNtfzJI=;
 b=LS7RYnr+zkIm+JjqmoBEpY8Efpz3IZ+adVY3qBYHZAWTmgpm6uwC+LPUT2Ndh47ybs
 FpfcgxM8CC0AhvKQkBCzOcY1MF/0Rr0UEZvu+C0Q1FqDWBp5NRSQKtmmpuvAm1T3vkBS
 u6DBP2uPLovPNnarBiep4V3+XV23sZAAokWfb+r9jM5stXvXSb5Osy1eYb7C2YUE92Ob
 M+LhKmMD6FgIFGL0uKhEWGgbK1s/GRl5kzKA4NzTqqeFomf7vXqV7Qz7maPCC0+iiUNW
 +nGyVoDBU7BXhBmWwRu9tbXQgTiW2QGkRyIwxlJ8XGH68sSq6ntegKr217hs2cBr4P7i
 sBPg==
X-Gm-Message-State: AOAM531EFqBr55bBLHXsjeZ5uA/psjvZOgZAJbWJj6a77r8oXa78nf9o
 OhXTqXAJMgKYg7B9cPOwOfmcbQ==
X-Google-Smtp-Source: ABdhPJxiK3GPNJ/h2MgeCOJyTlhyJ7ljp6EWYsF6/aVZgAXv6TQbPAOp/Guut9Euyip9uWXrRRl2uQ==
X-Received: by 2002:adf:ba4f:: with SMTP id t15mr2458340wrg.335.1601638614884; 
 Fri, 02 Oct 2020 04:36:54 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h16sm1490075wre.87.2020.10.02.04.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 04:36:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C98C1FF90;
 Fri,  2 Oct 2020 12:36:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/14] travis.yml: Drop the superfluous Python 3.6 build
Date: Fri,  2 Oct 2020 12:36:35 +0100
Message-Id: <20201002113645.17693-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201002113645.17693-1-alex.bennee@linaro.org>
References: <20201002113645.17693-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Python 3.6 is already the default Python in the jobs that are based
on Ubuntu Bionic, so it does not make much sense to test this again
separately.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200918103430.297167-7-thuth@redhat.com>
Message-Id: <20200925154027.12672-8-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 65b825ff64..990dd11e6f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -262,14 +262,6 @@ jobs:
       python: 3.5
 
 
-    - name: "GCC Python 3.6 (x86_64-softmmu)"
-      env:
-        - CONFIG="--target-list=x86_64-softmmu"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-default"
-      language: python
-      python: 3.6
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       dist: bionic
-- 
2.20.1


