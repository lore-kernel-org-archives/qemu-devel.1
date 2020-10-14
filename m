Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB2C43457
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:23:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F11F214D8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 05:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dX++O9c/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F11F214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSZGK-0006H4-5x
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 01:23:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSZEi-0004bb-Qn
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:22:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38850)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSZEe-0003F6-KY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 01:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602652919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ves9dhQ7uA40qroFqiDykwJd40sbkpK3awlCdW3aOiE=;
 b=dX++O9c/eOtsqf+9oV36t5fIWiguBBmKzJFDoo9ar1pXgT8leKUHbkZoPUgo6u7KvbWFky
 DqgKrv+XDVpKLhk80YVEvbCfjwQnOPaCARAySa/oj0qXgKjDxQ2ewuBj25SfCggHJX06tT
 cQpJDdHcuhKdxavmzuxuN3BqC0CJ26Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-hdRcwy3yNDmFa4KDv9ZORw-1; Wed, 14 Oct 2020 01:21:54 -0400
X-MC-Unique: hdRcwy3yNDmFa4KDv9ZORw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A254656BE6;
 Wed, 14 Oct 2020 05:21:53 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B0D95D9CD;
 Wed, 14 Oct 2020 05:21:52 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 4/4] Jobs based on custom runners: add job definitions for
 QEMU's machines
Date: Wed, 14 Oct 2020 01:21:40 -0400
Message-Id: <20201014052140.1146924-5-crosa@redhat.com>
In-Reply-To: <20201014052140.1146924-1-crosa@redhat.com>
References: <20201014052140.1146924-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Erik Skultety <eskultet@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, Andrea Bolognani <abologna@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The QEMU project has two machines (aarch64 and s390) that can be used
for jobs that do build and run tests.  This introduces those jobs,
which are a mapping of custom scripts used for the same purpose.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .gitlab-ci.d/custom-runners.yml | 192 ++++++++++++++++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 3004da2bda..5b51d1b336 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -12,3 +12,195 @@
 # strategy.
 variables:
   GIT_SUBMODULE_STRATEGY: recursive
+
+# All ubuntu-18.04 jobs should run successfully in an environment
+# setup by the scripts/ci/setup/build-environment.yml task
+# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
+ubuntu-18.04-s390x-all-linux-static:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+bug/1838763
+ # --disable-glusterfs is needed because there's no static version of those libs in distro supplied packages
+ - mkdir build
+ - cd build
+ - ../configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+ - make --output-sync -j`nproc` check-tcg V=1
+
+ubuntu-18.04-s390x-all:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-18.04-s390x-alldbg:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --enable-debug --disable-libssh
+ - make clean
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-18.04-s390x-clang:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-sanitizers
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-18.04-s390x-tci:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh --enable-tcg-interpreter
+ - make --output-sync -j`nproc`
+
+ubuntu-18.04-s390x-notcg:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_18.04
+ - s390x
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh --disable-tcg
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+# All ubuntu-20.04 jobs should run successfully in an environment
+# setup by the scripts/ci/setup/qemu/build-environment.yml task
+# "Install basic packages to build QEMU on Ubuntu 18.04/20.04"
+ubuntu-20.04-aarch64-all-linux-static:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ # --disable-libssh is needed because of https://bugs.launchpad.net/qemu/+bug/1838763
+ # --disable-glusterfs is needed because there's no static version of those libs in distro supplied packages
+ - mkdir build
+ - cd build
+ - ../configure --enable-debug --static --disable-system --disable-glusterfs --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+ - make --output-sync -j`nproc` check-tcg V=1
+
+ubuntu-20.04-aarch64-all:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-20.04-aarch64-alldbg:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --enable-debug --disable-libssh
+ - make clean
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-20.04-aarch64-clang:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh --cc=clang --cxx=clang++ --enable-sanitizers
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
+
+ubuntu-20.04-aarch64-tci:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh --enable-tcg-interpreter
+ - make --output-sync -j`nproc`
+
+ubuntu-20.04-aarch64-notcg:
+ needs: []
+ stage: build
+ tags:
+ - ubuntu_20.04
+ - aarch64
+ rules:
+ - if: '$CI_COMMIT_BRANCH =~ /^staging/'
+ script:
+ - mkdir build
+ - cd build
+ - ../configure --disable-libssh --disable-tcg
+ - make --output-sync -j`nproc`
+ - make --output-sync -j`nproc` check V=1
-- 
2.25.4


