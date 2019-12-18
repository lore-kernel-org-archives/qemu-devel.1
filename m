Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EA021582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 23:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYDFapvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EA021582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihiie-0000fO-FK
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 18:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35037)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ihih2-0007Cb-OI
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ihih0-0003bI-VA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:24 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43143
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ihih0-0003b5-RH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 18:25:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576711522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9IR9ft54WeduGfRTSuCObcjJ+1H3GXSFNlhqaKl5B5o=;
 b=HYDFapvS/S4vRXSzzuHMC1mKxQjyqju2bz4Tymp1Q+fhUok9ebDyb5+ASWO+GaVH5GBJjH
 pfQxKIENRo4NchyyKhLPON1JkERe/LcgHy6tbumyZdpviFUG+4A8aLpzYqpwuS0CB4knhX
 oAb1Cj+teb46j7gFjLIs7n+DBZPQm3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-WoWNtrIiNk6nxLs1u_GNxA-1; Wed, 18 Dec 2019 18:25:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15609DBA3;
 Wed, 18 Dec 2019 23:25:18 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-116-25.gru2.redhat.com
 [10.97.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE2E10001AE;
 Wed, 18 Dec 2019 23:25:15 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 2/4] Acceptance test: add "boot_linux" tests
Date: Wed, 18 Dec 2019 18:24:58 -0500
Message-Id: <20191218232500.23530-3-crosa@redhat.com>
In-Reply-To: <20191218232500.23530-1-crosa@redhat.com>
References: <20191218232500.23530-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: WoWNtrIiNk6nxLs1u_GNxA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This acceptance test, validates that a full blown Linux guest can
successfully boot in QEMU.  In this specific case, the guest chosen is
Fedora version 31.

 * x86_64, pc and q35 machine types, with and without kvm as an
   accelerator

 * aarch64 and virt machine type, with and without kvm as an
   accelerator

 * ppc64 and pseries machine type

 * s390x and s390-ccw-virtio machine type

The Avocado vmimage utils library is used to download and cache the
Linux guest images, and from those images a snapshot image is created
and given to QEMU.  If a qemu-img binary is available in the build
directory, it's used to create the snapshot image, so that matching
qemu-system-* and qemu-img are used in the same test run.  If qemu-img
is not available in the build tree, one is attempted to be found
installed system-wide (in the $PATH).  If qemu-img is not found in the
build dir or in the $PATH, the test is canceled.

The method for checking the successful boot is based on "cloudinit"
and its "phone home" feature.  The guest is given an ISO image with
the location of the phone home server, and the information to post
(the instance ID).  Upon receiving the correct information, from the
guest, the test is considered to have PASSed.

This test is currently limited to user mode networking only, and
instructs the guest to connect to the "router" address that is hard
coded in QEMU.

To create the cloudinit ISO image that will be used to configure the
guest, the pycdlib library is also required and has been added as
requirement to the virtual environment created by "check-venv".

The console output is read by a separate thread, by means of the
Avocado datadrainer utility module.

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 .travis.yml                    |   2 +-
 tests/acceptance/boot_linux.py | 180 +++++++++++++++++++++++++++++++++
 tests/requirements.txt         |   3 +-
 3 files changed, 183 insertions(+), 2 deletions(-)
 create mode 100644 tests/acceptance/boot_linux.py

diff --git a/.travis.yml b/.travis.yml
index 6cb8af6fa5..10c24330fd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -264,7 +264,7 @@ matrix:
=20
     # Acceptance (Functional) tests
     - env:
-        - CONFIG=3D"--python=3D/usr/bin/python3 --target-list=3Dx86_64-sof=
tmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmm=
u,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc-softmmu"
+        - CONFIG=3D"--python=3D/usr/bin/python3 --enable-tools --target-li=
st=3Dx86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softm=
mu,s390x-softmmu,alpha-softmmu,ppc-softmmu,ppc64-softmmu,m68k-softmmu,sparc=
-softmmu"
         - TEST_CMD=3D"make check-acceptance"
       after_failure:
         - cat tests/results/latest/job.log
diff --git a/tests/acceptance/boot_linux.py b/tests/acceptance/boot_linux.p=
y
new file mode 100644
index 0000000000..495ff2963c
--- /dev/null
+++ b/tests/acceptance/boot_linux.py
@@ -0,0 +1,180 @@
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
+from avocado_qemu import Test, BLD_DIR
+
+from qemu.accel import kvm_available
+
+from avocado.utils import cloudinit
+from avocado.utils import network
+from avocado.utils import vmimage
+from avocado.utils import datadrainer
+
+
+KVM_NOT_AVAILABLE =3D "KVM accelerator does not seem to be available"
+
+
+class BootLinux(Test):
+    """
+    Boots a Linux system, checking for a successful initialization
+    """
+
+    timeout =3D 900
+    chksum =3D None
+
+    def setUp(self):
+        super(BootLinux, self).setUp()
+        self.prepare_boot()
+        self.vm.add_args('-smp', '2')
+        self.vm.add_args('-m', '2048')
+        self.vm.add_args('-drive', 'file=3D%s' % self.boot.path)
+        self.prepare_cloudinit()
+
+    def prepare_boot(self):
+        self.log.info('Downloading/preparing boot image')
+        # Fedora 31 only provides ppc64le images
+        image_arch =3D self.arch
+        if image_arch =3D=3D 'ppc64':
+            image_arch =3D 'ppc64le'
+        # If qemu-img has been built, use it, otherwise the system wide on=
e
+        # will be used.  If none is available, the test will cancel.
+        qemu_img =3D os.path.join(BLD_DIR, 'qemu-img')
+        if os.path.exists(qemu_img):
+            vmimage.QEMU_IMG =3D qemu_img
+        try:
+            self.boot =3D vmimage.get(
+                'fedora', arch=3Dimage_arch, version=3D'31',
+                checksum=3Dself.chksum,
+                algorithm=3D'sha256',
+                cache_dir=3Dself.cache_dirs[0],
+                snapshot_dir=3Dself.workdir)
+        except:
+            self.cancel('Failed to download/prepare boot image')
+
+    def prepare_cloudinit(self):
+        self.log.info('Preparing cloudinit image')
+        try:
+            cloudinit_iso =3D os.path.join(self.workdir, 'cloudinit.iso')
+            self.phone_home_port =3D network.find_free_port()
+            cloudinit.iso(cloudinit_iso, self.name,
+                          username=3D'root',
+                          password=3D'password',
+                          # QEMU's hard coded usermode router address
+                          phone_home_host=3D'10.0.2.2',
+                          phone_home_port=3Dself.phone_home_port)
+            self.vm.add_args('-drive', 'file=3D%s,format=3Draw' % cloudini=
t_iso)
+        except Exception:
+            self.cancel('Failed to prepared cloudinit image')
+
+    def launch_and_wait(self):
+        self.vm.set_console()
+        self.vm.launch()
+        console_drainer =3D datadrainer.LineLogger(self.vm.console_socket.=
fileno(),
+                                                 logger=3Dself.log.getChil=
d('console'))
+        console_drainer.start()
+        self.log.info('VM launched, waiting for boot confirmation from gue=
st')
+        cloudinit.wait_for_phone_home(('0.0.0.0', self.phone_home_port), s=
elf.name)
+
+
+class BootLinuxX8664(BootLinux):
+    """
+    :avocado: tags=3Darch:x86_64
+    """
+
+    chksum =3D 'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c=
5c27a0'
+
+    def test_pc(self):
+        """
+        :avocado: tags=3Dmachine:pc
+        """
+        self.launch_and_wait()
+
+    def test_kvm_pc(self):
+        """
+        :avocado: tags=3Dmachine:pc
+        :avocado: tags=3Daccel:kvm
+        """
+        if not kvm_available(self.arch, self.qemu_bin):
+            self.cancel(KVM_NOT_AVAILABLE)
+        self.vm.add_args("-accel", "kvm")
+        self.launch_and_wait()
+
+    def test_q35(self):
+        """
+        :avocado: tags=3Dmachine:q35
+        """
+        self.launch_and_wait()
+
+    def test_kvm_q35(self):
+        """
+        :avocado: tags=3Dmachine:q35
+        :avocado: tags=3Daccel:kvm
+        """
+        if not kvm_available(self.arch, self.qemu_bin):
+            self.cancel(KVM_NOT_AVAILABLE)
+        self.vm.add_args("-accel", "kvm")
+        self.launch_and_wait()
+
+
+class BootLinuxAarch64(BootLinux):
+    """
+    :avocado: tags=3Darch:aarch64
+    :avocado: tags=3Dmachine:virt
+    """
+
+    chksum =3D '1e18d9c0cf734940c4b5d5ec592facaed2af0ad0329383d5639c997fdf=
16fe49'
+
+    def test_virt(self):
+        self.vm.add_args('-cpu', 'cortex-a53')
+        self.vm.add_args('-bios',
+                         os.path.join(BLD_DIR, 'pc-bios',
+                                      'edk2-aarch64-code.fd'))
+        self.vm.add_args('-device', 'virtio-rng-pci,rng=3Drng0')
+        self.vm.add_args('-object', 'rng-random,id=3Drng0,filename=3D/dev/=
urandom')
+        self.launch_and_wait()
+
+    def test_kvm_virt(self):
+        """
+        :avocado: tags=3Daccel:kvm
+        """
+        if not kvm_available(self.arch, self.qemu_bin):
+            self.cancel(KVM_NOT_AVAILABLE)
+        self.vm.add_args("-accel", "kvm")
+        self.test_virt()
+
+
+class BootLinuxPPC64(BootLinux):
+    """
+    :avocado: tags=3Darch:ppc64
+    """
+
+    chksum =3D '7c3528b85a3df4b2306e892199a9e1e43f991c506f2cc390dc4efa2026=
ad2f58'
+
+    def test_pseries(self):
+        """
+        :avocado: tags=3Dmachine:pseries
+        """
+        self.launch_and_wait()
+
+
+class BootLinuxS390X(BootLinux):
+    """
+    :avocado: tags=3Darch:s390x
+    """
+
+    chksum =3D '4caaab5a434fd4d1079149a072fdc7891e354f834d355069ca982fdcaf=
5a122d'
+
+    def test_s390_ccw_virtio(self):
+        """
+        :avocado: tags=3Dmachine:s390-ccw-virtio
+        """
+        self.launch_and_wait()
diff --git a/tests/requirements.txt b/tests/requirements.txt
index a2a587223a..0192c352cd 100644
--- a/tests/requirements.txt
+++ b/tests/requirements.txt
@@ -1,4 +1,5 @@
 # Add Python module requirements, one per line, to be installed
 # in the tests/venv Python virtual environment. For more info,
 # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
-avocado-framework=3D=3D72.0
+avocado-framework=3D=3D73.0
+pycdlib=3D=3D1.8.0
--=20
2.21.0


