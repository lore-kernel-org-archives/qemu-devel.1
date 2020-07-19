Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77954C433E4
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 12:23:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B91E207DD
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 12:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO2UWcSK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B91E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx8Lc-0007jM-HM
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 08:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jx8Jf-0005Ny-2G
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 08:21:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48603
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jx8Jc-0006Yw-Hi
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 08:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595161271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE6nNZtmYPvYCuM35y5q9HKwhayFHsq4lSNe/0ZYbhM=;
 b=cO2UWcSK0OMM2ErtCDq681mBquQqIFCZOo4dLkn8jVfb3qb+gp1rE4AKAEzAi79K7RiD2Q
 gGcxmJfTkk8MsvuhHWXZV0CdV9wXzGnJWg9if4jtdBvLbCsxKZavl9CMsiEeTNfsSgd5Jo
 YHZbtUdDgZzOzg/Hobtqr9C2aAeRu8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-7pHOths-Nw2XrQDbgndVpA-1; Sun, 19 Jul 2020 08:21:07 -0400
X-MC-Unique: 7pHOths-Nw2XrQDbgndVpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADD7819057A0;
 Sun, 19 Jul 2020 12:21:06 +0000 (UTC)
Received: from starship.redhat.com (unknown [10.35.206.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 364DC5D9CC;
 Sun, 19 Jul 2020 12:21:05 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] qemu-iotests: add testcase for bz #1857490
Date: Sun, 19 Jul 2020 15:20:59 +0300
Message-Id: <20200719122059.59843-3-mlevitsk@redhat.com>
In-Reply-To: <20200719122059.59843-1-mlevitsk@redhat.com>
References: <20200719122059.59843-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 08:21:06
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Test that we can't write-share raw luks images by default,
but we still can with share-rw=on

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/296     | 44 +++++++++++++++++++++++++++++++++++++-
 tests/qemu-iotests/296.out | 12 +++++++++--
 2 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/296 b/tests/qemu-iotests/296
index ec69ec8974..fb7dec88aa 100755
--- a/tests/qemu-iotests/296
+++ b/tests/qemu-iotests/296
@@ -133,6 +133,21 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         )
         self.assert_qmp(result, 'return', {})
 
+
+    ###########################################################################
+    # add virtio-blk consumer for a block device
+    def addImageUser(self, vm, id, disk_id, share_rw=False):
+        result = vm.qmp('device_add', **
+            {
+                'driver': 'virtio-blk',
+                'id': id,
+                'drive': disk_id,
+                'share-rw' : share_rw
+            }
+        )
+
+        iotests.log(result)
+
     # close the encrypted block device
     def closeImageQmp(self, vm, id):
         result = vm.qmp('blockdev-del', **{ 'node-name': id })
@@ -159,7 +174,7 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         vm.run_job('job0')
 
     # test that when the image opened by two qemu processes,
-    # neither of them can update the image
+    # neither of them can update the encryption keys
     def test1(self):
         self.createImg(test_img, self.secrets[0]);
 
@@ -193,6 +208,9 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         os.remove(test_img)
 
 
+    # test that when the image opened by two qemu processes,
+    # even if first VM opens it read-only, the second can't update encryption
+    # keys
     def test2(self):
         self.createImg(test_img, self.secrets[0]);
 
@@ -226,6 +244,30 @@ class EncryptionSetupTestCase(iotests.QMPTestCase):
         self.closeImageQmp(self.vm1, "testdev")
         os.remove(test_img)
 
+    # test that two VMs can't open the same luks image by default
+    # and attach it to a guest device
+    def test3(self):
+        self.createImg(test_img, self.secrets[0]);
+
+        self.openImageQmp(self.vm1, "testdev", test_img, self.secrets[0])
+        self.addImageUser(self.vm1, "testctrl", "testdev")
+
+        self.openImageQmp(self.vm2, "testdev", test_img, self.secrets[0])
+        self.addImageUser(self.vm2, "testctrl", "testdev")
+
+
+    # test that two VMs can attach the same luks image to a guest device,
+    # if both use share-rw=on
+    def test4(self):
+        self.createImg(test_img, self.secrets[0]);
+
+        self.openImageQmp(self.vm1, "testdev", test_img, self.secrets[0])
+        self.addImageUser(self.vm1, "testctrl", "testdev", share_rw=True)
+
+        self.openImageQmp(self.vm2, "testdev", test_img, self.secrets[0])
+        self.addImageUser(self.vm2, "testctrl", "testdev", share_rw=True)
+
+
 
 if __name__ == '__main__':
     # support only raw luks since luks encrypted qcow2 is a proper
diff --git a/tests/qemu-iotests/296.out b/tests/qemu-iotests/296.out
index afb6d2d09d..cb2859a15c 100644
--- a/tests/qemu-iotests/296.out
+++ b/tests/qemu-iotests/296.out
@@ -26,8 +26,16 @@ Job failed: Failed to get shared "consistent read" lock
 {"return": {}}
 {"execute": "job-dismiss", "arguments": {"id": "job0"}}
 {"return": {}}
-..
+Formatting 'TEST_DIR/test.img', fmt=luks size=1048576 key-secret=keysec0 iter-time=10
+
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "Failed to get \"write\" lock"}}
+Formatting 'TEST_DIR/test.img', fmt=luks size=1048576 key-secret=keysec0 iter-time=10
+
+{"return": {}}
+{"return": {}}
+....
 ----------------------------------------------------------------------
-Ran 2 tests
+Ran 4 tests
 
 OK
-- 
2.26.2


