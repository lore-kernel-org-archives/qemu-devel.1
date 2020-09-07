Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93443C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:22:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087E421775
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 04:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYMYale4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087E421775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kF8fO-0000eM-4h
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 00:22:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kF8dn-0006mw-2x
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 00:20:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42717
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kF8dk-0006xx-Vs
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 00:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599452423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1sO/F9TedgAcWLmV1eWEgoBI98exY9YnRjP3JaWCDl0=;
 b=AYMYale4RQwHeE9V9gTfKtq34adOiaLKCHrZg1jYaZamJE+pPvmTPFquo0Dd0qNXTp6bAV
 0RpjV5FjVBDqaBwixxzBNRFMPjVwrs0l9i8ET8XkYoypIem/u7ZBGQUOaQDcxXDPYzqv3y
 GW2b658IrGue/+HmyciDCQWnEzKWNLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-VvGfPN2DNMS6gq778xRX0Q-1; Mon, 07 Sep 2020 00:20:16 -0400
X-MC-Unique: VvGfPN2DNMS6gq778xRX0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0134E1009443;
 Mon,  7 Sep 2020 04:20:14 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-120-166.rdu2.redhat.com
 [10.10.120.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 354F21002D49;
 Mon,  7 Sep 2020 04:20:10 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/4] Acceptance tests: use an available kernel image package
 for arm
Date: Mon,  7 Sep 2020 00:19:57 -0400
Message-Id: <20200907042000.415931-2-crosa@redhat.com>
In-Reply-To: <20200907042000.415931-1-crosa@redhat.com>
References: <20200907042000.415931-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 21:15:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Which means a newer kernel version.  Expected output was changed
to match the new kernel too.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 44 +++++++++++++-------------
 tests/acceptance/replay_kernel.py      |  8 ++---
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index aaa781a581..751b47b8fd 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -490,12 +490,12 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=arch:arm
         :avocado: tags=machine:cubieboard
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
-        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
+                   'linux-image-dev-sunxi_20.08_armhf.deb')
+        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.20.7-sunxi')
+                                            '/boot/vmlinuz-5.8.0-sunxi')
         dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
@@ -522,7 +522,7 @@ class BootLinuxConsole(LinuxKernelTest):
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                 'Allwinner sun4i/sun5i')
         exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
-                                                'system-control@1c00000')
+                                                '1c00000.system-control')
         # cubieboard's reboot is not functioning; omit reboot test.
 
     def test_arm_cubieboard_sata(self):
@@ -530,12 +530,12 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=arch:arm
         :avocado: tags=machine:cubieboard
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
-        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
+                   'linux-image-dev-sunxi_20.08_armhf.deb')
+        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.20.7-sunxi')
+                                            '/boot/vmlinuz-5.8.0-sunxi')
         dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('https://github.com/groeck/linux-build-test/raw/'
@@ -573,12 +573,12 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
-        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
+                   'linux-image-dev-sunxi_20.08_armhf.deb')
+        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.20.7-sunxi')
+                                            '/boot/vmlinuz-5.8.0-sunxi')
         dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
 
@@ -598,12 +598,12 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=arch:arm
         :avocado: tags=machine:orangepi-pc
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
-        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
+                   'linux-image-dev-sunxi_20.08_armhf.deb')
+        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.20.7-sunxi')
+                                            '/boot/vmlinuz-5.8.0-sunxi')
         dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
@@ -629,7 +629,7 @@ class BootLinuxConsole(LinuxKernelTest):
         exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo',
                                                 'Allwinner sun8i Family')
         exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
-                                                'system-control@1c00000')
+                                                '1c00000.system-control')
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system')
         # Wait for VM to shut down gracefully
@@ -641,12 +641,12 @@ class BootLinuxConsole(LinuxKernelTest):
         :avocado: tags=machine:orangepi-pc
         :avocado: tags=device:sd
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
-        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
+                   'linux-image-dev-sunxi_20.08_armhf.deb')
+        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.20.7-sunxi')
+                                            '/boot/vmlinuz-5.8.0-sunxi')
         dtb_path = '/usr/lib/linux-image-dev-sunxi/sun8i-h3-orangepi-pc.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         rootfs_url = ('http://storage.kernelci.org/images/rootfs/buildroot/'
diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index b79fc8daf8..80a460814f 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -132,12 +132,12 @@ class ReplayKernel(LinuxKernelTest):
         :avocado: tags=arch:arm
         :avocado: tags=machine:cubieboard
         """
-        deb_url = ('https://apt.armbian.com/pool/main/l/'
-                   'linux-4.20.7-sunxi/linux-image-dev-sunxi_5.75_armhf.deb')
-        deb_hash = '1334c29c44d984ffa05ed10de8c3361f33d78315'
+        deb_url = ('https://apt.armbian.com/pool/main/l/linux-5.8.0-sunxi/'
+                   'linux-image-dev-sunxi_20.08_armhf.deb')
+        deb_hash = 'ae553a9f7d43b18abfa8f3e64bf2d31878b9be89'
         deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
         kernel_path = self.extract_from_deb(deb_path,
-                                            '/boot/vmlinuz-4.20.7-sunxi')
+                                            '/boot/vmlinuz-5.8.0-sunxi')
         dtb_path = '/usr/lib/linux-image-dev-sunxi/sun4i-a10-cubieboard.dtb'
         dtb_path = self.extract_from_deb(deb_path, dtb_path)
         initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
-- 
2.25.4


