Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEA5C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CE4C20838
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 09:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y0YaDWHJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CE4C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36095 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmwyp-0003Fh-SC
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 05:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47107)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <chihmin.chao@sifive.com>) id 1hmwye-0002pn-Lm
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chihmin.chao@sifive.com>) id 1hmwyd-0004ic-Bg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:08:56 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:38467)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <chihmin.chao@sifive.com>)
 id 1hmwyd-0004ei-4n
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 05:08:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id y15so7127481pfn.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=N+oIfyziDuwnxLpKqhY/smwRwjf6Qx0rWIQdNNXocn0=;
 b=Y0YaDWHJx/yD1Bz8WVXGtzxynTylq1nfqpuXhwSu+Vk+vluD0EAJ/p7AYYlKvmvPlg
 Ga8CUtxEg291DI7LpZyjaIvAaC3Kzd1Reo/usLLe2UZ6ilTgG7TaCvDwfO+lEHMHltTG
 xk9GfePJ1GPnrEhZhSfujl8rbGEQOqdO7P+m1EBB3VfuoNacPgjCpa64ZzSTnWf88Gwt
 9NeFaPS/c727F6F/UeU9JJ6RBSU6lZGzKSSSjwb+ucp9BQnIBkIWZqFxzaq3DCFmLxQX
 sFuk0vFbg0a6jILMc4vd+tDKE3EiHO6huPrRd/URjjZdOpv9Ch9h1Z7rW7nalYKBDnYI
 LPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=N+oIfyziDuwnxLpKqhY/smwRwjf6Qx0rWIQdNNXocn0=;
 b=Bt6WKEjLP9CiFsH+85Jt2UTNAW6snMNvsAAcFgK7YVp1a/ASL32WTH1azMbXm/9YQC
 tUY+GbKbLr8UWq/bk5mIMiiBy8f8M2jKF4CqkxTL/5zh3V+FJYMcxQsgiPvMZKn9metf
 UrKbSQHbNkqvTKBcmAvwfOcIBI6XStS7nGJx6qwto3cZ1WeJ3IGOVPEy78uhQoTRkFLC
 geM/xsek45IBJabpjdCVhKbdTZzTM6NgjjjZqzmLHLpYUVLVzMv4Z655q1NZIcDAaIXQ
 biHQa20TaQCdnisawQUrFLONtvPcs550RJ1NaVJAVB8QN+Y1pcFyGlrVuNgoXetgtUH3
 +BBw==
X-Gm-Message-State: APjAAAWY2/bt61RO6OoclFPdcHEapwV6OkayKZMOx+y2GM4qrAi7oiYU
 HwQl09+YevFEloT4NUcAQWV77BOYKO0=
X-Google-Smtp-Source: APXvYqwWBv4K7fkwNOaYu9rcWQr1X4BmonExcr/sRL371d3/Jha+Nn2vCx+YBQGw6u2YSG5LdkTR6w==
X-Received: by 2002:a17:90a:c596:: with SMTP id
 l22mr28413823pjt.46.1563181733089; 
 Mon, 15 Jul 2019 02:08:53 -0700 (PDT)
Received: from gamma06.internal.sifive.com ([64.62.193.194])
 by smtp.gmail.com with ESMTPSA id w197sm23458159pfd.41.2019.07.15.02.08.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Jul 2019 02:08:52 -0700 (PDT)
From: Chih-Min Chao <chihmin.chao@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 15 Jul 2019 02:08:36 -0700
Message-Id: <1563181721-5055-1-git-send-email-chihmin.chao@sifive.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: [Qemu-devel] [PATCH v2] tests/boot_linux_console: add a test for
 riscv64 + virt
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Chih-Min Chao <chihmin.chao@sifive.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Similar to the mips + malta test, it boots a Linux kernel on a virt
board and verify the serial is working.  Also, it relies on the serial
device set by the machine itself.

If riscv64 is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:riscv64" tags.

Alternatively, this test can be run using:

  $ avocado run -t arch:riscv64 tests/acceptance

packages
  debian official
    binutils-riscv64-linux-gnu_2.32-8
    opensbi_0.4-1_all
    linux-image-4.19.0-5-riscv64 4.19.37-4
  third-party
    https://github.com/groeck/linux-build-test/rootfs/riscv64/rootfs.cpio.gz
    (the repo is also used in mips target acceptance)

Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
---
 .travis.yml                            |  2 +-
 tests/acceptance/boot_linux_console.py | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 5d3d6ee..21fcead 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -232,7 +232,7 @@ matrix:
 
     # Acceptance (Functional) tests
     - env:
-        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
+        - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu,riscv64-softmmu"
         - TEST_CMD="make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 3215950..0f638bc 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -354,3 +354,69 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
+
+    def test_riscv64_virt(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                         '20190424T171759Z/pool/main/b/binutils/'
+                         'binutils-riscv64-linux-gnu_2.32-8_amd64.deb')
+        deb_hash = ('7fe376fd4452696c03acd508d6d613ca553ea15e')
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        objcopy_path = '/usr/bin/riscv64-linux-gnu-objcopy'
+        objcopy_path = self.extract_from_deb(deb_path, objcopy_path)
+        libbfd_path = '/usr/lib/x86_64-linux-gnu/libbfd-2.32-riscv64.so'
+        libbfd_path = self.extract_from_deb(deb_path, libbfd_path)
+        process.run('ls -al %s' % (objcopy_path))
+
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20190708T032337Z/pool/main/o/opensbi/'
+                   'opensbi_0.4-1_all.deb')
+        deb_hash = ('2319dcd702958291d323acf5649fd98a11d90112')
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        opensbi_path = ('/usr/lib/riscv64-linux-gnu/opensbi/'
+                        'qemu/virt/fw_jump.elf')
+        opensbi_path = self.extract_from_deb(deb_path, opensbi_path)
+
+        deb_url = ('https://snapshot.debian.org/archive/debian-ports/'
+                   '20190620T095935Z/pool-riscv64/main/l/linux/'
+                   'linux-image-4.19.0-5-riscv64_4.19.37-4_riscv64.deb')
+        deb_hash = ('bf5b5680c41d92134d22caef4fbd277c5217e1f0')
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = '/boot/vmlinux-4.19.0-5-riscv64'
+        kernel_path = self.extract_from_deb(deb_path, kernel_path)
+        kimage_path = self.workdir + "/Image"
+        env = os.environ
+        env['LD_LIBRARY_PATH'] = ('%s:' % (os.path.dirname(libbfd_path)) +
+                                 env.get('LD_LIBRARY_PATH', ''))
+        process.run(('%s -O binary -O binary -R'
+                     '.note -R .note.gnu.build-id -R .comment -S %s %s') %
+                     (objcopy_path, kernel_path, kimage_path))
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+                      'riscv64/rootfs.cpio.gz')
+        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+
+        self.vm.set_machine('virt')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 noreboot')
+        self.vm.add_args('-bios', opensbi_path,
+                         '-kernel', kimage_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
+                                               'isa')
+        self.exec_command_and_wait_for_pattern('uname -a',
+                                               'SMP Debian')
+        self.exec_command_and_wait_for_pattern('reboot',
+                                               'reboot: Restarting system')
-- 
2.7.4


