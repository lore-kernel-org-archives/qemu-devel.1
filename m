Return-Path: <SRS0=zSEs=EO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95092C388F9
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0521D206D4
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2020 20:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFhJF3OO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0521D206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbrja-0006Tz-2L
	for qemu-devel@archiver.kernel.org; Sun, 08 Nov 2020 15:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbJ-0004o1-V8
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kbrbI-0000XG-1k
 for qemu-devel@nongnu.org; Sun, 08 Nov 2020 15:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604868467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Llw+O6PjDVffHPJXTH+hz+9KQjdl+Bz3DI9UFB5K8Pg=;
 b=FFhJF3OOkVbYns6t2WA2ACVd1qmbKGhSJ6BuCSiO9JCCbidXkZzlxPSo1+mSMGUk5HJywT
 K4xvpwpHM7nQDOU2it4APw4UVN32aYEXuBYtYCMB/CvH/yAP0DeZm1ZrHyg7J0XT3hnVbf
 X0crY5/+iml1kSEHONGJtxgw6fgK8Kw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-NMewwbp9NIWkbrG3s05d8A-1; Sun, 08 Nov 2020 15:47:45 -0500
X-MC-Unique: NMewwbp9NIWkbrG3s05d8A-1
Received: by mail-wr1-f70.google.com with SMTP id e18so3367231wrs.23
 for <qemu-devel@nongnu.org>; Sun, 08 Nov 2020 12:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Llw+O6PjDVffHPJXTH+hz+9KQjdl+Bz3DI9UFB5K8Pg=;
 b=RM1LS/T0Xqfd/VaWcuoDic561wJMZGYRuMBJBqLEQ/NjGrMNK6Ec4LVwsbZE0QsmEF
 X9DH49UOOtoJmaOlT4sshJ8UIyLzdf+yi+J3LnlgtFk5Ii1FAwLrqm8qckrxpMWsfYNj
 GPTaAbJuVEz2K9p+NzuhIv5kJZbdxTKHdyEerSw0zluEHU/UzZe8p+DPtdIOljhOJ1ZE
 Bntr/L3KcQ4oCYgK7LPlMl4VU4iHbdMYmlS2LwtyByYfWBzqwUNBtO6w1EmJRy09foHB
 cS937HIU3aVfnMtEakGs5cGbLqQuLsG4zVLLNF0nJfiazhkdDtH/bQ0eSIUMKaGUu+8N
 l+MA==
X-Gm-Message-State: AOAM532Y0AweYnZIzTMFPyPDtG9a4dF1fjTx9azaR5k7/foOMo945h7M
 zE2x/VjG1yBRFDy1BHXjjSmXJn+XdxUUlGXtWT9gW9860xm/4EOq6WodvVc1CK5RBr+6a0hzwhq
 /xWbx5L1QHyxVNZs=
X-Received: by 2002:adf:dc4c:: with SMTP id m12mr14575587wrj.177.1604868463616; 
 Sun, 08 Nov 2020 12:47:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwkj28UmF0WqSpVBRRdSdfGeHF3IvrynkcwtYIunXVEaZY+ARIVIS65pjsXOzbmuxsvwsteuw==
X-Received: by 2002:adf:dc4c:: with SMTP id m12mr14575568wrj.177.1604868463426; 
 Sun, 08 Nov 2020 12:47:43 -0800 (PST)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id h81sm10593305wmf.44.2020.11.08.12.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2020 12:47:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-6.0 v4 09/17] gitlab-ci: Move gprof/gcov test across to
 gitlab
Date: Sun,  8 Nov 2020 21:45:27 +0100
Message-Id: <20201108204535.2319870-10-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201108204535.2319870-1-philmd@redhat.com>
References: <20201108204535.2319870-1-philmd@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similarly to commit 8cdb2cef3f1, move the gprof/gcov test to GitLab.

The coverage-summary.sh script is not Travis-CI specific, make it
generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 .gitlab-ci.yml                             | 12 ++++++++++++
 .travis.yml                                | 14 --------------
 MAINTAINERS                                |  2 +-
 scripts/{travis => ci}/coverage-summary.sh |  2 +-
 4 files changed, 14 insertions(+), 16 deletions(-)
 rename scripts/{travis => ci}/coverage-summary.sh (92%)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 80082a602b8..d1583cee5db 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -403,6 +403,18 @@ check-deprecated:
     MAKE_CHECK_ARGS: check-tcg
   allow_failure: true
 
+# gprof/gcov are GCC features
+build-gprof-gcov:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: ubuntu2004
+    CONFIGURE_ARGS: --enable-gprof --enable-gcov
+    MAKE_CHECK_ARGS: build-tcg
+    TARGETS: aarch64-softmmu mips64-softmmu ppc64-softmmu
+             riscv64-softmmu s390x-softmmu x86_64-softmmu
+  after_script:
+    - ${CI_PROJECT_DIR}/scripts/ci/coverage-summary.sh
+
 build-oss-fuzz:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index bee6197290d..6087e2909cd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -210,20 +210,6 @@ jobs:
       compiler: clang
 
 
-    # gprof/gcov are GCC features
-    - name: "GCC gprof/gcov"
-      dist: bionic
-      addons:
-        apt:
-          packages:
-            - ninja-build
-      env:
-        - CONFIG="--enable-gprof --enable-gcov --disable-libssh
-                  --target-list=${MAIN_SOFTMMU_TARGETS}"
-      after_success:
-        - ${SRC_DIR}/scripts/travis/coverage-summary.sh
-
-
     # We don't need to exercise every backend with every front-end
     - name: "GCC trace log,simple,syslog (user)"
       env:
diff --git a/MAINTAINERS b/MAINTAINERS
index 817c7c93f91..3d8c586d444 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3121,7 +3121,7 @@ R: Philippe Mathieu-Daudé <philmd@redhat.com>
 S: Maintained
 F: .github/lockdown.yml
 F: .travis.yml
-F: scripts/travis/
+F: scripts/ci/
 F: .shippable.yml
 F: tests/docker/
 F: tests/vm/
diff --git a/scripts/travis/coverage-summary.sh b/scripts/ci/coverage-summary.sh
similarity index 92%
rename from scripts/travis/coverage-summary.sh
rename to scripts/ci/coverage-summary.sh
index d7086cf9ca6..8d9fb4de401 100755
--- a/scripts/travis/coverage-summary.sh
+++ b/scripts/ci/coverage-summary.sh
@@ -3,7 +3,7 @@
 # Author: Alex Bennée <alex.bennee@linaro.org>
 #
 # Summerise the state of code coverage with gcovr and tweak the output
-# to be more sane on Travis hosts. As we expect to be executed on a
+# to be more sane on CI runner. As we expect to be executed on a
 # throw away CI instance we do spam temp files all over the shop. You
 # most likely don't want to execute this script but just call gcovr
 # directly. See also "make coverage-report"
-- 
2.26.2


