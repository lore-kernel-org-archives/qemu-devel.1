Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D05C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3E7207F9
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 16:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GY54qasg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3E7207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZdS5-0006GQ-UD
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 12:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZdRP-0005iQ-0W
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:44:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44110
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jZdRO-0006uL-0W
 for qemu-devel@nongnu.org; Fri, 15 May 2020 12:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589561044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=mjbARusCKKYfVYrSCZw2QjRCxpEhgf+YoN3hldQmzdE=;
 b=GY54qasgp0IxV5kMVhgVImhbHjuGDTmTuh122d3xdp4BmGZoQ+n4IFWRUIloaIPlYcB4J6
 O8BjkYOdCcpJZFBs2wkEqd69lFljky1TtjBFez954CkQhsk1X5gDrhWT8BsBycrWKHVKNh
 DoMQNZHFOWj6ifcHtOd59vB9tlxzHMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-66Rnlrw_MzK2TwrCS6zMaw-1; Fri, 15 May 2020 12:43:58 -0400
X-MC-Unique: 66Rnlrw_MzK2TwrCS6zMaw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D014106B3A5;
 Fri, 15 May 2020 16:43:50 +0000 (UTC)
Received: from thuth.com (ovpn-113-42.ams2.redhat.com [10.36.113.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8908B6E9EB;
 Fri, 15 May 2020 16:43:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: [PATCH] tests/acceptance: Add boot tests for sh4 QEMU advent calendar
 image
Date: Fri, 15 May 2020 18:43:37 +0200
Message-Id: <20200515164337.4899-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that we can select the second serial console in the acceptance tests
(see commit 746f244d9720 "Allow to use other serial consoles than default"),
we can also test the sh4 image from the QEMU advent calendar 2018.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 I've split my original patch that also added yet another mips64 test...
 I hope it's easier to review/ack/merge this way this only addresses sh4 here.

 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index fe708792ca..84b7f83ac4 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -291,7 +291,7 @@ jobs:
     - name: "GCC check-acceptance"
       dist: bionic
       env:
-        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
+        - CONFIG="--enable-tools --target-list=aarch64-softmmu,alpha-softmmu,arm-softmmu,m68k-softmmu,microblaze-softmmu,mips-softmmu,mips64el-softmmu,nios2-softmmu,or1k-softmmu,ppc-softmmu,ppc64-softmmu,s390x-softmmu,sh4-softmmu,sparc-softmmu,x86_64-softmmu,xtensa-softmmu"
         - TEST_CMD="make check-acceptance"
         - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-acceptance"
       after_script:
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index c6b06a1a13..0653c8c1bf 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -826,12 +826,12 @@ class BootLinuxConsole(Test):
         console_pattern = 'No filesystem could mount root'
         self.wait_for_console_pattern(console_pattern)
 
-    def do_test_advcal_2018(self, day, tar_hash, kernel_name):
+    def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
         tar_url = ('https://www.qemu-advent-calendar.org'
                    '/2018/download/day' + day + '.tar.xz')
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         archive.extract(file_path, self.workdir)
-        self.vm.set_console()
+        self.vm.set_console(console_index=console)
         self.vm.add_args('-kernel',
                          self.workdir + '/day' + day + '/' + kernel_name)
         self.vm.launch()
@@ -905,6 +905,15 @@ class BootLinuxConsole(Test):
         self.vm.add_args('-M', 'graphics=off')
         self.do_test_advcal_2018('15', tar_hash, 'invaders.elf')
 
+    def test_sh4_r2d(self):
+        """
+        :avocado: tags=arch:sh4
+        :avocado: tags=machine:r2d
+        """
+        tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
+        self.vm.add_args('-append', 'console=ttySC1')
+        self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
+
     def test_sparc_ss20(self):
         """
         :avocado: tags=arch:sparc
-- 
2.18.1


