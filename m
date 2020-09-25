Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB933C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:47:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 196DD21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V7LMJc0S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 196DD21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqs8-0008CZ-Ls
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVf-0006pI-S4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51694)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVd-0006qj-K4
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:47 -0400
Received: by mail-wm1-x32b.google.com with SMTP id w2so3638408wmi.1
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=25BY9m20F0UzEdPJ4XVHRzjKq1kcqLKFnuqSO6foM7U=;
 b=V7LMJc0SH/KrNoOhaDblTimtLfZTqHIS5Qv2WRAZCiG46ZFJFHjNp34/vYNDSLn1CQ
 Z0pP/xB9/UQA1L2whFTNKhrsiOxiaRqALIjilzblWyOPT468+ioryiTqZVzD9te2WS2B
 hk+feWKMdOG1zqTd/PENuAAfyDb1kuonZ01IL/qI9SGYxUsdnQtfVos8UT2i7R8C1iNP
 Y+e2p24hueYItebGKUuqgmPwq3DeQ3m3zUCpEQIQJGeXgUFiHimV0CwI70XOwz6vWjRQ
 avhCJExohyMkPu4x65vPwjWO8hM5JgeVD7Mn/m+lUWuuQPfx1YCYuqEUDBVMGfCJOT6z
 Ck3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=25BY9m20F0UzEdPJ4XVHRzjKq1kcqLKFnuqSO6foM7U=;
 b=prOSN3kbEIWfRYgBPezgdK6oPsujGE3f8P1TRocdq+oeItT3IZ3ypyGOJN/3lxNy6k
 H65KdnwVHK24d3x0/9BaY6qUFtf3T1tBLF4TIJQRHTccQ1O244XkEjB18A6mWPxBoiNN
 1kEwwDxDueoSzuR3Ic8B51a9RM0izEWgRF9MDh7UD1ZADTMTffNuRnww1uQZvJcQwvTh
 nhk5LbKWKb0fGUSevZwwU9g0aXW0vWFVHBaEAt4bx/lGk6/Aj7QRIegRo+ZnUMoJQR7I
 +cDYKTuUML5Am1zMF4u0H1O32F8p00VIdQtZ/E4qf3XMqhOTllBbSm64v5PCHNk46Y5f
 qT5A==
X-Gm-Message-State: AOAM533BxZsJPnWavZLqhrscvM4XktK17Qi5/Hq66bxIeyXbj6B3dMrH
 S84g6Ou/w4XXJa7KjfnpIvGktZEFegHRkWad
X-Google-Smtp-Source: ABdhPJy1dL/KBbKc3Kle4EouFaQeLJVlTYmHrfn89uJ80k+KRZWJfKQmuSUPjR0bXPdAhGy2mE/I6w==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr3844075wma.132.1601051021547; 
 Fri, 25 Sep 2020 09:23:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 19/21] Remove Texinfo related line from git.orderfile
Date: Fri, 25 Sep 2020 17:23:14 +0100
Message-Id: <20200925162316.21205-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't use Texinfo any more; we can remove the references to the
.texi source file from our git.orderfile.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/git.orderfile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index a021afc2d51..3736c1d6aff 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -12,7 +12,6 @@
 # Documentation
 docs/*
 *.rst
-*.texi
 
 # build system
 configure
-- 
2.20.1


