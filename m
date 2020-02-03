Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD48EC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982F72080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtfnbFpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982F72080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZlp-0007pe-Qa
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:20:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58648)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1iyZid-0003C1-Qk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1iyZic-0007so-Ee
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1iyZic-0007pR-AW
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580728601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fkid7Gf8f4dylwsRVnAS9OVVLeQlN5Lt8ov24InZcLQ=;
 b=KtfnbFpc75qn/8AlBGeipEmuAW+04KWT1ReqoPJRRKcrJNjMkUdBf37elVD+4/19/s1ROX
 2P+u0E77g3EwkM454X5yr0XrY+eEEldEfLFZcvMbQKV3jydeAz0la7W4ruo7v3SIYMq9qF
 C3f9xf28VKfhYpf2HPFjHm+jKrctxD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-qPnMyH2QMQeM0u4h6VMpFw-1; Mon, 03 Feb 2020 06:16:40 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56BA6800D4E
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 11:16:39 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37FB460BE0;
 Mon,  3 Feb 2020 11:16:38 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] Acceptance test: provides to use different transport
 for migration
Date: Mon,  3 Feb 2020 13:16:30 +0200
Message-Id: <20200203111631.18796-2-ovoshcha@redhat.com>
In-Reply-To: <20200203111631.18796-1-ovoshcha@redhat.com>
References: <20200203111631.18796-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: qPnMyH2QMQeM0u4h6VMpFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

v3:
 - Makes refactoring and split into 2 patches
Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 36 ++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a44c1ae58f..34263d8eeb 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -24,6 +24,26 @@ class Migration(Test):
     def migration_finished(vm):
         return vm.command('query-migrate')['status'] in ('completed', 'fai=
led')
=20
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
     def _get_free_port(self):
         port =3D network.find_free_port()
         if port is None:
@@ -32,19 +52,5 @@ class Migration(Test):
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
--=20
2.21.1


