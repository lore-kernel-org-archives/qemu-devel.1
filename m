Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CA4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2A02073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2A02073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtTC-00014w-Mi
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Pavel.Dovgaluk@gmail.com>)
 id 1jdtLV-000200-5o
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:31:37 -0400
Received: from mail.ispras.ru ([83.149.199.45]:33718)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Pavel.Dovgaluk@gmail.com>) id 1jdtLU-000252-2p
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:31:36 -0400
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id EC0F3CD463;
 Wed, 27 May 2020 13:31:34 +0300 (MSK)
Subject: [PATCH v2 10/11] tests/acceptance: refactor boot_linux to allow
 code reuse
From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>
To: qemu-devel@nongnu.org
Date: Wed, 27 May 2020 13:31:34 +0300
Message-ID: <159057549448.16818.934643360089121728.stgit@pasha-ThinkPad-X280>
In-Reply-To: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: softfail client-ip=83.149.199.45;
 envelope-from=Pavel.Dovgaluk@gmail.com; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 06:30:39
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 17
X-Spam_score: 1.7
X-Spam_bar: +
X-Spam_report: (1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_ADSP_CUSTOM_MED=0.001,
 FORGED_GMAIL_RCVD=1, FREEMAIL_FROM=0.001, FROM_WORDY=1,
 NML_ADSP_CUSTOM_MED=0.9, SPF_SOFTFAIL=0.665, T_FILL_THIS_FORM_SHORT=0.01,
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
Cc: wrampazz@redhat.com, alex.bennee@linaro.org, dovgaluk@ispras.ru,
 pavel.dovgaluk@ispras.ru, crosa@redhat.com, pbonzini@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch moves image downloading functions to the separate class to allow
reusing them from record/replay tests.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
---
 0 files changed

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 075a386300..3aa57e88b0 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -26,22 +26,8 @@ KVM_NOT_AVAILABLE = ACCEL_NOT_AVAILABLE_FMT % "KVM"
 TCG_NOT_AVAILABLE = ACCEL_NOT_AVAILABLE_FMT % "TCG"
 
 
-class BootLinux(Test):
-    """
-    Boots a Linux system, checking for a successful initialization
-    """
-
-    timeout = 900
-    chksum = None
-
-    def setUp(self):
-        super(BootLinux, self).setUp()
-        self.vm.add_args('-smp', '2')
-        self.vm.add_args('-m', '1024')
-        self.prepare_boot()
-        self.prepare_cloudinit()
-
-    def prepare_boot(self):
+class BootLinuxBase(Test):
+    def download_boot(self):
         self.log.debug('Looking for and selecting a qemu-img binary to be '
                        'used to create the bootable snapshot image')
         # If qemu-img has been built, use it, otherwise the system wide one
@@ -60,17 +46,17 @@ class BootLinux(Test):
         if image_arch == 'ppc64':
             image_arch = 'ppc64le'
         try:
-            self.boot = vmimage.get(
+            boot = vmimage.get(
                 'fedora', arch=image_arch, version='31',
                 checksum=self.chksum,
                 algorithm='sha256',
                 cache_dir=self.cache_dirs[0],
                 snapshot_dir=self.workdir)
-            self.vm.add_args('-drive', 'file=%s' % self.boot.path)
         except:
             self.cancel('Failed to download/prepare boot image')
+        return boot.path
 
-    def prepare_cloudinit(self):
+    def download_cloudinit(self):
         self.log.info('Preparing cloudinit image')
         try:
             cloudinit_iso = os.path.join(self.workdir, 'cloudinit.iso')
@@ -81,9 +67,32 @@ class BootLinux(Test):
                           # QEMU's hard coded usermode router address
                           phone_home_host='10.0.2.2',
                           phone_home_port=self.phone_home_port)
-            self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
         except Exception:
             self.cancel('Failed to prepared cloudinit image')
+        return cloudinit_iso
+
+class BootLinux(BootLinuxBase):
+    """
+    Boots a Linux system, checking for a successful initialization
+    """
+
+    timeout = 900
+    chksum = None
+
+    def setUp(self):
+        super(BootLinux, self).setUp()
+        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-m', '1024')
+        self.prepare_boot()
+        self.prepare_cloudinit()
+
+    def prepare_boot(self):
+        path = self.download_boot()
+        self.vm.add_args('-drive', 'file=%s' % path)
+
+    def prepare_cloudinit(self):
+        cloudinit_iso = self.download_cloudinit()
+        self.vm.add_args('-drive', 'file=%s,format=raw' % cloudinit_iso)
 
     def launch_and_wait(self):
         self.vm.set_console()


