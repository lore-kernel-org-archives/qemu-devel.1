Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60834C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A8632071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhE1OSHM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A8632071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdD1K-0005MZ-9Y
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 09:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41924)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdD0N-0003oK-NX
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:18:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44413
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jdD0M-0004CT-Rq
 for qemu-devel@nongnu.org; Mon, 25 May 2020 09:18:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590412738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=vgVKm2jtWg6qxjCB8UIltkWmTVKHw4S4ci2h8UYybB0=;
 b=RhE1OSHMV46ohNGgo+Zp0KOufnT+NU1hpzdx3GQ52jeaJF8LxKeGc4fnFYVxV2cnIEW7CF
 dyFsyehmccR0WiTseFFB7oeQTl8BOPPLT4V8x7ILNFGHPEHjIeCpLzG4/vzUc8QP4dNfbI
 JVRo/VcY65ASFk7Os/KXM5huPEN5e6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-zWCj2D9SOM2E9GNbprHGiQ-1; Mon, 25 May 2020 09:18:55 -0400
X-MC-Unique: zWCj2D9SOM2E9GNbprHGiQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F6331005510;
 Mon, 25 May 2020 13:18:55 +0000 (UTC)
Received: from thuth.com (ovpn-113-78.ams2.redhat.com [10.36.113.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 608175C1BB;
 Mon, 25 May 2020 13:18:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] GitLab CI: avoid calling before_scripts on unintended jobs
Date: Mon, 25 May 2020 15:18:19 +0200
Message-Id: <20200525131823.715-4-thuth@redhat.com>
In-Reply-To: <20200525131823.715-1-thuth@redhat.com>
References: <20200525131823.715-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 02:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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


