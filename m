Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0086C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:05:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9600B2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 12:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JiSoGiKk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9600B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k17JW-0002Fo-T1
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 08:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k17Gr-000756-S2
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:02:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39785
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k17Go-0002E1-SC
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 08:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596110566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAziPS/t2l9B0wy4h4X7BYPqklWLzEqTK26pplqbCzo=;
 b=JiSoGiKku765Y77w6tBm5jx5WmRVjm/M+FO/BHF8mZ2MnvU6Vs4T/gQFQF7BMiK7Kl/0tv
 heV65cgP2yoqQyXf1DKX5SPYz4ovyb2z5+7m2TNA4pEK57WXmLKxMDRM+eDMLCuki6J1Um
 ScPqUKYzs0GcHi1KTGRTqv1VT2ma/lA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-Ie61kC_uOo6H6-uk6abpYw-1; Thu, 30 Jul 2020 08:02:42 -0400
X-MC-Unique: Ie61kC_uOo6H6-uk6abpYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B6C7107BA6D;
 Thu, 30 Jul 2020 12:02:41 +0000 (UTC)
Received: from localhost (ovpn-113-153.ams2.redhat.com [10.36.113.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BB7A9619B5;
 Thu, 30 Jul 2020 12:02:40 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests/169: Test source cont with backing bmap
Date: Thu, 30 Jul 2020 14:02:34 +0200
Message-Id: <20200730120234.49288-3-mreitz@redhat.com>
In-Reply-To: <20200730120234.49288-1-mreitz@redhat.com>
References: <20200730120234.49288-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/29 23:51:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Max Reitz <mreitz@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test migrating from a VM with a persistent bitmap in the backing chain,
and then continuing that VM after the migration

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/169     | 64 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/169.out |  4 +--
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index 2c5a132aa3..40afb15299 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -24,11 +24,12 @@ import time
 import itertools
 import operator
 import re
-from iotests import qemu_img
+from iotests import qemu_img, qemu_img_create, Timeout
 
 
 disk_a = os.path.join(iotests.test_dir, 'disk_a')
 disk_b = os.path.join(iotests.test_dir, 'disk_b')
+base_a = os.path.join(iotests.test_dir, 'base_a')
 size = '1M'
 mig_file = os.path.join(iotests.test_dir, 'mig_file')
 mig_cmd = 'exec: cat > ' + mig_file
@@ -234,6 +235,67 @@ for cmb in list(itertools.product((True, False), repeat=2)):
     inject_test_case(TestDirtyBitmapMigration, name,
                      'do_test_migration_resume_source', *list(cmb))
 
+
+class TestDirtyBitmapBackingMigration(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img_create('-f', iotests.imgfmt, base_a, size)
+        qemu_img_create('-f', iotests.imgfmt, '-F', iotests.imgfmt,
+                        '-b', base_a, disk_a, size)
+
+        for f in (disk_a, base_a):
+            qemu_img('bitmap', '--add', f, 'bmap0')
+
+        blockdev = {
+            'node-name': 'node0',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': disk_a
+            },
+            'backing': {
+                'node-name': 'node0-base',
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': base_a
+                }
+            }
+        }
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        result = self.vm.qmp('blockdev-add', **blockdev)
+        self.assert_qmp(result, 'return', {})
+
+        # Check that the bitmaps are there
+        for node in self.vm.qmp('query-named-block-nodes', flat=True)['return']:
+            if 'node0' in node['node-name']:
+                self.assert_qmp(node, 'dirty-bitmaps[0]/name', 'bmap0')
+
+        caps = [{'capability': 'events', 'state': True}]
+        result = self.vm.qmp('migrate-set-capabilities', capabilities=caps)
+        self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for f in (disk_a, base_a):
+            os.remove(f)
+
+    def test_cont_on_source(self):
+        """
+        Continue the source after migration.
+        """
+        result = self.vm.qmp('migrate', uri=f'exec: cat > /dev/null')
+        self.assert_qmp(result, 'return', {})
+
+        with Timeout(10, 'Migration timeout'):
+            self.vm.wait_migration('postmigrate')
+
+        result = self.vm.qmp('cont')
+        self.assert_qmp(result, 'return', {})
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/169.out
index 5c26d15c0d..cafb8161f7 100644
--- a/tests/qemu-iotests/169.out
+++ b/tests/qemu-iotests/169.out
@@ -1,5 +1,5 @@
-....................................
+.....................................
 ----------------------------------------------------------------------
-Ran 36 tests
+Ran 37 tests
 
 OK
-- 
2.26.2


