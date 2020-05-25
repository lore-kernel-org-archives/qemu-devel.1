Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D00C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39342065F
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 07:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="An4ssYEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39342065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd7W9-0003T4-4r
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 03:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jd7VY-0002uV-ML
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:26:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29389
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jd7VX-0000zT-Dz
 for qemu-devel@nongnu.org; Mon, 25 May 2020 03:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590391606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type;
 bh=1bNu6oGRD8gxdN02xABNvQD2MATRZEUukTxl91nVRgU=;
 b=An4ssYECodq2/MG6kRPvpG+yMhISzzRfMgUG1KYkeY9ATXvVa+ZFAicF8Bsg81nWFOZ0aC
 o/4rmH8lEO935wQ7HkKdLHvMOOZL7SEPkDcoAFYdkLCzGHektX4Yn7yIMm3KrPrZMMIC4P
 QOBLZbpvUgT7k0wxCg5iK+ABgOdmQYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-AR_pXaXnPYCLfAUZugo2_g-1; Mon, 25 May 2020 03:26:40 -0400
X-MC-Unique: AR_pXaXnPYCLfAUZugo2_g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A58C1107ACCA;
 Mon, 25 May 2020 07:26:39 +0000 (UTC)
Received: from thuth.com (ovpn-113-78.ams2.redhat.com [10.36.113.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CCA9C5C1B2;
 Mon, 25 May 2020 07:26:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: Add a boot test for the xlnx-versal-virt
 machine
Date: Mon, 25 May 2020 09:26:30 +0200
Message-Id: <20200525072630.22280-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/25 01:44:10
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
Cc: Cleber Rosa <crosa@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As described by Edgar here:

 https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html

we can use the Ubuntu kernel for testing the xlnx-versal-virt machine.
So let's add a boot test for this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 0653c8c1bf..430a6c3b43 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -307,6 +307,30 @@ class BootLinuxConsole(Test):
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
 
+    def test_aarch64_xlnx_versal_virt(self):
+        """
+        :avocado: tags=arch:aarch64
+        :avocado: tags=machine:xlnx-versal-virt
+        """
+        kernel_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
+                      'bionic-updates/main/installer-arm64/current/images/'
+                      'netboot/ubuntu-installer/arm64/linux')
+        kernel_hash = '5bfc54cf7ed8157d93f6e5b0241e727b6dc22c50'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+
+        initrd_url = ('http://ports.ubuntu.com/ubuntu-ports/dists/'
+                      'bionic-updates/main/installer-arm64/current/images/'
+                      'netboot/ubuntu-installer/arm64/initrd.gz')
+        initrd_hash = 'd385d3e88d53e2004c5d43cbe668b458a094f772'
+        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+
+        self.vm.set_console()
+        self.vm.add_args('-m', '2G',
+                         '-kernel', kernel_path,
+                         '-initrd', initrd_path)
+        self.vm.launch()
+        self.wait_for_console_pattern('Checked W+X mappings: passed')
+
     def test_arm_virt(self):
         """
         :avocado: tags=arch:arm
-- 
2.18.1


