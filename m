Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDB8C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A43D222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuKmVwQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A43D222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihztb-0007aQ-Ti
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:47:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzYe-00077B-Sj
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzYb-00086B-Gr
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46614
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzYb-0007w0-9C
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObAbxKBDFX6idCUxDvztgVsj5J3YsU4c76UbUkC6040=;
 b=RuKmVwQ257NAiMQRT3AXBSDEWcrsXRFjQLRuEB2pCZ30DyGar9JwIODF2KZnAZ7N5FKp3a
 JKkGhhb9pscEV8p7KhQ89scQ8BRajx6LuYNUhEl5Dpse+gDB17RGCJpFG6HGBv5q7QxOh6
 qt8xddYVXKa081q2bxpNQVTrnUzDrbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-HTeuY3DVPKipAXzJhpStFA-1; Thu, 19 Dec 2019 12:25:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B3F64800D41;
 Thu, 19 Dec 2019 17:25:34 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89C8663B8A;
 Thu, 19 Dec 2019 17:25:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 25/30] iotests: 266: Convert to VM.blockdev_create()
Date: Thu, 19 Dec 2019 18:24:36 +0100
Message-Id: <20191219172441.7289-26-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HTeuY3DVPKipAXzJhpStFA-1
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Instead of having a separate blockdev_create() function, make use of the
VM.blockdev_create() offered by iotests.py.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/266     | 69 +++++++++++++++++---------------------
 tests/qemu-iotests/266.out | 14 ++++++++
 2 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/tests/qemu-iotests/266 b/tests/qemu-iotests/266
index 5b35cd67e4..c353cf88ee 100755
--- a/tests/qemu-iotests/266
+++ b/tests/qemu-iotests/266
@@ -22,15 +22,6 @@ import iotests
 from iotests import imgfmt
=20
=20
-def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3Dop=
tions,
-                        filters=3D[iotests.filter_qmp_testfiles])
-
-    if 'return' in result:
-        assert result['return'] =3D=3D {}
-        vm.run_job('job0')
-
-
 # Successful image creation (defaults)
 def implicit_defaults(vm, file_path):
     iotests.log("=3D=3D=3D Successful image creation (defaults) =3D=3D=3D"=
)
@@ -40,9 +31,9 @@ def implicit_defaults(vm, file_path):
     # (Close to 64 MB)
     size =3D 8 * 964 * 17 * 512
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'protocol-node',
-                          'size': size })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'protocol-node',
+                         'size': size })
=20
=20
 # Successful image creation (explicit defaults)
@@ -54,11 +45,11 @@ def explicit_defaults(vm, file_path):
     # (Close to 128 MB)
     size =3D 16 * 964 * 17 * 512
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'protocol-node',
-                          'size': size,
-                          'subformat': 'dynamic',
-                          'force-size': False })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'protocol-node',
+                         'size': size,
+                         'subformat': 'dynamic',
+                         'force-size': False })
=20
=20
 # Successful image creation (non-default options)
@@ -69,11 +60,11 @@ def non_defaults(vm, file_path):
     # Not representable in CHS (fine with force-size=3DTrue)
     size =3D 1048576
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'protocol-node',
-                          'size': size,
-                          'subformat': 'fixed',
-                          'force-size': True })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'protocol-node',
+                         'size': size,
+                         'subformat': 'fixed',
+                         'force-size': True })
=20
=20
 # Size not representable in CHS with force-size=3DFalse
@@ -84,10 +75,10 @@ def non_chs_size_without_force(vm, file_path):
     # Not representable in CHS (will not work with force-size=3DFalse)
     size =3D 1048576
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'protocol-node',
-                          'size': size,
-                          'force-size': False })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'protocol-node',
+                         'size': size,
+                         'force-size': False })
=20
=20
 # Zero size
@@ -95,9 +86,9 @@ def zero_size(vm, file_path):
     iotests.log("=3D=3D=3D Zero size=3D=3D=3D")
     iotests.log("")
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'protocol-node',
-                          'size': 0 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'protocol-node',
+                         'size': 0 })
=20
=20
 # Maximum CHS size
@@ -105,9 +96,9 @@ def maximum_chs_size(vm, file_path):
     iotests.log("=3D=3D=3D Maximum CHS size=3D=3D=3D")
     iotests.log("")
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'protocol-node',
-                          'size': 16 * 65535 * 255 * 512 })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'protocol-node',
+                         'size': 16 * 65535 * 255 * 512 })
=20
=20
 # Actual maximum size
@@ -115,10 +106,10 @@ def maximum_size(vm, file_path):
     iotests.log("=3D=3D=3D Actual maximum size=3D=3D=3D")
     iotests.log("")
=20
-    blockdev_create(vm, { 'driver': imgfmt,
-                          'file': 'protocol-node',
-                          'size': 0xff000000 * 512,
-                          'force-size': True })
+    vm.blockdev_create({ 'driver': imgfmt,
+                         'file': 'protocol-node',
+                         'size': 0xff000000 * 512,
+                         'force-size': True })
=20
=20
 def main():
@@ -132,9 +123,9 @@ def main():
             vm.launch()
=20
             iotests.log('--- Creating empty file ---')
-            blockdev_create(vm, { 'driver': 'file',
-                                  'filename': file_path,
-                                  'size': 0 })
+            vm.blockdev_create({ 'driver': 'file',
+                                 'filename': file_path,
+                                 'size': 0 })
=20
             vm.qmp_log('blockdev-add', driver=3D'file', filename=3Dfile_pa=
th,
                        node_name=3D'protocol-node',
diff --git a/tests/qemu-iotests/266.out b/tests/qemu-iotests/266.out
index b11953e81f..5a7d7d01aa 100644
--- a/tests/qemu-iotests/266.out
+++ b/tests/qemu-iotests/266.out
@@ -3,6 +3,7 @@
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
+
 {"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
 {"return": {}}
=20
@@ -13,6 +14,7 @@
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
+
 image: TEST_IMG
 file format: IMGFMT
 virtual size: 64 MiB (67125248 bytes)
@@ -23,6 +25,7 @@ cluster_size: 2097152
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
+
 {"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
 {"return": {}}
=20
@@ -33,6 +36,7 @@ cluster_size: 2097152
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
+
 image: TEST_IMG
 file format: IMGFMT
 virtual size: 128 MiB (134250496 bytes)
@@ -43,6 +47,7 @@ cluster_size: 2097152
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
+
 {"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
 {"return": {}}
=20
@@ -53,6 +58,7 @@ cluster_size: 2097152
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
+
 image: TEST_IMG
 file format: IMGFMT
 virtual size: 1 MiB (1048576 bytes)
@@ -62,6 +68,7 @@ virtual size: 1 MiB (1048576 bytes)
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
+
 {"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
 {"return": {}}
=20
@@ -73,6 +80,7 @@ Job failed: The requested image size cannot be represente=
d in CHS geometry
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
+
 qemu-img: Could not open 'TEST_IMG': File too small for a VHD header
=20
 --- Creating empty file ---
@@ -80,6 +88,7 @@ qemu-img: Could not open 'TEST_IMG': File too small for a=
 VHD header
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
+
 {"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
 {"return": {}}
=20
@@ -90,6 +99,7 @@ qemu-img: Could not open 'TEST_IMG': File too small for a=
 VHD header
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
+
 image: TEST_IMG
 file format: IMGFMT
 virtual size: 0 B (0 bytes)
@@ -100,6 +110,7 @@ cluster_size: 2097152
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
+
 {"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
 {"return": {}}
=20
@@ -110,6 +121,7 @@ cluster_size: 2097152
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
+
 image: TEST_IMG
 file format: IMGFMT
 virtual size: 127 GiB (136899993600 bytes)
@@ -120,6 +132,7 @@ cluster_size: 2097152
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
+
 {"execute": "blockdev-add", "arguments": {"driver": "file", "filename": "T=
EST_DIR/PID-t.vpc", "node-name": "protocol-node"}}
 {"return": {}}
=20
@@ -130,6 +143,7 @@ cluster_size: 2097152
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
=20
+
 image: TEST_IMG
 file format: IMGFMT
 virtual size: 1.99 TiB (2190433320960 bytes)
--=20
2.20.1


