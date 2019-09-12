Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8645EC5ACAE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E12020872
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E12020872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Cov-0004v7-0B
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 20:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i8Cn0-0002ld-O5
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i8Cmx-0006Ir-Ux
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49456)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i8Cms-0006Fz-6H; Wed, 11 Sep 2019 20:16:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 858B510576C6;
 Thu, 12 Sep 2019 00:16:37 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-203.bos.redhat.com [10.18.17.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D14DA5D6A5;
 Thu, 12 Sep 2019 00:16:36 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 11 Sep 2019 20:16:30 -0400
Message-Id: <20190912001633.11372-2-jsnow@redhat.com>
In-Reply-To: <20190912001633.11372-1-jsnow@redhat.com>
References: <20190912001633.11372-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Thu, 12 Sep 2019 00:16:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 1/4] iotests: add script_initialize
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Like script_main, but doesn't require a single point of entry.
Replace all existing initialization sections with this drop-in replacemen=
t.

This brings debug support to all existing script-style iotests.

Note: supported_oses=3D['linux'] was omitted, as it is a default argument=
.
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/149        |  3 +-
 tests/qemu-iotests/194        |  3 +-
 tests/qemu-iotests/202        |  3 +-
 tests/qemu-iotests/203        |  3 +-
 tests/qemu-iotests/206        |  2 +-
 tests/qemu-iotests/207        |  2 +-
 tests/qemu-iotests/208        |  2 +-
 tests/qemu-iotests/209        |  2 +-
 tests/qemu-iotests/210        |  2 +-
 tests/qemu-iotests/211        |  2 +-
 tests/qemu-iotests/212        |  2 +-
 tests/qemu-iotests/213        |  2 +-
 tests/qemu-iotests/216        |  3 +-
 tests/qemu-iotests/218        |  2 +-
 tests/qemu-iotests/219        |  2 +-
 tests/qemu-iotests/222        |  5 ++-
 tests/qemu-iotests/224        |  3 +-
 tests/qemu-iotests/228        |  3 +-
 tests/qemu-iotests/234        |  3 +-
 tests/qemu-iotests/235        |  4 +--
 tests/qemu-iotests/236        |  2 +-
 tests/qemu-iotests/237        |  2 +-
 tests/qemu-iotests/238        |  2 ++
 tests/qemu-iotests/242        |  2 +-
 tests/qemu-iotests/246        |  2 +-
 tests/qemu-iotests/248        |  2 +-
 tests/qemu-iotests/254        |  2 +-
 tests/qemu-iotests/255        |  2 +-
 tests/qemu-iotests/256        |  2 +-
 tests/qemu-iotests/262        |  3 +-
 tests/qemu-iotests/iotests.py | 61 +++++++++++++++++++++++------------
 31 files changed, 73 insertions(+), 62 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 4f363f295f..9fa97966c5 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -383,8 +383,7 @@ def test_once(config, qemu_img=3DFalse):
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
index d746ab1e21..c8aeb6d0e4 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -21,8 +21,7 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed', 'raw'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qed', 'raw'])
=20
 with iotests.FilePath('source.img') as source_img_path, \
      iotests.FilePath('dest.img') as dest_img_path, \
diff --git a/tests/qemu-iotests/202 b/tests/qemu-iotests/202
index 581ca34d79..1271ac9459 100755
--- a/tests/qemu-iotests/202
+++ b/tests/qemu-iotests/202
@@ -24,8 +24,7 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 with iotests.FilePath('disk0.img') as disk0_img_path, \
      iotests.FilePath('disk1.img') as disk1_img_path, \
diff --git a/tests/qemu-iotests/203 b/tests/qemu-iotests/203
index 4874a1a0d8..c40fe231ea 100755
--- a/tests/qemu-iotests/203
+++ b/tests/qemu-iotests/203
@@ -24,8 +24,7 @@
=20
 import iotests
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 with iotests.FilePath('disk0.img') as disk0_img_path, \
      iotests.FilePath('disk1.img') as disk1_img_path, \
diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 5bb738bf23..23ff2f624b 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create',
diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index ec8c1d06f0..ab9e3b6747 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -24,7 +24,7 @@ import iotests
 import subprocess
 import re
=20
-iotests.verify_image_format(supported_fmts=3D['raw'])
+iotests.script_initialize(supported_fmts=3D['raw'])
 iotests.verify_protocol(supported=3D['ssh'])
=20
 def filter_hash(qmsg):
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 1e202388dc..dfce6f9fe4 100755
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
index 259e991ec6..a77f884166 100755
--- a/tests/qemu-iotests/209
+++ b/tests/qemu-iotests/209
@@ -22,7 +22,7 @@ import iotests
 from iotests import qemu_img_create, qemu_io, qemu_img_verbose, qemu_nbd=
, \
                     file_path
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 disk, nbd_sock =3D file_path('disk', 'nbd-sock')
 nbd_uri =3D 'nbd+unix:///exp?socket=3D' + nbd_sock
diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index 565e3b7b9b..5a7013cd34 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['luks'])
+iotests.script_initialize(supported_fmts=3D['luks'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 6afc894f76..4d6aac497f 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['vdi'])
+iotests.script_initialize(supported_fmts=3D['vdi'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index 42b74f208b..ec35bceb11 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['parallels'])
+iotests.script_initialize(supported_fmts=3D['parallels'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 5604f3cebb..3d2c024375 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['vhdx'])
+iotests.script_initialize(supported_fmts=3D['vhdx'])
 iotests.verify_protocol(supported=3D['file'])
=20
 def blockdev_create(vm, options):
diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 3c0ae54b44..7574bcc09f 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -23,8 +23,7 @@ import iotests
 from iotests import log, qemu_img, qemu_io_silent
=20
 # Need backing file support
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed', 'v=
mdk'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmd=
k'])
=20
 log('')
 log('=3D=3D=3D Copy-on-read across nodes =3D=3D=3D')
diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
index 2554d84581..e18e31076b 100755
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
index e0c51662c0..9ae27cb04e 100755
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
index 0ead56d574..6788979ed3 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -24,9 +24,8 @@
 import iotests
 from iotests import log, qemu_img, qemu_io, qemu_io_silent
=20
-iotests.verify_platform(['linux'])
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed', 'v=
mdk',
-                                            'vhdx', 'raw'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed', 'vmd=
k',
+                                          'vhdx', 'raw'])
=20
 patterns =3D [("0x5d", "0",         "64k"),
             ("0xd5", "1M",        "64k"),
diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index b4dfaa639f..d0d0c44104 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -26,8 +26,7 @@ from iotests import log, qemu_img, qemu_io_silent, filt=
er_qmp_testfiles, \
 import json
=20
 # Need backing file support (for arbitrary backing formats)
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qcow', 'qed'])
=20
=20
 # There are two variations of this test:
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 9a50afd205..9785868ab3 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -25,8 +25,7 @@ from iotests import log, qemu_img, filter_testfiles, fi=
lter_imgfmt, \
         filter_qmp_testfiles, filter_qmp_imgfmt
=20
 # Need backing file and change-backing-file support
-iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2', 'qed'])
=20
=20
 def log_node_info(node):
diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index 34c818c485..3de6ab2341 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -23,8 +23,7 @@
 import iotests
 import os
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 with iotests.FilePath('img') as img_path, \
      iotests.FilePath('backing') as backing_path, \
diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
index fedd111fd4..9e88c65b93 100755
--- a/tests/qemu-iotests/235
+++ b/tests/qemu-iotests/235
@@ -27,6 +27,8 @@ sys.path.append(os.path.join(os.path.dirname(__file__),=
 '..', '..', 'python'))
=20
 from qemu.machine import QEMUMachine
=20
+iotests.script_initialize(supported_fmts=3D['qcow2'])
+
 # Note:
 # This test was added to check that mirror dead-lock was fixed (see prev=
ious
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
index 79a6381f8e..b88779eb0b 100755
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
index 06897f8c87..3758ace0bc 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -24,7 +24,7 @@ import math
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['vmdk'])
+iotests.script_initialize(supported_fmts=3D['vmdk'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options,
diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
index e5ac2b2ff8..6e27fb40c2 100755
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
index c176e92da6..7c2685b4cc 100755
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
index b0997a392f..1d7747d62d 100755
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
index f26b4bb2aa..781b21b227 100755
--- a/tests/qemu-iotests/248
+++ b/tests/qemu-iotests/248
@@ -21,7 +21,7 @@
 import iotests
 from iotests import qemu_img_create, qemu_io, file_path, filter_qmp_test=
files
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 source, target =3D file_path('source', 'target')
 size =3D 5 * 1024 * 1024
diff --git a/tests/qemu-iotests/254 b/tests/qemu-iotests/254
index 09584f3f7d..43b40f4f71 100755
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
index 3632d507d0..ff16402268 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -23,7 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 def blockdev_create(vm, options):
     result =3D vm.qmp_log('blockdev-create',
diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index c594a43205..d2f9212e5a 100755
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
diff --git a/tests/qemu-iotests/262 b/tests/qemu-iotests/262
index 398f63587e..f0e9d0f8ac 100755
--- a/tests/qemu-iotests/262
+++ b/tests/qemu-iotests/262
@@ -23,8 +23,7 @@
 import iotests
 import os
=20
-iotests.verify_image_format(supported_fmts=3D['qcow2'])
-iotests.verify_platform(['linux'])
+iotests.script_initialize(supported_fmts=3D['qcow2'])
=20
 with iotests.FilePath('img') as img_path, \
      iotests.FilePath('mig_fifo') as fifo, \
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index b26271187c..92117a64bc 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -895,7 +895,20 @@ def skip_if_unsupported(required_formats=3D[], read_=
only=3DFalse):
         return func_wrapper
     return skip_test_decorator
=20
-def execute_unittest(output, verbosity, debug):
+def execute_unittest(debug=3DFalse):
+    """Executes unittests within the calling module."""
+
+    verbosity =3D 2 if debug else 1
+
+    if debug:
+        output =3D sys.stdout
+    elif sys.version_info.major >=3D 3:
+        output =3D io.StringIO()
+    else:
+        # io.StringIO is for unicode strings, which is not what
+        # 2.x's test runner emits.
+        output =3D io.BytesIO()
+
     runner =3D unittest.TextTestRunner(stream=3Doutput, descriptions=3DT=
rue,
                                      verbosity=3Dverbosity)
     try:
@@ -903,15 +916,21 @@ def execute_unittest(output, verbosity, debug):
         # exception
         unittest.main(testRunner=3Drunner)
     finally:
+        # We need to filter out the time taken from the output so that
+        # qemu-iotest can reliably diff the results against master outpu=
t.
         if not debug:
             sys.stderr.write(re.sub(r'Ran (\d+) tests? in [\d.]+s',
                                     r'Ran \1 tests', output.getvalue()))
=20
-def execute_test(test_function=3DNone,
-                 supported_fmts=3D[], supported_oses=3D['linux'],
-                 supported_cache_modes=3D[], unsupported_fmts=3D[],
-                 supported_protocols=3D[], unsupported_protocols=3D[]):
-    """Run either unittest or script-style tests."""
+def execute_setup_common(supported_fmts=3D[],
+                         supported_oses=3D['linux'],
+                         supported_cache_modes=3D[],
+                         unsupported_fmts=3D[],
+                         supported_protocols=3D[],
+                         unsupported_protocols=3D[]):
+    """
+    Perform necessary setup for either script-style or unittest-style te=
sts.
+    """
=20
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
     # indicate that we're not being run via "check". There may be
@@ -921,38 +940,38 @@ def execute_test(test_function=3DNone,
         sys.stderr.write('Please run this test via the "check" script\n'=
)
         sys.exit(os.EX_USAGE)
=20
-    debug =3D '-d' in sys.argv
-    verbosity =3D 1
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_protocol(supported_protocols, unsupported_protocols)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
=20
+    debug =3D '-d' in sys.argv
     if debug:
-        output =3D sys.stdout
-        verbosity =3D 2
         sys.argv.remove('-d')
-    else:
-        # We need to filter out the time taken from the output so that
-        # qemu-iotest can reliably diff the results against master outpu=
t.
-        if sys.version_info.major >=3D 3:
-            output =3D io.StringIO()
-        else:
-            # io.StringIO is for unicode strings, which is not what
-            # 2.x's test runner emits.
-            output =3D io.BytesIO()
-
     logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WAR=
N))
=20
+    return debug
+
+def execute_test(test_function=3DNone, *args, **kwargs):
+    """Run either unittest or script-style tests."""
+
+    debug =3D execute_setup_common(*args, **kwargs)
     if not test_function:
-        execute_unittest(output, verbosity, debug)
+        execute_unittest(debug)
     else:
         test_function()
=20
+# This is called from script-style iotests without a single point of ent=
ry
+def script_initialize(*args, **kwargs):
+    """Initialize script-style tests without running any tests."""
+    execute_setup_common(*args, **kwargs)
+
+# This is called from script-style iotests with a single point of entry
 def script_main(test_function, *args, **kwargs):
     """Run script-style tests outside of the unittest framework"""
     execute_test(test_function, *args, **kwargs)
=20
+# This is called from unittest style iotests
 def main(*args, **kwargs):
     """Run tests using the unittest framework"""
     execute_test(None, *args, **kwargs)
--=20
2.21.0


