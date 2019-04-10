Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3DEC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:26:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B49D21741
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:26:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B49D21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJnR-0003bM-78
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:26:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiX-00073S-BV
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiW-0004UP-1N
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEJiS-0004Qr-Jp; Wed, 10 Apr 2019 16:21:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D225830A223D;
	Wed, 10 Apr 2019 20:21:03 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 359DB5D71E;
	Wed, 10 Apr 2019 20:21:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:20:31 +0200
Message-Id: <20190410202033.28617-10-mreitz@redhat.com>
In-Reply-To: <20190410202033.28617-1-mreitz@redhat.com>
References: <20190410202033.28617-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 10 Apr 2019 20:21:03 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 09/11] iotests: Add filter mirror test cases
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410202031.XR3LRCc2Z-BgyeUhqTAvH9Qsm8-zP1kgL18maIv5bNQ@z>

This patch adds some test cases how mirroring relates to filters.  One
of them tests what happens when you mirror off a filtered COW node, two
others use the mirror filter node as basically our only example of an
implicitly created filter node so far (besides the commit filter).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 146 ++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/041.out |   4 +-
 2 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 0c1432f189..c2b5299f62 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -20,8 +20,9 @@
=20
 import time
 import os
+import json
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_img_pipe, qemu_io
=20
 backing_img =3D os.path.join(iotests.test_dir, 'backing.img')
 target_backing_img =3D os.path.join(iotests.test_dir, 'target-backing.im=
g')
@@ -1191,5 +1192,148 @@ class TestReplaces(iotests.QMPTestCase):
         os.remove(test_img)
         os.remove(target_img)
=20
+# Tests for mirror with filters (and how the mirror filter behaves, as
+# an example for an implicit filter)
+class TestFilters(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', backing_img, test=
_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', backing_img, targ=
et_img)
+
+        qemu_io('-c', 'write -P 1 0 512k', backing_img)
+        qemu_io('-c', 'write -P 2 512k 512k', test_img)
+
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+        result =3D self.vm.qmp('blockdev-add', **{
+                                'node-name': 'target',
+                                'driver': iotests.imgfmt,
+                                'file': {
+                                    'driver': 'file',
+                                    'filename': target_img
+                                },
+                                'backing': None
+                            })
+        self.assert_qmp(result, 'return', {})
+
+        self.filterless_chain =3D {
+                'node-name': 'source',
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': test_img
+                },
+                'backing': {
+                    'node-name': 'backing',
+                    'driver': iotests.imgfmt,
+                    'file': {
+                        'driver': 'file',
+                        'filename': backing_img
+                    }
+                }
+            }
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+        os.remove(test_img)
+        os.remove(target_img)
+        os.remove(backing_img)
+
+    def test_cor(self):
+        result =3D self.vm.qmp('blockdev-add', **{
+                                'node-name': 'filter',
+                                'driver': 'copy-on-read',
+                                'file': self.filterless_chain
+                            })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-mirror',
+                             job_id=3D'mirror',
+                             device=3D'filter',
+                             target=3D'target',
+                             sync=3D'top')
+        self.assert_qmp(result, 'return', {})
+
+        self.complete_and_wait('mirror')
+
+        self.vm.qmp('blockdev-del', node_name=3D'target')
+
+        target_map =3D qemu_img_pipe('map', '--output=3Djson', target_im=
g)
+        target_map =3D json.loads(target_map)
+
+        assert target_map[0]['start'] =3D=3D 0
+        assert target_map[0]['length'] =3D=3D 512 * 1024
+        assert target_map[0]['depth'] =3D=3D 1
+
+        assert target_map[1]['start'] =3D=3D 512 * 1024
+        assert target_map[1]['length'] =3D=3D 512 * 1024
+        assert target_map[1]['depth'] =3D=3D 0
+
+    def test_implicit_mirror_filter(self):
+        result =3D self.vm.qmp('blockdev-add', **self.filterless_chain)
+        self.assert_qmp(result, 'return', {})
+
+        # We need this so we can query from above the mirror node
+        result =3D self.vm.qmp('device_add',
+                             driver=3D'virtio-blk',
+                             id=3D'virtio',
+                             bus=3D'pci.0',
+                             drive=3D'source')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-mirror',
+                             job_id=3D'mirror',
+                             device=3D'source',
+                             target=3D'target',
+                             sync=3D'top')
+        self.assert_qmp(result, 'return', {})
+
+        # The mirror filter is now an implicit node, so it should be
+        # invisible when querying the backing chain
+        device_info =3D self.vm.qmp('query-block')['return'][0]
+        assert device_info['qdev'] =3D=3D '/machine/peripheral/virtio/vi=
rtio-backend'
+
+        assert device_info['inserted']['node-name'] =3D=3D 'source'
+
+        image_info =3D device_info['inserted']['image']
+        assert image_info['filename'] =3D=3D test_img
+        assert image_info['backing-image']['filename'] =3D=3D backing_im=
g
+
+        self.complete_and_wait('mirror')
+
+    def test_explicit_mirror_filter(self):
+        # Same test as above, but this time we give the mirror filter
+        # a node-name so it will not be invisible
+        result =3D self.vm.qmp('blockdev-add', **self.filterless_chain)
+        self.assert_qmp(result, 'return', {})
+
+        # We need this so we can query from above the mirror node
+        result =3D self.vm.qmp('device_add',
+                             driver=3D'virtio-blk',
+                             id=3D'virtio',
+                             bus=3D'pci.0',
+                             drive=3D'source')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-mirror',
+                             job_id=3D'mirror',
+                             device=3D'source',
+                             target=3D'target',
+                             sync=3D'top',
+                             filter_node_name=3D'mirror-filter')
+        self.assert_qmp(result, 'return', {})
+
+        # With a node-name given to it, the mirror filter should now
+        # be visible
+        device_info =3D self.vm.qmp('query-block')['return'][0]
+        assert device_info['qdev'] =3D=3D '/machine/peripheral/virtio/vi=
rtio-backend'
+
+        assert device_info['inserted']['node-name'] =3D=3D 'mirror-filte=
r'
+
+        self.complete_and_wait('mirror')
+
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 2c448b4239..ffc779b4d1 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-........................................................................=
..................
+........................................................................=
.....................
 ----------------------------------------------------------------------
-Ran 90 tests
+Ran 93 tests
=20
 OK
--=20
2.20.1


