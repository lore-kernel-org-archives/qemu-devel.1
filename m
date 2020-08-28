Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24069C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37CA207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 13:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeOOTqKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37CA207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBeQb-0005Ug-8c
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 09:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBePn-0004Zx-89
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBePl-0005mY-Ei
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 09:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598621252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nvMHQQFio57YyV2L1DoZUFP8LrnIV4vlAtqxrzX+2A=;
 b=LeOOTqKPTmc1Oy7cdqZP/B4isF8oVpXYJ3xwnR2PBWfu6w3f6TJGHjqBhI/EF/DLhYdlmw
 hGIESvbgrh3aKsUbTIT6AAi2OmQecMxd34h+XTQU4DRlOuCio7C/g3OkmHgKDL+kCuiWrN
 vdkVRLyoC5J0VFQwHT35jkDXZrkwlM8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-z3FzYN3IO7GiZJiaV_Ja8w-1; Fri, 28 Aug 2020 09:27:30 -0400
X-MC-Unique: z3FzYN3IO7GiZJiaV_Ja8w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88F3518B9EEA;
 Fri, 28 Aug 2020 13:27:29 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-167.ams2.redhat.com
 [10.36.113.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 689DE7E722;
 Fri, 28 Aug 2020 13:27:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] gitlab: expand test coverage for crypto builds
Date: Fri, 28 Aug 2020 14:27:16 +0100
Message-Id: <20200828132716.279782-3-berrange@redhat.com>
In-Reply-To: <20200828132716.279782-1-berrange@redhat.com>
References: <20200828132716.279782-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most jobs test the latest nettle library. This adds explicit coverage
for latest gcrypt using Fedora, and old gcrypt and nettle using
CentOS-7. The latter does a minimal tools-only build, as we only need to
validate that the crypto code builds and unit tests pass. Finally a job
disabling both nettle and gcrypt is provided to validate that gnutls
still works.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.yml                          | 66 +++++++++++++++++++++++++
 tests/docker/dockerfiles/centos7.docker |  2 +
 tests/docker/dockerfiles/centos8.docker |  1 +
 3 files changed, 69 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index b7967b9a13..85cf1f6cfd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -130,6 +130,7 @@ build-system-fedora:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
+    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
     TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -160,6 +161,7 @@ build-system-centos:
   <<: *native_build_job_definition
   variables:
     IMAGE: centos8
+    CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
     TARGETS: ppc64-softmmu lm32-softmmu or1k-softmmu s390x-softmmu
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -196,6 +198,7 @@ build-disabled:
       --disable-guest-agent --disable-curses --disable-libxml2 --disable-tpm
       --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
       --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
+      --disable-nettle --disable-gcrypt --disable-gnutls
     TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
     MAKE_CHECK_ARGS: check-qtest SPEED=slow
 
@@ -271,3 +274,66 @@ build-tci:
       done
     - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
     - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
+
+# Most jobs test latest gcrypto or nettle builds
+#
+# These jobs test old gcrypt and nettle from RHEL7
+# which had some API differences.
+build-crypto-old-nettle:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: centos7
+    CONFIGURE_ARGS: --disable-system --disable-user --enable-tools --disable-gcrypt --enable-nettle
+    MAKE_CHECK_ARGS: check-build
+  artifacts:
+    paths:
+      - build
+
+check-crypto-old-nettle:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-crypto-old-nettle
+      artifacts: true
+  variables:
+    IMAGE: centos7
+    MAKE_CHECK_ARGS: check
+
+
+build-crypto-old-gcrypt:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: centos7
+    CONFIGURE_ARGS: --disable-system --disable-user --enable-tools --disable-nettle --enable-gcrypt
+    MAKE_CHECK_ARGS: check-build
+  artifacts:
+    paths:
+      - build
+
+check-crypto-old-gcrypt:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-crypto-old-gcrypt
+      artifacts: true
+  variables:
+    IMAGE: centos7
+    MAKE_CHECK_ARGS: check
+
+
+build-crypto-only-gnutls:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: centos7
+    CONFIGURE_ARGS: --disable-system --disable-user --enable-tools --disable-nettle --disable-gcrypt --enable-gnutls
+    MAKE_CHECK_ARGS: check-build
+  artifacts:
+    paths:
+      - build
+
+check-crypto-only-gnutls:
+  <<: *native_test_job_definition
+  needs:
+    - job: build-crypto-only-gnutls
+      artifacts: true
+  variables:
+    IMAGE: centos7
+    MAKE_CHECK_ARGS: check
diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/dockerfiles/centos7.docker
index e197acdc3c..46277773bf 100644
--- a/tests/docker/dockerfiles/centos7.docker
+++ b/tests/docker/dockerfiles/centos7.docker
@@ -15,9 +15,11 @@ ENV PACKAGES \
     gettext \
     git \
     glib2-devel \
+    gnutls-devel \
     libaio-devel \
     libepoxy-devel \
     libfdt-devel \
+    libgcrypt-devel \
     librdmacm-devel \
     libzstd-devel \
     lzo-devel \
diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/dockerfiles/centos8.docker
index 9852c5b9ee..f435616d6a 100644
--- a/tests/docker/dockerfiles/centos8.docker
+++ b/tests/docker/dockerfiles/centos8.docker
@@ -13,6 +13,7 @@ ENV PACKAGES \
     glib2-devel \
     libaio-devel \
     libepoxy-devel \
+    libgcrypt-devel \
     lzo-devel \
     make \
     mesa-libEGL-devel \
-- 
2.26.2


