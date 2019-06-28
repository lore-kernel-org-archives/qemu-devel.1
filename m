Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB6DC4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E7A2133F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 15:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E7A2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgsZX-0001IA-Ms
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 11:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49830)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1hgsOt-0002Oi-R6
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1hgsOq-0004uw-UY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37546)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1hgsOq-0004iv-Lu
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:02:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBE1A8F915
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 15:02:33 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52A1854529;
 Fri, 28 Jun 2019 15:02:33 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 28 Jun 2019 11:02:17 -0400
Message-Id: <20190628150217.32659-4-wainersm@redhat.com>
In-Reply-To: <20190628150217.32659-1-wainersm@redhat.com>
References: <20190628150217.32659-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 28 Jun 2019 15:02:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] tests/acceptance: Add boot linux with kvm
 test
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
Cc: philmd@redhat.com, jsnow@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Until now the suite of acceptance tests doesn't exercise
QEMU with kvm enabled. So this introduces a simple test
that boots the Linux kernel and checks it boots on the
accelerator correctly.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/kvm.py | 58 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 tests/acceptance/kvm.py

diff --git a/tests/acceptance/kvm.py b/tests/acceptance/kvm.py
new file mode 100644
index 0000000000..aafb865cdb
--- /dev/null
+++ b/tests/acceptance/kvm.py
@@ -0,0 +1,58 @@
+# KVM acceptance tests.
+#
+# Copyright (c) 2019 Red Hat, Inc.
+#
+# Author:
+#  Wainer dos Santos Moschetta <wainersm@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import logging
+
+from avocado_qemu import Test
+
+
+class Kvm(Test):
+    """
+    Suite of acceptance tests to check QEMU and KVM integration.
+    """
+
+    def test_boot_linux(self):
+        """
+        Simple Linux boot test with kvm enabled.
+
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Daccel:kvm
+        """
+        self.vm.add_args('-enable-kvm')
+        kernel_url =3D ('https://download.fedoraproject.org/pub/fedora/l=
inux/'
+                      'releases/29/Everything/x86_64/os/images/pxeboot/v=
mlinuz')
+        kernel_hash =3D '23bebd2680757891cf7adedb033532163a792495'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel=
_hash)
+
+        self.vm.set_machine('pc')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', 'printk.time=3D0 console=3DttyS0')
+        self.vm.launch()
+
+        query =3D self.vm.command('query-kvm')
+        self.assertTrue(query['enabled'])
+        self.assertTrue(query['present'])
+
+        console =3D self.vm.console_socket.makefile()
+        console_logger =3D logging.getLogger('console')
+        failure_message =3D 'Kernel panic - not syncing'
+        success_message =3D 'Booting paravirtualized kernel on KVM'
+
+        while True:
+            msg =3D console.readline().strip()
+            if not msg:
+                continue
+            console_logger.debug(msg)
+            if success_message in msg:
+                break
+            if failure_message in msg:
+                fail =3D 'Failure message found in console: %s' % failur=
e_message
+                self.fail(fail)
--=20
2.21.0


