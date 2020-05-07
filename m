Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DDCC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5B8A2070B
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO+iUHjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5B8A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWhx0-000263-2K
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 10:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWhtD-0004rC-Ii
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:52:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43223
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jWhtC-0005m6-Kl
 for qemu-devel@nongnu.org; Thu, 07 May 2020 10:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588863161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OMkRXXg8mRgWBU3O3mWn+2EcBY+4PrxcwBh0WP5YI3E=;
 b=bO+iUHjl7z7dBQ3dgLfpii5JlyziEAxZP9CHX5iEYXDpjnkRIKmOBed7mYCRGTYUSKGoaF
 5Ch0OxZlrs23wulO3WFse3T0s1c8kUdbw+2cCtndyksylMm7Psd25qiauEeqBMkRPMbtb0
 ey/jkFIKRDfm5KrbYh3PqrPdLTdjtbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-ANI_6uPAN--k6wB4vydSEQ-1; Thu, 07 May 2020 10:52:40 -0400
X-MC-Unique: ANI_6uPAN--k6wB4vydSEQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0804100CCC1;
 Thu,  7 May 2020 14:52:38 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-33.ams2.redhat.com [10.36.113.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6F3E7707BA;
 Thu,  7 May 2020 14:52:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] iotests: Mirror with different source/target size
Date: Thu,  7 May 2020 16:52:28 +0200
Message-Id: <20200507145228.323412-4-kwolf@redhat.com>
In-Reply-To: <20200507145228.323412-1-kwolf@redhat.com>
References: <20200507145228.323412-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 03:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This tests that the mirror job catches situations where the target node
has a different size than the source node. It must also forbid resize
operations when the job is already running.

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
                              target=3Dself.qmp_target)
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+    def do_test_resize(self, device, node):
+        def pre_finalize():
+            if device:
+                result =3D self.vm.qmp('block_resize', device=3Ddevice, si=
ze=3D65536)
+                self.assert_qmp(result, 'error/class', 'GenericError')
+
+            result =3D self.vm.qmp('block_resize', node_name=3Dnode, size=
=3D65536)
+            self.assert_qmp(result, 'error/class', 'GenericError')
+
+        result =3D self.vm.qmp(self.qmp_cmd, job_id=3D'job0', device=3D'dr=
ive0',
+                             sync=3D'full', target=3Dself.qmp_target,
+                             auto_finalize=3DFalse, auto_dismiss=3DFalse)
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.run_job('job0', auto_finalize=3DFalse,
+                                 pre_finalize=3Dpre_finalize)
+        self.assertEqual(result, None)
+
+    def test_source_resize(self):
+        self.do_test_resize('drive0', 'top')
+
+    def test_target_resize(self):
+        self.do_test_resize(None, self.qmp_target)
+
+    def do_test_target_size(self, size):
+        result =3D self.vm.qmp('block_resize', node_name=3Dself.qmp_target=
,
+                             size=3Dsize)
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp(self.qmp_cmd, job_id=3D'job0',
+                             device=3D'drive0', sync=3D'full', auto_dismis=
s=3DFalse,
+                             target=3Dself.qmp_target)
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.run_job('job0')
+        self.assertEqual(result, 'Source and target image have different s=
izes')
+
+    def test_small_target(self):
+        self.do_test_target_size(self.image_len // 2)
+
+    def test_large_target(self):
+        self.do_test_target_size(self.image_len * 2)
+
     test_large_cluster =3D None
     test_image_not_found =3D None
     test_small_buffer2 =3D None
@@ -251,6 +294,8 @@ class TestSingleDriveZeroLength(TestSingleDrive):
=20
 class TestSingleBlockdevZeroLength(TestSingleBlockdev):
     image_len =3D 0
+    test_small_target =3D None
+    test_large_target =3D None
=20
 class TestSingleDriveUnalignedLength(TestSingleDrive):
     image_len =3D 1025 * 1024
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 877b76fd31..53abe11d73 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-..........................................................................=
....................
+..........................................................................=
..............................
 ----------------------------------------------------------------------
-Ran 94 tests
+Ran 104 tests
=20
 OK
--=20
2.25.3


