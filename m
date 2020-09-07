Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD54C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D46742075A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 12:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrhIwLE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D46742075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFG7l-0007ej-23
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 08:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFG01-0004Na-SD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48705
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFFzz-0007wy-PQ
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 08:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599480711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj79IjS7v1Gcq5rK+AMCX97kXIltfe+mxSAkI1qI8rs=;
 b=QrhIwLE/mStUbTT2Rx+1wS+oL5fMTg6z3+dHU+OMBRLDC7ZYvOOXHXt8Q+iE0zmwggxe7p
 LvN8vMZvXFLECTM5jhQeCy08/hL7uYGKePkK86bdYDhn74Da8QpDbdKe/ZtuejbkAnt0iP
 QKre0srYSg8rDDUb8zFSLottIvIt3kU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-N8X9fQpfNHaptx483mFfPg-1; Mon, 07 Sep 2020 08:11:48 -0400
X-MC-Unique: N8X9fQpfNHaptx483mFfPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBD091084D87;
 Mon,  7 Sep 2020 12:11:47 +0000 (UTC)
Received: from thuth.com (ovpn-112-193.ams2.redhat.com [10.36.112.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B771E5C1BB;
 Mon,  7 Sep 2020 12:11:46 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/14] gitlab: expand test coverage for crypto builds
Date: Mon,  7 Sep 2020 14:11:25 +0200
Message-Id: <20200907121127.136243-13-thuth@redhat.com>
In-Reply-To: <20200907121127.136243-1-thuth@redhat.com>
References: <20200907121127.136243-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

Most jobs test the latest nettle library. This adds explicit coverage
for latest gcrypt using Fedora, and old gcrypt and nettle using
CentOS-7. The latter does a minimal tools-only build, as we only need to
validate that the crypto code builds and unit tests pass. Finally a job
disabling both nettle and gcrypt is provided to validate that gnutls
still works.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200901133050.381844-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml                          | 68 +++++++++++++++++++++++++
 tests/docker/dockerfiles/centos7.docker |  2 +
 tests/docker/dockerfiles/centos8.docker |  1 +
 3 files changed, 71 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d677e00933..72e8604579 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -133,6 +133,7 @@ build-system-fedora:
   <<: *native_build_job_definition
   variables:
     IMAGE: fedora
+    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
     TARGETS: tricore-softmmu unicore32-softmmu microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -164,6 +165,7 @@ build-system-centos:
   <<: *native_build_job_definition
   variables:
     IMAGE: centos8
+    CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
     TARGETS: ppc64-softmmu lm32-softmmu or1k-softmmu s390x-softmmu
       x86_64-softmmu rx-softmmu sh4-softmmu nios2-softmmu
     MAKE_CHECK_ARGS: check-build
@@ -290,3 +292,69 @@ build-tci:
       done
     - QTEST_QEMU_BINARY="./qemu-system-x86_64" ./tests/qtest/pxe-test
     - QTEST_QEMU_BINARY="./qemu-system-s390x" ./tests/qtest/pxe-test -m slow
+
+# Most jobs test latest gcrypt or nettle builds
+#
+# These jobs test old gcrypt and nettle from RHEL7
+# which had some API differences.
+build-crypto-old-nettle:
+  <<: *native_build_job_definition
+  variables:
+    IMAGE: centos7
+    TARGETS: x86_64-softmmu x86_64-linux-user
+    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle
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
+    TARGETS: x86_64-softmmu x86_64-linux-user
+    CONFIGURE_ARGS: --disable-nettle --enable-gcrypt
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
+    TARGETS: x86_64-softmmu x86_64-linux-user
+    CONFIGURE_ARGS: --disable-nettle --disable-gcrypt --enable-gnutls
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
2.18.2


