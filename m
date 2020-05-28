Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF97C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:17:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBAB20776
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYj+Tvib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBAB20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFb4-0001Ev-8a
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVM-00084c-1p
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVL-0003TN-1e
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590660674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNf3cU2oyR5QNcg1NDTqnK9CdNawf41GU1VX4DKDoQk=;
 b=cYj+Tvib5rc/20veMoFED0rYwsEAyW0JdnPAn0zg+6g3kJrNEaD4T3HMJZQf3lN+f9etIG
 GUAWYcOFLaVr79X9vo0AnaEFAD2U+g08dXvUQvGAeprLKwCd9fZ7fduk30hZW7SdO0X7sx
 pdR5KdzQEx6cHAviWLbPpLoH1JubtZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-u0JyY8DhN6qCoOe36sE9IQ-1; Thu, 28 May 2020 06:11:10 -0400
X-MC-Unique: u0JyY8DhN6qCoOe36sE9IQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4FC6418FE861;
 Thu, 28 May 2020 10:11:09 +0000 (UTC)
Received: from thuth.com (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 29A095D9EF;
 Thu, 28 May 2020 10:11:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 6/7] gitlab-ci: Do not use the standard container images from
 gitlab
Date: Thu, 28 May 2020 12:10:38 +0200
Message-Id: <20200528101039.24600-7-thuth@redhat.com>
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

Currently all pipelines of the gitlab CI are failing, except for the
"build-user" pipeline. There is an issue with the default container
image (likely Debian stable) where they imported something bad in one
of the system headers:

 /usr/include/linux/swab.h: In function '__swab':
 /builds/huth/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not
  defined, evaluates to 0 [-Werror=undef]
 #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)

We could maybe work-around this issue or wait for the default containers
to get fixed, but considering that we use Ubuntu (and thus Debian-style)
CI in Travis already to a very large extent, we should consider to use
some RPM-based distros in our gitlab CI instead. Thus let's change the
failing pipelines to use Fedora and CentOS (and also one Ubuntu 19.10,
since 20.04 is broken, too) now.

Message-Id: <20200525131823.715-6-thuth@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5208d93ff8..559ec2ab4d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -5,9 +5,17 @@ include:
 .update_apt_template: &before_script_apt
  before_script:
   - apt-get update -qq
-  - apt-get install -y -qq libglib2.0-dev libpixman-1-dev genisoimage
+  - apt-get install -y -qq git gcc libglib2.0-dev libpixman-1-dev make
+        genisoimage
+
+.update_dnf_template: &before_script_dnf
+ before_script:
+  - dnf update -y
+  - dnf install -y bzip2 diffutils gcc git genisoimage findutils glib2-devel
+        make python3 perl-podlators perl-Test-Harness pixman-devel zlib-devel
 
 build-system1:
+ image: ubuntu:19.10
  <<: *before_script_apt
  script:
  - apt-get install -y -qq libgtk-3-dev libvte-dev nettle-dev libcacard-dev
@@ -21,11 +29,12 @@ build-system1:
  - make -j2 check
 
 build-system2:
- <<: *before_script_apt
+ image: fedora:latest
+ <<: *before_script_dnf
  script:
- - apt-get install -y -qq libsdl2-dev libgcrypt-dev libbrlapi-dev libaio-dev
-      libfdt-dev liblzo2-dev librdmacm-dev libibverbs-dev libibumad-dev
-      libzstd-dev
+ - yum install -y SDL2-devel libgcrypt-devel brlapi-devel libaio-devel
+       libfdt-devel lzo-devel librdmacm-devel libibverbs-devel libibumad-devel
+       libzstd-devel
  - mkdir build
  - cd build
  - ../configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
@@ -35,7 +44,8 @@ build-system2:
  - make -j2 check
 
 build-disabled:
- <<: *before_script_apt
+ image: fedora:latest
+ <<: *before_script_dnf
  script:
  - mkdir build
  - cd build
@@ -50,9 +60,10 @@ build-disabled:
  - make -j2 check-qtest SPEED=slow
 
 build-tcg-disabled:
- <<: *before_script_apt
+ image: centos:8
+ <<: *before_script_dnf
  script:
- - apt-get install -y -qq clang libgtk-3-dev libusb-dev
+ - dnf install -y clang gtk3-devel libusbx-devel libgcrypt-devel
  - mkdir build
  - cd build
  - ../configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
@@ -79,10 +90,11 @@ build-user:
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
 
 build-clang:
- <<: *before_script_apt
+ image: fedora:latest
+ <<: *before_script_dnf
  script:
- - apt-get install -y -qq clang libsdl2-dev libattr1-dev libcap-ng-dev
-      xfslibs-dev libiscsi-dev libnfs-dev libseccomp-dev gnutls-dev librbd-dev
+ - yum install -y clang SDL2-devel libattr-devel libcap-ng-devel xfsprogs-devel
+       libiscsi-devel libnfs-devel libseccomp-devel gnutls-devel librbd-devel
  - mkdir build
  - cd build
  - ../configure --cc=clang --cxx=clang++ --enable-werror
@@ -92,7 +104,8 @@ build-clang:
  - make -j2 check
 
 build-tci:
- <<: *before_script_apt
+ image: centos:8
+ <<: *before_script_dnf
  script:
  - TARGETS="aarch64 alpha arm hppa m68k microblaze moxie ppc64 s390x x86_64"
  - mkdir build
-- 
2.18.1


