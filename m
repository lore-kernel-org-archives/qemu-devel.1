Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E3FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF40020759
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 12:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPML/uex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF40020759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZZoL-0004Fe-17
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 08:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZih-0002JU-2n
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47692
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jZZif-000278-4x
 for qemu-devel@nongnu.org; Fri, 15 May 2020 08:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589546740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tCfxbEtQqZs5JrNHeQ27Uq5tlNIM45o4v+oWJ8/63g0=;
 b=OPML/uexAboaINJMdoTReN+3eVTwV4lT2HSmQvIOltGbMaY7vnelht7n1VsdTK65pAtMag
 1IoaWdOJT6IAiT+48fhxGWSiH3/wSV55t+ASTOc8vraU2xynEDfuu4K01A+rnAQEsnV6Gl
 zgymgXYsN+pzSEdqztiJPIJOULzax6g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-GSGZH1FbNkWyx4jDjJqMfw-1; Fri, 15 May 2020 08:45:36 -0400
X-MC-Unique: GSGZH1FbNkWyx4jDjJqMfw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1186819200C1;
 Fri, 15 May 2020 12:45:35 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-110.ams2.redhat.com
 [10.36.113.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 18A3C2E024;
 Fri, 15 May 2020 12:45:33 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 04/51] iotests: Mirror with different source/target size
Date: Fri, 15 May 2020 14:44:34 +0200
Message-Id: <20200515124521.335403-5-kwolf@redhat.com>
In-Reply-To: <20200515124521.335403-1-kwolf@redhat.com>
References: <20200515124521.335403-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 22:56:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests that the mirror job catches situations where the target node
has a different size than the source node. It must also forbid resize
operations when the job is already running.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200511135825.219437-5-kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/041     | 45 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 1812dd8479..601c756117 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -240,6 +240,49 @@ class TestSingleBlockdev(TestSingleDrive):
                              target=self.qmp_target)
         self.assert_qmp(result, 'error/class', 'GenericError')
 
+    def do_test_resize(self, device, node):
+        def pre_finalize():
+            if device:
+                result = self.vm.qmp('block_resize', device=device, size=65536)
+                self.assert_qmp(result, 'error/class', 'GenericError')
+
+            result = self.vm.qmp('block_resize', node_name=node, size=65536)
+            self.assert_qmp(result, 'error/class', 'GenericError')
+
+        result = self.vm.qmp(self.qmp_cmd, job_id='job0', device='drive0',
+                             sync='full', target=self.qmp_target,
+                             auto_finalize=False, auto_dismiss=False)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.run_job('job0', auto_finalize=False,
+                                 pre_finalize=pre_finalize)
+        self.assertEqual(result, None)
+
+    def test_source_resize(self):
+        self.do_test_resize('drive0', 'top')
+
+    def test_target_resize(self):
+        self.do_test_resize(None, self.qmp_target)
+
+    def do_test_target_size(self, size):
+        result = self.vm.qmp('block_resize', node_name=self.qmp_target,
+                             size=size)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp(self.qmp_cmd, job_id='job0',
+                             device='drive0', sync='full', auto_dismiss=False,
+                             target=self.qmp_target)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.run_job('job0')
+        self.assertEqual(result, 'Source and target image have different sizes')
+
+    def test_small_target(self):
+        self.do_test_target_size(self.image_len // 2)
+
+    def test_large_target(self):
+        self.do_test_target_size(self.image_len * 2)
+
     test_large_cluster = None
     test_image_not_found = None
     test_small_buffer2 = None
@@ -251,6 +294,8 @@ class TestSingleDriveZeroLength(TestSingleDrive):
 
 class TestSingleBlockdevZeroLength(TestSingleBlockdev):
     image_len = 0
+    test_small_target = None
+    test_large_target = None
 
 class TestSingleDriveUnalignedLength(TestSingleDrive):
     image_len = 1025 * 1024
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 877b76fd31..53abe11d73 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-..............................................................................................
+........................................................................................................
 ----------------------------------------------------------------------
-Ran 94 tests
+Ran 104 tests
 
 OK
-- 
2.25.4


