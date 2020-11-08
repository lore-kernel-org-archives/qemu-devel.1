Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD46C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:24:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC810206E3
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 22:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="duTmwlax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC810206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbt6h-0002U0-1Z
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 17:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2P-0006D5-0C
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbt2N-000270-0P
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 17:19:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604873990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EMPOslgUIn2gPkqETCgv4eVsfUBUm27ATWoJ+FEEAoc=;
 b=duTmwlaxiLQCkiyZ8SkSe+qlROhV1g/zggkoi2VpOMbxkNNUHaLw8UUAN8HjWF+mA0FYye
 tKXuaQRSGB/Je2PdCq4LD2JGx9QRQCdPAIZX8g6KxNXEo8gC+QtCESnnP3H6GNwp7/qwSv
 oCYFAF7a5rQUOIwJZRGcgtCEVvdcBAc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-GAv5q7qWMzevtWQE6Tk2LQ-1; Sun, 08 Nov 2020 17:19:48 -0500
X-MC-Unique: GAv5q7qWMzevtWQE6Tk2LQ-1
Received: by mail-wr1-f69.google.com with SMTP id y2so832404wrl.3
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 14:19:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EMPOslgUIn2gPkqETCgv4eVsfUBUm27ATWoJ+FEEAoc=;
 b=gN7iy/J2YvsbWY7coc4NVWoHBM26Vw6tYA0qp6/ZbPo7jeA9i//efE2VHzAkJPSjz4
 Kmnf8dh2ADH6V+StouPR45W6kX68uNLepNf/NapLwxE45UhfOp84Oy/VdgMuEKQqdVF0
 2FAPpfHpAIlfp025On3AlDKL6QFaR7tiQ/XwAME7KjcZHrFUd1OkL7jHgyr1UaQ5Ed9f
 1L+q7CfvVUhHfVyoD5nlVdzvwnMU+vSL8QR93Bqi97Z2wX58W6MxE5Zx8NBpAYRydZ5P
 xP0rgZnHIDwt169R67wtZSQ+24nU/9Tg4XwWP+GLfVnkzwLzYAxTMxcrhWdx40x18+mw
 WkZA==
X-Gm-Message-State: AOAM5319o9DHVn+CirLufGP0F9FNkcCSDSFV8xCfOWtX4mKyGg33jkHI
 CTNVLkIqfboOX3GJFIuM4BiAMZuKKSq/3PvXChVRrSwhQyfZ+jvdCd+7/wjzWgstTf1Nohud2KQ
 MjjMT5iP8GqDxB9g=
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr11136477wmd.60.1604873987327; 
 Sun, 08 Nov 2020 14:19:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx790b5XkPQ6PUx5vJM6dr0rGjJdTXYtHNpMdZF+xz0WZWWMx46WM0O0qNCw79SVOgroxt7Gw==
X-Received: by 2002:a1c:1d51:: with SMTP id d78mr11136465wmd.60.1604873987193; 
 Sun, 08 Nov 2020 14:19:47 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id x10sm10538676wrp.62.2020.11.08.14.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 14:19:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/11] gitlab-ci: Replace YAML anchors by extends
 (native_test_job)
Date: Sun,  8 Nov 2020 23:19:18 +0100
Message-Id: <20201108221925.2344515-5-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/08 09:03:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
 .gitlab-ci.yml | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a96e7dd23e5..e11f80f6d65 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -34,7 +34,7 @@ include:
         make -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
 
-.native_test_job_template: &native_test_job_definition
+.native_test_job:
   stage: test
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
   script:
@@ -80,7 +80,7 @@ build-system-ubuntu:
       - build
 
 check-system-ubuntu:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-ubuntu
       artifacts: true
@@ -89,7 +89,7 @@ check-system-ubuntu:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-ubuntu:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-ubuntu
       artifacts: true
@@ -111,7 +111,7 @@ build-system-debian:
       - build
 
 check-system-debian:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-debian
       artifacts: true
@@ -120,7 +120,7 @@ check-system-debian:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-debian:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-debian
       artifacts: true
@@ -143,7 +143,7 @@ build-system-fedora:
       - build
 
 check-system-fedora:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-fedora
       artifacts: true
@@ -152,7 +152,7 @@ check-system-fedora:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-fedora:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-fedora
       artifacts: true
@@ -175,7 +175,7 @@ build-system-centos:
       - build
 
 check-system-centos:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-centos
       artifacts: true
@@ -184,7 +184,7 @@ check-system-centos:
     MAKE_CHECK_ARGS: check
 
 acceptance-system-centos:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-system-centos
       artifacts: true
@@ -282,7 +282,7 @@ build-deprecated:
 # We split the check-tcg step as test failures are expected but we still
 # want to catch the build breaking.
 check-deprecated:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-deprecated
       artifacts: true
@@ -346,7 +346,7 @@ build-crypto-old-nettle:
       - build
 
 check-crypto-old-nettle:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-crypto-old-nettle
       artifacts: true
@@ -367,7 +367,7 @@ build-crypto-old-gcrypt:
       - build
 
 check-crypto-old-gcrypt:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-crypto-old-gcrypt
       artifacts: true
@@ -388,7 +388,7 @@ build-crypto-only-gnutls:
       - build
 
 check-crypto-only-gnutls:
-  <<: *native_test_job_definition
+  extends: .native_test_job
   needs:
     - job: build-crypto-only-gnutls
       artifacts: true
-- 
2.26.2


