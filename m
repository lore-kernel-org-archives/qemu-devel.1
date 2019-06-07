Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46436C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE112064A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 16:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE112064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZHlN-0007bc-TP
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 12:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <crosa@redhat.com>) id 1hZGht-00057j-UN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:23:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1hZGhs-0006Fv-FZ
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:23:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34488)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1hZGhq-0006BS-FX
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 11:23:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7104830F1BA9;
 Fri,  7 Jun 2019 15:22:56 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-122-62.rdu2.redhat.com
 [10.10.122.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7A71842A8;
 Fri,  7 Jun 2019 15:22:50 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 11:22:20 -0400
Message-Id: <20190607152223.9467-6-crosa@redhat.com>
In-Reply-To: <20190607152223.9467-1-crosa@redhat.com>
References: <20190607152223.9467-1-crosa@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Fri, 07 Jun 2019 15:23:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 5/8] VNC Acceptance test: use UNIX domain
 sockets to avoid port collisions
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
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

While running in parallel, the VNC tests that use a TCP port easily
collide.  There's a number of possibilities to reduce the probability
of collisions, but none that completely prevents it from happening.

So, to avoid those collisions, and given that the scope of the tests
are really not related to nature of the socket type, let's switch to
UNIX domain sockets created in temporary directories.

Note: the amount of boiler plate code is far from the ideal, but it's
related to the fact that a test "workdir"[1] attribute can not be used
here, because of the 108 bytes limitation of the UNIX socket path (see
ad9579aaa16). There's a fair assumption here that the temporary
directory returned by Python's tempfile.mkdtemp() won't be anywhere
close to 100 bytes.

[1] https://avocado-framework.readthedocs.io/en/68.0/api/test/avocado.htm=
l#avocado.Test.workdir

Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 tests/acceptance/vnc.py | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
index 064ceabcc1..675fd507ed 100644
--- a/tests/acceptance/vnc.py
+++ b/tests/acceptance/vnc.py
@@ -8,6 +8,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
=20
+import os
+import tempfile
+import shutil
+
 from avocado_qemu import Test
=20
=20
@@ -34,8 +38,16 @@ class Vnc(Test):
         self.assertEqual(set_password_response['error']['desc'],
                          'Could not set password')
=20
+class VncUnixSocket(Test):
+
+    def setUp(self):
+        super(VncUnixSocket, self).setUp()
+        self.socket_dir =3D tempfile.mkdtemp()
+        self.socket_path =3D os.path.join(self.socket_dir, 'vnc-socket')
+
     def test_vnc_change_password_requires_a_password(self):
-        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0')
+        self.vm.add_args('-nodefaults', '-S',
+                         '-vnc', 'unix:%s' % self.socket_path)
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         set_password_response =3D self.vm.qmp('change',
@@ -49,7 +61,8 @@ class Vnc(Test):
                          'Could not set password')
=20
     def test_vnc_change_password(self):
-        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password')
+        self.vm.add_args('-nodefaults', '-S',
+                         '-vnc', 'unix:%s,password' % self.socket_path)
         self.vm.launch()
         self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
         set_password_response =3D self.vm.qmp('change',
@@ -57,3 +70,6 @@ class Vnc(Test):
                                             target=3D'password',
                                             arg=3D'new_password')
         self.assertEqual(set_password_response['return'], {})
+
+    def tearDown(self):
+        shutil.rmtree(self.socket_dir)
--=20
2.21.0


