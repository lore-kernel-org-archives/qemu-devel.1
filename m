Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE83C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:15:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BEE9206CC
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 14:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqRlE3Oe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEE9206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jADl1-0008Bh-8B
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 09:15:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jADkD-0007AH-GZ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jADkC-0006SQ-5P
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:14:29 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57104
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jADkC-0006PM-1g
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 09:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583504067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nm8bSKne1Lj8icaooySgKh7g2utjjmhvjceauz95xM=;
 b=iqRlE3OevSlm3HZVnGQiNo2m53OsaAr57lRvw7WgiCRn38IOO+sdReSqlEz6bdb9A8PTt7
 44Yu6TG3FnaKcVKwBk7HZ9H0MzwRYHpmOxyOFZns5i1pyCQNwFney14ClYmTcG8SG0IWcH
 MpSbaMFyRBtwWOWACiMYyx//AQgxIr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-jisbAg9xNKm3Dk6rIxiOJQ-1; Fri, 06 Mar 2020 09:14:25 -0500
X-MC-Unique: jisbAg9xNKm3Dk6rIxiOJQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6599F18A6EC6;
 Fri,  6 Mar 2020 14:14:24 +0000 (UTC)
Received: from linux.fritz.box.com (unknown [10.36.118.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1F1060C80;
 Fri,  6 Mar 2020 14:14:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 1/2] iotests: Refactor blockdev-reopen test for iothreads
Date: Fri,  6 Mar 2020 15:14:12 +0100
Message-Id: <20200306141413.30705-2-kwolf@redhat.com>
In-Reply-To: <20200306141413.30705-1-kwolf@redhat.com>
References: <20200306141413.30705-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We'll want to test more than one successful case in the future, so
prepare the test for that by a refactoring that runs each scenario in a
separate VM.

test_iothreads_switch_{backing,overlay} currently produce errors, but
these are cases that should actually work, by switching either the
backing file node or the overlay node to the AioContext of the other
node.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
---
 tests/qemu-iotests/245     | 47 ++++++++++++++++++++++++++++++--------
 tests/qemu-iotests/245.out |  4 ++--
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 489bf78bd0..7d9eb6285c 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -970,8 +970,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         self.assertEqual(self.get_node('hd1'), None)
         self.assert_qmp(self.get_node('hd2'), 'ro', True)
=20
-    # We don't allow setting a backing file that uses a different AioConte=
xt
-    def test_iothreads(self):
+    def run_test_iothreads(self, iothread_a, iothread_b, errmsg =3D None):
         opts =3D hd_opts(0)
         result =3D self.vm.qmp('blockdev-add', conv_keys =3D False, **opts=
)
         self.assert_qmp(result, 'return', {})
@@ -986,20 +985,48 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         result =3D self.vm.qmp('object-add', qom_type=3D'iothread', id=3D'=
iothread1')
         self.assert_qmp(result, 'return', {})
=20
-        result =3D self.vm.qmp('x-blockdev-set-iothread', node_name=3D'hd0=
', iothread=3D'iothread0')
+        result =3D self.vm.qmp('device_add', driver=3D'virtio-scsi', id=3D=
'scsi0',
+                             iothread=3Diothread_a)
         self.assert_qmp(result, 'return', {})
=20
-        self.reopen(opts, {'backing': 'hd2'}, "Cannot use a new backing fi=
le with a different AioContext")
-
-        result =3D self.vm.qmp('x-blockdev-set-iothread', node_name=3D'hd2=
', iothread=3D'iothread1')
+        result =3D self.vm.qmp('device_add', driver=3D'virtio-scsi', id=3D=
'scsi1',
+                             iothread=3Diothread_b)
         self.assert_qmp(result, 'return', {})
=20
-        self.reopen(opts, {'backing': 'hd2'}, "Cannot use a new backing fi=
le with a different AioContext")
+        if iothread_a:
+            result =3D self.vm.qmp('device_add', driver=3D'scsi-hd', drive=
=3D'hd0',
+                                 share_rw=3DTrue, bus=3D"scsi0.0")
+            self.assert_qmp(result, 'return', {})
=20
-        result =3D self.vm.qmp('x-blockdev-set-iothread', node_name=3D'hd2=
', iothread=3D'iothread0')
-        self.assert_qmp(result, 'return', {})
+        if iothread_b:
+            result =3D self.vm.qmp('device_add', driver=3D'scsi-hd', drive=
=3D'hd2',
+                                 share_rw=3DTrue, bus=3D"scsi1.0")
+            self.assert_qmp(result, 'return', {})
=20
-        self.reopen(opts, {'backing': 'hd2'})
+        # Attaching the backing file may or may not work
+        self.reopen(opts, {'backing': 'hd2'}, errmsg)
+
+        # But removing the backing file should always work
+        self.reopen(opts, {'backing': None})
+
+        self.vm.shutdown()
+
+    # We don't allow setting a backing file that uses a different AioConte=
xt if
+    # neither of them can switch to the other AioContext
+    def test_iothreads_error(self):
+        self.run_test_iothreads('iothread0', 'iothread1',
+                                "Cannot use a new backing file with a diff=
erent AioContext")
+
+    def test_iothreads_compatible_users(self):
+        self.run_test_iothreads('iothread0', 'iothread0')
+
+    def test_iothreads_switch_backing(self):
+        self.run_test_iothreads('iothread0', None,
+                                "Cannot use a new backing file with a diff=
erent AioContext")
+
+    def test_iothreads_switch_overlay(self):
+        self.run_test_iothreads(None, 'iothread0',
+                                "Cannot use a new backing file with a diff=
erent AioContext")
=20
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D["qcow2"],
diff --git a/tests/qemu-iotests/245.out b/tests/qemu-iotests/245.out
index a19de5214d..682b93394d 100644
--- a/tests/qemu-iotests/245.out
+++ b/tests/qemu-iotests/245.out
@@ -1,6 +1,6 @@
-..................
+.....................
 ----------------------------------------------------------------------
-Ran 18 tests
+Ran 21 tests
=20
 OK
 {"execute": "job-finalize", "arguments": {"id": "commit0"}}
--=20
2.20.1


