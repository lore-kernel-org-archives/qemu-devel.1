Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BBF5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766C12080A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 11:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766C12080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT1OU-0000wD-AS
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 07:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kT1Nf-0000OQ-JW
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:25:11 -0400
Received: from mail.ispras.ru ([83.149.199.84]:47180)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kT1Nc-0007p8-Ul
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 07:25:11 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 3DED240A1DD4;
 Thu, 15 Oct 2020 11:25:03 +0000 (UTC)
Subject: [PATCH] tests/acceptance: add MIPS record/replay tests
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Thu, 15 Oct 2020 14:25:02 +0300
Message-ID: <160276110297.2705.10918105269658307206.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 07:25:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, PDS_BTC_ID=0.498,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: pavel.dovgalyuk@ispras.ru, ehabkost@redhat.com, alex.bennee@linaro.org,
 wrampazz@redhat.com, crosa@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch adds MIPS-targeted acceptance tests for
record/replay functions.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
---
 0 files changed

diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay_kernel.py
index 952f429cac..6c3d1ec3fb 100644
--- a/tests/acceptance/replay_kernel.py
+++ b/tests/acceptance/replay_kernel.py
@@ -9,6 +9,8 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
+import lzma
+import shutil
 import logging
 import time
 
@@ -19,7 +21,7 @@ from avocado.utils import archive
 from avocado.utils import process
 from boot_linux_console import LinuxKernelTest
 
-class ReplayKernel(LinuxKernelTest):
+class ReplayKernelBase(LinuxKernelTest):
     """
     Boots a Linux kernel in record mode and checks that the console
     is operational and the kernel command line is properly passed
@@ -74,6 +76,7 @@ class ReplayKernel(LinuxKernelTest):
         logger = logging.getLogger('replay')
         logger.info('replay overhead {:.2%}'.format(t2 / t1 - 1))
 
+class ReplayKernelNormal(ReplayKernelBase):
     @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
     def test_x86_64_pc(self):
         """
@@ -91,6 +94,103 @@ class ReplayKernel(LinuxKernelTest):
 
         self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
 
+    def test_mips_malta(self):
+        """
+        :avocado: tags=arch:mips
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:big
+        """
+        deb_url = ('http://snapshot.debian.org/archive/debian/'
+                   '20130217T032700Z/pool/main/l/linux-2.6/'
+                   'linux-image-2.6.32-5-4kc-malta_2.6.32-48_mips.deb')
+        deb_hash = 'a8cfc28ad8f45f54811fc6cf74fc43ffcfe0ba04'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-2.6.32-5-4kc-malta')
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+    def test_mips64el_malta(self):
+        """
+        This test requires the ar tool to extract "data.tar.gz" from
+        the Debian package.
+
+        The kernel can be rebuilt using this Debian kernel source [1] and
+        following the instructions on [2].
+
+        [1] http://snapshot.debian.org/package/linux-2.6/2.6.32-48/
+            #linux-source-2.6.32_2.6.32-48
+        [2] https://kernel-team.pages.debian.net/kernel-handbook/
+            ch-common-tasks.html#s-common-official
+
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:malta
+        """
+        deb_url = ('http://snapshot.debian.org/archive/debian/'
+                   '20130217T032700Z/pool/main/l/linux-2.6/'
+                   'linux-image-2.6.32-5-5kc-malta_2.6.32-48_mipsel.deb')
+        deb_hash = '1aaec92083bf22fda31e0d27fa8d9a388e5fc3d5'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-2.6.32-5-5kc-malta')
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=ttyS0'
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5)
+
+    def do_test_mips_malta32el_nanomips(self, kernel_path_xz):
+        kernel_path = self.workdir + "kernel"
+        with lzma.open(kernel_path_xz, 'rb') as f_in:
+            with open(kernel_path, 'wb') as f_out:
+                shutil.copyfileobj(f_in, f_out)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'mem=256m@@0x0 '
+                               + 'console=ttyS0')
+        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=('-cpu', 'I7200'))
+
+    def test_mips_malta32el_nanomips_4k(self):
+        """
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        """
+        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+                      'generic_nano32r6el_page4k.xz')
+        kernel_hash = '477456aafd2a0f1ddc9482727f20fe9575565dd6'
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+    def test_mips_malta32el_nanomips_16k_up(self):
+        """
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        """
+        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+                      'generic_nano32r6el_page16k_up.xz')
+        kernel_hash = 'e882868f944c71c816e832e2303b7874d044a7bc'
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
+    def test_mips_malta32el_nanomips_64k_dbg(self):
+        """
+        :avocado: tags=arch:mipsel
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        """
+        kernel_url = ('https://mipsdistros.mips.com/LinuxDistro/nanomips/'
+                      'kernels/v4.15.18-432-gb2eb9a8b07a1-20180627102142/'
+                      'generic_nano32r6el_page64k_dbg.xz')
+        kernel_hash = '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
+        kernel_path_xz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        self.do_test_mips_malta32el_nanomips(kernel_path_xz)
+
     def test_aarch64_virt(self):
         """
         :avocado: tags=arch:aarch64
@@ -302,3 +402,70 @@ class ReplayKernel(LinuxKernelTest):
         file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
         self.do_test_advcal_2018(file_path, 'santas-sleigh-ride.elf',
                                  args=('-cpu', 'dc233c'))
+
+class ReplayKernelSlow(ReplayKernelBase):
+    timeout = 180
+
+    def test_mips_malta_cpio(self):
+        """
+        :avocado: tags=arch:mips
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:big
+        :avocado: tags=slowness:high
+        """
+        # Override the timeout, because this kernel includes
+        # an inner loop which is executed with TB recompilings during
+        # replay, making it very slow.
+        deb_url = ('http://snapshot.debian.org/archive/debian/'
+                   '20160601T041800Z/pool/main/l/linux/'
+                   'linux-image-4.5.0-2-4kc-malta_4.5.5-1_mips.deb')
+        deb_hash = 'a3c84f3e88b54e06107d65a410d1d1e8e0f340f8'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinux-4.5.0-2-4kc-malta')
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
+                      'mips/rootfs.cpio.gz')
+        initrd_hash = 'bf806e17009360a866bf537f6de66590de349a99'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = self.workdir + "rootfs.cpio"
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        console_pattern = 'Boot successful.'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=('-initrd', initrd_path))
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    def test_mips64el_malta_5KEc_cpio(self):
+        """
+        :avocado: tags=arch:mips64el
+        :avocado: tags=machine:malta
+        :avocado: tags=endian:little
+        :avocado: tags=slowness:high
+        """
+        # Override the timeout, because this kernel includes
+        # an inner loop which is executed with TB recompilings during
+        # replay, making it very slow.
+        kernel_url = ('https://github.com/philmd/qemu-testing-blob/'
+                      'raw/9ad2df38/mips/malta/mips64el/'
+                      'vmlinux-3.19.3.mtoman.20150408')
+        kernel_hash = '00d1d268fb9f7d8beda1de6bebcc46e884d71754'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        initrd_url = ('https://github.com/groeck/linux-build-test/'
+                      'raw/8584a59e/rootfs/'
+                      'mipsel64/rootfs.mipsel64r1.cpio.gz')
+        initrd_hash = '1dbb8a396e916847325284dbe2151167'
+        initrd_path_gz = self.fetch_asset(initrd_url, algorithm='md5',
+                                          asset_hash=initrd_hash)
+        initrd_path = self.workdir + "rootfs.cpio"
+        archive.gzip_uncompress(initrd_path_gz, initrd_path)
+
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
+                               + 'console=ttyS0 console=tty '
+                               + 'rdinit=/sbin/init noreboot')
+        console_pattern = 'Boot successful.'
+        self.run_rr(kernel_path, kernel_command_line, console_pattern, shift=5,
+                    args=('-initrd', initrd_path, '-cpu', '5KEc'))


