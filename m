Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1380BC4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E174235FD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RuHTMNDq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E174235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqMQ-00049v-KC
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpy8-0002Xs-Tb
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:49:11 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:38201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLpy6-0000V9-Se
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:49:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id v12so3815210wmh.3
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=onYubvnZAptV0g3qVhyvCNtLG7BSB07qR8hJW0/fGsI=;
 b=RuHTMNDqG5bAGY9kkcDg9HN8S0pLpMdgWdNDi89GQlrXY/C6RMnKoJxlasuVzz6psr
 pxxLmv3zf308pqTiyeghIIaKTVhMBxe/SO7BrEgt/+2QgntHTM0X2powvD9eflkSC0RN
 Jwec8oZTyVyjMJmkdQKN8YSDZEs9HvWg1M4nS8a5Uw6EnpUiVbkfxUR0mlQ8JDJ37YIk
 aJ4Sc5sX+cnVs6CxuovqkBXggatOT/58jwSFfcHQjH+ixbxLu60kuqhks/epSKJhlpV4
 oJ8/zxLtbyrIfUMzNCMG7y4F725p6XW+qLV5pntOxJwzIfJt/GaOTbWnMmbv1hlKdlZU
 WFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=onYubvnZAptV0g3qVhyvCNtLG7BSB07qR8hJW0/fGsI=;
 b=LKc0RvJYqFS4YYv7BAgDz2rgRZd1InMtct7lzby+JmE2ndpmz6PDFsoYiwuD67Wvcw
 qg+Vu077wNpIMdnU3xm+jq5WES9wvGHk9aNJQQzu2HNBM6WMQl6+fcURPh5kFqZAXOqP
 0nlpwXXSTLzWD3RbECZSyjOQ7CzNpjEsAVzY9NUxIGiyTKTzbbgFEbTNPEBpTqfVQhTV
 Lrso1elkVrmOnnP9+QyKcBvPKcNVqV9HI5Dzj2Xd7+KHw1aOAvjOnnDz67Mb54RDEjj+
 dcahUSlHoAzQ42c7tKr41bAVq6+lhw1CqTziPsm1A5vP14WOX6PB+AzAQN44DyNWc1nw
 aqEw==
X-Gm-Message-State: AOAM530imTEfGZfjDqIj97nU+i/qZwPe+NkJV0uQKLbCMF/ZzelDaFxI
 ga/MiiPjnnEuSThg/1xjTnptQA==
X-Google-Smtp-Source: ABdhPJwg3Qt6FTfBMMepdqKtHeZx02g88WW7I1hYbCO9+P/hVvrwwG5YONeteBig8cwFL5mjB7pMxg==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr4063399wmu.73.1601048945110; 
 Fri, 25 Sep 2020 08:49:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m23sm3108366wmi.19.2020.09.25.08.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 08:49:04 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B10D1FF7E;
 Fri, 25 Sep 2020 16:40:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 14/15] gitlab-ci: Increase the timeout for the
 cross-compiler builds
Date: Fri, 25 Sep 2020 16:40:26 +0100
Message-Id: <20200925154027.12672-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925154027.12672-1-alex.bennee@linaro.org>
References: <20200925154027.12672-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

Some of the cross-compiler builds (the mips build and the win64 build
for example) are quite slow and sometimes hit the 1h time limit.
Increase the limit a little bit to make sure that we do not get failures
in the CI runs just because of some few minutes.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200921174320.46062-7-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.d/crossbuilds.yml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 510cfec03bb7..03ebfabb3fac 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -2,6 +2,7 @@
 .cross_system_build_job_template: &cross_system_build_job_definition
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  timeout: 80m
   script:
     - mkdir build
     - cd build
-- 
2.20.1


