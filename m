Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51642C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:29:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 189D320702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 07:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K07VAVkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 189D320702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsi3C-0001Ag-Bs
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 03:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxs-0001Wc-Si
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:28 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:43983)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jshxr-0006gH-47
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 03:24:28 -0400
Received: by mail-wr1-x433.google.com with SMTP id j4so41598173wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 00:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gQ8vOrn8UzVSlnR8O9dGfbIrh6XgeWKqH3C6tmBlZYU=;
 b=K07VAVkb1kwsCPj34I4BuKcUO9oMG355TR8agcZ23u2cc+D1juVTfgXCJl4PTniMcz
 rfa09IAKcNu1eWNRHGJUcBaWp2TTdDQs16B/POtNxO07WHuMPP+SFEdXc2LgbqevS+/n
 VA51b+78HrrRFmLCt5EyFHce03XRYI+Jl+nyKJyZwiAOhaPC6YBE6kWDos1kQV6ZY4Md
 Pmcv5uE4M1d4rJqWIiUwLCP1o9xOOdjHZbnjTHUdxTZlTQ+wMA5yQvwJTojQokX4Zel8
 vfHy4H/RCPSDH68Pzfh2Q2wkduNNLfJ8tuMNkBmhv1bcFQI0E4h9FmEasYvoEft180+W
 nGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gQ8vOrn8UzVSlnR8O9dGfbIrh6XgeWKqH3C6tmBlZYU=;
 b=iJP6EUi6KxDqwwPd60K2YFV/bsqeDKwM2pOs4lXDFKit4wT/EevTO6LpvOX5Lw9b2T
 xRgWKD7MNcSFc4Z9mdS2hOWLAe+Fb6jOgaAneKRWbO5r2QJYhozWBtMAhXbVrvrq3qoN
 4i81r08ayktXmoDnA/0PVyFX4xzNDeKa9B4gzOa9aLVqQXcIDGLl6VZAJBwlCRZna4f5
 9BfFC8JqX+8qnN/Pj/IOgJkI4hr0hP2KSZ88DZ2jL0NUzWpsKA0pQZkb0M0qfwnMtGPJ
 tlzudCfmQUNk0myaW+zVqUrT+D76GMhD9uZzcwZ4eMaDb0kC1SkA8t/nROUm7tHKT9UF
 KciQ==
X-Gm-Message-State: AOAM530g/ZFgo4vo+mJRzjGSKxSkZHUIfds5UESwF4w9GqhOyKCFVaXb
 ukK91gvzbxEhK943tkIHiXD84F6+W/A=
X-Google-Smtp-Source: ABdhPJyzchFcZ00hBCyMcViTZJ4voFtwgPdH3FBqqwXMuYMlu2hUKKrJhKi14mkZtlyPmrWhmdKAoA==
X-Received: by 2002:adf:e546:: with SMTP id z6mr48953240wrm.99.1594106665660; 
 Tue, 07 Jul 2020 00:24:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 92sm29119733wrr.96.2020.07.07.00.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 00:24:22 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C8C071FFBB;
 Tue,  7 Jul 2020 08:09:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 33/41] gitlab: add avocado asset caching
Date: Tue,  7 Jul 2020 08:08:50 +0100
Message-Id: <20200707070858.6622-34-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200707070858.6622-1-alex.bennee@linaro.org>
References: <20200707070858.6622-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These can be quite big so lets cache them. I couldn't find any nots on
ccache in the gitlab docs so I've just ignored it for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200701135652.1366-36-alex.bennee@linaro.org>

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 257947853b72..13e9531724d2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,6 +8,12 @@ stages:
   - build
   - test
 
+# We assume GitLab has it's own caching set up for RPM/APT repositories so we
+# just take care of avocado assets here.
+cache:
+  paths:
+    - $HOME/avocado/data/cache
+
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
-- 
2.20.1


