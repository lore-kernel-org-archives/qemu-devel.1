Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5887DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:52:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25433206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CZ6LbqP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25433206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzyS-0005d7-KC
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzYT-00071X-R0
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzYL-0007sD-Be
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47358
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzYL-0007qu-6t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEhUuCcQRA4LeWBGXMjUbkFOU0DMtH4AppbK9cHRxWA=;
 b=CZ6LbqP0T8zJhDPtny2b+xw2nuKbJykzbUV2axlcmPm+HlEo7e72cJ1xYfGFFjDfu4thue
 Tf5D35vakabd1nnuZ6IYftNA0AdnBUQTUeDco2Pn0QTneD2i3ZofJCqeEeysdgDAPGU/vw
 EnAROrtUtuaF4ut8ffhbcb5cSEX0n1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-1V0YNZJoPpKrQ3VR4xDFLw-1; Thu, 19 Dec 2019 12:25:28 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F03E800D48;
 Thu, 19 Dec 2019 17:25:27 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D37E620C0;
 Thu, 19 Dec 2019 17:25:25 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 22/30] iotests: 212: Convert to VM.blockdev_create()
Date: Thu, 19 Dec 2019 18:24:33 +0100
Message-Id: <20191219172441.7289-23-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 1V0YNZJoPpKrQ3VR4xDFLw-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of having a separate blockdev_create() function, make use of the
VM.blockdev_create() offered by iotests.py.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/212 | 101 +++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 55 deletions(-)

diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index 42b74f208b..8f3ccc7b15 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -26,15 +26,6 @@ from iotests import imgfmt
 iotests.verify_image_format(supported_fmts=3D['parallels'])
 iotests.verify_protocol(supported=3D['file'])
=20
-def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3Dop=
tions,
-                        filters=3D[iotests.filter_qmp_testfiles])
-
-    if 'return' in result:
-        assert result['return'] =3D=3D {}
-        vm.run_job('job0')
-    iotests.log("")
-
 with iotests.FilePath('t.parallels') as disk_path, \
      iotests.VM() as vm:
=20
@@ -47,16 +38,16 @@ with iotests.FilePath('t.parallels') as disk_path, \
     size =3D 128 * 1024 * 1024
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': 'file',
-                          'filename': disk_path,
-                          'size': 0 })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0 })
=20
     vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
                node_name=3D'imgfile', filters=3D[iotests.filter_qmp_testfi=
les])
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'imgfile',
-                          'size': size })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'imgfile',
+                         'size': size })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -71,16 +62,16 @@ with iotests.FilePath('t.parallels') as disk_path, \
     size =3D 64 * 1024 * 1024
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': 'file',
-                          'filename': disk_path,
-                          'size': 0 })
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': {
-                              'driver': 'file',
-                              'filename': disk_path,
-                          },
-                          'size': size,
-                          'cluster-size': 1048576 })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'cluster-size': 1048576 })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -95,16 +86,16 @@ with iotests.FilePath('t.parallels') as disk_path, \
     size =3D 32 * 1024 * 1024
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': 'file',
-                          'filename': disk_path,
-                          'size': 0 })
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': {
-                              'driver': 'file',
-                              'filename': disk_path,
-                          },
-                          'size': size,
-                          'cluster-size': 65536 })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'cluster-size': 65536 })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -116,9 +107,9 @@ with iotests.FilePath('t.parallels') as disk_path, \
     iotests.log("")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': "this doesn't exist",
-                          'size': size })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': "this doesn't exist",
+                         'size': size })
     vm.shutdown()
=20
     #
@@ -129,9 +120,9 @@ with iotests.FilePath('t.parallels') as disk_path, \
=20
     vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dnode0' % (dis=
k_path))
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 0 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 0 })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -143,9 +134,9 @@ with iotests.FilePath('t.parallels') as disk_path, \
     iotests.log("")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 4503599627369984})
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 4503599627369984})
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -171,9 +162,9 @@ with iotests.FilePath('t.parallels') as disk_path, \
     vm.launch()
     for size in [ 1234, 18446744073709551104, 9223372036854775808,
                   9223372036854775296, 4503599627370497 ]:
-        blockdev_create(vm, { 'driver': imgfmt,
-                              'file': 'node0',
-                              'size': size })
+        vm.blockdev_create({ 'driver': imgfmt,
+                             'file': 'node0',
+                             'size': size })
     vm.shutdown()
=20
     #
@@ -185,12 +176,12 @@ with iotests.FilePath('t.parallels') as disk_path, \
     vm.launch()
     for csize in [ 1234, 128, 4294967296, 9223372036854775808,
                    18446744073709551104, 0 ]:
-        blockdev_create(vm, { 'driver': imgfmt,
-                              'file': 'node0',
-                              'size': 67108864,
-                              'cluster-size': csize })
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 281474976710656,
-                          'cluster-size': 512 })
+        vm.blockdev_create({ 'driver': imgfmt,
+                             'file': 'node0',
+                             'size': 67108864,
+                             'cluster-size': csize })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 281474976710656,
+                         'cluster-size': 512 })
     vm.shutdown()
--=20
2.20.1


