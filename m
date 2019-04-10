Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A46C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0946C206DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 16:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0946C206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEG7R-0005DE-5P
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 12:30:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEG6N-0004eP-5D
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEG6M-000698-8p
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 12:29:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEG6J-00065g-VS; Wed, 10 Apr 2019 12:29:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3CC5D83F4C;
	Wed, 10 Apr 2019 16:29:26 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4757A5D72E;
	Wed, 10 Apr 2019 16:29:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 18:29:18 +0200
Message-Id: <20190410162918.9343-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Wed, 10 Apr 2019 16:29:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] iotests: Let 245 pass on tmpfs
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410162918.LnbtyNil7mwR8nxn82_xlupkpEI5MQABudjeYJJdQEM@z>

tmpfs does not support O_DIRECT.  Detect this case, and skip flipping
@direct if the filesystem does not support it.

Fixes: bf3e50f6239090e63a8ffaaec971671e66d88e07
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/245 | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 7891a210c1..a04c6235c1 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -209,6 +209,12 @@ class TestBlockdevReopen(iotests.QMPTestCase):
=20
     # Reopen an image several times changing some of its options
     def test_reopen(self):
+        # Check whether the filesystem supports O_DIRECT
+        if 'O_DIRECT' in qemu_io('-f', 'raw', '-t', 'none', '-c', 'quit'=
, hd_path[0]):
+            supports_direct =3D False
+        else:
+            supports_direct =3D True
+
         # Open the hd1 image passing all backing options
         opts =3D hd_opts(1)
         opts['backing'] =3D hd_opts(0)
@@ -231,9 +237,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(self.get_node('hd1'), 'cache/writeback', True)
         self.assert_qmp(self.get_node('hd1'), 'cache/direct', False)
         self.assert_qmp(self.get_node('hd1'), 'cache/no-flush', False)
-        self.reopen(opts, {'cache': { 'direct': True, 'no-flush': True }=
})
+        self.reopen(opts, {'cache': { 'direct': supports_direct, 'no-flu=
sh': True }})
         self.assert_qmp(self.get_node('hd1'), 'cache/writeback', True)
-        self.assert_qmp(self.get_node('hd1'), 'cache/direct', True)
+        self.assert_qmp(self.get_node('hd1'), 'cache/direct', supports_d=
irect)
         self.assert_qmp(self.get_node('hd1'), 'cache/no-flush', True)
=20
         # Reopen again with the original options
--=20
2.20.1


