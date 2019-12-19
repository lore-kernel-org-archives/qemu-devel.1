Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4F7C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:52:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28805206D8
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hcs2ngf5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28805206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzyl-0006Go-NF
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:52:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzYe-00077E-SV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzYb-00085A-Av
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54741
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzYV-0007v1-NO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UhavTerdPTQoYgu7CvuljzUleQArQqWB5x+i4QENFd4=;
 b=hcs2ngf5eU1GDa9QaS093Ar4SeruLg4A1k6J3Gqfpnd7VPX14R17LnO7EhB0SUWDNFJOwb
 lyt1BLmn3bc9qWYlakm+dsowSVXRf5cG+4UaLOUwwRC/byAEgNgSN6NaKZhTSl/xaQWEQx
 wfenhzaEila4jX+I6RgB2VUhZ+LXmXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-ikZvk8nuMCGUNXa8pwNEQQ-1; Thu, 19 Dec 2019 12:25:33 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 424F110054E3;
 Thu, 19 Dec 2019 17:25:32 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 020A263B8A;
 Thu, 19 Dec 2019 17:25:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 24/30] iotests: 237: Convert to VM.blockdev_create()
Date: Thu, 19 Dec 2019 18:24:35 +0100
Message-Id: <20191219172441.7289-25-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: ikZvk8nuMCGUNXa8pwNEQQ-1
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
 tests/qemu-iotests/237 | 139 +++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 74 deletions(-)

diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index 06897f8c87..a2242a4736 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -26,15 +26,6 @@ from iotests import imgfmt
=20
 iotests.verify_image_format(supported_fmts=3D['vmdk'])
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
 with iotests.FilePath('t.vmdk') as disk_path, \
      iotests.FilePath('t.vmdk.1') as extent1_path, \
      iotests.FilePath('t.vmdk.2') as extent2_path, \
@@ -50,16 +41,16 @@ with iotests.FilePath('t.vmdk') as disk_path, \
     size =3D 5 * 1024 * 1024 * 1024
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
@@ -74,21 +65,21 @@ with iotests.FilePath('t.vmdk') as disk_path, \
     size =3D 64 * 1024 * 1024
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': 'file',
-                          'filename': disk_path,
-                          'size': 0 })
-
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': {
-                              'driver': 'file',
-                              'filename': disk_path,
-                          },
-                          'size': size,
-                          'extents': [],
-                          'subformat': 'monolithicSparse',
-                          'adapter-type': 'ide',
-                          'hwversion': '4',
-                          'zeroed-grain': False })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0 })
+
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'extents': [],
+                         'subformat': 'monolithicSparse',
+                         'adapter-type': 'ide',
+                         'hwversion': '4',
+                         'zeroed-grain': False })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -103,20 +94,20 @@ with iotests.FilePath('t.vmdk') as disk_path, \
     size =3D 32 * 1024 * 1024
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': 'file',
-                          'filename': disk_path,
-                          'size': 0 })
-
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': {
-                              'driver': 'file',
-                              'filename': disk_path,
-                          },
-                          'size': size,
-                          'extents': [],
-                          'subformat': 'monolithicSparse',
-                          'adapter-type': 'buslogic',
-                          'zeroed-grain': True })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0 })
+
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'extents': [],
+                         'subformat': 'monolithicSparse',
+                         'adapter-type': 'buslogic',
+                         'zeroed-grain': True })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -128,9 +119,9 @@ with iotests.FilePath('t.vmdk') as disk_path, \
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
@@ -148,10 +139,10 @@ with iotests.FilePath('t.vmdk') as disk_path, \
=20
     vm.launch()
     for adapter_type in [ 'ide', 'buslogic', 'lsilogic', 'legacyESX' ]:
-        blockdev_create(vm, { 'driver': imgfmt,
-                              'file': 'node0',
-                              'size': size,
-                              'adapter-type': adapter_type })
+        vm.blockdev_create({ 'driver': imgfmt,
+                             'file': 'node0',
+                             'size': size,
+                             'adapter-type': adapter_type })
     vm.shutdown()
=20
     # Invalid
@@ -160,10 +151,10 @@ with iotests.FilePath('t.vmdk') as disk_path, \
=20
     vm.launch()
     for adapter_type in [ 'foo', 'IDE', 'legacyesx', 1 ]:
-        blockdev_create(vm, { 'driver': imgfmt,
-                              'file': 'node0',
-                              'size': size,
-                              'adapter-type': adapter_type })
+        vm.blockdev_create({ 'driver': imgfmt,
+                             'file': 'node0',
+                             'size': size,
+                             'adapter-type': adapter_type })
     vm.shutdown()
=20
     #
@@ -185,10 +176,10 @@ with iotests.FilePath('t.vmdk') as disk_path, \
     iotests.log("")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': size,
-                          'subformat': 'monolithicFlat' })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': size,
+                         'subformat': 'monolithicFlat' })
     vm.shutdown()
=20
     # Correct extent
@@ -196,11 +187,11 @@ with iotests.FilePath('t.vmdk') as disk_path, \
     iotests.log("")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': size,
-                          'subformat': 'monolithicFlat',
-                          'extents': ['ext1'] })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': size,
+                         'subformat': 'monolithicFlat',
+                         'extents': ['ext1'] })
     vm.shutdown()
=20
     # Extra extent
@@ -208,11 +199,11 @@ with iotests.FilePath('t.vmdk') as disk_path, \
     iotests.log("")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 512,
-                          'subformat': 'monolithicFlat',
-                          'extents': ['ext1', 'ext2', 'ext3'] })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 512,
+                         'subformat': 'monolithicFlat',
+                         'extents': ['ext1', 'ext2', 'ext3'] })
     vm.shutdown()
=20
     # Split formats
@@ -228,11 +219,11 @@ with iotests.FilePath('t.vmdk') as disk_path, \
             extents =3D [ "ext%d" % (i) for i in range(1, num_extents + 1)=
 ]
=20
             vm.launch()
-            blockdev_create(vm, { 'driver': imgfmt,
-                                  'file': 'node0',
-                                  'size': size,
-                                  'subformat': subfmt,
-                                  'extents': extents })
+            vm.blockdev_create({ 'driver': imgfmt,
+                                 'file': 'node0',
+                                 'size': size,
+                                 'subformat': subfmt,
+                                 'extents': extents })
             vm.shutdown()
=20
             iotests.img_info_log(disk_path)
--=20
2.20.1


