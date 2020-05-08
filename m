Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8ECC47254
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00BE324963
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 12:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsA6jpd3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00BE324963
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2WV-0005qA-0z
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 08:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KX-0000Et-9J
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jX2KS-0008Ea-Qz
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588941732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTemD0JLp415x05I2fMhDhO+J7yzVhGwAWs1mEFO9fs=;
 b=HsA6jpd33N9FTnQu2yro9faRFfq8iOZyc1cTR52r+nFD8aCOI30b4x64X3Kh346BA6IkFH
 J0xcu1Qb+8Hpeci2z6WWQugOSKvito0wIurrXmO+Khl2Za73wl8iWu1KEBMmYqs0bRP7xO
 12oLh/d8Hv3y0XpUjl4Cil7jMuWYT6M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-z-r5LZrwPNuXlQghFrWTdw-1; Fri, 08 May 2020 08:42:09 -0400
X-MC-Unique: z-r5LZrwPNuXlQghFrWTdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84C42100CCC1;
 Fri,  8 May 2020 12:42:08 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-190.ams2.redhat.com
 [10.36.113.190])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8729419167;
 Fri,  8 May 2020 12:42:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 20/30] iotests/055: Use cache.no-flush for vmdk target
Date: Fri,  8 May 2020 14:41:25 +0200
Message-Id: <20200508124135.252565-21-kwolf@redhat.com>
In-Reply-To: <20200508124135.252565-1-kwolf@redhat.com>
References: <20200508124135.252565-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:25:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
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
Message-Id: <20200505064618.16267-1-kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/055 | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/055 b/tests/qemu-iotests/055
index 7f8e630de3..4d3744b0d3 100755
--- a/tests/qemu-iotests/055
+++ b/tests/qemu-iotests/055
@@ -489,7 +489,7 @@ class TestSingleTransaction(iotests.QMPTestCase):
=20
 class TestCompressedToQcow2(iotests.QMPTestCase):
     image_len =3D 64 * 1024 * 1024 # MB
-    target_fmt =3D {'type': 'qcow2', 'args': ()}
+    target_fmt =3D {'type': 'qcow2', 'args': (), 'drive-opts': ''}
=20
     def tearDown(self):
         self.vm.shutdown()
@@ -500,14 +500,16 @@ class TestCompressedToQcow2(iotests.QMPTestCase):
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
                               img_format=3Dself.target_fmt['type'],
-                              interface=3D"none")
+                              interface=3D"none",
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


