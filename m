Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:49:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C8220661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifNWRW8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C8220661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixD0M-0005LJ-BD
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 11:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1ixCtz-0005NU-EU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1ixCty-0008LF-4T
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:42:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31662
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1ixCty-0008L3-0Z
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 11:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580402565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nq8shDh5nxJjg02cbMGDylXu+sFYAPVUasKVVYAD/X0=;
 b=ifNWRW8yRQuw9JKNQi0MrxoljfO/E/7rPRyb+VznRCYIaQGk7f++ZcoubqK5L5VmeJa5w0
 GVb9ugm8qSUrLwIy+v55IpFon7+6kdPdfYM/8sXLYXnw7r6Uoa3jL/CBNjVKqBZAS5cJe6
 3qvz4M/Fe6G4JisNgAYyYGDKcaMPWaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-TdcXEcdNMryu4LUhRTce2Q-1; Thu, 30 Jan 2020 11:42:43 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAF2519057A1
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 16:42:42 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-116-182.ams2.redhat.com [10.36.116.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8927C10018FF;
 Thu, 30 Jan 2020 16:42:36 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 REPOST] Acceptance test: provides to use different
 transport for migration
Date: Thu, 30 Jan 2020 18:42:35 +0200
Message-Id: <20200130164235.12306-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: TdcXEcdNMryu4LUhRTce2Q-1
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
Cc: philmd@redhat.com, wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Along with VM migration via TCP, we can use migration through EXEC
and UNIX transport protocol

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
v2:
  - Removes unnecessary symbols and unused method
---
 tests/acceptance/migration.py | 51 ++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a44c1ae58f..1f6a674843 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -10,10 +10,13 @@
 # later.  See the COPYING file in the top-level directory.
=20
=20
+import tempfile
 from avocado_qemu import Test
+from avocado import skipUnless
=20
 from avocado.utils import network
 from avocado.utils import wait
+from avocado.utils.path import find_command
=20
=20
 class Migration(Test):
@@ -24,6 +27,26 @@ class Migration(Test):
     def migration_finished(vm):
         return vm.command('query-migrate')['status'] in ('completed', 'fai=
led')
=20
+    def do_migrate(self, dest_uri, src_uri=3DNone):
+        source_vm =3D self.get_vm()
+        dest_vm =3D self.get_vm('-incoming', dest_uri)
+        dest_vm.launch()
+        if src_uri is None:
+            src_uri =3D dest_uri
+        source_vm.launch()
+        source_vm.qmp('migrate', uri=3Dsrc_uri)
+        self.assert_migration(source_vm, dest_vm)
+
+    def assert_migration(self, source_vm, dest_vm):
+        wait.wait_for(self.migration_finished,
+                      timeout=3Dself.timeout,
+                      step=3D0.1,
+                      args=3D(source_vm,))
+        self.assertEqual(source_vm.command('query-migrate')['status'], 'co=
mpleted')
+        self.assertEqual(dest_vm.command('query-migrate')['status'], 'comp=
leted')
+        self.assertEqual(dest_vm.command('query-status')['status'], 'runni=
ng')
+        self.assertEqual(source_vm.command('query-status')['status'], 'pos=
tmigrate')
+
     def _get_free_port(self):
         port =3D network.find_free_port()
         if port is None:
@@ -32,19 +55,17 @@ class Migration(Test):
=20
=20
     def test_migration_with_tcp_localhost(self):
-        source_vm =3D self.get_vm()
         dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
-        dest_vm =3D self.get_vm('-incoming', dest_uri)
-        dest_vm.launch()
-        source_vm.launch()
-        source_vm.qmp('migrate', uri=3Ddest_uri)
-        wait.wait_for(
-            self.migration_finished,
-            timeout=3Dself.timeout,
-            step=3D0.1,
-            args=3D(source_vm,)
-        )
-        self.assertEqual(dest_vm.command('query-migrate')['status'], 'comp=
leted')
-        self.assertEqual(source_vm.command('query-migrate')['status'], 'co=
mpleted')
-        self.assertEqual(dest_vm.command('query-status')['status'], 'runni=
ng')
-        self.assertEqual(source_vm.command('query-status')['status'], 'pos=
tmigrate')
+        self.do_migrate(dest_uri)
+
+    def test_migration_with_unix(self):
+        with tempfile.TemporaryDirectory(prefix=3D'socket_') as socket_pat=
h:
+            dest_uri =3D 'unix:%s/qemu-test.sock' % socket_path
+            self.do_migrate(dest_uri)
+
+    @skipUnless(find_command('nc', default=3DFalse), "nc command not found=
 on the system")
+    def test_migration_with_exec(self):
+        free_port =3D self._get_free_port()
+        dest_uri =3D 'exec:nc -l localhost %u' % free_port
+        src_uri =3D 'exec:nc localhost %u' % free_port
+        self.do_migrate(dest_uri, src_uri)
--=20
2.21.1


