Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408FAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:14:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED8F32224D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 14:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bb9OzKl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED8F32224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k97oZ-00023F-71
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 10:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97j8-0007k9-Lu
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k97j4-0004aM-Ek
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 10:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598018941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=utOUJzpcufX05SSRrX/MVtEK87W4K1Te9K0n/0E9ctc=;
 b=bb9OzKl+vKTz/e0C+jvbHae8zruFz5MeP/rW1neKNRISav+5HnzMD18d5FaZcBnlG1ljMD
 VCLTckdug2Lp8XsRB5j86ao0mpN2XU2IA0gkDM+/YsOk3FbrMsrdSUbZOgMWtTPZW2BTfS
 xzsT7UmPaidWlwiYD0U3bWkqQ0EqliQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-PG26rx8JO56qPydtWUH5YA-1; Fri, 21 Aug 2020 10:08:44 -0400
X-MC-Unique: PG26rx8JO56qPydtWUH5YA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3786101962F;
 Fri, 21 Aug 2020 14:08:43 +0000 (UTC)
Received: from blue.redhat.com (ovpn-113-220.phx2.redhat.com [10.3.113.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C4087AEC5;
 Fri, 21 Aug 2020 14:08:43 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/14] iotests: Test node/bitmap aliases during migration
Date: Fri, 21 Aug 2020 09:08:26 -0500
Message-Id: <20200821140826.194322-15-eblake@redhat.com>
In-Reply-To: <20200821140826.194322-1-eblake@redhat.com>
References: <20200821140826.194322-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200820150725.68687-4-mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
[eblake: fold in python cleanups recommended by Vladimir]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/300     | 593 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out |   5 +
 tests/qemu-iotests/group   |   1 +
 3 files changed, 599 insertions(+)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
new file mode 100755
index 000000000000..5b75121b8496
--- /dev/null
+++ b/tests/qemu-iotests/300
@@ -0,0 +1,593 @@
+#!/usr/bin/env python3
+#
+# Copyright (C) 2020 Red Hat, Inc.
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
+import re
+from typing import Dict, List, Optional, Union
+import iotests
+import qemu
+
+BlockBitmapMapping = List[Dict[str, Union[str, List[Dict[str, str]]]]]
+
+assert iotests.sock_dir is not None
+mig_sock = os.path.join(iotests.sock_dir, 'mig_sock')
+
+
+class TestDirtyBitmapMigration(iotests.QMPTestCase):
+    src_node_name: str = ''
+    dst_node_name: str = ''
+    src_bmap_name: str = ''
+    dst_bmap_name: str = ''
+
+    def setUp(self) -> None:
+        self.vm_a = iotests.VM(path_suffix='-a')
+        self.vm_a.add_blockdev(f'node-name={self.src_node_name},'
+                               'driver=null-co')
+        self.vm_a.launch()
+
+        self.vm_b = iotests.VM(path_suffix='-b')
+        self.vm_b.add_blockdev(f'node-name={self.dst_node_name},'
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
+            self.vm_a.hmp_qemu_io(self.src_node_name, f'discard {mb_ofs}M 1M')
+
+        result = self.vm_a.qmp('x-debug-block-dirty-bitmap-sha256',
+                               node=self.src_node_name,
+                               name=self.src_bmap_name)
+        self.bitmap_hash_reference = result['return']['sha256']
+
+        caps = [{'capability': name, 'state': True}
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
+    def migrate(self, bitmap_name_valid: bool = True,
+                migration_success: bool = True) -> None:
+        result = self.vm_a.qmp('migrate', uri=f'unix:{mig_sock}')
+        self.assert_qmp(result, 'return', {})
+
+        with iotests.Timeout(5, 'Timeout waiting for migration to complete'):
+            self.assertEqual(self.vm_a.wait_migration('postmigrate'),
+                             migration_success)
+            self.assertEqual(self.vm_b.wait_migration('running'),
+                             migration_success)
+
+        if migration_success:
+            self.check_bitmap(bitmap_name_valid)
+
+    def verify_dest_error(self, msg: Optional[str]) -> None:
+        """
+        Check whether the given error message is present in vm_b's log.
+        (vm_b is shut down to do so.)
+        If @msg is None, check that there has not been any error.
+        """
+        self.vm_b.shutdown()
+        if msg is None:
+            self.assertNotIn('qemu-system-', self.vm_b.get_log())
+        else:
+            self.assertIn(msg, self.vm_b.get_log())
+
+    @staticmethod
+    def mapping(node_name: str, node_alias: str,
+                bitmap_name: str, bitmap_alias: str) -> BlockBitmapMapping:
+        return [{
+            'node-name': node_name,
+            'alias': node_alias,
+            'bitmaps': [{
+                'name': bitmap_name,
+                'alias': bitmap_alias
+            }]
+        }]
+
+    def set_mapping(self, vm: iotests.VM, mapping: BlockBitmapMapping,
+                    error: Optional[str] = None) -> None:
+        """
+        Invoke migrate-set-parameters on @vm to set the given @mapping.
+        Check for success if @error is None, or verify the error message
+        if it is not.
+        On success, verify that "info migrate_parameters" on HMP returns
+        our mapping.  (Just to check its formatting code.)
+        """
+        result = vm.qmp('migrate-set-parameters',
+                        block_bitmap_mapping=mapping)
+
+        if error is None:
+            self.assert_qmp(result, 'return', {})
+
+            result = vm.qmp('human-monitor-command',
+                            command_line='info migrate_parameters')
+
+            m = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
+                          result['return'], flags=re.MULTILINE)
+            hmp_mapping = m.group(0).replace('\r', '') if m else None
+
+            self.assertEqual(hmp_mapping, self.to_hmp_mapping(mapping))
+        else:
+            self.assert_qmp(result, 'error/desc', error)
+
+    @staticmethod
+    def to_hmp_mapping(mapping: BlockBitmapMapping) -> str:
+        result = 'block-bitmap-mapping:\n'
+
+        for node in mapping:
+            result += f"  '{node['node-name']}' -> '{node['alias']}'\n"
+
+            assert isinstance(node['bitmaps'], list)
+            for bitmap in node['bitmaps']:
+                result += f"    '{bitmap['name']}' -> '{bitmap['alias']}'\n"
+
+        return result
+
+
+class TestAliasMigration(TestDirtyBitmapMigration):
+    src_node_name = 'node0'
+    dst_node_name = 'node0'
+    src_bmap_name = 'bmap0'
+    dst_bmap_name = 'bmap0'
+
+    def test_migration_without_alias(self) -> None:
+        self.migrate(self.src_node_name == self.dst_node_name and
+                     self.src_bmap_name == self.dst_bmap_name)
+
+        # Check for error message on the destination
+        if self.src_node_name != self.dst_node_name:
+            self.verify_dest_error(f"Cannot find "
+                                   f"device={self.src_node_name} nor "
+                                   f"node_name={self.src_node_name}")
+        else:
+            self.verify_dest_error(None)
+
+    def test_alias_on_src_migration(self) -> None:
+        mapping = self.mapping(self.src_node_name, self.dst_node_name,
+                               self.src_bmap_name, self.dst_bmap_name)
+
+        self.set_mapping(self.vm_a, mapping)
+        self.migrate()
+        self.verify_dest_error(None)
+
+    def test_alias_on_dst_migration(self) -> None:
+        mapping = self.mapping(self.dst_node_name, self.src_node_name,
+                               self.dst_bmap_name, self.src_bmap_name)
+
+        self.set_mapping(self.vm_b, mapping)
+        self.migrate()
+        self.verify_dest_error(None)
+
+    def test_alias_on_both_migration(self) -> None:
+        src_map = self.mapping(self.src_node_name, 'node-alias',
+                               self.src_bmap_name, 'bmap-alias')
+
+        dst_map = self.mapping(self.dst_node_name, 'node-alias',
+                               self.dst_bmap_name, 'bmap-alias')
+
+        self.set_mapping(self.vm_a, src_map)
+        self.set_mapping(self.vm_b, dst_map)
+        self.migrate()
+        self.verify_dest_error(None)
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
+class TestLongBitmapNames(TestAliasMigration):
+    # Giving long bitmap names is OK, as long as there is a short alias for
+    # migration
+    src_bmap_name = 'a' * 512
+    dst_bmap_name = 'b' * 512
+
+    # Skip all tests that do not use the intermediate alias
+    def test_migration_without_alias(self) -> None:
+        pass
+
+    def test_alias_on_src_migration(self) -> None:
+        pass
+
+    def test_alias_on_dst_migration(self) -> None:
+        pass
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
+        mapping: BlockBitmapMapping = [
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
+        self.set_mapping(self.vm_a, mapping,
+                         "Invalid mapping given for block-bitmap-mapping: "
+                         "The node alias 'common-alias' is used twice")
+
+    def test_non_injective_bitmap_mapping(self) -> None:
+        mapping: BlockBitmapMapping = [{
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
+        self.set_mapping(self.vm_a, mapping,
+                         "Invalid mapping given for block-bitmap-mapping: "
+                         "The bitmap alias 'node-alias0'/'common-alias' is "
+                         "used twice")
+
+    def test_ambiguous_node_mapping(self) -> None:
+        mapping: BlockBitmapMapping = [
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
+        self.set_mapping(self.vm_a, mapping,
+                         "Invalid mapping given for block-bitmap-mapping: "
+                         "The node name 'node0' is mapped twice")
+
+    def test_ambiguous_bitmap_mapping(self) -> None:
+        mapping: BlockBitmapMapping = [{
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
+        self.set_mapping(self.vm_a, mapping,
+                         "Invalid mapping given for block-bitmap-mapping: "
+                         "The bitmap 'node0'/'bmap0' is mapped twice")
+
+    def test_migratee_node_is_not_mapped_on_src(self) -> None:
+        self.set_mapping(self.vm_a, [])
+        # Should just ignore all bitmaps on unmapped nodes
+        self.migrate(False)
+        self.verify_dest_error(None)
+
+    def test_migratee_node_is_not_mapped_on_dst(self) -> None:
+        self.set_mapping(self.vm_b, [])
+        self.migrate(False)
+        self.verify_dest_error(f"Unknown node alias '{self.src_node_name}'")
+
+    def test_migratee_bitmap_is_not_mapped_on_src(self) -> None:
+        mapping: BlockBitmapMapping = [{
+            'node-name': self.src_node_name,
+            'alias': self.dst_node_name,
+            'bitmaps': []
+        }]
+
+        self.set_mapping(self.vm_a, mapping)
+        # Should just ignore all unmapped bitmaps
+        self.migrate(False)
+        self.verify_dest_error(None)
+
+    def test_migratee_bitmap_is_not_mapped_on_dst(self) -> None:
+        mapping: BlockBitmapMapping = [{
+            'node-name': self.dst_node_name,
+            'alias': self.src_node_name,
+            'bitmaps': []
+        }]
+
+        self.set_mapping(self.vm_b, mapping)
+        self.migrate(False)
+        self.verify_dest_error(f"Unknown bitmap alias "
+                               f"'{self.src_bmap_name}' "
+                               f"on node '{self.dst_node_name}' "
+                               f"(alias '{self.src_node_name}')")
+
+    def test_unused_mapping_on_dst(self) -> None:
+        # Let the source not send any bitmaps
+        self.set_mapping(self.vm_a, [])
+
+        # Establish some mapping on the destination
+        self.set_mapping(self.vm_b, [])
+
+        # The fact that there is a mapping on B without any bitmaps
+        # being received should be fine, not fatal
+        self.migrate(False)
+        self.verify_dest_error(None)
+
+    def test_non_wellformed_node_alias(self) -> None:
+        alias = '123-foo'
+
+        mapping: BlockBitmapMapping = [{
+            'node-name': self.src_node_name,
+            'alias': alias,
+            'bitmaps': []
+        }]
+
+        self.set_mapping(self.vm_a, mapping,
+                         f"Invalid mapping given for block-bitmap-mapping: "
+                         f"The node alias '{alias}' is not well-formed")
+
+    def test_node_alias_too_long(self) -> None:
+        alias = 'a' * 256
+
+        mapping: BlockBitmapMapping = [{
+            'node-name': self.src_node_name,
+            'alias': alias,
+            'bitmaps': []
+        }]
+
+        self.set_mapping(self.vm_a, mapping,
+                         f"Invalid mapping given for block-bitmap-mapping: "
+                         f"The node alias '{alias}' is longer than 255 bytes")
+
+    def test_bitmap_alias_too_long(self) -> None:
+        alias = 'a' * 256
+
+        mapping = self.mapping(self.src_node_name, self.dst_node_name,
+                               self.src_bmap_name, alias)
+
+        self.set_mapping(self.vm_a, mapping,
+                         f"Invalid mapping given for block-bitmap-mapping: "
+                         f"The bitmap alias '{alias}' is longer than 255 "
+                         f"bytes")
+
+    def test_bitmap_name_too_long(self) -> None:
+        name = 'a' * 256
+
+        result = self.vm_a.qmp('block-dirty-bitmap-add',
+                               node=self.src_node_name,
+                               name=name)
+        self.assert_qmp(result, 'return', {})
+
+        self.migrate(False, False)
+
+        # Check for the error in the source's log
+        self.vm_a.shutdown()
+        self.assertIn(f"Cannot migrate bitmap '{name}' on node "
+                      f"'{self.src_node_name}': Name is longer than 255 bytes",
+                      self.vm_a.get_log())
+
+        # Expect abnormal shutdown of the destination VM because of
+        # the failed migration
+        try:
+            self.vm_b.shutdown()
+        except qemu.machine.AbnormalShutdown:
+            pass
+
+    def test_aliased_bitmap_name_too_long(self) -> None:
+        # Longer than the maximum for bitmap names
+        self.dst_bmap_name = 'a' * 1024
+
+        mapping = self.mapping(self.dst_node_name, self.src_node_name,
+                               self.dst_bmap_name, self.src_bmap_name)
+
+        # We would have to create this bitmap during migration, and
+        # that would fail, because the name is too long.  Better to
+        # catch it early.
+        self.set_mapping(self.vm_b, mapping,
+                         f"Invalid mapping given for block-bitmap-mapping: "
+                         f"The bitmap name '{self.dst_bmap_name}' is longer "
+                         f"than 1023 bytes")
+
+    def test_node_name_too_long(self) -> None:
+        # Longer than the maximum for node names
+        self.dst_node_name = 'a' * 32
+
+        mapping = self.mapping(self.dst_node_name, self.src_node_name,
+                               self.dst_bmap_name, self.src_bmap_name)
+
+        # During migration, this would appear simply as a node that
+        # cannot be found.  Still better to catch impossible node
+        # names early (similar to test_non_wellformed_node_alias).
+        self.set_mapping(self.vm_b, mapping,
+                         f"Invalid mapping given for block-bitmap-mapping: "
+                         f"The node name '{self.dst_node_name}' is longer "
+                         f"than 31 bytes")
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
+    def cross_mapping() -> BlockBitmapMapping:
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
+        bitmaps = self.vm_b.query_bitmaps()
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
+        self.set_mapping(self.vm_a, self.cross_mapping())
+
+        # Checks that node-a.bmap-a was migrated to node-b.bmap-b, and
+        # that is enough
+        self.migrate()
+        self.verify_dest_has_all_bitmaps()
+        self.verify_dest_error(None)
+
+    def test_alias_on_dst(self) -> None:
+        self.set_mapping(self.vm_b, self.cross_mapping())
+
+        # Checks that node-a.bmap-a was migrated to node-b.bmap-b, and
+        # that is enough
+        self.migrate()
+        self.verify_dest_has_all_bitmaps()
+        self.verify_dest_error(None)
+
+
+if __name__ == '__main__':
+    iotests.main(supported_protocols=['file'])
diff --git a/tests/qemu-iotests/300.out b/tests/qemu-iotests/300.out
new file mode 100644
index 000000000000..cafb8161f7b1
--- /dev/null
+++ b/tests/qemu-iotests/300.out
@@ -0,0 +1,5 @@
+.....................................
+----------------------------------------------------------------------
+Ran 37 tests
+
+OK
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index ecff2621cddc..a53ea7f78b81 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -307,6 +307,7 @@
 296 rw
 297 meta
 299 auto quick
+300 migration
 301 backing quick
 302 quick
 303 rw quick
-- 
2.28.0


