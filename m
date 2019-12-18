Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F7EC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 14:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 293C421582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 14:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JFGGdzbV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293C421582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihaZB-0004gV-94
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 09:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihaYV-0004H7-CY
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 09:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihaYS-0007CB-OU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 09:44:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43914
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihaYS-000739-3u
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 09:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576680239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2arDANuKcCRoUOX9pzo6ycOeu9V/Wt7V7uq/JXcQjis=;
 b=JFGGdzbVPFqaHnaNgr4qUnExMFpRWnbh4UzKXrNJ+qF3CmNR7KXSkPdwXqgmOTU7ldtO7T
 LWfWStf0nCQhIr4E6Ky0YwvJXF53QhEvvQdBrI3+Bv2cnd7lC2vLXbgO23Dez0bjMy4y2v
 +k+oq/bXSgZfYy1ECyqUwi3y49+xKF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-7C4Wyl9qOvmAUxHycJpizw-1; Wed, 18 Dec 2019 09:43:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63AFBCF1D2;
 Wed, 18 Dec 2019 14:43:54 +0000 (UTC)
Received: from thuth.com (ovpn-116-150.ams2.redhat.com [10.36.116.150])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CFF295D9E2;
 Wed, 18 Dec 2019 14:43:52 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Subject: [PATCH v2] iotests: Add more "skip_if_unsupported" statements to the
 python tests
Date: Wed, 18 Dec 2019 15:43:49 +0100
Message-Id: <20191218144349.19354-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 7C4Wyl9qOvmAUxHycJpizw-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The python code already contains a possibility to skip tests if the
corresponding driver is not available in the qemu binary - use it
in more spots to avoid that the tests are failing if the driver has
been disabled.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Thanks to Max' "iotests: Allow skipping test cases" patch (see
     commit 6be012252018249d3a), this patch has been greatly simplified
     by only marking the setUp functions instead of all functions from
     a class.

 tests/qemu-iotests/030 | 1 +
 tests/qemu-iotests/040 | 2 ++
 tests/qemu-iotests/041 | 1 +
 tests/qemu-iotests/245 | 2 ++
 4 files changed, 6 insertions(+)

diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
index f3766f2a81..a585554c61 100755
--- a/tests/qemu-iotests/030
+++ b/tests/qemu-iotests/030
@@ -530,6 +530,7 @@ class TestQuorum(iotests.QMPTestCase):
     children =3D []
     backing =3D []
=20
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         opts =3D ['driver=3Dquorum', 'vote-threshold=3D2']
=20
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 762ad1ebcb..74f62c3c4a 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -106,6 +106,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xab 0 52=
4288', backing_img).find("verification failed"))
         self.assertEqual(-1, qemu_io('-f', 'raw', '-c', 'read -P 0xef 5242=
88 524288', backing_img).find("verification failed"))
=20
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_with_filter_and_quit(self):
         result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group', =
id=3D'tg')
         self.assert_qmp(result, 'return', {})
@@ -125,6 +126,7 @@ class TestSingleDrive(ImageCommitTestCase):
         self.has_quit =3D True
=20
     # Same as above, but this time we add the filter after starting the jo=
b
+    @iotests.skip_if_unsupported(['throttle'])
     def test_commit_plus_filter_and_quit(self):
         result =3D self.vm.qmp('object-add', qom_type=3D'throttle-group', =
id=3D'tg')
         self.assert_qmp(result, 'return', {})
diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8568426311..ef95fba656 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -871,6 +871,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
     image_len =3D 1 * 1024 * 1024 # MB
     IMAGES =3D [ quorum_img1, quorum_img2, quorum_img3 ]
=20
+    @iotests.skip_if_unsupported(['quorum'])
     def setUp(self):
         self.vm =3D iotests.VM()
=20
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index e66a23c5f0..36d7ca6ded 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -478,6 +478,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
     # This test verifies that we can't change the children of a block
     # device during a reopen operation in a way that would create
     # cycles in the node graph
+    @iotests.skip_if_unsupported(['blkverify'])
     def test_graph_cycles(self):
         opts =3D []
=20
@@ -534,6 +535,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assert_qmp(result, 'return', {})
=20
     # Misc reopen tests with different block drivers
+    @iotests.skip_if_unsupported(['quorum'])
     def test_misc_drivers(self):
         ####################
         ###### quorum ######
--=20
2.18.1


