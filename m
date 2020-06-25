Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6989520775
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLdef352"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6989520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joU8o-0002zR-Kd
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjV-0007AS-GX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:24:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45016
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjT-0001dB-3C
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:24:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZqU6OKIKVuM7S4OBfB9tkserSvEzSWHObc2msGEIOk=;
 b=hLdef352H/o8uco1Y1xDjfN3+PhLQF1G/948fL+szGLJ1HtQTSKILiC08ubVUdnlWd4Fkc
 xw39irwNs1vurMH9Q5FdeOJPXcEYYORBlGEKXgxztEkWd6PLkiJmYmv2b1ScIduVOBnH3J
 3DMevNEeam+c+r3tmUyfCYKvWwpHPP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-7BuHWV-yPXW6j2DiMuUV5g-1; Thu, 25 Jun 2020 11:23:59 -0400
X-MC-Unique: 7BuHWV-yPXW6j2DiMuUV5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F236464;
 Thu, 25 Jun 2020 15:23:58 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0E02B612BA;
 Thu, 25 Jun 2020 15:23:57 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 45/47] iotests: Add filter mirror test cases
Date: Thu, 25 Jun 2020 17:22:13 +0200
Message-Id: <20200625152215.941773-46-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index b843f88a66..588bb76626 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -21,8 +21,9 @@
 import time
 import os
 import re
+import json
 import iotests
-from iotests import qemu_img, qemu_io
+from iotests import qemu_img, qemu_img_pipe, qemu_io
 
 backing_img = os.path.join(iotests.test_dir, 'backing.img')
 target_backing_img = os.path.join(iotests.test_dir, 'target-backing.img')
@@ -1275,6 +1276,149 @@ class TestReplaces(iotests.QMPTestCase):
 
         self.vm.assert_block_path('filter0', '/file', 'target')
 
+# Tests for mirror with filters (and how the mirror filter behaves, as
+# an example for an implicit filter)
+class TestFilters(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', backing_img, test_img)
+        qemu_img('create', '-f', iotests.imgfmt, '-b', backing_img, target_img)
+
+        qemu_io('-c', 'write -P 1 0 512k', backing_img)
+        qemu_io('-c', 'write -P 2 512k 512k', test_img)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        result = self.vm.qmp('blockdev-add', **{
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
+        self.filterless_chain = {
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
+        result = self.vm.qmp('blockdev-add', **{
+                                'node-name': 'filter',
+                                'driver': 'copy-on-read',
+                                'file': self.filterless_chain
+                            })
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             device='filter',
+                             target='target',
+                             sync='top')
+        self.assert_qmp(result, 'return', {})
+
+        self.complete_and_wait('mirror')
+
+        self.vm.qmp('blockdev-del', node_name='target')
+
+        target_map = qemu_img_pipe('map', '--output=json', target_img)
+        target_map = json.loads(target_map)
+
+        assert target_map[0]['start'] == 0
+        assert target_map[0]['length'] == 512 * 1024
+        assert target_map[0]['depth'] == 1
+
+        assert target_map[1]['start'] == 512 * 1024
+        assert target_map[1]['length'] == 512 * 1024
+        assert target_map[1]['depth'] == 0
+
+    def test_implicit_mirror_filter(self):
+        result = self.vm.qmp('blockdev-add', **self.filterless_chain)
+        self.assert_qmp(result, 'return', {})
+
+        # We need this so we can query from above the mirror node
+        result = self.vm.qmp('device_add',
+                             driver='virtio-blk',
+                             id='virtio',
+                             bus='pci.0',
+                             drive='source')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             device='source',
+                             target='target',
+                             sync='top')
+        self.assert_qmp(result, 'return', {})
+
+        # The mirror filter is now an implicit node, so it should be
+        # invisible when querying the backing chain
+        device_info = self.vm.qmp('query-block')['return'][0]
+        assert device_info['qdev'] == '/machine/peripheral/virtio/virtio-backend'
+
+        assert device_info['inserted']['node-name'] == 'source'
+
+        image_info = device_info['inserted']['image']
+        assert image_info['filename'] == test_img
+        assert image_info['backing-image']['filename'] == backing_img
+
+        self.complete_and_wait('mirror')
+
+    def test_explicit_mirror_filter(self):
+        # Same test as above, but this time we give the mirror filter
+        # a node-name so it will not be invisible
+        result = self.vm.qmp('blockdev-add', **self.filterless_chain)
+        self.assert_qmp(result, 'return', {})
+
+        # We need this so we can query from above the mirror node
+        result = self.vm.qmp('device_add',
+                             driver='virtio-blk',
+                             id='virtio',
+                             bus='pci.0',
+                             drive='source')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('blockdev-mirror',
+                             job_id='mirror',
+                             device='source',
+                             target='target',
+                             sync='top',
+                             filter_node_name='mirror-filter')
+        self.assert_qmp(result, 'return', {})
+
+        # With a node-name given to it, the mirror filter should now
+        # be visible
+        device_info = self.vm.qmp('query-block')['return'][0]
+        assert device_info['qdev'] == '/machine/peripheral/virtio/virtio-backend'
+
+        assert device_info['inserted']['node-name'] == 'mirror-filter'
+
+        self.complete_and_wait('mirror')
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'],
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 53abe11d73..46651953e8 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-........................................................................................................
+...........................................................................................................
 ----------------------------------------------------------------------
-Ran 104 tests
+Ran 107 tests
 
 OK
-- 
2.26.2


