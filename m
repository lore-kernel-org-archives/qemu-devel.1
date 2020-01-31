Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D144FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3532082E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 17:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX3DXoWB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3532082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixZiG-0005Rb-PL
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 12:04:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55315)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ixZhC-0004DR-KR
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ixZhA-0006J9-CC
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:03:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45072
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ixZh9-0006EY-Th
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 12:03:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580490183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HvVjaR4hiIqrKejAHJ+Fb1dU6Wg4eHD3W0GTo8C4l7g=;
 b=MX3DXoWByzCKMZok9rix2ETcb405m3yJqmT9YX8TN8w3XxZR70sFr1rELfrn4uVTsJu74E
 EsOCES+kKWVU6q6gfKu1aj/rxIkN4FzIOT2TtXfaBrSi39PQgRcdgcaEni3Zvgi4dOfn/d
 yumFDb3MjREKdzowFaIZt0O7vISJd58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-rtA98fGzNdyDkUqau5jtxQ-1; Fri, 31 Jan 2020 12:02:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9D83107ACC4;
 Fri, 31 Jan 2020 17:02:43 +0000 (UTC)
Received: from thuth.com (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 041101036B47;
 Fri, 31 Jan 2020 17:02:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/acceptance: Add a test for the integratorcp arm machine
Date: Fri, 31 Jan 2020 18:02:33 +0100
Message-Id: <20200131170233.14584-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: rtA98fGzNdyDkUqau5jtxQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a kernel and initrd available on github which we can use
for testing this machine.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                  |  1 +
 tests/acceptance/machine_arm_integratorcp.py | 43 ++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_integratorcp.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e4976d366..6a03835037 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -599,6 +599,7 @@ S: Maintained
 F: hw/arm/integratorcp.c
 F: hw/misc/arm_integrator_debug.c
 F: include/hw/misc/arm_integrator_debug.h
+F: tests/acceptance/machine_arm_integratorcp.py
=20
 MCIMX6UL EVK / i.MX6ul
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/acceptance/machine_arm_integratorcp.py b/tests/acceptanc=
e/machine_arm_integratorcp.py
new file mode 100644
index 0000000000..4f9ab40f2f
--- /dev/null
+++ b/tests/acceptance/machine_arm_integratorcp.py
@@ -0,0 +1,43 @@
+# Functional test that boots a Linux kernel and checks the console
+#
+# Copyright (c) 2020 Red Hat, Inc.
+#
+# Author:
+#  Thomas Huth <thuth@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+
+from avocado import skipUnless
+from avocado_qemu import Test
+from avocado_qemu import wait_for_console_pattern
+
+class IntegratorMachine(Test):
+    """Boots the Linux kernel and checks that the console is operational""=
"
+
+    timeout =3D 90
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_integratorcp(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:integratorcp
+        """
+        kernel_url =3D ('https://github.com/zayac/qemu-arm/raw/master/'
+                      'arm-test/kernel/zImage.integrator')
+        kernel_hash =3D '0d7adba893c503267c946a3cbdc63b4b54f25468'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
+
+        initrd_url =3D ('https://github.com/zayac/qemu-arm/raw/master/'
+                      'arm-test/kernel/arm_root.img')
+        initrd_hash =3D 'b51e4154285bf784e017a37586428332d8c7bd8b'
+        initrd_path =3D self.fetch_asset(initrd_url, asset_hash=3Dinitrd_h=
ash)
+
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path,
+                         '-initrd', initrd_path,
+                         '-append', 'printk.time=3D0 console=3DttyAMA0')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'Log in as root')
--=20
2.18.1


