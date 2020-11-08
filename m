Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F75C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C353E206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OAphHeV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C353E206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt6O-00020Y-Sc
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2T-0006MJ-Aw
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49273)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2R-00027H-LD
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604873995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vjq32+DhREyifig8wIg6zg2KFvI7/fWuGdDzcT/0/h8=;
 b=OAphHeV1dRhXWzoObA2TDh5H2Vhywr0U64DpkPtUZlwE/2KxjJm3aj9g5OquCgDTSIjYC1
 M90hfl4LM9HFy/c+cIxg5WeXcdpW7khHHCHEvG+Hk+nSD7jPuFSV8hfatF9jIxXlaU/t/6
 qNmk3KlMtk/zl/VNuuLt8z2ng4MCK/M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-bg_jtsrZO4KeMVqMcM9yIg-1; Sun, 08 Nov 2020 17:19:53 -0500
X-MC-Unique: bg_jtsrZO4KeMVqMcM9yIg-1
Received: by mail-wr1-f72.google.com with SMTP id b6so3445192wrn.17
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Vjq32+DhREyifig8wIg6zg2KFvI7/fWuGdDzcT/0/h8=;
 b=uS7M64/zSPBjHKUtecixqSxMBHVG5xsyFHQs4FYtNWRe0PalmpG+j9g31MZcf42cNE
 xm1ETkWGNGBGCAOG3m6vDPjR8yGSe/D2SI6lR8ZyLKJUv1MKBpWns6q1uDMaLCFMEU9M
 tqktPaQdMhnnq6qLR8B6pxIWQCMZ2/7VuA84sCdiNVym1sB9yIUiClB4Hq6qbjYC2P6Q
 E4kL8liFqHHTaV3Wj2t6gonJ9iXIYa2PcTcytkLD7uJkbRTwyKt4vldWvwS6qCcLOOom
 Od4xUluEep8w5AKeuzshk7YD9L2vPhy/6QVrR5+dlxTmbbtqJ3hLpcZ5XdOv/W5GuWtN
 N6rg==
X-Gm-Message-State: AOAM530Atz90pMKDhVGl8/MuxlCnjtu2ktm8qakQlC+Bq3kyYCVzY8Eu
 WvDVqQF8TmHPmQt+Q07VNeXj5XfismjvyQtUEFV6bhojsGie2k1RpnHyNmwkJMam/reZe8mdr1W
 gJQc2c1pDV9XdMXc=
X-Received: by 2002:a1c:a98c:: with SMTP id
 s134mr11676997wme.159.1604873992394; 
 Sun, 08 Nov 2020 14:19:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjflHEZL+P6J8cz6tnr+unNNBzEkmK4pgGTTmcmAr1OtwdgIIqshzbnwlJwz6XuTvH0vhILQ==
X-Received: by 2002:a1c:a98c:: with SMTP id
 s134mr11676981wme.159.1604873992263; 
 Sun, 08 Nov 2020 14:19:52 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id f2sm11554437wre.63.2020.11.08.14.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:19:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/11] gitlab-ci: Replace YAML anchors by extends
 (acceptance_test_job)
Date: Sun,  8 Nov 2020 23:19:19 +0100
Message-Id: <20201108221925.2344515-6-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108221925.2344515-1-philmd@redhat.com>
References: <20201108221925.2344515-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 15:45:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'extends' is an alternative to using YAML anchors
and is a little more flexible and readable. See:
https://docs.gitlab.com/ee/ci/yaml/#extends

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e11f80f6d65..0ef814764a0 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -42,7 +42,8 @@ include:
     - find . -type f -exec touch {} +
     - make $MAKE_CHECK_ARGS
 
-.acceptance_template: &acceptance_definition
+.acceptance_test_job:
+  extends: .native_test_job
   cache:
     key: "${CI_JOB_NAME}-cache"
     paths:
@@ -89,14 +90,13 @@ check-system-ubuntu:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-ubuntu:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-ubuntu
       artifacts: true
   variables:
     IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-system-debian:
   extends: .native_build_job
@@ -120,14 +120,13 @@ check-system-debian:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-debian:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-debian
       artifacts: true
   variables:
     IMAGE: debian-amd64
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-system-fedora:
   extends: .native_build_job
@@ -152,14 +151,13 @@ check-system-fedora:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-fedora:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-fedora
       artifacts: true
   variables:
     IMAGE: fedora
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-system-centos:
   extends: .native_build_job
@@ -184,14 +182,13 @@ check-system-centos:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-centos:
-  extends: .native_test_job
+  extends: .acceptance_test_job
   needs:
     - job: build-system-centos
       artifacts: true
   variables:
     IMAGE: centos8
     MAKE_CHECK_ARGS: check-acceptance
-  <<: *acceptance_definition
 
 build-disabled:
   extends: .native_build_job
-- 
2.26.2


