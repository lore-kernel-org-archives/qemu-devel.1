Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9749C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:51:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8864220767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/3VPkfL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8864220767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVyg-0000ry-MF
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDVwZ-0005uv-9J
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:49:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43748)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1kDVwX-0006sU-JM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:49:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599065344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0RSMoQlFPKoMhJiIrLIMZacDgnHgqBUudsX1B8+tBI=;
 b=W/3VPkfLvhjptO4ACY1B2Y2CsIbplPHAxGvhi0nrtMvSzME60K4hSP6SAiXIBnPkTZ+4Wn
 rcfwm7tE4n8nMs5bH3RCQV+6XlwSwlHBF/TsPluxuFcRuViBbcftIGBBftaSQN8+Omr+V8
 qo6gk4gX5JKj4VNfgEKyhNTcq/xZSW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-JawOd8NUNIW7oxA7CQ4IhQ-1; Wed, 02 Sep 2020 12:48:50 -0400
X-MC-Unique: JawOd8NUNIW7oxA7CQ4IhQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A0E71091068;
 Wed,  2 Sep 2020 16:48:49 +0000 (UTC)
Received: from localhost (ovpn-114-169.ams2.redhat.com [10.36.114.169])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B6AF1010405;
 Wed,  2 Sep 2020 16:48:49 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] iotests/041: x-blockdev-reopen during mirror
Date: Wed,  2 Sep 2020 18:48:41 +0200
Message-Id: <20200902164841.214948-4-mreitz@redhat.com>
In-Reply-To: <20200902164841.214948-1-mreitz@redhat.com>
References: <20200902164841.214948-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test what happens when you remove the backing file during a mirror with
sync=top.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 92 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 +-
 2 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index cdbef3ba20..4ed7e293ae 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1432,6 +1432,98 @@ class TestFilters(iotests.QMPTestCase):
         self.complete_and_wait('mirror')
 
 
+class TestReconfDuringMirror(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, backing_img, '1M')
+        qemu_img('create', '-f', iotests.imgfmt, '-b', backing_img,
+                 '-F', iotests.imgfmt, test_img)
+
+        qemu_io('-c', 'write -P 1 0 1M', test_img)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        blockdevs = (
+            { 'node-name': 'backing-file',
+              'driver': 'file',
+              'filename': backing_img },
+
+            { 'node-name': 'backing',
+              'driver': iotests.imgfmt,
+              'file': 'backing-file',
+              'read-only': True },
+
+            { 'node-name': 'source-file',
+              'driver': 'file',
+              'filename': test_img },
+
+            { 'node-name': 'source',
+              'driver': iotests.imgfmt,
+              'file': 'source-file',
+              'backing': 'backing' }
+        )
+
+        for blockdev in blockdevs:
+            result = self.vm.qmp('blockdev-add', **blockdev)
+            self.assert_qmp(result, 'return', {})
+
+    def tearDown(self):
+        self.vm.shutdown()
+
+        os.remove(test_img)
+        os.remove(backing_img)
+
+        try:
+            os.remove(target_img)
+        except OSError:
+            pass
+
+    def test_reconf_during_top_mirror(self):
+        result = self.vm.qmp('drive-mirror',
+                             job_id='mirror',
+                             device='source',
+                             sync='top',
+                             target=target_img,
+                             speed=65536)
+        self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('x-blockdev-reopen',
+                             **{ 'node-name': 'source',
+                                 'driver': iotests.imgfmt,
+                                 'file': 'source-file',
+                                 'backing': None })
+        if 'error' in result:
+            self.assert_qmp(result, 'error/desc',
+                            "Cannot change 'backing' link "
+                            "from 'source' to 'backing'")
+
+            result = self.vm.qmp('block-job-set-speed',
+                                 device='mirror', speed=0)
+            self.assert_qmp(result, 'return', {})
+
+            self.complete_and_wait('mirror')
+
+            # Pass
+            return
+
+        # This is not expected.  Let's see what happens when we drop
+        # the backing file altogether.
+        for node in ('backing', 'backing-file'):
+            result = self.vm.qmp('blockdev-del', node_name=node)
+            self.assert_qmp(result, 'return', {})
+
+        result = self.vm.qmp('block-job-set-speed',
+                             device='mirror', speed=0)
+        self.assert_qmp(result, 'return', {})
+
+        # Completing will now probably result in a segfault, because
+        # it tries to assign 'backing' as the target's backing node
+        self.complete_and_wait('mirror')
+
+        # Either way, this is a failure.
+        self.fail('x-blockdev-reopen should not have succeeded')
+
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'],
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 46651953e8..5273ce86c3 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-...........................................................................................................
+............................................................................................................
 ----------------------------------------------------------------------
-Ran 107 tests
+Ran 108 tests
 
 OK
-- 
2.26.2


