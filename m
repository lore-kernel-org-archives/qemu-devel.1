Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F313CC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F2E206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff65bxzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F2E206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguJX-000188-DI
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:37:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igtrs-00057p-JK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igtrr-0004Rp-0X
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43809
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igtrq-0004R5-SK
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576516150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9w/18jZyLV30S83YZql6CNRQOdsnRN+w62k/NbVivo4=;
 b=Ff65bxzEFoxcHMs0jci3bJh8D/x3l12zJ3PqG/Gp9ZDo4yUOtgCFixoiQxrMRD4wXZfOGu
 PSg60j2PgMml+9qiqNgAqvsc33qSl4RMi2USpXEJWrwZkGdx5Zm2CxfZa+8FuTWzdie+Lc
 ZaTIO8VeowCUu0Ului2XQmDnntbvDjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-E5vhkJDnPJKeK0y3-wuteA-1; Mon, 16 Dec 2019 12:09:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29902800D4C;
 Mon, 16 Dec 2019 17:09:06 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D38467C81E;
 Mon, 16 Dec 2019 17:09:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 03/10] iotests: 206: Convert to VM.blockdev_create()
Date: Mon, 16 Dec 2019 18:08:50 +0100
Message-Id: <20191216170857.11880-4-kwolf@redhat.com>
In-Reply-To: <20191216170857.11880-1-kwolf@redhat.com>
References: <20191216170857.11880-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: E5vhkJDnPJKeK0y3-wuteA-1
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of having a separate blockdev_create() function, make use of the
VM.blockdev_create() offered by iotests.py.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/206 | 232 ++++++++++++++++++++---------------------
 1 file changed, 111 insertions(+), 121 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 5bb738bf23..9f16a7df8d 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -25,16 +25,6 @@ from iotests import imgfmt
=20
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
=20
-def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create',
-                        filters=3D[iotests.filter_qmp_testfiles],
-                        job_id=3D'job0', options=3Doptions)
-
-    if 'return' in result:
-        assert result['return'] =3D=3D {}
-        vm.run_job('job0')
-    iotests.log("")
-
 with iotests.FilePath('t.qcow2') as disk_path, \
      iotests.FilePath('t.qcow2.base') as backing_path, \
      iotests.VM() as vm:
@@ -50,18 +40,18 @@ with iotests.FilePath('t.qcow2') as disk_path, \
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
     vm.qmp_log('blockdev-add',
                filters=3D[iotests.filter_qmp_testfiles],
                driver=3D'file', filename=3Ddisk_path,
                node_name=3D'imgfile')
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
@@ -76,23 +66,23 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     size =3D 64 * 1024 * 1024
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': 'file',
-                          'filename': disk_path,
-                          'size': 0,
-                          'preallocation': 'off',
-                          'nocow': False })
-
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': {
-                              'driver': 'file',
-                              'filename': disk_path,
-                          },
-                          'size': size,
-                          'version': 'v3',
-                          'cluster-size': 65536,
-                          'preallocation': 'off',
-                          'lazy-refcounts': False,
-                          'refcount-bits': 16 })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0,
+                         'preallocation': 'off',
+                         'nocow': False })
+
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'version': 'v3',
+                         'cluster-size': 65536,
+                         'preallocation': 'off',
+                         'lazy-refcounts': False,
+                         'refcount-bits': 16 })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -107,23 +97,23 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     size =3D 32 * 1024 * 1024
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': 'file',
-                          'filename': disk_path,
-                          'size': 0,
-                          'preallocation': 'falloc',
-                          'nocow': True })
-
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': {
-                              'driver': 'file',
-                              'filename': disk_path,
-                          },
-                          'size': size,
-                          'version': 'v3',
-                          'cluster-size': 2097152,
-                          'preallocation': 'metadata',
-                          'lazy-refcounts': True,
-                          'refcount-bits': 1 })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0,
+                         'preallocation': 'falloc',
+                         'nocow': True })
+
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'version': 'v3',
+                         'cluster-size': 2097152,
+                         'preallocation': 'metadata',
+                         'lazy-refcounts': True,
+                         'refcount-bits': 1 })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -135,20 +125,20 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     iotests.log("")
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
-                          'backing-file': backing_path,
-                          'backing-fmt': 'qcow2',
-                          'version': 'v2',
-                          'cluster-size': 512 })
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
+                         'backing-file': backing_path,
+                         'backing-fmt': 'qcow2',
+                         'version': 'v2',
+                         'cluster-size': 512 })
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -160,22 +150,22 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     iotests.log("")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': {
-                              'driver': 'file',
-                              'filename': disk_path,
-                          },
-                          'size': size,
-                          'encrypt': {
-                              'format': 'luks',
-                              'key-secret': 'keysec0',
-                              'cipher-alg': 'twofish-128',
-                              'cipher-mode': 'ctr',
-                              'ivgen-alg': 'plain64',
-                              'ivgen-hash-alg': 'md5',
-                              'hash-alg': 'sha1',
-                              'iter-time': 10,
-                          }})
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'encrypt': {
+                             'format': 'luks',
+                             'key-secret': 'keysec0',
+                             'cipher-alg': 'twofish-128',
+                             'cipher-mode': 'ctr',
+                             'ivgen-alg': 'plain64',
+                             'ivgen-hash-alg': 'md5',
+                             'hash-alg': 'sha1',
+                             'iter-time': 10,
+                         }})
     vm.shutdown()
=20
     iotests.img_info_log(disk_path)
@@ -187,9 +177,9 @@ with iotests.FilePath('t.qcow2') as disk_path, \
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
@@ -211,9 +201,9 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     vm.launch()
     for size in [ 1234, 18446744073709551104, 9223372036854775808,
                   9223372036854775296 ]:
-        blockdev_create(vm, { 'driver': imgfmt,
-                              'file': 'node0',
-                              'size': size })
+        vm.blockdev_create({ 'driver': imgfmt,
+                             'file': 'node0',
+                             'size': size })
     vm.shutdown()
=20
     #
@@ -222,20 +212,20 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     iotests.log("=3D=3D=3D Invalid version =3D=3D=3D")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 67108864,
-                          'version': 'v1' })
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 67108864,
-                          'version': 'v2',
-                          'lazy-refcounts': True })
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 67108864,
-                          'version': 'v2',
-                          'refcount-bits': 8 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 67108864,
+                         'version': 'v1' })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 67108864,
+                         'version': 'v2',
+                         'lazy-refcounts': True })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 67108864,
+                         'version': 'v2',
+                         'refcount-bits': 8 })
     vm.shutdown()
=20
     #
@@ -244,15 +234,15 @@ with iotests.FilePath('t.qcow2') as disk_path, \
     iotests.log("=3D=3D=3D Invalid backing file options =3D=3D=3D")
=20
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 67108864,
-                          'backing-file': '/dev/null',
-                          'preallocation': 'full' })
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'size': 67108864,
-                          'backing-fmt': imgfmt })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 67108864,
+                         'backing-file': '/dev/null',
+                         'preallocation': 'full' })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'size': 67108864,
+                         'backing-fmt': imgfmt })
     vm.shutdown()
=20
     #
@@ -262,14 +252,14 @@ with iotests.FilePath('t.qcow2') as disk_path, \
=20
     vm.launch()
     for csize in [ 1234, 128, 4194304, 0 ]:
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
=20
     #
@@ -279,8 +269,8 @@ with iotests.FilePath('t.qcow2') as disk_path, \
=20
     vm.launch()
     for refcount_bits in [ 128, 0, 7 ]:
-        blockdev_create(vm, { 'driver': imgfmt,
-                              'file': 'node0',
-                              'size': 67108864,
-                              'refcount-bits': refcount_bits })
+        vm.blockdev_create({ 'driver': imgfmt,
+                             'file': 'node0',
+                             'size': 67108864,
+                             'refcount-bits': refcount_bits })
     vm.shutdown()
--=20
2.20.1


