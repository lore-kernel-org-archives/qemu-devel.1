Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A463C35247
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D930F20659
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiljYs+N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D930F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izRNO-0000VY-Uy
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 15:34:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1izRML-00072O-Mq
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1izRMK-0005E6-B4
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1izRMK-00059C-6j
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 15:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580934794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uvRpncIm2GFwWR1rhLCciCWBKtJgGZNQdlNj/+PUO6U=;
 b=NiljYs+NyLILl3U9oJavmWlhsOBl12UAbxbwtJgfw8X2IClei8D2YcxkvHWFMlXGwLlsbF
 cJgcQOCZAvIPiLb543j0DjD4IBeQnbaId7Oq2fAbF2K6ZeoewFhj5/DtbACuShITAOGseX
 PILL40HXLf42pEybNedwcVMa1iHLiWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-yTkpxFgGNTOdQ8qnJR0RoQ-1; Wed, 05 Feb 2020 15:32:59 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D5B98010F8;
 Wed,  5 Feb 2020 20:32:58 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A164F10013A1;
 Wed,  5 Feb 2020 20:32:57 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/8] test/acceptance: boot_linux_console: Add boot
 Linux/ppc64le with KVM
Date: Wed,  5 Feb 2020 15:32:47 -0500
Message-Id: <20200205203250.30526-6-wainersm@redhat.com>
In-Reply-To: <20200205203250.30526-1-wainersm@redhat.com>
References: <20200205203250.30526-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: yTkpxFgGNTOdQ8qnJR0RoQ-1
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
Cc: drjones@redhat.com, ehabkost@redhat.com, philmd@redhat.com,
 thuth@redhat.com, crosa@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Likewise this splitted the boot Linux for ppc64le test in a version
for KVM and another for TCG.

The kvm test case is designed to run on POWER8 or greater, otherwise
it is skipped. The SMT should be off on POWER8, that is also checked.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/boot_linux_console.py | 39 ++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot=
_linux_console.py
index 76a66ee533..ca385c90a4 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -19,6 +19,8 @@ from avocado_qemu import exec_command_and_wait_for_patter=
n
 from avocado_qemu import wait_for_console_pattern
 from avocado.utils import process
 from avocado.utils import archive
+from avocado.utils.cpu import get_cpu_vendor_name
+from avocado.utils.path import find_command
=20
=20
 class BootLinuxConsole(Test):
@@ -551,11 +553,7 @@ class BootLinuxConsole(Test):
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
@@ -570,6 +568,37 @@ class BootLinuxConsole(Test):
         console_pattern =3D 'Kernel command line: %s' % kernel_command_lin=
e
         self.wait_for_console_pattern(console_pattern)
=20
+    @skipUnless(find_command('ppc64_cpu', default=3DFalse))
+    def test_ppc64_pseries_kvm(self):
+        """
+        :avocado: tags=3Darch:ppc64
+        :avocado: tags=3Dmachine:pseries
+        :avocado: tags=3Daccel:kvm
+
+        It assumes running on POWER8 or greater, otherwise skip the test.
+        If on POWER8 then SMT should be off, otherwise skip the test.
+        """
+        cpu =3D get_cpu_vendor_name()
+        if not cpu.startswith('power'):
+            self.cancel('do not test with %s cpu' % cpu)
+        else:
+            version =3D int(cpu.replace('power', ''))
+            if version < 8:
+                self.cancel('cpu %s is not >=3D POWER8')
+            elif version =3D=3D 8:
+                smt =3D process.run('ppc64_cpu --smt -n').stdout_text.stri=
p()
+                if smt !=3D 'SMT=3D1':
+                    self.cancel('%s on POWER8' % smt)
+        self.do_test_ppc64_pseries()
+
+    def test_ppc64_pseries_tcg(self):
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
2.24.1


