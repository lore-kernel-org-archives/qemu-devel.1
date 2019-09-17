Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B8BC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F53921897
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 09:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F53921897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA9jG-0006HY-6I
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 05:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iA9em-0001WF-A2
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iA9el-0004Ud-3v
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 05:20:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iA9eh-0004S9-Tg; Tue, 17 Sep 2019 05:20:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CFA4D10CC1ED;
 Tue, 17 Sep 2019 09:20:14 +0000 (UTC)
Received: from localhost (ovpn-116-130.ams2.redhat.com [10.36.116.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 037995D6C8;
 Tue, 17 Sep 2019 09:20:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Tue, 17 Sep 2019 11:19:58 +0200
Message-Id: <20190917092004.999-2-mreitz@redhat.com>
In-Reply-To: <20190917092004.999-1-mreitz@redhat.com>
References: <20190917092004.999-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Tue, 17 Sep 2019 09:20:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 1/7] iotests: Prefer null-co over null-aio
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use null-co basically everywhere in the iotests.  Unless we want to
test null-aio specifically, we should use it instead (for consistency).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/093 | 7 +++----
 tests/qemu-iotests/245 | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 3c4f5173ce..50c1e7f2ec 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -267,13 +267,12 @@ class ThrottleTestCoroutine(ThrottleTestCase):
     test_img =3D "null-co://"
=20
 class ThrottleTestGroupNames(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
     max_drives =3D 3
=20
     def setUp(self):
         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img,
+            self.vm.add_drive("null-co://",
                               "throttling.iops-total=3D100,file.read-zer=
oes=3Don")
         self.vm.launch()
=20
@@ -376,10 +375,10 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCas=
e):
=20
     def test_removable_media(self):
         # Add a couple of dummy nodes named cd0 and cd1
-        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
+        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
                              read_zeroes=3DTrue, node_name=3D"cd0")
         self.assert_qmp(result, 'return', {})
-        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
+        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
                              read_zeroes=3DTrue, node_name=3D"cd1")
         self.assert_qmp(result, 'return', {})
=20
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 41218d5f1d..e66a23c5f0 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -598,7 +598,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         ##################
         ###### null ######
         ##################
-        opts =3D {'driver': 'null-aio', 'node-name': 'root', 'size': 102=
4}
+        opts =3D {'driver': 'null-co', 'node-name': 'root', 'size': 1024=
}
=20
         result =3D self.vm.qmp('blockdev-add', conv_keys =3D False, **op=
ts)
         self.assert_qmp(result, 'return', {})
--=20
2.21.0


