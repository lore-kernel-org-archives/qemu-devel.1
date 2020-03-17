Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E1CC18E5B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:09:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3822520658
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 04:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y1cY+rt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3822520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52223 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE3Xb-0004yF-EE
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 00:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3Ud-0008GI-85
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1jE3Ub-00032d-Aa
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:15 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33622)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1jE3Ub-0002vx-3F
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 00:06:13 -0400
Received: by mail-pg1-x541.google.com with SMTP id m5so10982719pgg.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding:cc:from:to;
 bh=Nva8E1OWcJIE1NilXnKldlirFJKhPrI+ipIaZ9JueS4=;
 b=Y1cY+rt5n7KA4ighproX33aPZqsdJq7Gm/xEzl9xnQbF/VHEZICGwx+kVpBLzfpHYz
 43MVl6OXwMshlQOdjVjOlZklAkI8RgL4+Q8AaEEX1aMRGpVt+irJ8R15sAlxK9ZW+MbC
 +EMZ3NGepkPw+gbwTJ/rELcyQ1hSAvaDtDh6BZpZftR0hdEGDvMxeKtO65GwoC2cvSzo
 /j0U77QIZ+vf2k3vSG2F82NWlYAmkVzO74b3FzNUecnCYbEW9FhW5qsYyfbQcgiIXVcR
 gOhXlLOqaWu7DsK9qo4RS0y8q52dJVuqa1T8LbII6uQz7hBtRT3kBA5nqMYRHTiPjwVT
 /YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:cc:from:to;
 bh=Nva8E1OWcJIE1NilXnKldlirFJKhPrI+ipIaZ9JueS4=;
 b=Upofs4qgLjqGFhNapfI7G4K+OCsc9/5+bBi6ox6gujaqRmnxo0rpsE56X4EUgadS7r
 b8CzvqCdBVCTkNEIIYOpjEXW+VI0Gli1SkBMYuysBzNaH6Kngx2imWqf3us2rriIp2h6
 PtVw8WzrArpAsYfn/c0UAUzTxGIGGzqRRJDCUUMsxa/rEgWBCXe+5Zl2LjbjOYH5K7Y+
 nMDOjk707Za/KvdbCBjQB+1QKdGQ1SaidMO+dJti6Pd8UGuWgPLNoAEuqv4FPeeqW3ap
 cRlcjHP2yxPhIaW6MLz24zTCpdEbRohCbS5Uw9zT91YlIp9w0rh/DDvj9Pemnx6FHTYn
 AbWQ==
X-Gm-Message-State: ANhLgQ3to5VhmZnN3iFb12sYiQ8Ai7PSgKS7OzDMDcLDbfMVJPg/4XQf
 c5ZzeHaOyLWa32lx08y1XT73dA==
X-Google-Smtp-Source: ADFU+vu8N20pler5Np9qBBnMysikZGCu9zHc/x2SfAPvlZUf3DHzGd4MYjRZUaTb7ykutlLAI+ftrQ==
X-Received: by 2002:a63:4752:: with SMTP id w18mr2929264pgk.379.1584417971766; 
 Mon, 16 Mar 2020 21:06:11 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
 by smtp.gmail.com with ESMTPSA id y7sm1268552pfq.159.2020.03.16.21.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 21:06:11 -0700 (PDT)
Subject: [PULL 5/6] gitlab-ci.yml: Add jobs to build OpenSBI firmware binaries
Date: Mon, 16 Mar 2020 21:05:46 -0700
Message-Id: <20200317040547.222501-6-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200317040547.222501-1-palmerdabbelt@google.com>
References: <20200317040547.222501-1-palmerdabbelt@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: qemu-riscv@nongnu.org,          qemu-devel@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>,
 ilippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, 
 Palmer Dabbelt <palmerdabbelt@google.com>
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bin Meng <bmeng.cn@gmail.com>

Add two GitLab jobs to build the OpenSBI firmware binaries.

The first job builds a Docker image with the packages requisite
to build OpenSBI, and stores this image in the GitLab registry.
The second job pulls the image from the registry and builds the
OpenSBI firmware binaries.

The docker image is only rebuilt if the GitLab YAML or the
Dockerfile is updated. The second job is only built when the
roms/opensbi/ submodule is updated, when a git-ref starts with
'opensbi' or when the last commit contains 'OpenSBI'. The files
generated are archived in the artifacts.zip file.

With OpenSBI v0.6, it took 2 minutes 56 seconds to build
the docker image, and 1 minute 24 seconds to generate the
artifacts.zip with the firmware binaries (filesize: 111KiB).

See: https://gitlab.com/lbmeng/qemu/pipelines/120520138

Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 .gitlab-ci-opensbi.yml          | 63 +++++++++++++++++++++++++++++++++
 .gitlab-ci.d/opensbi/Dockerfile | 33 +++++++++++++++++
 .gitlab-ci.yml                  |  1 +
 3 files changed, 97 insertions(+)
 create mode 100644 .gitlab-ci-opensbi.yml
 create mode 100644 .gitlab-ci.d/opensbi/Dockerfile

diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci-opensbi.yml
new file mode 100644
index 0000000000..dd051c0124
--- /dev/null
+++ b/.gitlab-ci-opensbi.yml
@@ -0,0 +1,63 @@
+docker-opensbi:
+ stage: build
+ rules: # Only run this job when the Dockerfile is modified
+ - changes:
+   - .gitlab-ci-opensbi.yml
+   - .gitlab-ci.d/opensbi/Dockerfile
+   when: always
+ image: docker:19.03.1
+ services:
+ - docker:19.03.1-dind
+ variables:
+  GIT_DEPTH: 3
+  IMAGE_TAG: $CI_REGISTRY_IMAGE:opensbi-cross-build
+  # We don't use TLS
+  DOCKER_HOST: tcp://docker:2375
+  DOCKER_TLS_CERTDIR: ""
+ before_script:
+ - docker login -u $CI_REGISTRY_USER -p $CI_REGISTRY_PASSWORD $CI_REGISTRY
+ script:
+ - docker pull $IMAGE_TAG || true
+ - docker build --cache-from $IMAGE_TAG --tag $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
+                                        --tag $IMAGE_TAG .gitlab-ci.d/opensbi
+ - docker push $CI_REGISTRY_IMAGE:$CI_COMMIT_SHA
+ - docker push $IMAGE_TAG
+
+build-opensbi:
+ rules: # Only run this job when ...
+ - changes: # ... roms/opensbi/ is modified (submodule updated)
+   - roms/opensbi/*
+   when: always
+ - if: '$CI_COMMIT_REF_NAME =~ /^opensbi/' # or the branch/tag starts with 'opensbi'
+   when: always
+ - if: '$CI_COMMIT_MESSAGE =~ /opensbi/i' # or last commit description contains 'OpenSBI'
+   when: always
+ artifacts:
+   paths: # 'artifacts.zip' will contains the following files:
+   - pc-bios/opensbi-riscv32-sifive_u-fw_jump.bin
+   - pc-bios/opensbi-riscv32-virt-fw_jump.bin
+   - pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
+   - pc-bios/opensbi-riscv64-virt-fw_jump.bin
+   - opensbi32-virt-stdout.log
+   - opensbi32-virt-stderr.log
+   - opensbi64-virt-stdout.log
+   - opensbi64-virt-stderr.log
+   - opensbi32-sifive_u-stdout.log
+   - opensbi32-sifive_u-stderr.log
+   - opensbi64-sifive_u-stdout.log
+   - opensbi64-sifive_u-stderr.log
+ image: $CI_REGISTRY_IMAGE:opensbi-cross-build
+ variables:
+   GIT_DEPTH: 3
+ script: # Clone the required submodules and build OpenSBI
+ - git submodule update --init roms/opensbi
+ - export JOBS=$(($(getconf _NPROCESSORS_ONLN) + 1))
+ - echo "=== Using ${JOBS} simultaneous jobs ==="
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi32-virt 2>&1 1>opensbi32-virt-stdout.log | tee -a opensbi32-virt-stderr.log >&2
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi64-virt 2>&1 1>opensbi64-virt-stdout.log | tee -a opensbi64-virt-stderr.log >&2
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi32-sifive_u 2>&1 1>opensbi32-sifive_u-stdout.log | tee -a opensbi32-sifive_u-stderr.log >&2
+ - make -j${JOBS} -C roms/opensbi clean
+ - make -j${JOBS} -C roms opensbi64-sifive_u 2>&1 1>opensbi64-sifive_u-stdout.log | tee -a opensbi64-sifive_u-stderr.log >&2
diff --git a/.gitlab-ci.d/opensbi/Dockerfile b/.gitlab-ci.d/opensbi/Dockerfile
new file mode 100644
index 0000000000..4ba8a4de86
--- /dev/null
+++ b/.gitlab-ci.d/opensbi/Dockerfile
@@ -0,0 +1,33 @@
+#
+# Docker image to cross-compile OpenSBI firmware binaries
+#
+FROM ubuntu:18.04
+
+MAINTAINER Bin Meng <bmeng.cn@gmail.com>
+
+# Install packages required to build OpenSBI
+RUN apt update \
+    && \
+    \
+    DEBIAN_FRONTEND=noninteractive \
+    apt install --assume-yes --no-install-recommends \
+        build-essential \
+        ca-certificates \
+        git \
+        make \
+        wget \
+    && \
+    \
+    rm -rf /var/lib/apt/lists/*
+
+# Manually install the kernel.org "Crosstool" based toolchains for gcc-8.3
+RUN wget -O - \
+    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv32-linux.tar.xz \
+    | tar -C /opt -xJ
+RUN wget -O - \
+    https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/8.3.0/x86_64-gcc-8.3.0-nolibc-riscv64-linux.tar.xz \
+    | tar -C /opt -xJ
+
+# Export the toolchains to the system path
+ENV PATH="/opt/gcc-8.3.0-nolibc/riscv32-linux/bin:${PATH}"
+ENV PATH="/opt/gcc-8.3.0-nolibc/riscv64-linux/bin:${PATH}"
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 72f8b8aa51..b889fb96b6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,5 +1,6 @@
 include:
   - local: '/.gitlab-ci-edk2.yml'
+  - local: '/.gitlab-ci-opensbi.yml'
 
 before_script:
  - apt-get update -qq
-- 
2.25.1.481.gfbce0eb801-goog


