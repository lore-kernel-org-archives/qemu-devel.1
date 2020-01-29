Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720BFC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:21:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E9B320678
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 13:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dnEG2liQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9B320678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwnHL-0002eL-FN
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 08:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iwnFs-0001SJ-FO
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:19:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iwnFp-0002Cm-H1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:19:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iwnFo-0002CJ-Sp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 08:19:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580303976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KmeI+7oXvqzalvY4bsXXeKKa/FeDHGMNqU98zZjgdbY=;
 b=dnEG2liQRo8ici/Rz6VL4HQHp6GOf9vMI59eY8WoJ27NmmDkFv4shC6UEqMv30IV2f4ZHV
 PJohcgFehlcdiAGsYXl6HVP8lZQGEODWRikhRIqeLsjhPT7Tfi1gxAS/390wZPLddTdjXN
 BWMngxtCOVAYtDuzRDTxnCfrxwHV1Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-LD7z4yD7P4SWLyxDKyGWvQ-1; Wed, 29 Jan 2020 08:19:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 26E9518C43C3;
 Wed, 29 Jan 2020 13:19:28 +0000 (UTC)
Received: from thuth.com (ovpn-116-210.ams2.redhat.com [10.36.116.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9184D5DA66;
 Wed, 29 Jan 2020 13:19:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH] tests/acceptance: Add a test for the N800 and N810 arm
 machines
Date: Wed, 29 Jan 2020 14:19:20 +0100
Message-Id: <20200129131920.22302-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: LD7z4yD7P4SWLyxDKyGWvQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Old kernels from the Meego project can be used to check that Linux
is at least starting on these machines.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 The serial console is written to the second UART, so this needs Phil's
 "Allow to use other serial consoles than default" patch as a prerequisite:
 Based-on: <20200120235159.18510-5-f4bug@amsat.org>

 MAINTAINERS                          |  1 +
 tests/acceptance/machine_arm_n8x0.py | 49 ++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tests/acceptance/machine_arm_n8x0.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ddf6fe0794..560507e821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -672,6 +672,7 @@ F: hw/rtc/twl92230.c
 F: include/hw/display/blizzard.h
 F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
+F: tests/acceptance/machine_arm_n8x0.py
=20
 Palm
 M: Andrzej Zaborowski <balrogg@gmail.com>
diff --git a/tests/acceptance/machine_arm_n8x0.py b/tests/acceptance/machin=
e_arm_n8x0.py
new file mode 100644
index 0000000000..e5741f2d8d
--- /dev/null
+++ b/tests/acceptance/machine_arm_n8x0.py
@@ -0,0 +1,49 @@
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
+class N8x0Machine(Test):
+    """Boots the Linux kernel and checks that the console is operational""=
"
+
+    timeout =3D 90
+
+    def __do_test_n8x0(self):
+        kernel_url =3D ('http://stskeeps.subnetmask.net/meego-n8x0/'
+                      'meego-arm-n8x0-1.0.80.20100712.1431-'
+                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
+        kernel_hash =3D 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
+        kernel_path =3D self.fetch_asset(kernel_url, asset_hash=3Dkernel_h=
ash)
+
+        self.vm.set_console(console_index=3D1)
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', 'printk.time=3D0 console=3DttyS1')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'TSC2005 driver initializing')
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_n800(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:n800
+        """
+        self.__do_test_n8x0()
+
+    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code=
')
+    def test_n810(self):
+        """
+        :avocado: tags=3Darch:arm
+        :avocado: tags=3Dmachine:n810
+        """
+        self.__do_test_n8x0()
--=20
2.18.1


