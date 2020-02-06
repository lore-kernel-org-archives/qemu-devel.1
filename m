Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807B3C352A5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:38:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3AC218AC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 21:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJw5+8NF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3AC218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izor6-0000hT-BJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 16:38:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izoaX-0000Tj-RH
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izoaW-0005iw-P3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41666
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izoaW-0005hS-Kj
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581024088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=29JTNGpOpid7ssNg3sbe4hNPdOspFe+Ch8ZvI4XRUFs=;
 b=FJw5+8NFf4Z+GIqiPPefxoBFt4Ea9UggTP2hie3dRKlfBazi7/dZ/+og37qyOCQ/U7p7Tr
 UP0Gb2wilkxbSRS2bLNBnAFV30/pBHy3us01vZ+hKSi/59cGftrfAvfjXD9ddRKECOU6Cu
 Ez0vGBLJ1vVmOwWU2GvF7jkdjFk66wY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-Ca7IxHYxOlW_zC_PM95BEw-1; Thu, 06 Feb 2020 16:21:26 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF79E1050442
 for <qemu-devel@nongnu.org>; Thu,  6 Feb 2020 21:21:25 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-120.brq.redhat.com [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6809F60BEC;
 Thu,  6 Feb 2020 21:21:24 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/46] tests/acceptance/migration: Test EXEC transport when
 migrating
Date: Thu,  6 Feb 2020 22:19:18 +0100
Message-Id: <20200206211936.17098-29-philmd@redhat.com>
In-Reply-To: <20200206211936.17098-1-philmd@redhat.com>
References: <20200206211936.17098-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Ca7IxHYxOlW_zC_PM95BEw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Oksana Vohchana <ovoshcha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Oksana Vohchana <ovoshcha@redhat.com>

Along with VM migration via TCP, we can use migration through
the EXEC transport protocol

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20200203111631.18796-3-ovoshcha@redhat.com>
[PMD: Split patch in 2, reworded subject and description]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/acceptance/migration.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index 9eebc36b8f..41b13b9e0d 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -12,9 +12,11 @@
=20
 import tempfile
 from avocado_qemu import Test
+from avocado import skipUnless
=20
 from avocado.utils import network
 from avocado.utils import wait
+from avocado.utils.path import find_command
=20
=20
 class Migration(Test):
@@ -60,3 +62,11 @@ class Migration(Test):
         with tempfile.TemporaryDirectory(prefix=3D'socket_') as socket_pat=
h:
             dest_uri =3D 'unix:%s/qemu-test.sock' % socket_path
             self.do_migrate(dest_uri)
+
+    @skipUnless(find_command('nc', default=3DFalse), "'nc' command not fou=
nd")
+    def test_migration_with_exec(self):
+        """
+        The test works for both netcat-traditional and netcat-openbsd pack=
ages
+        """
+        free_port =3D self._get_free_port()
+        dest_uri =3D 'exec:nc -l localhost %u' % free_port
--=20
2.21.1


