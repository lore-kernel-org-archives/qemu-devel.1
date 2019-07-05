Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF57BC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E5821670
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 20:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E5821670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjUuy-0007sI-1g
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 16:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33108)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jsnow@redhat.com>) id 1hjUeT-000680-M0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1hjUeS-0007Up-H8
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 16:17:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40084)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1hjUeP-0007S5-TD; Fri, 05 Jul 2019 16:17:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2DB3E3082E06;
 Fri,  5 Jul 2019 20:17:45 +0000 (UTC)
Received: from probe.redhat.com (ovpn-122-149.rdu2.redhat.com [10.10.122.149])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03DC586432;
 Fri,  5 Jul 2019 20:17:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Fri,  5 Jul 2019 16:16:29 -0400
Message-Id: <20190705201631.26266-17-jsnow@redhat.com>
In-Reply-To: <20190705201631.26266-1-jsnow@redhat.com>
References: <20190705201631.26266-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Fri, 05 Jul 2019 20:17:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 16/18] iotests: Add virtio-scsi device helper
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems that it comes up enough.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/040        | 6 +-----
 tests/qemu-iotests/093        | 6 ++----
 tests/qemu-iotests/139        | 7 ++-----
 tests/qemu-iotests/238        | 5 +----
 tests/qemu-iotests/iotests.py | 4 ++++
 5 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index b81133a474..657b37103c 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -85,11 +85,7 @@ class TestSingleDrive(ImageCommitTestCase):
         qemu_io('-f', 'raw', '-c', 'write -P 0xab 0 524288', backing_img=
)
         qemu_io('-f', iotests.imgfmt, '-c', 'write -P 0xef 524288 524288=
', mid_img)
         self.vm =3D iotests.VM().add_drive(test_img, "node-name=3Dtop,ba=
cking.node-name=3Dmid,backing.backing.node-name=3Dbase", interface=3D"non=
e")
-        if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-            self.vm.add_device("virtio-scsi-ccw")
-        else:
-            self.vm.add_device("virtio-scsi-pci")
-
+        self.vm.add_device(iotests.get_virtio_scsi_device())
         self.vm.add_device("scsi-hd,id=3Dscsi0,drive=3Ddrive0")
         self.vm.launch()
=20
diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index d88fbc182e..46153220f8 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -366,10 +366,8 @@ class ThrottleTestGroupNames(iotests.QMPTestCase):
 class ThrottleTestRemovableMedia(iotests.QMPTestCase):
     def setUp(self):
         self.vm =3D iotests.VM()
-        if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-            self.vm.add_device("virtio-scsi-ccw,id=3Dvirtio-scsi")
-        else:
-            self.vm.add_device("virtio-scsi-pci,id=3Dvirtio-scsi")
+        self.vm.add_device("{},id=3Dvirtio-scsi".format(
+            iotests.get_virtio_scsi_device()))
         self.vm.launch()
=20
     def tearDown(self):
diff --git a/tests/qemu-iotests/139 b/tests/qemu-iotests/139
index 933b45121a..2176ea51ba 100755
--- a/tests/qemu-iotests/139
+++ b/tests/qemu-iotests/139
@@ -35,11 +35,8 @@ class TestBlockdevDel(iotests.QMPTestCase):
     def setUp(self):
         iotests.qemu_img('create', '-f', iotests.imgfmt, base_img, '1M')
         self.vm =3D iotests.VM()
-        if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-            self.vm.add_device("virtio-scsi-ccw,id=3Dvirtio-scsi")
-        else:
-            self.vm.add_device("virtio-scsi-pci,id=3Dvirtio-scsi")
-
+        self.vm.add_device("{},id=3Dvirtio-scsi".format(
+            iotests.get_virtio_scsi_device()))
         self.vm.launch()
=20
     def tearDown(self):
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index 1c0a46fa90..387a77b2cd 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -23,10 +23,7 @@ import os
 import iotests
 from iotests import log
=20
-if iotests.qemu_default_machine =3D=3D 's390-ccw-virtio':
-    virtio_scsi_device =3D 'virtio-scsi-ccw'
-else:
-    virtio_scsi_device =3D 'virtio-scsi-pci'
+virtio_scsi_device =3D iotests.get_virtio_scsi_device()
=20
 vm =3D iotests.VM()
 vm.launch()
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 6135c9663d..8ae7bc353e 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -164,6 +164,10 @@ def qemu_io_silent(*args):
                          (-exitcode, ' '.join(args)))
     return exitcode
=20
+def get_virtio_scsi_device():
+    if qemu_default_machine =3D=3D 's390-ccw-virtio':
+        return 'virtio-scsi-ccw'
+    return 'virtio-scsi-pci'
=20
 class QemuIoInteractive:
     def __init__(self, *args):
--=20
2.21.0


