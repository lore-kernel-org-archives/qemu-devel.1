Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943C8C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:36:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 607AD206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSAqgMZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 607AD206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iguIh-0000Rb-Gv
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:36:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49731)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1igtru-0005AQ-5D
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1igtrs-0004To-Ue
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28839
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1igtrs-0004TK-RX
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 12:09:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576516152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U04431BIeN0FzPjbcC98pWRFVUrdHv07OhSxu9XIOqY=;
 b=BSAqgMZZS/vohnt+j84tNdB5Wjz177FhKTU5GC55mj3WRooT78IzlPd46C6woJDOjqDx1h
 gyyA9q23I9mbUCNujp1L+HSl8GsqeXRu+hI5SehDO2pvbv8WsXD61eiByzFy15TgdQvAz5
 79ttpPPz0LCoqsgZ/jXcJETnYzMrtbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-26-FRHD0SwZOiO0hvMtbqO2DA-1; Mon, 16 Dec 2019 12:09:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F41D1800D63;
 Mon, 16 Dec 2019 17:09:07 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-54.ams2.redhat.com [10.36.117.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6DA706FEE8;
 Mon, 16 Dec 2019 17:09:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 04/10] iotests: 210: Convert to VM.blockdev_create()
Date: Mon, 16 Dec 2019 18:08:51 +0100
Message-Id: <20191216170857.11880-5-kwolf@redhat.com>
In-Reply-To: <20191216170857.11880-1-kwolf@redhat.com>
References: <20191216170857.11880-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: FRHD0SwZOiO0hvMtbqO2DA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 tests/qemu-iotests/210 | 81 +++++++++++++++++++-----------------------
 1 file changed, 36 insertions(+), 45 deletions(-)

diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index 565e3b7b9b..4ca0fe26ef 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -26,15 +26,6 @@ from iotests import imgfmt
 iotests.verify_image_format(supported_fmts=3D['luks'])
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
 with iotests.FilePath('t.luks') as disk_path, \
      iotests.VM() as vm:
=20
@@ -49,18 +40,18 @@ with iotests.FilePath('t.luks') as disk_path, \
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
-                          'key-secret': 'keysec0',
-                          'size': size,
-                          'iter-time': 10 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'imgfile',
+                         'key-secret': 'keysec0',
+                         'size': size,
+                         'iter-time': 10 })
     vm.shutdown()
=20
     # TODO Proper support for images to be used with imgopts and/or protoc=
ols
@@ -79,22 +70,22 @@ with iotests.FilePath('t.luks') as disk_path, \
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
-                          'key-secret': 'keysec0',
-                          'cipher-alg': 'twofish-128',
-                          'cipher-mode': 'ctr',
-                          'ivgen-alg': 'plain64',
-                          'ivgen-hash-alg': 'md5',
-                          'hash-alg': 'sha1',
-                          'iter-time': 10 })
+    vm.blockdev_create({ 'driver': 'file',
+                         'filename': disk_path,
+                         'size': 0 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': {
+                             'driver': 'file',
+                             'filename': disk_path,
+                         },
+                         'size': size,
+                         'key-secret': 'keysec0',
+                         'cipher-alg': 'twofish-128',
+                         'cipher-mode': 'ctr',
+                         'ivgen-alg': 'plain64',
+                         'ivgen-hash-alg': 'md5',
+                         'hash-alg': 'sha1',
+                         'iter-time': 10 })
     vm.shutdown()
=20
     # TODO Proper support for images to be used with imgopts and/or protoc=
ols
@@ -113,9 +104,9 @@ with iotests.FilePath('t.luks') as disk_path, \
     size =3D 64 * 1024 * 1024
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
@@ -126,11 +117,11 @@ with iotests.FilePath('t.luks') as disk_path, \
=20
     vm.add_blockdev('driver=3Dfile,filename=3D%s,node-name=3Dnode0' % (dis=
k_path))
     vm.launch()
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'node0',
-                          'key-secret': 'keysec0',
-                          'size': 0,
-                          'iter-time': 10 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'node0',
+                         'key-secret': 'keysec0',
+                         'size': 0,
+                         'iter-time': 10 })
     vm.shutdown()
=20
     # TODO Proper support for images to be used with imgopts and/or protoc=
ols
@@ -157,10 +148,10 @@ with iotests.FilePath('t.luks') as disk_path, \
=20
     vm.launch()
     for size in [ 18446744073709551104, 9223372036854775808, 9223372036854=
775296 ]:
-        blockdev_create(vm, { 'driver': imgfmt,
-                              'file': 'node0',
-                              'key-secret': 'keysec0',
-                              'size': size })
+        vm.blockdev_create({ 'driver': imgfmt,
+                             'file': 'node0',
+                             'key-secret': 'keysec0',
+                             'size': size })
     vm.shutdown()
=20
     #
--=20
2.20.1


