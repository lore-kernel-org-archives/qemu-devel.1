Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92005C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:21:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAD520721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAUSOFUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAD520721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZmw-0000e0-KF
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:21:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58708)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1iyZik-0003Oo-It
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1iyZii-0008T3-Pw
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20844
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1iyZii-0008Qm-Ko
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580728608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ajsidTzn5/I+8wkuum+PyCDwtRBZnLT260hmTdcDgLg=;
 b=AAUSOFUSqhPQrDtknilsTDuX+VDWQ1GD4EIeFCmox2sqp8fZa1DJpiSkPIRjaWgH5kk2t2
 4ImfE1O7UpTl8344Iea7N6yEIzOlW1OjagyH+cwe+5RVupD6vWfUmytYT+WEXIMUbyq2ZO
 FlTd18IJqbV28nw0WVyY2h9A55g3Q3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-y6gU43-jMQKSVdGJxLYm-g-1; Mon, 03 Feb 2020 06:16:46 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C33213EA
 for <qemu-devel@nongnu.org>; Mon,  3 Feb 2020 11:16:45 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-116-185.ams2.redhat.com [10.36.116.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA05160BE0;
 Mon,  3 Feb 2020 11:16:39 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] Acceptance test: provides to use different transport
 for migration
Date: Mon,  3 Feb 2020 13:16:31 +0200
Message-Id: <20200203111631.18796-3-ovoshcha@redhat.com>
In-Reply-To: <20200203111631.18796-1-ovoshcha@redhat.com>
References: <20200203111631.18796-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: y6gU43-jMQKSVdGJxLYm-g-1
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
 - Provides TCP and EXEC migration
Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 34263d8eeb..4419e38384 100644
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
@@ -54,3 +57,16 @@ class Migration(Test):
     def test_migration_with_tcp_localhost(self):
         dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
         self.do_migrate(dest_uri)
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
+        """
+        The test works for both netcat-traditional and netcat-openbsd pack=
ages
+        """
+        free_port =3D self._get_free_port()
+        dest_uri =3D 'exec:nc -l localhost %u' % free_port
+        src_uri =3D 'exec:nc localhost %u' % free_port
+        self.do_migrate(dest_uri, src_uri)
--=20
2.21.1


