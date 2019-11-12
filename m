Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:00:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7861321A49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyWxLDZg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7861321A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUWiq-0000jv-Rz
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:00:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iUWhX-0008IH-U6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:59:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iUWhW-00057o-PN
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:59:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56399
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iUWhW-00057P-Lk
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 08:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573567162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twVqRx4Sja+DfqjSaz8u0cWY+m3+byf5RH+2bJlobTY=;
 b=TyWxLDZgTvNeHWNqjUulCouE3UC1FHEV+Of+fX5ieHp2BUwowpYD+8OXqd8RvgdCc/Vs0F
 K3nv+Xd7+dbt4ejK0ssfvWve/KOhcRlF4DmEGVBBc6d99tePxPjIu4qu7uJBY3K5J8FVSw
 WZLzH00tV6Fuo6LyBxUKrBtu/ccJXu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-0pC-nGahPhGGzMtCWMAQDQ-1; Tue, 12 Nov 2019 08:58:12 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 237F41800D63
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 13:58:12 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6E32F100EBAC;
 Tue, 12 Nov 2019 13:58:11 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] tests/acceptance: Makes linux_initrd and empty_cpu_model
 use QEMUMachine
Date: Tue, 12 Nov 2019 08:58:01 -0500
Message-Id: <20191112135801.854-3-wainersm@redhat.com>
In-Reply-To: <20191112135801.854-1-wainersm@redhat.com>
References: <20191112135801.854-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 0pC-nGahPhGGzMtCWMAQDQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

On linux_initrd and empty_cpu_model tests the same effect of
calling QEMU through run() to inspect the terminated process is
achieved with a sequence of set_qmp_monitor() / launch() / wait()
commands on an QEMUMachine object. This patch changes those
tests to use QEMUMachine instead, so they follow the same pattern
to launch QEMU found on other acceptance tests.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tests/acceptance/empty_cpu_model.py | 13 +++++++------
 tests/acceptance/linux_initrd.py    | 13 +++++++------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/tests/acceptance/empty_cpu_model.py b/tests/acceptance/empty_c=
pu_model.py
index 3f4f663582..8c20a4ef4a 100644
--- a/tests/acceptance/empty_cpu_model.py
+++ b/tests/acceptance/empty_cpu_model.py
@@ -7,13 +7,14 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
-import subprocess
 from avocado_qemu import Test
=20
 class EmptyCPUModel(Test):
     def test(self):
-        cmd =3D [self.qemu_bin, '-S', '-display', 'none', '-machine', 'non=
e', '-cpu', '']
-        r =3D subprocess.run(cmd, stderr=3Dsubprocess.PIPE, stdout=3Dsubpr=
ocess.PIPE)
-        self.assertEquals(r.returncode, 1, "QEMU exit code should be 1")
-        self.assertEquals(r.stdout, b'', "QEMU stdout should be empty")
-        self.assertNotEquals(r.stderr, b'', "QEMU stderr shouldn't be empt=
y")
+        self.vm.add_args('-S', '-display', 'none', '-machine', 'none',
+                         '-cpu', '')
+        self.vm.set_qmp_monitor(disabled=3DTrue)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be=
 1")
+        self.assertRegex(self.vm.get_log(), r'-cpu option cannot be empty'=
)
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_init=
rd.py
index c61d9826a4..158ec4d46c 100644
--- a/tests/acceptance/linux_initrd.py
+++ b/tests/acceptance/linux_initrd.py
@@ -10,7 +10,6 @@
=20
 import logging
 import tempfile
-from avocado.utils.process import run
=20
 from avocado_qemu import Test
=20
@@ -41,13 +40,15 @@ class LinuxInitrd(Test):
             initrd.seek(max_size)
             initrd.write(b'\0')
             initrd.flush()
-            cmd =3D "%s -kernel %s -initrd %s -m 4096" % (
-                  self.qemu_bin, kernel_path, initrd.name)
-            res =3D run(cmd, ignore_status=3DTrue)
-            self.assertEqual(res.exit_status, 1)
+            self.vm.add_args('-kernel', kernel_path, '-initrd', initrd.nam=
e,
+                             '-m', '4096')
+            self.vm.set_qmp_monitor(disabled=3DTrue)
+            self.vm.launch()
+            self.vm.wait()
+            self.assertEqual(self.vm.exitcode(), 1)
             expected_msg =3D r'.*initrd is too large.*max: \d+, need %s.*'=
 % (
                 max_size + 1)
-            self.assertRegex(res.stderr_text, expected_msg)
+            self.assertRegex(self.vm.get_log(), expected_msg)
=20
     def test_with_2gib_file_should_work_with_linux_v4_16(self):
         """
--=20
2.18.1


