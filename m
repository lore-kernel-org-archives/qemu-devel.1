Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8AFC433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C325206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 15:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C325206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htCs3-0006hn-SC
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 11:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36083)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1htCqC-0005BT-T2
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1htCqB-0000k4-3C
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 11:18:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1htCq7-0000i7-5w; Thu, 01 Aug 2019 11:17:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C1853002F44;
 Thu,  1 Aug 2019 15:17:58 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-117-98.ams2.redhat.com
 [10.36.117.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7DA062675;
 Thu,  1 Aug 2019 15:17:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu,  1 Aug 2019 17:17:43 +0200
Message-Id: <20190801151744.798-3-kwolf@redhat.com>
In-Reply-To: <20190801151744.798-1-kwolf@redhat.com>
References: <20190801151744.798-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 01 Aug 2019 15:17:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/3] iotests: Enable -d for Python non-unittest
 tests
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

The part of iotests.main() that is related to the implementation of the
debug option -d and enables QEMU and QMP logging is not only useful in
tests that use the Python unittest framework, but also in tests that
work by comparing with a reference output.

Factor these parts out into iotests.init() and call it from the test
cases that currently lack support for debug output.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/194        |  1 +
 tests/qemu-iotests/202        |  1 +
 tests/qemu-iotests/203        |  2 ++
 tests/qemu-iotests/206        |  1 +
 tests/qemu-iotests/207        |  1 +
 tests/qemu-iotests/208        |  1 +
 tests/qemu-iotests/210        |  1 +
 tests/qemu-iotests/211        |  1 +
 tests/qemu-iotests/212        |  1 +
 tests/qemu-iotests/213        |  1 +
 tests/qemu-iotests/216        |  2 ++
 tests/qemu-iotests/218        |  1 +
 tests/qemu-iotests/219        |  1 +
 tests/qemu-iotests/222        |  1 +
 tests/qemu-iotests/224        |  2 ++
 tests/qemu-iotests/228        |  2 ++
 tests/qemu-iotests/234        |  2 ++
 tests/qemu-iotests/236        |  1 +
 tests/qemu-iotests/237        |  1 +
 tests/qemu-iotests/246        |  1 +
 tests/qemu-iotests/255        |  1 +
 tests/qemu-iotests/256        |  1 +
 tests/qemu-iotests/iotests.py | 23 +++++++++++++++--------
 23 files changed, 42 insertions(+), 8 deletions(-)

diff --git a/tests/qemu-iotests/194 b/tests/qemu-iotests/194
index d746ab1e21..cd6928fbd9 100755
--- a/tests/qemu-iotests/194
+++ b/tests/qemu-iotests/194
@@ -21,6 +21,7 @@
=20
 import iotests
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed', 'raw'])
 iotests.verify_platform(['linux'])
=20
diff --git a/tests/qemu-iotests/202 b/tests/qemu-iotests/202
index 581ca34d79..86a3b94586 100755
--- a/tests/qemu-iotests/202
+++ b/tests/qemu-iotests/202
@@ -24,6 +24,7 @@
=20
 import iotests
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
 iotests.verify_platform(['linux'])
=20
diff --git a/tests/qemu-iotests/203 b/tests/qemu-iotests/203
index 4874a1a0d8..fe25c249fb 100755
--- a/tests/qemu-iotests/203
+++ b/tests/qemu-iotests/203
@@ -27,6 +27,8 @@ import iotests
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
 iotests.verify_platform(['linux'])
=20
+iotests.init()
+
 with iotests.FilePath('disk0.img') as disk0_img_path, \
      iotests.FilePath('disk1.img') as disk1_img_path, \
      iotests.VM() as vm:
diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 5bb738bf23..481e4b98ea 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -23,6 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
=20
 def blockdev_create(vm, options):
diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
index ec8c1d06f0..57c1e900d2 100755
--- a/tests/qemu-iotests/207
+++ b/tests/qemu-iotests/207
@@ -24,6 +24,7 @@ import iotests
 import subprocess
 import re
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['raw'])
 iotests.verify_protocol(supported=3D['ssh'])
=20
diff --git a/tests/qemu-iotests/208 b/tests/qemu-iotests/208
index 1e202388dc..3b2c732cd4 100755
--- a/tests/qemu-iotests/208
+++ b/tests/qemu-iotests/208
@@ -22,6 +22,7 @@
=20
 import iotests
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['generic'])
=20
 with iotests.FilePath('disk.img') as disk_img_path, \
diff --git a/tests/qemu-iotests/210 b/tests/qemu-iotests/210
index 565e3b7b9b..a90db1c067 100755
--- a/tests/qemu-iotests/210
+++ b/tests/qemu-iotests/210
@@ -23,6 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['luks'])
 iotests.verify_protocol(supported=3D['file'])
=20
diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 6afc894f76..e6a0bef332 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -23,6 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['vdi'])
 iotests.verify_protocol(supported=3D['file'])
=20
diff --git a/tests/qemu-iotests/212 b/tests/qemu-iotests/212
index 42b74f208b..865674191c 100755
--- a/tests/qemu-iotests/212
+++ b/tests/qemu-iotests/212
@@ -23,6 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['parallels'])
 iotests.verify_protocol(supported=3D['file'])
=20
diff --git a/tests/qemu-iotests/213 b/tests/qemu-iotests/213
index 5604f3cebb..8fb94147ff 100755
--- a/tests/qemu-iotests/213
+++ b/tests/qemu-iotests/213
@@ -23,6 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['vhdx'])
 iotests.verify_protocol(supported=3D['file'])
=20
diff --git a/tests/qemu-iotests/216 b/tests/qemu-iotests/216
index 3c0ae54b44..adcb487fb4 100755
--- a/tests/qemu-iotests/216
+++ b/tests/qemu-iotests/216
@@ -22,6 +22,8 @@
 import iotests
 from iotests import log, qemu_img, qemu_io_silent
=20
+iotests.init()
+
 # Need backing file support
 iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed', 'v=
mdk'])
 iotests.verify_platform(['linux'])
diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
index 2554d84581..18639020ee 100755
--- a/tests/qemu-iotests/218
+++ b/tests/qemu-iotests/218
@@ -29,6 +29,7 @@
 import iotests
 from iotests import log, qemu_img, qemu_io_silent
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2', 'raw'])
=20
=20
diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
index e0c51662c0..c7265d12c5 100755
--- a/tests/qemu-iotests/219
+++ b/tests/qemu-iotests/219
@@ -21,6 +21,7 @@
=20
 import iotests
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
=20
 img_size =3D 4 * 1024 * 1024
diff --git a/tests/qemu-iotests/222 b/tests/qemu-iotests/222
index 0ead56d574..bb2b8cc78a 100644
--- a/tests/qemu-iotests/222
+++ b/tests/qemu-iotests/222
@@ -24,6 +24,7 @@
 import iotests
 from iotests import log, qemu_img, qemu_io, qemu_io_silent
=20
+iotests.init()
 iotests.verify_platform(['linux'])
 iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed', 'v=
mdk',
                                             'vhdx', 'raw'])
diff --git a/tests/qemu-iotests/224 b/tests/qemu-iotests/224
index b4dfaa639f..00013473a8 100755
--- a/tests/qemu-iotests/224
+++ b/tests/qemu-iotests/224
@@ -25,6 +25,8 @@ from iotests import log, qemu_img, qemu_io_silent, filt=
er_qmp_testfiles, \
                     filter_qmp_imgfmt
 import json
=20
+iotests.init()
+
 # Need backing file support (for arbitrary backing formats)
 iotests.verify_image_format(supported_fmts=3D['qcow2', 'qcow', 'qed'])
 iotests.verify_platform(['linux'])
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 9a50afd205..9b9acf8be5 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -24,6 +24,8 @@ import iotests
 from iotests import log, qemu_img, filter_testfiles, filter_imgfmt, \
         filter_qmp_testfiles, filter_qmp_imgfmt
=20
+iotests.init()
+
 # Need backing file and change-backing-file support
 iotests.verify_image_format(supported_fmts=3D['qcow2', 'qed'])
 iotests.verify_platform(['linux'])
diff --git a/tests/qemu-iotests/234 b/tests/qemu-iotests/234
index 34c818c485..17c03d2f6a 100755
--- a/tests/qemu-iotests/234
+++ b/tests/qemu-iotests/234
@@ -26,6 +26,8 @@ import os
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
 iotests.verify_platform(['linux'])
=20
+iotests.init()
+
 with iotests.FilePath('img') as img_path, \
      iotests.FilePath('backing') as backing_path, \
      iotests.FilePath('mig_fifo_a') as fifo_a, \
diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
index 79a6381f8e..15ef48f0b6 100755
--- a/tests/qemu-iotests/236
+++ b/tests/qemu-iotests/236
@@ -22,6 +22,7 @@
 import iotests
 from iotests import log
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['generic'])
 size =3D 64 * 1024 * 1024
 granularity =3D 64 * 1024
diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
index 06897f8c87..cbaaeed9eb 100755
--- a/tests/qemu-iotests/237
+++ b/tests/qemu-iotests/237
@@ -24,6 +24,7 @@ import math
 import iotests
 from iotests import imgfmt
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['vmdk'])
=20
 def blockdev_create(vm, options):
diff --git a/tests/qemu-iotests/246 b/tests/qemu-iotests/246
index b0997a392f..7f6da5dced 100755
--- a/tests/qemu-iotests/246
+++ b/tests/qemu-iotests/246
@@ -22,6 +22,7 @@
 import iotests
 from iotests import log
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
 size =3D 64 * 1024 * 1024 * 1024
 gran_small =3D 32 * 1024
diff --git a/tests/qemu-iotests/255 b/tests/qemu-iotests/255
index 3632d507d0..099617ab59 100755
--- a/tests/qemu-iotests/255
+++ b/tests/qemu-iotests/255
@@ -23,6 +23,7 @@
 import iotests
 from iotests import imgfmt
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
=20
 def blockdev_create(vm, options):
diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index c594a43205..e15f1b1a8a 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -23,6 +23,7 @@ import os
 import iotests
 from iotests import log
=20
+iotests.init()
 iotests.verify_image_format(supported_fmts=3D['qcow2'])
 size =3D 64 * 1024 * 1024
=20
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 91172c39a5..f2ad2b9749 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -858,10 +858,7 @@ def skip_if_unsupported(required_formats=3D[], read_=
only=3DFalse):
         return func_wrapper
     return skip_test_decorator
=20
-def main(supported_fmts=3D[], supported_oses=3D['linux'], supported_cach=
e_modes=3D[],
-         unsupported_fmts=3D[]):
-    '''Run tests'''
-
+def init():
     global debug
=20
     # We are using TEST_DIR and QEMU_DEFAULT_MACHINE as proxies to
@@ -873,7 +870,19 @@ def main(supported_fmts=3D[], supported_oses=3D['lin=
ux'], supported_cache_modes=3D[],
         sys.exit(os.EX_USAGE)
=20
     debug =3D '-d' in sys.argv
-    verbosity =3D 1
+    if debug:
+        sys.argv.remove('-d')
+
+    logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WAR=
N))
+
+def main(supported_fmts=3D[], supported_oses=3D['linux'], supported_cach=
e_modes=3D[],
+         unsupported_fmts=3D[]):
+    '''Run tests'''
+
+    global debug
+
+    init()
+
     verify_image_format(supported_fmts, unsupported_fmts)
     verify_platform(supported_oses)
     verify_cache_mode(supported_cache_modes)
@@ -881,8 +890,8 @@ def main(supported_fmts=3D[], supported_oses=3D['linu=
x'], supported_cache_modes=3D[],
     if debug:
         output =3D sys.stdout
         verbosity =3D 2
-        sys.argv.remove('-d')
     else:
+        verbosity =3D 1
         # We need to filter out the time taken from the output so that
         # qemu-iotest can reliably diff the results against master outpu=
t.
         if sys.version_info.major >=3D 3:
@@ -892,8 +901,6 @@ def main(supported_fmts=3D[], supported_oses=3D['linu=
x'], supported_cache_modes=3D[],
             # 2.x's test runner emits.
             output =3D io.BytesIO()
=20
-    logging.basicConfig(level=3D(logging.DEBUG if debug else logging.WAR=
N))
-
     class MyTestRunner(unittest.TextTestRunner):
         def __init__(self, stream=3Doutput, descriptions=3DTrue, verbosi=
ty=3Dverbosity):
             unittest.TextTestRunner.__init__(self, stream, descriptions,=
 verbosity)
--=20
2.20.1


