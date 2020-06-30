Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126B0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEBB7206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aISBfk95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEBB7206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBvK-0004jo-0i
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBu9-0003PE-CG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:46:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50707
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqBu6-0008Th-84
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 04:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593506769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lGhfgMGqmBZCrMdRTWEdjWMbVbC0YO69oV1FkSo31Fo=;
 b=aISBfk95UwpnxNAsSrO/ChJHaREvvNPqnZR2Tbq9s8s4H736RruL/HkQV2yqnyP12viY82
 LHWlBF/DKqnrg6B+NefXlUz7LKDz/SfC07JiYzv5A8Dx7srdvxds3E5cUNoBysqkuLDc4U
 exjAfOksc+rjNu/sEnm2a+sq4IBQrgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-nujtIBIjM5aIN7nW2jXh7Q-1; Tue, 30 Jun 2020 04:46:05 -0400
X-MC-Unique: nujtIBIjM5aIN7nW2jXh7Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90181800D5C;
 Tue, 30 Jun 2020 08:46:04 +0000 (UTC)
Received: from localhost (ovpn-113-102.ams2.redhat.com [10.36.113.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D21965D9DC;
 Tue, 30 Jun 2020 08:46:03 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/4] iotests: Test node/bitmap aliases during migration
Date: Tue, 30 Jun 2020 10:45:52 +0200
Message-Id: <20200630084552.46362-5-mreitz@redhat.com>
In-Reply-To: <20200630084552.46362-1-mreitz@redhat.com>
References: <20200630084552.46362-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/300     | 487 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out |   5 +
 tests/qemu-iotests/group   |   1 +
 3 files changed, 493 insertions(+)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
new file mode 100755
index 0000000000..621a60e179
--- /dev/null
+++ b/tests/qemu-iotests/300
@@ -0,0 +1,487 @@
+#!/usr/bin/env python3
+#
+# Tests for dirty bitmaps migration with node aliases
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+import os
+import random
+from typing import Dict, List, Union
+import iotests
+
+assert iotests.sock_dir is not None
+mig_sock = os.path.join(iotests.sock_dir, 'mig_sock')
+
+class TestDirtyBitmapMigration(iotests.QMPTestCase):
+    src_node_name: str = ''
+    dst_node_name: str = ''
+    src_bmap_name: str = ''
+    dst_bmap_name: str = ''
+
+    def setUp(self) -> None:
+        self.vm_a = iotests.VM(path_suffix='-a')
+        self.vm_a.add_blockdev(f'node-name={self.src_node_name},' \
+                               'driver=null-co')
+        self.vm_a.launch()
+
+        self.vm_b = iotests.VM(path_suffix='-b')
+        self.vm_b.add_blockdev(f'node-name={self.dst_node_name},' \
+                               'driver=null-co')
+        self.vm_b.add_incoming(f'unix:{mig_sock}')
+        self.vm_b.launch()
+
+        result = self.vm_a.qmp('block-dirty-bitmap-add',
+                               node=self.src_node_name,
+                               name=self.src_bmap_name)
+        self.assert_qmp(result, 'return', {})
+
+        # Dirty some random megabytes
+        for _ in range(9):
+            mb_ofs = random.randrange(1024)
+            self.vm_a.hmp_qemu_io(self.src_node_name, 'write %dM 1M' % mb_ofs)
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node=self.src_node_name,
+                               name=self.src_bmap_name)
+        self.bitmap_hash_reference = result['return']['sha256']
+
+        caps = [{'capability': name, 'state': True} \
+                for name in ('dirty-bitmaps', 'events')]
+
+        for vm in (self.vm_a, self.vm_b):
+            result = vm.qmp('migrate-set-capabilities', capabilities=caps)
+            self.assert_qmp(result, 'return', {})
+
+    def tearDown(self) -> None:
+        self.vm_a.shutdown()
+        self.vm_b.shutdown()
+        try:
+            os.remove(mig_sock)
+        except OSError:
+            pass
+
+    def check_bitmap(self, bitmap_name_valid: bool) -> None:
+        result = self.vm_b.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node=self.dst_node_name,
+                               name=self.dst_bmap_name)
+        if bitmap_name_valid:
+            self.assert_qmp(result, 'return/sha256',
+                            self.bitmap_hash_reference)
+        else:
+            self.assert_qmp(result, 'error/desc',
+                            f"Dirty bitmap '{self.dst_bmap_name}' not found")
+
+    def migrate(self, migration_success: bool = True,
+                bitmap_name_valid: bool = True) -> None:
+        result = self.vm_a.qmp('migrate', uri=f'unix:{mig_sock}')
+        self.assert_qmp(result, 'return', {})
+
+        status = None
+        while status not in ('completed', 'failed'):
+            status = self.vm_a.event_wait('MIGRATION')['data']['status']
+
+        self.assertEqual(status == 'completed', migration_success)
+        if status == 'failed':
+            # Wait until the migration has been cleaned up
+            # (Otherwise, bdrv_close_all() will abort because the
+            # dirty bitmap migration code still holds a reference to
+            # the BDS)
+            # (Unfortunately, there does not appear to be a nicer way
+            # of waiting until a failed migration has been cleaned up)
+            timeout_msg = 'Timeout waiting for migration to be cleaned up'
+            with iotests.Timeout(30, timeout_msg):
+                while os.path.exists(mig_sock):
+                    pass
+
+                # Dropping src_node_name will only work once the
+                # bitmap migration code has released it
+                while 'error' in self.vm_a.qmp('blockdev-del',
+                                               node_name=self.src_node_name):
+                    pass
+
+            return
+
+        self.vm_a.wait_for_runstate('postmigrate')
+        self.vm_b.wait_for_runstate('running')
+
+        self.check_bitmap(bitmap_name_valid)
+
+    @staticmethod
+    def mapping(node_name: str, node_alias: str,
+                bitmap_name: str, bitmap_alias: str) \
+        -> List[Dict[str, Union[str, List[Dict[str, str]]]]]:
+        return [{
+            'node-name': node_name,
+            'alias': node_alias,
+            'bitmaps': [{
+                'name': bitmap_name,
+                'alias': bitmap_alias
+            }]
+        }]
+
+
+class TestAliasMigration(TestDirtyBitmapMigration):
+    src_node_name = 'node0'
+    dst_node_name = 'node0'
+    src_bmap_name = 'bmap0'
+    dst_bmap_name = 'bmap0'
+
+    def test_migration_without_alias(self) -> None:
+        self.migrate(self.src_node_name == self.dst_node_name,
+                     self.src_bmap_name == self.dst_bmap_name)
+
+    def test_alias_on_src_migration(self) -> None:
+        mapping = self.mapping(self.src_node_name, self.dst_node_name,
+                               self.src_bmap_name, self.dst_bmap_name)
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate()
+
+    def test_alias_on_dst_migration(self) -> None:
+        mapping = self.mapping(self.dst_node_name, self.src_node_name,
+                               self.dst_bmap_name, self.src_bmap_name)
+
+        result = self.vm_b.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate()
+
+    def test_alias_on_both_migration(self) -> None:
+        src_map = self.mapping(self.src_node_name, 'node-alias',
+                               self.src_bmap_name, 'bmap-alias')
+
+        dst_map = self.mapping(self.dst_node_name, 'node-alias',
+                               self.dst_bmap_name, 'bmap-alias')
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=src_map)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm_b.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=dst_map)
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate()
+
+
+class TestNodeAliasMigration(TestAliasMigration):
+    src_node_name = 'node-src'
+    dst_node_name = 'node-dst'
+
+
+class TestBitmapAliasMigration(TestAliasMigration):
+    src_bmap_name = 'bmap-src'
+    dst_bmap_name = 'bmap-dst'
+
+
+class TestFullAliasMigration(TestAliasMigration):
+    src_node_name = 'node-src'
+    dst_node_name = 'node-dst'
+    src_bmap_name = 'bmap-src'
+    dst_bmap_name = 'bmap-dst'
+
+
+class TestBlockBitmapMappingErrors(TestDirtyBitmapMigration):
+    src_node_name = 'node0'
+    dst_node_name = 'node0'
+    src_bmap_name = 'bmap0'
+    dst_bmap_name = 'bmap0'
+
+    """
+    Note that mapping nodes or bitmaps that do not exist is not an error.
+    """
+
+    def test_non_injective_node_mapping(self) -> None:
+        mapping = [
+            {
+                'node-name': 'node0',
+                'alias': 'common-alias',
+                'bitmaps': [{
+                    'name': 'bmap0',
+                    'alias': 'bmap-alias0'
+                }]
+            },
+            {
+                'node-name': 'node1',
+                'alias': 'common-alias',
+                'bitmaps': [{
+                    'name': 'bmap1',
+                    'alias': 'bmap-alias1'
+                }]
+            }
+        ]
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'error/desc',
+                        'Invalid mapping given for block-bitmap-mapping: ' \
+                        'The node alias common-alias is used twice')
+
+    def test_non_injective_bitmap_mapping(self) -> None:
+        mapping = [{
+            'node-name': 'node0',
+            'alias': 'node-alias0',
+            'bitmaps': [
+                {
+                    'name': 'bmap0',
+                    'alias': 'common-alias'
+                },
+                {
+                    'name': 'bmap1',
+                    'alias': 'common-alias'
+                }
+            ]
+        }]
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'error/desc',
+                        'Invalid mapping given for block-bitmap-mapping: ' \
+                        'The bitmap alias node-alias0/common-alias is used ' \
+                        'twice')
+
+    def test_ambiguous_node_mapping(self) -> None:
+        mapping = [
+            {
+                'node-name': 'node0',
+                'alias': 'node-alias0',
+                'bitmaps': [{
+                    'name': 'bmap0',
+                    'alias': 'bmap-alias0'
+                }]
+            },
+            {
+                'node-name': 'node0',
+                'alias': 'node-alias1',
+                'bitmaps': [{
+                    'name': 'bmap0',
+                    'alias': 'bmap-alias0'
+                }]
+            }
+        ]
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'error/desc',
+                        'Invalid mapping given for block-bitmap-mapping: ' \
+                        'The node name node0 is mapped twice')
+
+    def test_ambiguous_bitmap_mapping(self) -> None:
+        mapping = [{
+            'node-name': 'node0',
+            'alias': 'node-alias0',
+            'bitmaps': [
+                {
+                    'name': 'bmap0',
+                    'alias': 'bmap-alias0'
+                },
+                {
+                    'name': 'bmap0',
+                    'alias': 'bmap-alias1'
+                }
+            ]
+        }]
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'error/desc',
+                        'Invalid mapping given for block-bitmap-mapping: ' \
+                        'The bitmap node0/bmap0 is mapped twice')
+
+    def test_migratee_node_is_not_mapped_on_src(self) -> None:
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=[])
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate(False, False)
+
+        self.vm_a.shutdown()
+        self.assertIn(f"Bitmap '{self.src_bmap_name}' on node " \
+                      f"'{self.src_node_name}' with no alias cannot be " \
+                      "migrated",
+                      self.vm_a.get_log())
+
+    def test_migratee_node_is_not_mapped_on_dst(self) -> None:
+        result = self.vm_b.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=[])
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate(False, False)
+
+        self.vm_b.shutdown()
+        self.assertIn(f"Unknown node alias '{self.src_node_name}'",
+                      self.vm_b.get_log())
+
+    def test_migratee_bitmap_is_not_mapped_on_src(self) -> None:
+        mapping = [{
+            'node-name': self.src_node_name,
+            'alias': self.dst_node_name,
+            'bitmaps': []
+        }]
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate(False, False)
+
+        self.vm_a.shutdown()
+        self.assertIn(f"Bitmap '{self.src_bmap_name}' with no alias on node " \
+                      f"'{self.src_node_name}' cannot be migrated",
+                      self.vm_a.get_log())
+
+    def test_migratee_bitmap_is_not_mapped_on_dst(self) -> None:
+        mapping = [{
+            'node-name': self.dst_node_name,
+            'alias': self.src_node_name,
+            'bitmaps': []
+        }]
+
+        result = self.vm_b.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate(False, False)
+
+        self.vm_b.shutdown()
+        self.assertIn(f"Unknown bitmap alias '{self.src_bmap_name}' on node " \
+                      f"'{self.dst_node_name}' (alias '{self.src_node_name}')",
+                      self.vm_b.get_log())
+
+    def test_non_wellformed_node_alias(self) -> None:
+        mapping = [{
+            'node-name': self.src_bmap_name,
+            'alias': '123-foo',
+            'bitmaps': []
+        }]
+
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=mapping)
+        self.assert_qmp(result, 'error/desc',
+                        'Invalid mapping given for block-bitmap-mapping: ' \
+                        'The node alias 123-foo is not well-formed')
+
+
+class TestCrossAliasMigration(TestDirtyBitmapMigration):
+    """
+    Swap aliases, both to see that qemu does not get confused, and
+    that we can migrate multiple things at once.
+
+    So we migrate this:
+      node-a.bmap-a -> node-b.bmap-b
+      node-a.bmap-b -> node-b.bmap-a
+      node-b.bmap-a -> node-a.bmap-b
+      node-b.bmap-b -> node-a.bmap-a
+    """
+
+    src_node_name = 'node-a'
+    dst_node_name = 'node-b'
+    src_bmap_name = 'bmap-a'
+    dst_bmap_name = 'bmap-b'
+
+    def setUp(self) -> None:
+        TestDirtyBitmapMigration.setUp(self)
+
+        # Now create another block device and let both have two bitmaps each
+        result = self.vm_a.qmp('blockdev-add',
+                               node_name='node-b', driver='null-co')
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm_b.qmp('blockdev-add',
+                               node_name='node-a', driver='null-co')
+        self.assert_qmp(result, 'return', {})
+
+        bmaps_to_add = (('node-a', 'bmap-b'),
+                        ('node-b', 'bmap-a'),
+                        ('node-b', 'bmap-b'))
+
+        for (node, bmap) in bmaps_to_add:
+            result = self.vm_a.qmp('block-dirty-bitmap-add',
+                                   node=node, name=bmap)
+            self.assert_qmp(result, 'return', {})
+
+    @staticmethod
+    def cross_mapping() -> List[Dict[str, Union[str, List[Dict[str, str]]]]]:
+        return [
+            {
+                'node-name': 'node-a',
+                'alias': 'node-b',
+                'bitmaps': [
+                    {
+                        'name': 'bmap-a',
+                        'alias': 'bmap-b'
+                    },
+                    {
+                        'name': 'bmap-b',
+                        'alias': 'bmap-a'
+                    }
+                ]
+            },
+            {
+                'node-name': 'node-b',
+                'alias': 'node-a',
+                'bitmaps': [
+                    {
+                        'name': 'bmap-b',
+                        'alias': 'bmap-a'
+                    },
+                    {
+                        'name': 'bmap-a',
+                        'alias': 'bmap-b'
+                    }
+                ]
+            }
+        ]
+
+    def verify_dest_has_all_bitmaps(self) -> None:
+        bitmaps = self.vm_a.query_bitmaps()
+
+        # Extract and sort bitmap names
+        for node in bitmaps:
+            bitmaps[node] = sorted((bmap['name'] for bmap in bitmaps[node]))
+
+        self.assertEqual(bitmaps,
+                         {'node-a': ['bmap-a', 'bmap-b'],
+                          'node-b': ['bmap-a', 'bmap-b']})
+
+    def test_alias_on_src(self) -> None:
+        result = self.vm_a.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=self.cross_mapping())
+        self.assert_qmp(result, 'return', {})
+
+        # Checks that node-a.bmap-a was migrated to node-b.bmap-b, and
+        # that is enough
+        self.migrate()
+
+        self.verify_dest_has_all_bitmaps()
+
+    def test_alias_on_dst(self) -> None:
+        result = self.vm_b.qmp('migrate-set-parameters',
+                               block_bitmap_mapping=self.cross_mapping())
+        self.assert_qmp(result, 'return', {})
+
+        # Checks that node-a.bmap-a was migrated to node-b.bmap-b, and
+        # that is enough
+        self.migrate()
+
+        self.verify_dest_has_all_bitmaps()
+
+
+if __name__ == '__main__':
+    iotests.main(supported_protocols=['file'])
diff --git a/tests/qemu-iotests/300.out b/tests/qemu-iotests/300.out
new file mode 100644
index 0000000000..6d9bee1a4b
--- /dev/null
+++ b/tests/qemu-iotests/300.out
@@ -0,0 +1,5 @@
+...........................
+----------------------------------------------------------------------
+Ran 27 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d886fa0cb3..be93b513b8 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -302,3 +302,4 @@
 291 rw quick
 292 rw auto quick
 297 meta
+300 migration
-- 
2.26.2


