Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D117C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18880206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 06:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EtCWSC96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18880206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVrMZ-0007GN-7P
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 02:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVrLh-0006lz-G8
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:46:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58771
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jVrLf-0002NM-Pk
 for qemu-devel@nongnu.org; Tue, 05 May 2020 02:46:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588661194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9w20DTnLApXp2WBba6e7sCP3P2gYoBJjt39YZPwmO9A=;
 b=EtCWSC96T6MjwgWYvaj72GRDzYZRm9oFY8H4L35wpXtou8o0HgogCsnRzAOeRxKxh4xaJZ
 cpdv+hXpctgj9q34unDYk0IajRXLMdxZlx0oitjnD+YeYUVnhGlXlO9YRuBF6qBRm9VaC5
 4/nGMm1a83iozSXJqnHzidK3RAZL6mI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-GyIgpLwaNF2g7zN5OLhOog-1; Tue, 05 May 2020 02:46:33 -0400
X-MC-Unique: GyIgpLwaNF2g7zN5OLhOog-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12A7080183C;
 Tue,  5 May 2020 06:46:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-112-11.ams2.redhat.com [10.36.112.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 331DD10013D9;
 Tue,  5 May 2020 06:46:30 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/055: Use cache.no-flush for vmdk target
Date: Tue,  5 May 2020 08:46:18 +0200
Message-Id: <20200505064618.16267-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

055 uses the backup block job to create a compressed backup of an
$IMGFMT image with both qcow2 and vmdk targets. However, cluster
allocation in vmdk is very slow because it flushes the image file after
each L2 update.

There is no reason why we need this level of safety in this test, so
let's disable flushes for vmdk. For the blockdev-backup tests this is
achieved by simply adding the cache.no-flush=3Don to the drive_add() for
the target. For drive-backup, the caching flags are copied from the
source node, so we'll also add the flag to the source node, even though
it is not vmdk.

This can make the test run significantly faster (though it doesn't make
a difference on tmpfs). In my usual setup it goes from ~45s to ~15s.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/055 | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index ab90062b99..002706c114 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -490,7 +490,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
=20
 class TestCompressedToQcow2(iotests.QMPTestCase):
     image_len =3D 64 * 1024 * 1024 # MB
-    target_fmt =3D {'type': 'qcow2', 'args': ()}
+    target_fmt =3D {'type': 'qcow2', 'args': (), 'drive-opts': ''}
=20
     def tearDown(self):
         self.vm.shutdown()
@@ -501,13 +501,15 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
             pass
=20
     def do_prepare_drives(self, attach_target):
-        self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img)
+        self.vm =3D iotests.VM().add_drive('blkdebug::' + test_img,
+                                         opts=3Dself.target_fmt['drive-opt=
s'])
=20
         qemu_img('create', '-f', self.target_fmt['type'], blockdev_target_=
img,
                  str(self.image_len), *self.target_fmt['args'])
         if attach_target:
             self.vm.add_drive(blockdev_target_img,
-                              format=3Dself.target_fmt['type'], interface=
=3D"none")
+                              format=3Dself.target_fmt['type'], interface=
=3D"none",
+                              opts=3Dself.target_fmt['drive-opts'])
=20
         self.vm.launch()
=20
@@ -601,7 +603,8 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
=20
=20
 class TestCompressedToVmdk(TestCompressedToQcow2):
-    target_fmt =3D {'type': 'vmdk', 'args': ('-o', 'subformat=3DstreamOpti=
mized')}
+    target_fmt =3D {'type': 'vmdk', 'args': ('-o', 'subformat=3DstreamOpti=
mized'),
+                  'drive-opts': 'cache.no-flush=3Don'}
=20
     @iotests.skip_if_unsupported(['vmdk'])
     def setUp(self):
--=20
2.25.3


