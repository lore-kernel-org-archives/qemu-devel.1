Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293FAC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7C8E206C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 18:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4zGoDUd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C8E206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if7AH-0000Wq-Mn
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 13:56:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1if79I-00086A-9m
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1if79F-0006T6-6J
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26217
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1if79F-0006RY-0e
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 13:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576090544;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C027+qP+Ucd9AjIY+dJd9HmyMJGJbuHv6eZml/KFFFY=;
 b=K4zGoDUdtXQj9umxNspdvy9918KE0DiKy/xacLJk1j6k5ByDFIkO8m8DgLb7l+4CUM6Oga
 tAuS0PjQliC28WLLsb5A6qi4PR1nDbPM6JDitwiEV/l+Fy0OWMHj0/Q19DVHc0rLpzm/Z4
 5F3TI3j/lEJleof6r1W8jFcdb9zbpWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-3W6x3mDQO_uApiHMUkTPsw-1; Wed, 11 Dec 2019 13:55:42 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 089E3800D53
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 18:55:42 +0000 (UTC)
Received: from virtlab501.virt.lab.eng.bos.redhat.com
 (virtlab501.virt.lab.eng.bos.redhat.com [10.19.152.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 679565D6AE;
 Wed, 11 Dec 2019 18:55:41 +0000 (UTC)
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] tests/acceptance: Makes linux_initrd and
 empty_cpu_model use QEMUMachine
Date: Wed, 11 Dec 2019 13:55:36 -0500
Message-Id: <20191211185536.16962-3-wainersm@redhat.com>
In-Reply-To: <20191211185536.16962-1-wainersm@redhat.com>
References: <20191211185536.16962-1-wainersm@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 3W6x3mDQO_uApiHMUkTPsw-1
X-Mimecast-Spam-Score: 0
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
Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/empty_cpu_model.py | 12 ++++++------
 tests/acceptance/linux_initrd.py    | 13 +++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tests/acceptance/empty_cpu_model.py b/tests/acceptance/empty_c=
pu_model.py
index 3f4f663582..a1e59e45e4 100644
--- a/tests/acceptance/empty_cpu_model.py
+++ b/tests/acceptance/empty_cpu_model.py
@@ -7,13 +7,13 @@
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
+        self.vm.add_args('-S', '-display', 'none', '-machine', 'none', '-c=
pu', '')
+        self.vm.set_qmp_monitor(enabled=3DFalse)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be=
 1")
+        self.assertRegex(self.vm.get_log(), r'-cpu option cannot be empty'=
)
diff --git a/tests/acceptance/linux_initrd.py b/tests/acceptance/linux_init=
rd.py
index c61d9826a4..aaa4eb9698 100644
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
+            self.vm.set_qmp_monitor(enabled=3DFalse)
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
2.21.0


