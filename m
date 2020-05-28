Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814C2C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BC562075A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 10:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXYiSjgh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BC562075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeFXh-000408-Gv
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 06:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVN-00086x-4h
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jeFVM-0003Tq-3m
 for qemu-devel@nongnu.org; Thu, 28 May 2020 06:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590660675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fA/aOdTZYOe4tkHV6oQL79sbDJCrso6VigZdl6PZCk0=;
 b=YXYiSjghuNUa2OLvSmcd8Aa/s/4uhwX/kNKtIV5sqqnL+bZny4tOJGh1plmYBFPgLxAVFd
 S1sJCzLzS8+CNgAhuOkzRA4q9E7WjuRDB47iiSy0iq46vpBR6dIvleWpLXY/3fyMOeZOhp
 AFaWhFw0IkKPlHECa1AU8D0oATcbAw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-IMDzrXp5Pwqb9WM2TXuWXw-1; Thu, 28 May 2020 06:11:13 -0400
X-MC-Unique: IMDzrXp5Pwqb9WM2TXuWXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 636BA835B40;
 Thu, 28 May 2020 10:11:12 +0000 (UTC)
Received: from thuth.com (ovpn-112-213.ams2.redhat.com [10.36.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0A51B5D9EF;
 Thu, 28 May 2020 10:11:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 7/7] gitlab-ci: Determine the number of jobs dynamically
Date: Thu, 28 May 2020 12:10:39 +0200
Message-Id: <20200528101039.24600-8-thuth@redhat.com>
In-Reply-To: <20200528101039.24600-1-thuth@redhat.com>
References: <20200528101039.24600-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some people might want to run the gitlab CI pipelines in an environment
where multiple CPUs are available to the runners, so let's rather get
the number for "-j" from the "nproc" program (increased by 1 to compensate
for jobs that wait for I/O) instead of hard-coding it.

Message-Id: <20200525131823.715-7-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.yml | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 559ec2ab4d..349c77aa58 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -7,12 +7,14 @@ include:
   - apt-get update -qq
   - apt-get install -y -qq git gcc libglib2.0-dev libpixman-1-dev make
         genisoimage
+  - JOBS=$(expr $(nproc) + 1)
 
 .update_dnf_template: &before_script_dnf
  before_script:
   - dnf update -y
   - dnf install -y bzip2 diffutils gcc git genisoimage findutils glib2-devel
         make python3 perl-podlators perl-Test-Harness pixman-devel zlib-devel
+  - JOBS=$(expr $(nproc) + 1)
 
 build-system1:
  image: ubuntu:19.10
@@ -25,8 +27,8 @@ build-system1:
  - ../configure --enable-werror --target-list="aarch64-softmmu alpha-softmmu
       cris-softmmu hppa-softmmu lm32-softmmu moxie-softmmu microblazeel-softmmu
       mips64el-softmmu m68k-softmmu ppc-softmmu riscv64-softmmu sparc-softmmu"
- - make -j2
- - make -j2 check
+ - make -j"$JOBS"
+ - make -j"$JOBS" check
 
 build-system2:
  image: fedora:latest
@@ -40,8 +42,8 @@ build-system2:
  - ../configure --enable-werror --target-list="tricore-softmmu unicore32-softmmu
       microblaze-softmmu mips-softmmu riscv32-softmmu s390x-softmmu sh4-softmmu
       sparc64-softmmu x86_64-softmmu xtensa-softmmu nios2-softmmu or1k-softmmu"
- - make -j2
- - make -j2 check
+ - make -j"$JOBS"
+ - make -j"$JOBS" check
 
 build-disabled:
  image: fedora:latest
@@ -56,8 +58,8 @@ build-disabled:
       --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
       --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
       --target-list="i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user"
- - make -j2
- - make -j2 check-qtest SPEED=slow
+ - make -j"$JOBS"
+ - make -j"$JOBS" check-qtest SPEED=slow
 
 build-tcg-disabled:
  image: centos:8
@@ -67,7 +69,7 @@ build-tcg-disabled:
  - mkdir build
  - cd build
  - ../configure --cc=clang --enable-werror --disable-tcg --audio-drv-list=""
- - make -j2
+ - make -j"$JOBS"
  - make check-unit
  - make check-qapi-schema
  - cd tests/qemu-iotests/
@@ -86,7 +88,7 @@ build-user:
  - cd build
  - ../configure --enable-werror --disable-system --disable-guest-agent
                --disable-capstone --disable-slirp --disable-fdt
- - make -j2
+ - make -j"$JOBS"
  - make run-tcg-tests-i386-linux-user run-tcg-tests-x86_64-linux-user
 
 build-clang:
@@ -100,8 +102,8 @@ build-clang:
  - ../configure --cc=clang --cxx=clang++ --enable-werror
       --target-list="alpha-softmmu arm-softmmu m68k-softmmu mips64-softmmu
                      ppc-softmmu s390x-softmmu x86_64-softmmu arm-linux-user"
- - make -j2
- - make -j2 check
+ - make -j"$JOBS"
+ - make -j"$JOBS" check
 
 build-tci:
  image: centos:8
@@ -112,7 +114,7 @@ build-tci:
  - cd build
  - ../configure --enable-tcg-interpreter
       --target-list="$(for tg in $TARGETS; do echo -n ${tg}'-softmmu '; done)"
- - make -j2
+ - make -j"$JOBS"
  - make run-tcg-tests-x86_64-softmmu
  - make tests/qtest/boot-serial-test tests/qtest/cdrom-test tests/qtest/pxe-test
  - for tg in $TARGETS ; do
-- 
2.18.1


