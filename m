Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83EEC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE80C2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 16:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVGuHUld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE80C2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfREU-0008Qd-TJ
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 12:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR1D-0004Sr-40
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:41:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jfR1C-0007IL-0W
 for qemu-devel@nongnu.org; Sun, 31 May 2020 12:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590943261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j5BS+2d4i/ahG24dd/tHPN0fLUUFmd8jGntUYE3MrX0=;
 b=QVGuHUldABUXxW2N4Qro9bxjw+JGAAvcnmELyn3fiWYu3rGRi+xe68TTUeWrUgEgeapKUg
 COegbJ3W1QdthNyD0mMn8vqLOxGXyC5+kDl6V27JIy/ulO2E2+lUj3DbsBKRLxu2lY5LEa
 U+6Iet2pWrYr0nIwXDCxxAJl9RvA5ac=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-Vo9Ns-jYPfmWnb968jpDOA-1; Sun, 31 May 2020 12:40:58 -0400
X-MC-Unique: Vo9Ns-jYPfmWnb968jpDOA-1
Received: by mail-wr1-f69.google.com with SMTP id w16so3602882wru.18
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 09:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j5BS+2d4i/ahG24dd/tHPN0fLUUFmd8jGntUYE3MrX0=;
 b=UQo6A4yF+2mk8LUorBUiC6Q2O8Dpa0udrLh43RewdEc7B2BmssVO774GBdDES8nJkH
 Q58jtjStBZrydms9BTzLa/2iYFi2V2xvmkeoNHZzadq5tC5ZxQQrSicQjDAfCq3vBabv
 xELm/tz1LQDFSmY4eY6ZBAaup90wB+iTBS5gvDNe4S8E07LR4i68xC990Cpq4dxuvE60
 PZjQlY2R/mIbrtlwPJEUOiMV8H0uIR4sIU/Z/Ur50D4EMLG3jG+0o3TmOgeDqMEZ806v
 HwfLXVvOpWemWnGgkitvddPtKHe4Sx35Xzzg7BW0BUqQQk9JNjG7DLxN+P4Dr5kB1Iae
 RZkQ==
X-Gm-Message-State: AOAM530A6dof5+XLx780Mt6j9jtuts3HWCxx7LP9owDMB26H5gdZjiVO
 MT29W+BUOfNqtcYL5Y0YXBqvB6L26kUtvAAbLkXxUh+azdubMZMVLS9hOBdPNw3fwrXW1TZn6An
 N5WHA9ssgIGJDJUQ=
X-Received: by 2002:adf:b354:: with SMTP id k20mr18137779wrd.412.1590943256927; 
 Sun, 31 May 2020 09:40:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0HkzqO5UvunzkIevQCS8DP8RYc0sFupFoLUZyl6tgkem6GKu1Knj86ln8moQU3+6mIDc99g==
X-Received: by 2002:adf:b354:: with SMTP id k20mr18137753wrd.412.1590943256749; 
 Sun, 31 May 2020 09:40:56 -0700 (PDT)
Received: from localhost.localdomain (43.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.43])
 by smtp.gmail.com with ESMTPSA id d15sm18060321wrq.30.2020.05.31.09.40.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2020 09:40:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/25] tests/acceptance: refactor boot_linux to allow code reuse
Date: Sun, 31 May 2020 18:38:46 +0200
Message-Id: <20200531163846.25363-26-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200531163846.25363-1-philmd@redhat.com>
References: <20200531163846.25363-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/31 11:09:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_FILL_THIS_FORM_SHORT=0.01,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

This patch moves image downloading functions to the separate class to allow
reusing them from record/replay tests.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <159073593167.20809.17582679291556188984.stgit@pasha-ThinkPad-X280>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/acceptance/boot_linux.py | 49 ++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.py
index 075a386300..3aa57e88b0 100644
--- a/tests/acceptance/boot_linux.py
+++ b/tests/acceptance/boot_linux.py
@@ -26,22 +26,8 @@
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
@@ -60,17 +46,17 @@ def prepare_boot(self):
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
@@ -81,9 +67,32 @@ def prepare_cloudinit(self):
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
-- 
2.21.3


