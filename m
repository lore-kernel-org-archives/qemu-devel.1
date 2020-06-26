Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60098C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:27:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F08C20836
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2VuEGbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F08C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot4e-0003cQ-DF
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0G-0003rI-LN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:08 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:34635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0E-00058K-JQ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id f7so7385006wrw.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8+ywLSq/cpQR9jk1x4FDeODnKkLS2LjIS17ZB0FsQ2E=;
 b=t2VuEGbPaVY2reVVq1TouABum0h/TkvNxEmYOmFMPu6EqOygHm0DfKVYcEsACMkk5e
 OLz+p1yxJVimcULfYgCMU/ac3a1IftHMuZSLZY5rJGSEJIBh3hRkdtXZvbj5At3qe3iS
 WSg+QUOlMNQ03meX2oqUIdrODWd0fvlN057PKexc2/v9a8gQuSN6NM0RVMXj+65u6unZ
 uujj36fyCdpp4cAXjCcd2baOCPwieNS6dJt4KMU2Wyhh8TKrmRaGUBcXbvjbxHvfHqua
 rw/711UqyQJSSN7i3E0qQqJLDXax6WtJD1LXq9MN9NT6lIwmlpgC5pOkTlUHrkDeTF28
 kivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8+ywLSq/cpQR9jk1x4FDeODnKkLS2LjIS17ZB0FsQ2E=;
 b=ZfwMHwOfKqHfhV+n51MaMGBGO9kFqeuBQDudS25RFTxZPhMyRm5s1blrjhoH1v7Fa1
 DP5CWzfrE6p+6UqUXJ3GRJHmo3NX2D+KxjCpjb8rS30MgYph7npoTIcFSRwNNp+GyLT6
 3ywoMSPdEZkiuv1NzakfWRlUFD7OSlrDsbjinIo9tXbdecPoAgZn8dI9EFWOL57FaFYF
 3bm2rVKCD+NYiYRVHN59IYj99Qhnrh5pik4ONNh2UMNonCzajzBwTSUaqnlRJTwA0/A9
 b/aQ067CAmsEd7FTdAS7jqwgx9WJLBwUDuQ8jZ9JhuaUiYsuf5o6yLDGDYR/XAhIBMSu
 cpgQ==
X-Gm-Message-State: AOAM531XLgtcoaTSIwypQ0UBB9x5mdOPZBjSxWXWU3cGN5ZODwTMHX5e
 60J4JsepjqevNuhdMFYX9DTp3Q==
X-Google-Smtp-Source: ABdhPJx15jdfgtME4nsEudWIAGeIPo+KeJ5rwWH0LMMH51+e4hcuu8/8+USt0/BBkRHSxLFBcxdcrw==
X-Received: by 2002:adf:82f5:: with SMTP id 108mr5009572wrc.218.1593195785203; 
 Fri, 26 Jun 2020 11:23:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 11sm18436613wmg.41.2020.06.26.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3C381FFAB;
 Fri, 26 Jun 2020 19:14:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 24/30] gitlab: add acceptance testing to system builds
Date: Fri, 26 Jun 2020 19:13:51 +0100
Message-Id: <20200626181357.26211-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

As part of migrating things from Travis to GitLab add the acceptance
tests. To do this:

  - rename system1 to system-ubuntu-main
  - rename system2 to system-fedora-misc
  - split into build/check/acceptance
  - remove -j from check stages
  - use artifacts to save build stage
  - add post acceptance template and use

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200622143204.12921-16-alex.bennee@linaro.org>

---
v2
  - updated with danp's docker changes
  - use needs instead of dependancies
  - touch all the build files to prevent rebuild
---
 .gitlab-ci.yml | 66 +++++++++++++++++++++++++++++++++++++++++++++++---
 .travis.yml    | 23 ------------------
 2 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index a7abc55a5c6..5ae8130bd1a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,8 +1,12 @@
+# Currently we have two build stages after our containers are built:
+#  - build (for traditional build and test or first stage build)
+#  - test (for test stages, using build artefacts from a build stage)
 stages:
   - containers
   - containers-layer2
   - containers-layer3
   - build
+  - test
 
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
@@ -24,26 +28,82 @@ include:
         ../configure --enable-werror $CONFIGURE_ARGS ;
       fi
     - make -j"$JOBS"
-    - make -j"$JOBS" $MAKE_CHECK_ARGS
+    - if test -n "$MAKE_CHECK_ARGS";
+      then
+        make $MAKE_CHECK_ARGS ;
+      fi
+
+.native_test_job_template: &native_test_job_definition
+  stage: test
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  script:
+    - cd build
+    - find . -type f -exec touch {} +
+    - make $MAKE_CHECK_ARGS
+
+.post_acceptance_template: &post_acceptance
+  after_script:
+    - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
+    - du -chs $HOME/avocado/data/cache
 
-build-system1:
+build:system-ubuntu-main:
   <<: *native_build_job_definition
   variables:
     IMAGE: ubuntu2004
     TARGETS: aarch64-softmmu alpha-softmmu cris-softmmu hppa-softmmu lm32-softmmu
       moxie-softmmu microblazeel-softmmu mips64el-softmmu m68k-softmmu ppc-softmmu
       riscv64-softmmu sparc-softmmu
+  artifacts:
+    paths:
+      - build
+
+check:system-ubuntu-main:
+  <<: *native_test_job_definition
+  needs:
+    - job: build:system-ubuntu-main
+      artifacts: true
+  variables:
+    IMAGE: ubuntu2004
     MAKE_CHECK_ARGS: check
 
-build-system2:
+acceptance:system-ubuntu-main:
+  <<: *native_test_job_definition
+  needs:
+    - job: build:system-ubuntu-main
+      artifacts: true
+  variables:
+    IMAGE: ubuntu2004
+    MAKE_CHECK_ARGS: check-acceptance
+
+build:system-fedora-alt:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
     TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
       riscv32-softmmu s390x-softmmu sh4-softmmu sparc64-softmmu x86_64-softmmu
       xtensa-softmmu nios2-softmmu or1k-softmmu
+  artifacts:
+    paths:
+      - build
+
+check:system-fedora-alt:
+  <<: *native_test_job_definition
+  needs:
+    - job: build:system-fedora-alt
+      artifacts: true
+  variables:
+    IMAGE: fedora
     MAKE_CHECK_ARGS: check
 
+check:system-fedora-alt:
+  <<: *native_test_job_definition
+  needs:
+    - job: build:system-fedora-alt
+      artifacts: true
+  variables:
+    IMAGE: fedora
+    MAKE_CHECK_ARGS: check-acceptance
+
 build-disabled:
   <<: *native_build_job_definition
   variables:
diff --git a/.travis.yml b/.travis.yml
index 74158f741b1..c24dfbe377f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -289,29 +289,6 @@ jobs:
       python: 3.6
 
 
-    # Acceptance (Functional) tests
-    - name: "GCC check-acceptance"
-      dist: bionic
-      env:
-        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
-        - TEST_CMD="make check-acceptance"
-        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
-      after_script:
-        - python3 -c 'import json; r = json.load(open("tests/results/latest/results.json")); [print(t["logfile"]) for t in r["tests"] if t["status"] not in ("PASS", "SKIP")]' | xargs cat
-        - du -chs $HOME/avocado/data/cache
-      addons:
-        apt:
-          packages:
-            - python3-pil
-            - python3-pip
-            - python3-numpy
-            - python3-opencv
-            - python3-venv
-            - rpm2cpio
-            - tesseract-ocr
-            - tesseract-ocr-eng
-
-
     # Using newer GCC with sanitizers
     - name: "GCC9 with sanitizers (softmmu)"
       addons:
-- 
2.20.1


