Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5029C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:00:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA3024656
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PWxkbkAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA3024656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6vMR-0003H9-IO
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:00:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vK5-0007n5-6M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ovoshcha@redhat.com>) id 1j6vK4-0000QF-7S
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36611
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ovoshcha@redhat.com>) id 1j6vK4-0000LQ-1L
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582718271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7u2as1P7VZGjapNZAwy/f4vGjFGJdJvNHv2ThNBYOYQ=;
 b=PWxkbkANYwvbrcqRqhoRyOfYEn55XxCp2QMG7UzwFp27+IWAHNfmHr1q+I3EFZBWnsTuuO
 5vs4C7i2mJUiWPu7SGndoCR9/wAbFbYueLCJCJK4DBD+DoSid6oxTjivm15uWhm9Y/GaoP
 7c3iheYlN4GGjZg+BpRF3DQsgrZOBUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477--XV0-7VjNAC42iuJsreZcQ-1; Wed, 26 Feb 2020 06:57:47 -0500
X-MC-Unique: -XV0-7VjNAC42iuJsreZcQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD03818FE860
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 11:57:46 +0000 (UTC)
Received: from kh066.redhat.com (ovpn-117-106.ams2.redhat.com [10.36.117.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DBF75C102;
 Wed, 26 Feb 2020 11:57:44 +0000 (UTC)
From: Oksana Vohchana <ovoshcha@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 3/3] Acceptance test: add FD migration
Date: Wed, 26 Feb 2020 13:57:35 +0200
Message-Id: <20200226115735.857-4-ovoshcha@redhat.com>
In-Reply-To: <20200226115735.857-1-ovoshcha@redhat.com>
References: <20200226115735.857-1-ovoshcha@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: ovoshcha@redhat.com, philmd@redhat.com, ehabkost@redhat.com,
 wainersm@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The patch adds a new type of migration test through the file descriptor.

Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
---
 tests/acceptance/migration.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
index a8367ca023..7f4879ce5d 100644
--- a/tests/acceptance/migration.py
+++ b/tests/acceptance/migration.py
@@ -10,7 +10,10 @@
 # later.  See the COPYING file in the top-level directory.
=20
=20
+import os
 import tempfile
+from socket import socketpair, AF_UNIX, SOCK_STREAM
+
 from avocado_qemu import Test
 from avocado import skipUnless
=20
@@ -75,3 +78,21 @@ class Migration(Test):
         """
         free_port =3D self._get_free_port()
         dest_uri =3D 'exec:nc -l localhost %u' % free_port
+
+    def test_migration_with_fd(self):
+        opaque =3D 'fd-migration'
+        data_to_send =3D b"{\"execute\": \"getfd\",  \"arguments\": \
+                        {\"fdname\": \"fd-migration\"}}"
+        send_socket, recv_socket =3D socketpair(AF_UNIX, SOCK_STREAM)
+        fd1 =3D send_socket.fileno()
+        fd2 =3D recv_socket.fileno()
+        os.set_inheritable(fd2, True)
+
+        source_vm =3D self.get_vm()
+        source_vm.launch()
+        source_vm.send_fd_scm(fd=3Dfd1, data=3Ddata_to_send)
+
+        dest_vm =3D self.get_vm('-incoming', 'fd:%s' % fd2)
+        dest_vm.launch()
+        source_vm.qmp('migrate', uri=3D'fd:%s' % opaque)
+        self.assert_migration(source_vm, dest_vm)
--=20
2.21.1


