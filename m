Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E40FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 756EF207FC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxwuYhCJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756EF207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k30Qy-0001p9-Mr
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 13:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k30K2-0007Ov-JV
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20305
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k30K0-0005VJ-Gy
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 13:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596560511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Aa9bXWXZtVMBQqv1Ik2hcEgY5s63pjYkVIapNPkplRk=;
 b=ZxwuYhCJLU7x15MhmE7DLQeOYZUg43KCh38msGGw45r9aTH0TQz9ohgunsHilL7YBsb3WJ
 ePsfdDrwJGQgpyQLL5x6Mw8mWsZbPMvDXHSUY44YHQkMHfhm0eibImIeXQJbXmp1KyLa+7
 GuJP4vQ/o9HlDaO5nYghFfX0Z34v4H4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-y9MXpcUAOkavRyz9bZA3kw-1; Tue, 04 Aug 2020 13:01:47 -0400
X-MC-Unique: y9MXpcUAOkavRyz9bZA3kw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A007100AA23;
 Tue,  4 Aug 2020 17:01:46 +0000 (UTC)
Received: from thuth.com (ovpn-112-162.ams2.redhat.com [10.36.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C969610013D0;
 Tue,  4 Aug 2020 17:01:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 09/11] gitlab-ci: Add cross-compiling build tests
Date: Tue,  4 Aug 2020 19:00:53 +0200
Message-Id: <20200804170055.2851-10-thuth@redhat.com>
In-Reply-To: <20200804170055.2851-1-thuth@redhat.com>
References: <20200804170055.2851-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:01:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Weil <sw@weilnetz.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can use all our QEMU test containers in the gitlab-CI, we can
easily add some jobs that test cross-compilation for various architectures.
There is just only small ugliness: Since the shared runners on gitlab.com
are single-threaded, we have to split each compilation job into two parts
(--disable-user and --disable-system), and exclude some additional targets,
to avoid that the jobs are running too long and hitting the timeout of 1 h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/crossbuilds.yml | 113 +++++++++++++++++++++++++++++++++++
 .gitlab-ci.yml               |   1 +
 MAINTAINERS                  |   1 +
 3 files changed, 115 insertions(+)
 create mode 100644 .gitlab-ci.d/crossbuilds.yml

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
new file mode 100644
index 0000000000..4ec7226b5c
--- /dev/null
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -0,0 +1,113 @@
+
+.cross_system_build_job_template: &cross_system_build_job_definition
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  script:
+    - mkdir build
+    - cd build
+    - PKG_CONFIG_PATH=$PKG_CONFIG_PATH
+      ../configure --enable-werror $QEMU_CONFIGURE_OPTS --disable-user
+        --target-list-exclude="aarch64-softmmu i386-softmmu microblaze-softmmu
+          mips-softmmu mipsel-softmmu mips64-softmmu ppc64-softmmu sh4-softmmu
+          xtensa-softmmu"
+    - make -j$(expr $(nproc) + 1) all check-build
+
+.cross_user_build_job_template: &cross_user_build_job_definition
+  stage: build
+  image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:latest
+  script:
+    - mkdir build
+    - cd build
+    - PKG_CONFIG_PATH=$PKG_CONFIG_PATH
+      ../configure --enable-werror $QEMU_CONFIGURE_OPTS --disable-system
+    - make -j$(expr $(nproc) + 1) all check-build
+
+cross-armel-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-armel-cross
+
+cross-armel-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-armel-cross
+
+cross-armhf-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-armhf-cross
+
+cross-armhf-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-armhf-cross
+
+cross-arm64-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-arm64-cross
+
+cross-arm64-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-arm64-cross
+
+cross-mips-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-mips-cross
+
+cross-mips-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-mips-cross
+
+cross-mipsel-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-mipsel-cross
+
+cross-mipsel-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-mipsel-cross
+
+cross-mips64el-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-mips64el-cross
+
+cross-mips64el-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-mips64el-cross
+
+cross-ppc64el-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-ppc64el-cross
+
+cross-ppc64el-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-ppc64el-cross
+
+cross-s390x-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-s390x-cross
+
+cross-s390x-user:
+  <<: *cross_user_build_job_definition
+  variables:
+    IMAGE: debian-s390x-cross
+
+cross-win32-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-win32-cross
+
+cross-win64-system:
+  <<: *cross_system_build_job_definition
+  variables:
+    IMAGE: debian-win64-cross
diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 362e5ee755..8f748237f8 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -18,6 +18,7 @@ include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
   - local: '/.gitlab-ci.d/containers.yml'
+  - local: '/.gitlab-ci.d/crossbuilds.yml'
 
 .native_build_job_template: &native_build_job_definition
   stage: build
diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b..2731f7a594 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3067,6 +3067,7 @@ M: Alex Bennée <alex.bennee@linaro.org>
 R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
 F: .gitlab-ci.yml
+F: .gitlab-ci.d/crossbuilds.yml
 
 Guest Test Compilation Support
 M: Alex Bennée <alex.bennee@linaro.org>
-- 
2.18.1


