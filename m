Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408CCC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 17:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E039206BE
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 17:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K1cTeQSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E039206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrm5I-0000m7-7f
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 13:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrm4d-000070-PU
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 13:35:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jrm4b-0008Se-Dp
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 13:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593884131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Uv1zs5yRBrT+v2uJdKmYkr4ZfSFS8U6jGLMXM0VEOWk=;
 b=K1cTeQSSDjCcrMxEnZKznZxWWtb154cOYIhEmVaOLvleNAZGsVioLRxxSNvnV+bb6I0Yqz
 1pkAmZ/3DNQj5WRPYoWIJDntK9d2QPyzdtsbmrfBuMkCCGT4F4g+bmxsBbP0ViY8jbQ5Co
 511lT3LydDCOY6257eZWD53n1FdY9pQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-pmj2AZCsPgOQL2jQdnKk1A-1; Sat, 04 Jul 2020 13:35:27 -0400
X-MC-Unique: pmj2AZCsPgOQL2jQdnKk1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BD0D800597;
 Sat,  4 Jul 2020 17:35:26 +0000 (UTC)
Received: from thuth.com (ovpn-112-37.ams2.redhat.com [10.36.112.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B5D365C1D2;
 Sat,  4 Jul 2020 17:35:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v2] tests/acceptance: Add a test for the sun4u sparc64 machine
Date: Sat,  4 Jul 2020 19:35:19 +0200
Message-Id: <20200704173519.26087-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can use the image from the advent calendar 2018 to test the sun4u
machine. It's not using the "QEMU advent calendar" string, so we can
not use the do_test_advcal_2018() from boot_linux_console.py, thus
let's also put it into a separate file to also be able to add an
entry to the MAINTAINERS file.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Added KERNEL_COMMON_COMMAND_LINE as suggested by Philippe

 MAINTAINERS                               |  1 +
 tests/acceptance/machine_sparc64_sun4u.py | 36 +++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tests/acceptance/machine_sparc64_sun4u.py

diff --git a/MAINTAINERS b/MAINTAINERS
index dec252f38b..c26bc06e39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1318,6 +1318,7 @@ F: include/hw/pci-host/sabre.h
 F: hw/pci-bridge/simba.c
 F: include/hw/pci-bridge/simba.h
 F: pc-bios/openbios-sparc64
+F: tests/acceptance/machine_sparc64_sun4u.py
 
 Sun4v
 M: Artyom Tarasenko <atar4qemu@gmail.com>
diff --git a/tests/acceptance/machine_sparc64_sun4u.py b/tests/acceptance/machine_sparc64_sun4u.py
new file mode 100644
index 0000000000..458165500e
--- /dev/null
+++ b/tests/acceptance/machine_sparc64_sun4u.py
@@ -0,0 +1,36 @@
+# Functional test that boots a Linux kernel and checks the console
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later. See the COPYING file in the top-level directory.
+
+import os
+
+from avocado_qemu import wait_for_console_pattern
+from avocado.utils import archive
+from boot_linux_console import LinuxKernelTest
+
+class Sun4uMachine(LinuxKernelTest):
+    """Boots the Linux kernel and checks that the console is operational"""
+
+    timeout = 90
+
+    def test_sparc64_sun4u(self):
+        """
+        :avocado: tags=arch:sparc64
+        :avocado: tags=machine:sun4u
+        """
+        tar_url = ('https://www.qemu-advent-calendar.org'
+                   '/2018/download/day23.tar.xz')
+        tar_hash = '142db83cd974ffadc4f75c8a5cad5bcc5722c240'
+        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
+        archive.extract(file_path, self.workdir)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.workdir + '/day23/vmlinux',
+                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Starting logging: OK')
-- 
2.18.1


