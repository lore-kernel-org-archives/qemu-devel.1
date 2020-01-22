Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6185C2D0CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:30:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19B72465A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 01:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjMUrMqr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19B72465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu4qM-0002y9-4e
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 20:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iu4og-0001Ln-Ma
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iu4oe-0004R7-9B
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45747
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iu4oe-0004QZ-5e
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 20:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579656499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XkOJW5CRhAR2yP0xNntEPugQOv+nm9ZnOkcmx4SulkI=;
 b=CjMUrMqrqB28uGy7lsHyunJjQmBkhZcvs7Ie3qkFze4wm1SdNsGwk6Xxnnl8LSNTj0ZV41
 cSv5Lr2Lw9j5Xs+6yUpPNSziXL2IbeSdY3IMGfBw5JNhBhfiPsGWIF/wxBmjTlBwHEkt9L
 gmSmgy6hTpA0pTcpA5kqaBPauSUzKro=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-Mdj64IhoNoS_ApSvrQ7LGQ-1; Tue, 21 Jan 2020 20:28:15 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFDCADB23;
 Wed, 22 Jan 2020 01:28:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-78.gru2.redhat.com
 [10.97.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 32C07806B7;
 Wed, 22 Jan 2020 01:28:07 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/4] tests/acceptance: boot_linux_console: Add boot Linux
 with kvm tests
Date: Tue, 21 Jan 2020 22:27:51 -0300
Message-Id: <20200122012753.9846-3-wainersm@redhat.com>
In-Reply-To: <20200122012753.9846-1-wainersm@redhat.com>
References: <20200122012753.9846-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Mdj64IhoNoS_ApSvrQ7LGQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: philmd@redhat.com, thuth@redhat.com, alex.bennee@linaro.org,
 ehabkost@redhat.com, crosa@redhat.com
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
index e40b84651b..a36eae630c 100644
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
@@ -485,11 +509,7 @@ class BootLinuxConsole(Test):
         exec_command_and_wait_for_pattern(self, 'reboot',
                                                 'reboot: Restarting system=
')
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
@@ -505,6 +525,22 @@ class BootLinuxConsole(Test):
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
@@ -526,11 +562,7 @@ class BootLinuxConsole(Test):
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
@@ -545,6 +577,22 @@ class BootLinuxConsole(Test):
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


