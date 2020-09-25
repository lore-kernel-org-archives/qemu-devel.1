Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC359C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84CBA20708
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g9ki3RXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CBA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLq50-0000yH-LZ
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 11:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpyA-0002Y0-0s
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:49:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:40515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpy7-0000VM-TZ
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:49:09 -0400
Received: by mail-wr1-x42a.google.com with SMTP id j2so4101310wrx.7
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a1oClsqC0Jus89g3hfrBaMyM4864X7tFULVIlVAmDEU=;
 b=g9ki3RXU4kaHJ0pqVY+OckCldjvK0wP3mRFn8kstX1401P8jhS7jgWNK4x6xCE9gOg
 okN0F2bWrmAbmBMsjmDjWIDCvfuELqKXPssIrL32nyUMk+i8TvWE9XTW3qRoNVKH+1s4
 LwfqJ6jJCQM9cCSDAlcWZPMNCH5oPXJSlKFuM42nMMu/zcLrrUy2lnsW0vhEuA5vwKgf
 ajEUfNnbN5i7dVR3FzOjM1xW3GFv5f20bUg4GAxnApvxrLCZyoyypGVuTz8ndpdafPwd
 8ioLBh2RSrHqs0fKGXUks5EZ1P0BqtDE0jB170dRPqHs54C7kBsZbhXpY6BqEwVy7bZl
 FlJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a1oClsqC0Jus89g3hfrBaMyM4864X7tFULVIlVAmDEU=;
 b=UvW9R7AalcXvVRvvMApjhAb+PtPY71VMGCDL6oeoyris0J5JeC+9Zkju/JQnrUrLb3
 jXdqFFUx4MhlIMjipgc2ib0csKsOrK5oKBvp3WwEiqCgtWbJ0i4MFwGzm431ls8Fbpn5
 IjmNsN7/ahjHi+zP1cXJsfMVfkTXxj75aBl2BwAMe5ZsYO3rsWoLpLPCwB0Abx1iZTBG
 SAaQ1IHQYWM65YOpFH1Pkdepw+fNHhAWq/Ceog0q1F7nyBlFUWVSTcff/kVXkNE7mKLX
 IqW7jOY+W9FVfMghiPaL8mwdVZVrglXJopDt7aE+8FMpjU07GH68LLPeWJEmXLTYS/Zz
 OLUw==
X-Gm-Message-State: AOAM530zB7q42uVy5g8zU6QUzWrCZh/i0vFmp1EX766+eN23o07CiVgi
 KlQkBtlB6RUNVxdRhDj0iemtlA==
X-Google-Smtp-Source: ABdhPJyaKy24ARcDo2jKflNE1sBSIehz6uIXj+vxFIgr+bb8Aw9gcWUKYoD885DgMg330ClYWTc1YQ==
X-Received: by 2002:a5d:56cd:: with SMTP id m13mr5026148wrw.261.1601048946237; 
 Fri, 25 Sep 2020 08:49:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm3226507wrp.84.2020.09.25.08.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:49:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 298481FF9B;
 Fri, 25 Sep 2020 16:40:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 12/15] shippable.yml: Remove the Debian9-based MinGW
 cross-compiler tests
Date: Fri, 25 Sep 2020 16:40:24 +0100
Message-Id: <20200925154027.12672-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

We're not supporting Debian 9 anymore, and we are now testing
MinGW cross-compiler builds in the gitlab-CI, too, so we do not
really need these jobs in the shippable.yml anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200921174320.46062-5-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .shippable.yml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/.shippable.yml b/.shippable.yml
index 0b4fd6df1d81..14350e6de8a1 100644
--- a/.shippable.yml
+++ b/.shippable.yml
@@ -7,10 +7,6 @@ env:
   matrix:
     - IMAGE=debian-amd64
       TARGET_LIST=x86_64-softmmu,x86_64-linux-user
-    - IMAGE=debian-win32-cross
-      TARGET_LIST=arm-softmmu,i386-softmmu
-    - IMAGE=debian-win64-cross
-      TARGET_LIST=aarch64-softmmu,sparc64-softmmu,x86_64-softmmu
     - IMAGE=debian-armel-cross
       TARGET_LIST=arm-softmmu,arm-linux-user,armeb-linux-user
     - IMAGE=debian-armhf-cross
-- 
2.20.1


