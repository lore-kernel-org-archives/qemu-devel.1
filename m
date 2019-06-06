Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681AEC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC95208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 21:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC95208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43460 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZ04z-00054D-W6
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 17:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51944)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hYzu9-000654-Ab
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:26:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hYziU-00082m-KC
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38694)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hYziT-0007wr-5h
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 17:14:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B96F83091851;
 Thu,  6 Jun 2019 21:14:29 +0000 (UTC)
Received: from dhcp-17-47.bos.redhat.com (dhcp-17-47.bos.redhat.com
 [10.18.17.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C243E10ABD9F;
 Thu,  6 Jun 2019 21:14:27 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 17:14:12 -0400
Message-Id: <20190606211414.8681-6-crosa@redhat.com>
In-Reply-To: <20190606211414.8681-1-crosa@redhat.com>
References: <20190606211414.8681-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 06 Jun 2019 21:14:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 5/7] Add "boot_linux" test for x86_64 and pc
 and q35 machine types
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
 Cornelia Huck <cohuck@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This acceptance test, validates that a full blown Linux guest can
successfully boot in QEMU.  In this specific case, the guest chosen is
Fedora version 30.  It adds two different tests for machine types pc
and q35.

The method for checking the successful boot is based on "cloudinit"
and its "phone home" feature.  The guest is given an ISO image
with the location of the phone home server, and the information to
post (the instance ID).  Upon receiving the correct information,
from the guest, the test is considered to have PASSed.

This test is currently limited to user mode networking only, and
instructs the guest to connect to the "router" address that is hard
coded in QEMU.

To create the cloudinit ISO image that will be used to configure the
guest, the pycdlib library is also required and has been added as
requirement to the virtual environment created by "check-venv".

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                    |  2 +-
 tests/acceptance/boot_linux.py | 83 ++++++++++++++++++++++++++++++++++
 tests/requirements.txt         |  2 +
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 tests/acceptance/boot_linux.py

diff --git a/.travis.yml b/.travis.yml
index b053a836a3..df74234692 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -224,7 +224,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-s=
oftmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-so=
ftmmu,alpha-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --enable-slirp=3Dgit --t=
arget-list=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu=
,arm-softmmu,s390x-softmmu,alpha-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       addons:
         apt:
diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux=
.py
new file mode 100644
index 0000000000..2180f69a12
--- /dev/null
+++ b/tests/acceptance/boot_linux.py
@@ -0,0 +1,83 @@
+# Functional test that boots a complete Linux system via a cloud image
+#
+# Copyright (c) 2018-2019 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+
+from avocado_qemu import Test
+
+from avocado.utils import cloudinit
+from avocado.utils import network
+from avocado.utils import vmimage
+
+
+class BootLinux(Test):
+    """
+    Boots a Linux system, checking for a successful initialization
+    """
+
+    timeout =3D 600
+    chksum =3D None
+
+    def setUp(self):
+        super(BootLinux, self).setUp()
+        self.prepare_boot()
+        self.vm.add_args('-m', '1024')
+        self.vm.add_args('-drive', 'file=3D%s' % self.boot.path)
+        self.prepare_cloudinit()
+
+    def prepare_boot(self):
+        try:
+            self.log.info('Downloading and preparing boot image')
+            self.boot =3D vmimage.get(
+                'fedora', arch=3Dself.arch, version=3D'30',
+                checksum=3Dself.chksum,
+                algorithm=3D'sha256',
+                cache_dir=3Dself.cache_dirs[0],
+                snapshot_dir=3Dself.workdir)
+        except:
+            self.cancel('Failed to download boot image')
+
+    def prepare_cloudinit(self):
+        cloudinit_iso =3D os.path.join(self.workdir, 'cloudinit.iso')
+        self.phone_home_port =3D network.find_free_port()
+        cloudinit.iso(cloudinit_iso, self.name,
+                      username=3D'root',
+                      password=3D'password',
+                      # QEMU's hard coded usermode router address
+                      phone_home_host=3D'10.0.2.2',
+                      phone_home_port=3Dself.phone_home_port)
+        self.vm.add_args('-drive', 'file=3D%s,format=3Draw' % cloudinit_=
iso)
+
+    def wait_for_boot_confirmation(self):
+        self.log.info('VM launched, waiting for boot confirmation from g=
uest')
+        cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port),=
 self.name)
+
+
+class BootLinuxX8664(BootLinux):
+
+    chksum =3D '72b6ae7b4ed09a4dccd6e966e1b3ac69bd97da419de9760b410e837b=
a00b4e26'
+
+    def test_pc(self):
+        """
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmachine:pc
+        """
+        self.vm.set_machine('pc')
+        self.vm.launch()
+        self.wait_for_boot_confirmation()
+
+    def test_q35(self):
+        """
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmachine:q35
+        """
+        self.vm.set_machine('q35')
+        self.vm.launch()
+        self.wait_for_boot_confirmation()
diff --git a/tests/requirements.txt b/tests/requirements.txt
index 3ae0e29ad7..9d2c79b146 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -3,3 +3,5 @@
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
 avocado-framework=3D=3D68.0
 paramiko
+pycdlib=3D=3D1.6.0
+
--=20
2.21.0


