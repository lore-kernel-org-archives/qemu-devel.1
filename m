Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D38A22076E
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xf4HwYVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D38A22076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6Fq-0000ZE-5Z
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68x-0004Ec-1Z
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37848)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68v-0005wr-8M
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:50 -0400
Received: by mail-wr1-x436.google.com with SMTP id a6so2457966wrm.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NSbE/oPaUPqzCfEUFHpvKz9daAgMJApN4FMtaAwBhjs=;
 b=xf4HwYVQa2TwFiK7FK4SfJ7rbA0WfBzMSdNwuq9AtPmuET4wwmYI11fqOhMzGhgZbT
 nhn2iGl4RX6CU4bLiWV6+BJ3XacG8upCIgnVe8Z3vP1ZnLXT8mMkgFUa4ospWZw30V0v
 Y3rtZ1hlfIywtrzWgaKQeqE03iZmpmMho5ayD2Uuh9sKoCPgFa+pXS8xMcg51CJxsfXF
 cKFpop+2G5uf8VfKrK5rkOjRi7FnSaH1yJgweyH46nH9kQCiZsvU5Mgdms7xCKlrMpew
 cxu8Y8G473nSrJwfhodkRgUwJn2n4nHv0IyYtuc5ElAqFqsT5NrCCU2WdSfFw/e3OiBU
 5LtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NSbE/oPaUPqzCfEUFHpvKz9daAgMJApN4FMtaAwBhjs=;
 b=O6GiJ73TINB5rR6cN/CcbAfURRZmTrppPnjCuF4dMKsYkO5yDOznUxflejpIdBEgSM
 aHojChJ+JMSxlOGvs6UZOLCrVmM4yNbh6cGIuevC3RgY1d9GfHUr6i98Ys7LP58XXr7l
 Rw+spELqeT/A/foA6R1tVpDMdI1VY5C8/VoQKqv5NfPf8pDf4O51okJlF/eU6LgRULSL
 kEXb8gRF1hQ6xzMkEwj42nuv1cv+Gcxggthvu2VHB5lPm6hvMYr/YYFdXE0bax0LpJSd
 cH/ibkaqGeGiVLx5hrh3gT1A+zxO5zSdWb0jKukF8sAIJBYQLZsSherofKLESIGhpOeZ
 MnIg==
X-Gm-Message-State: AOAM531P5DqHwTDU4ZpcJ89UbZtlKbV4KYOHs0OxcYbSb42n3r5iTtuK
 jmPTDK6bElI5FY8sjt5wnxqMVA==
X-Google-Smtp-Source: ABdhPJwxt6p3HNem1VIJO66ghucbwjgASoziL3+xzwdDbpJZjNmtj0qNm7Or4gZAUuJ9GkM80im6Og==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr30961671wro.30.1593007967876; 
 Wed, 24 Jun 2020 07:12:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u186sm8568589wmu.10.2020.06.24.07.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:12:46 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAFB01FFAF;
 Wed, 24 Jun 2020 15:04:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 25/25] gitlab: split build-disabled into two phases
Date: Wed, 24 Jun 2020 15:04:46 +0100
Message-Id: <20200624140446.15380-26-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we run check-qtest in "SLOW" mode this can timeout so split into
two jobs.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 683a1d90fe6..2567c88f99d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -109,7 +109,7 @@ check:system-fedora-alt:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-acceptance
 
-build-disabled:
+build:system-fedora-disabled:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
@@ -120,6 +120,17 @@ build-disabled:
       --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
       --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
     TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
+  artifacts:
+    paths:
+      - build
+
+qtest:system-fedora-disabled:
+  <<: *native_test_job_definition
+  needs:
+    - job: build:system-fedora-disabled
+      artifacts: true
+  variables:
+    IMAGE: fedora
     MAKE_CHECK_ARGS: check-qtest SPEED=slow
 
 build-tcg-disabled:
-- 
2.20.1


