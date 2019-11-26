Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6895EC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345732071A
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsZX0i59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345732071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZayb-0006rC-38
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 08:33:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39890)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iZauc-00049L-8P
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iZaua-0000wD-B2
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42884
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iZauZ-0000uz-0N
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 08:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574774986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5AFYkr7AE9YDxHQ9t5BowRjTy1X9gyqLwc17mwhpohU=;
 b=NsZX0i59DOHkgbItDHd4cIJ5re7qeKogyjGHLlnzbd0Ke6hZjZjXAg0+rbLsxVCo8CHqJR
 HAveng81/Rg3/W9oXMwThMjyb8NiSCw/GpKagvYlzDxfkhUKKSqhw5WME7rzmUXj1+/E7i
 ztFh3mJBAhbBgt1Mt0yNSTr5yi44DgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-vaNRyB5UM7yY9x9DCj4hDg-1; Tue, 26 Nov 2019 08:29:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98F69805A8D;
 Tue, 26 Nov 2019 13:29:43 +0000 (UTC)
Received: from localhost (ovpn-204-240.brq.redhat.com [10.40.204.240])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 328BE196AE;
 Tue, 26 Nov 2019 13:29:43 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/2] iotests: add new test cases to bitmap migration
Date: Tue, 26 Nov 2019 14:29:36 +0100
Message-Id: <20191126132936.1141588-3-mreitz@redhat.com>
In-Reply-To: <20191126132936.1141588-1-mreitz@redhat.com>
References: <20191126132936.1141588-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: vaNRyB5UM7yY9x9DCj4hDg-1
X-Mimecast-Spam-Score: 0
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Add optional pre-shutdown: shutdown/launch vm before migration. This
leads to storing persistent bitmap to the storage, which breaks
migration with dirty-bitmaps capability enabled and shared storage
until fixed by previous commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191125125229.13531-3-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/169     | 22 +++++++++++++++-------
 tests/qemu-iotests/169.out |  4 ++--
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 8c204caf20..9656a7f620 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -134,7 +134,7 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
         self.check_bitmap(self.vm_a, sha256 if persistent else False)
=20
     def do_test_migration(self, persistent, migrate_bitmaps, online,
-                          shared_storage):
+                          shared_storage, pre_shutdown):
         granularity =3D 512
=20
         # regions =3D ((start, count), ...)
@@ -142,15 +142,13 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
                    (0xf0000, 0x10000),
                    (0xa0201, 0x1000))
=20
-        should_migrate =3D migrate_bitmaps or persistent and shared_storag=
e
+        should_migrate =3D \
+            (migrate_bitmaps and (persistent or not pre_shutdown)) or \
+            (persistent and shared_storage)
         mig_caps =3D [{'capability': 'events', 'state': True}]
         if migrate_bitmaps:
             mig_caps.append({'capability': 'dirty-bitmaps', 'state': True}=
)
=20
-        result =3D self.vm_a.qmp('migrate-set-capabilities',
-                               capabilities=3Dmig_caps)
-        self.assert_qmp(result, 'return', {})
-
         self.vm_b.add_incoming(incoming_cmd if online else "defer")
         self.vm_b.add_drive(disk_a if shared_storage else disk_b)
=20
@@ -166,6 +164,14 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
             self.vm_a.hmp_qemu_io('drive0', 'write %d %d' % r)
         sha256 =3D self.get_bitmap_hash(self.vm_a)
=20
+        if pre_shutdown:
+            self.vm_a.shutdown()
+            self.vm_a.launch()
+
+        result =3D self.vm_a.qmp('migrate-set-capabilities',
+                               capabilities=3Dmig_caps)
+        self.assert_qmp(result, 'return', {})
+
         result =3D self.vm_a.qmp('migrate', uri=3Dmig_cmd)
         while True:
             event =3D self.vm_a.event_wait('MIGRATION')
@@ -210,11 +216,13 @@ def inject_test_case(klass, name, method, *args, **kw=
args):
     mc =3D operator.methodcaller(method, *args, **kwargs)
     setattr(klass, 'test_' + method + name, lambda self: mc(self))
=20
-for cmb in list(itertools.product((True, False), repeat=3D4)):
+for cmb in list(itertools.product((True, False), repeat=3D5)):
     name =3D ('_' if cmb[0] else '_not_') + 'persistent_'
     name +=3D ('_' if cmb[1] else '_not_') + 'migbitmap_'
     name +=3D '_online' if cmb[2] else '_offline'
     name +=3D '_shared' if cmb[3] else '_nonshared'
+    if (cmb[4]):
+        name +=3D '__pre_shutdown'
=20
     inject_test_case(TestDirtyBitmapMigration, name, 'do_test_migration',
                      *list(cmb))
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
index 3a89159833..5c26d15c0d 100644
--- a/tests/qemu-iotests/169.out
+++ b/tests/qemu-iotests/169.out
@@ -1,5 +1,5 @@
-....................
+....................................
 ----------------------------------------------------------------------
-Ran 20 tests
+Ran 36 tests
=20
 OK
--=20
2.23.0


