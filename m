Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC3C10DCE
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:28:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E152B20409
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 23:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWq9Tz3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E152B20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGsyB-0002tR-2W
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 19:28:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jGssM-0008Eg-DJ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jGssJ-000241-6O
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58577)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jGssJ-00023l-2W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 19:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585092142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4w0/fn9Bf65eiAsdlwwPSuUGSNq9ByFyxpZuHZOQ27I=;
 b=CWq9Tz3qSXZnTYIn+iVq7L3Fl+dYR3miDGg0ukZ/YhKuzBpEh9qHYq87jEBnMFQUQyIsrD
 cqQl+5W5rfYAjTX2+7hbcw6DKmPB4UhIRVB2iKBRncsTIvEzFdKoFFGUT0pzqdLQDL1hXE
 QC8jq4qujleOUUqhL8JVsivQIeMwqXA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-Sja_MKK3NCaYnZbxCzK2Qw-1; Tue, 24 Mar 2020 19:22:20 -0400
X-MC-Unique: Sja_MKK3NCaYnZbxCzK2Qw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C4D31902EDD;
 Tue, 24 Mar 2020 23:22:00 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 996535D9C5;
 Tue, 24 Mar 2020 23:21:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 11/14] iotests: add script_initialize
Date: Tue, 24 Mar 2020 19:21:00 -0400
Message-Id: <20200324232103.4195-12-jsnow@redhat.com>
In-Reply-To: <20200324232103.4195-1-jsnow@redhat.com>
References: <20200324232103.4195-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org,
 philmd@redhat.com, armbru@redhat.com, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like script_main, but doesn't require a single point of entry.
Replace all existing initialization sections with this drop-in replacement.

This brings debug support to all existing script-style iotests.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/149        |  3 +-
 tests/qemu-iotests/194        |  4 +-
 tests/qemu-iotests/202        |  4 +-
 tests/qemu-iotests/203        |  4 +-
 tests/qemu-iotests/206        |  2 +-
 tests/qemu-iotests/207        |  6 ++-
 tests/qemu-iotests/208        |  2 +-
 tests/qemu-iotests/209        |  2 +-
 tests/qemu-iotests/210        |  6 ++-
 tests/qemu-iotests/211        |  6 ++-
 tests/qemu-iotests/212        |  6 ++-
 tests/qemu-iotests/213        |  6 ++-
 tests/qemu-iotests/216        |  4 +-
 tests/qemu-iotests/218        |  2 +-
 tests/qemu-iotests/219        |  2 +-
 tests/qemu-iotests/222        |  7 ++--
 tests/qemu-iotests/224        |  4 +-
 tests/qemu-iotests/228        |  6 ++-
 tests/qemu-iotests/234        |  4 +-
 tests/qemu-iotests/235        |  4 +-
 tests/qemu-iotests/236        |  2 +-
 tests/qemu-iotests/237        |  2 +-
 tests/qemu-iotests/238        |  2 +
 tests/qemu-iotests/242        |  2 +-
 tests/qemu-iotests/246        |  2 +-
 tests/qemu-iotests/248        |  2 +-
 tests/qemu-iotests/254        |  2 +-
 tests/qemu-iotests/255        |  2 +-
 tests/qemu-iotests/256        |  2 +-
 tests/qemu-iotests/258        |  7 ++--
 tests/qemu-iotests/260        |  4 +-
 tests/qemu-iotests/262        |  4 +-
 tests/qemu-iotests/264        |  4 +-
 tests/qemu-iotests/277        |  2 +
 tests/qemu-iotests/280        |  8 ++--
 tests/qemu-iotests/283        |  4 +-
 tests/qemu-iotests/iotests.py | 75 +++++++++++++++++++++++------------
 37 files changed, 129 insertions(+), 81 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index b4a21bf7b7..852768f80a 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -382,8 +382,7 @@ def test_once(config, qemu_img=3DFalse):
=20
=20
 # Obviously we only work with the luks image format
-iotests.verify_image_format(supported_fmts=3D['luks'])
-iotests.verify_platform()
+iotests.script_initialize(supported_fmts=3D['luks'])
=20
 # We need sudo in order to run cryptsetup to create
 # dm-crypt devices. This is safe to use on any
diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index 9dc1bd3510..8b1f720af4 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -21,8 +21,8 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed', 'raw'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qed', 'raw'],
+                          supported_platforms=3D['linux'])
=20
 with iotests.FilePath('source.img') as source_img_path, \
      iotests.FilePath('dest.img') as dest_img_path, \
diff --git a/tests/qemu-iotests/202 b/tests/qemu-iotests/202
index 920a8683ef..e3900a44d1 100755
--- a/tests/qemu-iotests/202
+++ b/tests/qemu-iotests/202
@@ -24,8 +24,8 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          supported_platforms=3D['linux'])
=20
 with iotests.FilePath('disk0.img') as disk0_img_path, \
      iotests.FilePath('disk1.img') as disk1_img_path, \
diff --git a/tests/qemu-iotests/203 b/tests/qemu-iotests/203
index 49eff5d405..4b4bd3307d 100755
--- a/tests/qemu-iotests/203
+++ b/tests/qemu-iotests/203
@@ -24,8 +24,8 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          supported_platforms=3D['linux'])
=20
 with iotests.FilePath('disk0.img') as disk0_img_path, \
      iotests.FilePath('disk1.img') as disk1_img_path, \
diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index e2b50ae24d..f42432a838 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 with iotests.FilePath('t.qcow2') as disk_path, \
      iotests.FilePath('t.qcow2.base') as backing_path, \
diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index 3d9c1208ca..a6621410da 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -24,8 +24,10 @@ import iotests
 import subprocess
 import re
=20
-iotests.verify_image_format(supported_fmts=3D['raw'])
-iotests.verify_protocol(supported=3D['ssh'])
+iotests.script_initialize(
+    supported_fmts=3D['raw'],
+    supported_protocols=3D['ssh'],
+)
=20
 def filter_hash(qmsg):
     def _filter(key, value):
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 1c3fc8c7fd..6cb642f821 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -22,7 +22,7 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['generic'])
+iotests.script_initialize(supported_fmts=3D['generic'])
=20
 with iotests.FilePath('disk.img') as disk_img_path, \
      iotests.FilePath('disk-snapshot.img') as disk_snapshot_img_path, \
diff --git a/tests/qemu-iotests/209 b/tests/qemu-iotests/209
index 65c1a1e70a..8c804f4a30 100755
--- a/tests/qemu-iotests/209
+++ b/tests/qemu-iotests/209
@@ -22,7 +22,7 @@ import iotests
 from iotests import qemu_img_create, qemu_io, qemu_img_verbose, qemu_nbd, =
\
                     file_path
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 disk =3D file_path('disk')
 nbd_sock =3D file_path('nbd-sock', base_dir=3Diotests.sock_dir)
diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index e49896e23d..7bf591f313 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -23,8 +23,10 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['luks'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(
+    supported_fmts=3D['luks'],
+    supported_protocols=3D['file'],
+)
=20
 with iotests.FilePath('t.luks') as disk_path, \
      iotests.VM() as vm:
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 163994d559..4969edb00c 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -23,8 +23,10 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['vdi'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(
+    supported_fmts=3D['vdi'],
+    supported_protocols=3D['file'],
+)
=20
 def blockdev_create(vm, options):
     error =3D vm.blockdev_create(options)
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index 800f92dd84..45d08842bb 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -23,8 +23,10 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['parallels'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(
+    supported_fmts=3D['parallels'],
+    supported_protocols=3D['file'],
+)
=20
 with iotests.FilePath('t.parallels') as disk_path, \
      iotests.VM() as vm:
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 1eee45276a..cf638eb927 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -23,8 +23,10 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['vhdx'])
-iotests.verify_protocol(supported=3D['file'])
+iotests.script_initialize(
+    supported_fmts=3D['vhdx'],
+    supported_protocols=3D['file'],
+)
=20
 with iotests.FilePath('t.vhdx') as disk_path, \
      iotests.VM() as vm:
diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 372f042d3e..de11d85b5d 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -23,8 +23,8 @@ import iotests
 from iotests import log, qemu_img, qemu_io_silent
=20
 # Need backing file support
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmd=
k'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmdk'=
],
+                          supported_platforms=3D['linux'])
=20
 log('')
 log('=3D=3D=3D Copy-on-read across nodes =3D=3D=3D')
diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
index 1325ba9eaa..5586870456 100755
--- a/tests/qemu-iotests/218
+++ b/tests/qemu-iotests/218
@@ -29,7 +29,7 @@
 import iotests
 from iotests import log, qemu_img, qemu_io_silent
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'raw'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'raw'])
=20
=20
 # Launches the VM, adds two null-co nodes (source and target), and
diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index b8774770c4..db272c5249 100755
--- a/tests/qemu-iotests/219
+++ b/tests/qemu-iotests/219
@@ -21,7 +21,7 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 img_size =3D 4 * 1024 * 1024
=20
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index bf1718e179..6602f6b4ba 100755
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -24,9 +24,10 @@
 import iotests
 from iotests import log, qemu_img, qemu_io, qemu_io_silent
=20
-iotests.verify_platform(['linux'])
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmd=
k',
-                                            'vhdx', 'raw'])
+iotests.script_initialize(
+    supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmdk', 'vhdx', 'raw'],
+    supported_platforms=3D['linux'],
+)
=20
 patterns =3D [("0x5d", "0",         "64k"),
             ("0xd5", "1M",        "64k"),
diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index e91fb26fd8..81ca1e4898 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -26,8 +26,8 @@ from iotests import log, qemu_img, qemu_io_silent, filter=
_qmp_testfiles, \
 import json
=20
 # Need backing file support (for arbitrary backing formats)
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed'],
+                          supported_platforms=3D['linux'])
=20
=20
 # There are two variations of this test:
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 64bc82ee23..da0900fb82 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -25,8 +25,10 @@ from iotests import log, qemu_img, filter_testfiles, fil=
ter_imgfmt, \
         filter_qmp_testfiles, filter_qmp_imgfmt
=20
 # Need backing file and change-backing-file support
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(
+    supported_fmts=3D['qcow2', 'qed'],
+    supported_platforms=3D['linux'],
+)
=20
=20
 def log_node_info(node):
diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index 324c1549fd..73c899ddae 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -23,8 +23,8 @@
 import iotests
 import os
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          supported_platforms=3D['linux'])
=20
 with iotests.FilePath('img') as img_path, \
      iotests.FilePath('backing') as backing_path, \
diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index 760826128e..d1b10ac36b 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -27,6 +27,8 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '=
..', '..', 'python'))
=20
 from qemu.machine import QEMUMachine
=20
+iotests.script_initialize(supported_fmts=3D['qcow2'])
+
 # Note:
 # This test was added to check that mirror dead-lock was fixed (see previo=
us
 # commit before this test addition).
@@ -40,8 +42,6 @@ from qemu.machine import QEMUMachine
=20
 size =3D 1 * 1024 * 1024 * 1024
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-
 disk =3D file_path('disk')
=20
 # prepare source image
diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 8ce927a16c..6f5cee2444 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -22,7 +22,7 @@
 import iotests
 from iotests import log
=20
-iotests.verify_image_format(supported_fmts=3D['generic'])
+iotests.script_initialize(supported_fmts=3D['generic'])
 size =3D 64 * 1024 * 1024
 granularity =3D 64 * 1024
=20
diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index 50ba364a3e..5b21ad3509 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -24,7 +24,7 @@ import math
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['vmdk'])
+iotests.script_initialize(supported_fmts=3D['vmdk'])
=20
 with iotests.FilePath('t.vmdk') as disk_path, \
      iotests.FilePath('t.vmdk.1') as extent1_path, \
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index d4e060228c..b8fcf15a1f 100755
--- a/tests/qemu-iotests/238
+++ b/tests/qemu-iotests/238
@@ -23,6 +23,8 @@ import os
 import iotests
 from iotests import log
=20
+iotests.script_initialize()
+
 virtio_scsi_device =3D iotests.get_virtio_scsi_device()
=20
 vm =3D iotests.VM()
diff --git a/tests/qemu-iotests/242 b/tests/qemu-iotests/242
index 97617876bc..64f1bd95e4 100755
--- a/tests/qemu-iotests/242
+++ b/tests/qemu-iotests/242
@@ -24,7 +24,7 @@ import struct
 from iotests import qemu_img_create, qemu_io, qemu_img_pipe, \
     file_path, img_info_log, log, filter_qemu_io
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 disk =3D file_path('disk')
 chunk =3D 256 * 1024
diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
index 59a216a839..58a479cc1f 100755
--- a/tests/qemu-iotests/246
+++ b/tests/qemu-iotests/246
@@ -22,7 +22,7 @@
 import iotests
 from iotests import log
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
 size =3D 64 * 1024 * 1024 * 1024
 gran_small =3D 32 * 1024
 gran_large =3D 128 * 1024
diff --git a/tests/qemu-iotests/248 b/tests/qemu-iotests/248
index 68c374692e..18ba03467e 100755
--- a/tests/qemu-iotests/248
+++ b/tests/qemu-iotests/248
@@ -21,7 +21,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_io, file_path, filter_qmp_testfi=
les
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 source, target =3D file_path('source', 'target')
 size =3D 5 * 1024 * 1024
diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index ee66c986db..150e58be8e 100755
--- a/tests/qemu-iotests/254
+++ b/tests/qemu-iotests/254
@@ -21,7 +21,7 @@
 import iotests
 from iotests import qemu_img_create, file_path, log
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 disk, top =3D file_path('disk', 'top')
 size =3D 1024 * 1024
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 4a4818bafb..8f08f741da 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 iotests.log('Finishing a commit job with background reads')
 iotests.log('=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D')
diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index e34074c83e..db8d6f31cf 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -23,7 +23,7 @@ import os
 import iotests
 from iotests import log
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
 size =3D 64 * 1024 * 1024
=20
 with iotests.FilePath('img0') as img0_path, \
diff --git a/tests/qemu-iotests/258 b/tests/qemu-iotests/258
index 091755a45c..a65151dda6 100755
--- a/tests/qemu-iotests/258
+++ b/tests/qemu-iotests/258
@@ -24,9 +24,10 @@ from iotests import log, qemu_img, qemu_io_silent, \
         filter_qmp_testfiles, filter_qmp_imgfmt
=20
 # Need backing file and change-backing-file support
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed'])
-iotests.verify_platform(['linux'])
-
+iotests.script_initialize(
+    supported_fmts=3D['qcow2', 'qed'],
+    supported_platforms=3D['linux'],
+)
=20
 # Returns a node for blockdev-add
 def node(node_name, path, backing=3DNone, fmt=3DNone, throttle=3DNone):
diff --git a/tests/qemu-iotests/260 b/tests/qemu-iotests/260
index 30c0de380d..804a7addb9 100755
--- a/tests/qemu-iotests/260
+++ b/tests/qemu-iotests/260
@@ -21,7 +21,9 @@
 import iotests
 from iotests import qemu_img_create, file_path, log, filter_qmp_event
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(
+    supported_fmts=3D['qcow2']
+)
=20
 base, top =3D file_path('base', 'top')
 size =3D 64 * 1024 * 3
diff --git a/tests/qemu-iotests/262 b/tests/qemu-iotests/262
index 8835dce7be..03af061f94 100755
--- a/tests/qemu-iotests/262
+++ b/tests/qemu-iotests/262
@@ -23,8 +23,8 @@
 import iotests
 import os
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'],
+                          supported_platforms=3D['linux'])
=20
 with iotests.FilePath('img') as img_path, \
      iotests.FilePath('mig_fifo') as fifo, \
diff --git a/tests/qemu-iotests/264 b/tests/qemu-iotests/264
index 879123a343..304a7443d7 100755
--- a/tests/qemu-iotests/264
+++ b/tests/qemu-iotests/264
@@ -24,7 +24,9 @@ import iotests
 from iotests import qemu_img_create, qemu_io_silent_check, file_path, \
         qemu_nbd_popen, log
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(
+    supported_fmts=3D['qcow2'],
+)
=20
 disk_a, disk_b, nbd_sock =3D file_path('disk_a', 'disk_b', 'nbd-sock')
 nbd_uri =3D 'nbd+unix:///?socket=3D' + nbd_sock
diff --git a/tests/qemu-iotests/277 b/tests/qemu-iotests/277
index 04aa15a3d5..d34f87021f 100755
--- a/tests/qemu-iotests/277
+++ b/tests/qemu-iotests/277
@@ -23,6 +23,8 @@ import subprocess
 import iotests
 from iotests import file_path, log
=20
+iotests.script_initialize()
+
=20
 nbd_sock, conf_file =3D file_path('nbd-sock', 'nbd-fault-injector.conf')
=20
diff --git a/tests/qemu-iotests/280 b/tests/qemu-iotests/280
index 69288fdd0e..f594bb9ed2 100755
--- a/tests/qemu-iotests/280
+++ b/tests/qemu-iotests/280
@@ -22,9 +22,11 @@
 import iotests
 import os
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_protocol(supported=3D['file'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(
+    supported_fmts=3D['qcow2'],
+    supported_protocols=3D['file'],
+    supported_platforms=3D['linux'],
+)
=20
 with iotests.FilePath('base') as base_path , \
      iotests.FilePath('top') as top_path, \
diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
index 55b7cff953..e17b953333 100644
--- a/tests/qemu-iotests/283
+++ b/tests/qemu-iotests/283
@@ -21,7 +21,9 @@
 import iotests
=20
 # The test is unrelated to formats, restrict it to qcow2 to avoid extra ru=
ns
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(
+    supported_fmts=3D['qcow2'],
+)
=20
 size =3D 1024 * 1024
=20
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 4faee06f14..fbca0f2a40 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -28,7 +28,8 @@
 import struct
 import subprocess
 import sys
-from typing import (Any, Callable, Dict, Iterable, List, Optional, TypeVar=
)
+from typing import (Any, Callable, Collection, Dict,
+                    Iterable, List, Optional, TypeVar)
 import unittest
=20
 # pylint: disable=3Dimport-error, wrong-import-position
@@ -1023,12 +1024,11 @@ def verify_protocol(supported=3D(), unsupported=3D(=
)):
     if not_sup or (imgproto in unsupported):
         notrun('not suitable for this protocol: %s' % imgproto)
=20
-def verify_platform(supported=3DNone, unsupported=3DNone):
-    if unsupported is not None:
-        if any((sys.platform.startswith(x) for x in unsupported)):
-            notrun('not suitable for this OS: %s' % sys.platform)
+def verify_platform(supported=3D(), unsupported=3D()):
+    if any((sys.platform.startswith(x) for x in unsupported)):
+        notrun('not suitable for this OS: %s' % sys.platform)
=20
-    if supported is not None:
+    if supported:
         if not any((sys.platform.startswith(x) for x in supported)):
             notrun('not suitable for this OS: %s' % sys.platform)
=20
@@ -1110,7 +1110,18 @@ def func_wrapper(*args, **kwargs):
             return func(*args, **kwargs)
     return func_wrapper
=20
-def execute_unittest(output, verbosity, debug):
+def execute_unittest(debug=3DFalse):
+    """Executes unittests within the calling module."""
+
+    verbosity =3D 2 if debug else 1
+
+    if debug:
+        output =3D sys.stdout
+    else:
+        # We need to filter out the time taken from the output so that
+        # qemu-iotest can reliably diff the results against master output.
+        output =3D io.StringIO()
+
     runner =3D unittest.TextTestRunner(stream=3Doutput, descriptions=3DTru=
e,
                                      verbosity=3Dverbosity)
     try:
@@ -1118,6 +1129,8 @@ def execute_unittest(output, verbosity, debug):
         # exception
         unittest.main(testRunner=3Drunner)
     finally:
+        # We need to filter out the time taken from the output so that
+        # qemu-iotest can reliably diff the results against master output.
         if not debug:
             out =3D output.getvalue()
             out =3D re.sub(r'Ran (\d+) tests? in [\d.]+s', r'Ran \1 tests'=
, out)
@@ -1129,13 +1142,18 @@ def execute_unittest(output, verbosity, debug):
=20
             sys.stderr.write(out)
=20
-def execute_test(test_function=3DNone,
-                 supported_fmts=3D(),
-                 supported_platforms=3DNone,
-                 supported_cache_modes=3D(), supported_aio_modes=3D(),
-                 unsupported_fmts=3D(), supported_protocols=3D(),
-                 unsupported_protocols=3D()):
-    """Run either unittest or script-style tests."""
+def execute_setup_common(supported_fmts: Collection[str] =3D (),
+                         supported_platforms: Collection[str] =3D (),
+                         supported_cache_modes: Collection[str] =3D (),
+                         supported_aio_modes: Collection[str] =3D (),
+                         unsupported_fmts: Collection[str] =3D (),
+                         supported_protocols: Collection[str] =3D (),
+                         unsupported_protocols: Collection[str] =3D ()) ->=
 bool:
+    """
+    Perform necessary setup for either script-style or unittest-style test=
s.
+
+    :return: Bool; Whether or not debug mode has been requested via the CL=
I.
+    """
=20
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
     # indicate that we're not being run via "check". There may be
@@ -1145,34 +1163,39 @@ def execute_test(test_function=3DNone,
         sys.stderr.write('Please run this test via the "check" script\n')
         sys.exit(os.EX_USAGE)
=20
-    debug =3D '-d' in sys.argv
-    verbosity =3D 1
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_protocol(supported_protocols, unsupported_protocols)
     verify_platform(supported=3Dsupported_platforms)
     verify_cache_mode(supported_cache_modes)
     verify_aio_mode(supported_aio_modes)
=20
+    debug =3D '-d' in sys.argv
     if debug:
-        output =3D sys.stdout
-        verbosity =3D 2
         sys.argv.remove('-d')
-    else:
-        # We need to filter out the time taken from the output so that
-        # qemu-iotest can reliably diff the results against master output.
-        output =3D io.StringIO()
-
     logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WARN)=
)
=20
+    return debug
+
+def execute_test(*args, test_function=3DNone, **kwargs):
+    """Run either unittest or script-style tests."""
+
+    debug =3D execute_setup_common(*args, **kwargs)
     if not test_function:
-        execute_unittest(output, verbosity, debug)
+        execute_unittest(debug)
     else:
         test_function()
=20
+# This is called from script-style iotests without a single point of entry
+def script_initialize(*args, **kwargs):
+    """Initialize script-style tests without running any tests."""
+    execute_setup_common(*args, **kwargs)
+
+# This is called from script-style iotests with a single point of entry
 def script_main(test_function, *args, **kwargs):
     """Run script-style tests outside of the unittest framework"""
-    execute_test(test_function, *args, **kwargs)
+    execute_test(*args, test_function=3Dtest_function, **kwargs)
=20
+# This is called from unittest style iotests
 def main(*args, **kwargs):
     """Run tests using the unittest framework"""
-    execute_test(None, *args, **kwargs)
+    execute_test(*args, **kwargs)
--=20
2.21.1


