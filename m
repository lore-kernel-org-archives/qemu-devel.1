Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3937EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:13:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 074BB2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iC3/P9jW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 074BB2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFXF-0003F0-7U
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVD-0007o7-HV
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVC-0003P8-MM
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590660666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L6l/Pyxp3UNeqwPyE5zJPTavGtjyIEE5ZZIqpmgPSeE=;
 b=iC3/P9jWzclH6EQuntOfnF9AhfkOTCmC3YliLvu2z0L3w2E3GLuXXIOnIHi4V8T+uWAymR
 L0O0WG12j7r6YvHJVw6F2ZWSf0qGi1I0821RmP9VwA31tk67jJN3cbJhOZYn4wYy3niuld
 lgeGImE5EwvEmzw4LshOgrAXVvnJK0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-bolhuVtCNYuqzzkmIhjWBg-1; Thu, 28 May 2020 06:11:01 -0400
X-MC-Unique: bolhuVtCNYuqzzkmIhjWBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D45F518FE860;
 Thu, 28 May 2020 10:11:00 +0000 (UTC)
Received: from thuth.com (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25EC45D9EF;
 Thu, 28 May 2020 10:10:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 4/7] GitLab CI: avoid calling before_scripts on unintended jobs
Date: Thu, 28 May 2020 12:10:36 +0200
Message-Id: <20200528101039.24600-5-thuth@redhat.com>
In-Reply-To: <20200528101039.24600-1-thuth@redhat.com>
References: <20200528101039.24600-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cleber Rosa <crosa@redhat.com>

At this point it seems that all jobs depend on those steps, with
maybe the EDK2 jobs as exceptions.

The jobs that will be added later will not want those scripts to be
run, so let's move these steps to the appropriate jobs, while
still trying to avoid repetition.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
Message-Id: <20200525131823.715-4-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
[thuth: Rebased to current master branch, use separate template]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 994774250f..bc6aee6aba 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,11 +2,13 @@ include:
   - local: '/.gitlab-ci-edk2.yml'
   - local: '/.gitlab-ci-opensbi.yml'
 
-before_script:
- - apt-get update -qq
- - apt-get install -y -qq libglib2.0-dev libpixman-1-dev genisoimage
+.update_apt_template: &before_script_apt
+ before_script:
+  - apt-get update -qq
+  - apt-get install -y -qq libglib2.0-dev libpixman-1-dev genisoimage
 
 build-system1:
+ <<: *before_script_apt
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
       libusb-dev libvde-dev libspice-protocol-dev libgl1-mesa-dev libvdeplug-dev
@@ -19,6 +21,7 @@ build-system1:
  - make -j2 check
 
 build-system2:
+ <<: *before_script_apt
  script:
  - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-dev
       libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
@@ -32,6 +35,7 @@ build-system2:
  - make -j2 check
 
 build-disabled:
+ <<: *before_script_apt
  script:
  - mkdir build
  - cd build
@@ -46,6 +50,7 @@ build-disabled:
  - make -j2 check-qtest SPEED=slow
 
 build-tcg-disabled:
+ <<: *before_script_apt
  script:
  - apt-get install -y -qq clang libgtk-3-dev libusb-dev
  - mkdir build
@@ -64,6 +69,7 @@ build-tcg-disabled:
             260 261 262 263 264 270 272 273 277 279
 
 build-user:
+ <<: *before_script_apt
  script:
  - mkdir build
  - cd build
@@ -73,6 +79,7 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
 
 build-clang:
+ <<: *before_script_apt
  script:
  - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
       xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
@@ -85,6 +92,7 @@ build-clang:
  - make -j2 check
 
 build-tci:
+ <<: *before_script_apt
  script:
  - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
  - mkdir build
-- 
2.18.1


