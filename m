Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F97FC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD352176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 17:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ck/BPBrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD352176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihck3-0005Up-HM
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 12:04:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ihcgZ-0001zO-8V
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:00:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ihcgT-0006yI-KA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:00:31 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52577
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ihcgT-0006uP-8l
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 12:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576688424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=huUWadbrWDXfwDniwHZ+Gz0+zjfCRf6uUVCEk0EQzu4=;
 b=Ck/BPBrSkB7GuegJ1YMFtNWGKD4kxs2rbhzHf202CxJ2+yYWhUr3lhTE4LBlZSfgK03JUJ
 D4feFY2ZCPnxGAmr6xcWF/9BlqKyaFpA5Q0621/EvQNJQ+nJvUKF6lU3UBl7ERlj3FW9PW
 CUOIAAi0CJWbiLLCr3Ge17PlGMSpZrc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-kOJ5j8RnOdGi1uDxmmQDMg-1; Wed, 18 Dec 2019 12:00:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4A651B18BC3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-50.gru2.redhat.com
 [10.97.116.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF1555C1D4;
 Wed, 18 Dec 2019 17:00:16 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] tests/acceptance: boot_linux_console: Add boot Linux
 with kvm tests
Date: Wed, 18 Dec 2019 14:00:02 -0300
Message-Id: <20191218170003.31356-3-wainersm@redhat.com>
In-Reply-To: <20191218170003.31356-1-wainersm@redhat.com>
References: <20191218170003.31356-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: kOJ5j8RnOdGi1uDxmmQDMg-1
X-Mimecast-Spam-Score: 0
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
Cc: philmd@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Added boot Linux test cases that launch QEMU with kvm
enabled. Likewise it was added tests for tcg.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 88 ++++++++++++++++++++------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index 9c6aa2040a..d3730b43dc 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -51,11 +51,7 @@ class BootLinuxConsole(Test):
         os.chdir(cwd)
         return self.workdir + path
=20
-    def test_x86_64_pc(self):
-        """
-        :avocado: tags=3Darch:x86_64
-        :avocado: tags=3Dmachine:pc
-        """
+    def do_test_x86_64_pc(self):
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/fe=
dora'
                       '/linux/releases/29/Everything/x86_64/os/images/pxeb=
oot'
                       '/vmlinuz')
@@ -70,6 +66,22 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_x86_64_pc_kvm(self):
+        """
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmachine:pc
+        :avocado: tags=3Daccel:kvm
+        """
+        self.do_test_x86_64_pc()
+
+    def test_x86_64_pc_tcg(self):
+        """
+        :avocado: tags=3Darch:x86_64
+        :avocado: tags=3Dmachine:pc
+        :avocado: tags=3Daccel:tcg
+        """
+        self.do_test_x86_64_pc()
+
     def test_mips_malta(self):
         """
         :avocado: tags=3Darch:mips
@@ -258,11 +270,7 @@ class BootLinuxConsole(Test):
         kernel_hash =3D '18d1c68f2e23429e266ca39ba5349ccd0aeb7180'
         self.do_test_mips_malta32el_nanomips(kernel_url, kernel_hash)
=20
-    def test_aarch64_virt(self):
-        """
-        :avocado: tags=3Darch:aarch64
-        :avocado: tags=3Dmachine:virt
-        """
+    def do_test_aarch64_virt(self):
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/fe=
dora'
                       '/linux/releases/29/Everything/aarch64/os/images/pxe=
boot'
                       '/vmlinuz')
@@ -279,6 +287,22 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_aarch64_virt_kvm(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Daccel:kvm
+        """
+        self.do_test_aarch64_virt()
+
+    def test_aarch64_virt_tcg(self):
+        """
+        :avocado: tags=3Darch:aarch64
+        :avocado: tags=3Dmachine:virt
+        :avocado: tags=3Daccel:tcg
+        """
+        self.do_test_aarch64_virt()
+
     def test_arm_virt(self):
         """
         :avocado: tags=3Darch:arm
@@ -400,11 +424,7 @@ class BootLinuxConsole(Test):
         self.wait_for_console_pattern('Boot successful.')
         # TODO user command, for now the uart is stuck
=20
-    def test_s390x_s390_ccw_virtio(self):
-        """
-        :avocado: tags=3Darch:s390x
-        :avocado: tags=3Dmachine:s390-ccw-virtio
-        """
+    def do_test_s390x_s390_ccw_virtio(self):
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/s390x/os/i=
mages'
                       '/kernel.img')
@@ -420,6 +440,22 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_s390x_s390_ccw_virtio_kvm(self):
+        """
+        :avocado: tags=3Darch:s390x
+        :avocado: tags=3Dmachine:s390-ccw-virtio
+        :avocado: tags=3Daccel:kvm
+        """
+        self.do_test_s390x_s390_ccw_virtio()
+
+    def test_s390x_s390_ccw_virtio_tcg(self):
+        """
+        :avocado: tags=3Darch:s390x
+        :avocado: tags=3Dmachine:s390-ccw-virtio
+        :avocado: tags=3Daccel:tcg
+        """
+        self.do_test_s390x_s390_ccw_virtio()
+
     def test_alpha_clipper(self):
         """
         :avocado: tags=3Darch:alpha
@@ -441,11 +477,7 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
-    def test_ppc64_pseries(self):
-        """
-        :avocado: tags=3Darch:ppc64
-        :avocado: tags=3Dmachine:pseries
-        """
+    def do_test_ppc64_pseries(self):
         kernel_url =3D ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/29/Everything/ppc64le/os=
'
                       '/ppc/ppc64/vmlinuz')
@@ -460,6 +492,22 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
+    def test_ppc64le_pseries_kvm(self):
+        """
+        :avocado: tags=3Darch:ppc64
+        :avocado: tags=3Dmachine:pseries
+        :avocado: tags=3Daccel:kvm
+        """
+        self.do_test_ppc64_pseries()
+
+    def test_ppc64le_pseries_tcg(self):
+        """
+        :avocado: tags=3Darch:ppc64
+        :avocado: tags=3Dmachine:pseries
+        :avocado: tags=3Daccel:tcg
+        """
+        self.do_test_ppc64_pseries()
+
     def test_m68k_q800(self):
         """
         :avocado: tags=3Darch:m68k
--=20
2.23.0


