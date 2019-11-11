Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C4C17445
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:15:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51EFF21783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0y+EXoB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51EFF21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCLN-000678-2h
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:15:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUCAB-0000Np-8J
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUCAA-0003AH-6M
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUCAA-00039l-30
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwInKIeB2qHqz5J6Rh6jtjb8BLoBMDSnI+3OT0jmMbs=;
 b=i0y+EXoBDuO2GJmUAYVF4EHiO4UWoFybOGDEUvW+U5Qe6zMOhjNBYH1tBHR/5ZQ9FnERo/
 wfJfJ9+Ir+1ka1Y6qvCBs1acC6dlPV4/SJaiXXXGUSbsUv1YeUxb/M6j/NvshZLyL9lMl6
 Pi2i/HIUZbAv4iSclqHeLOTFSz7bOzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-DX4p-F7uOKW3Albyr_5N-g-1; Mon, 11 Nov 2019 11:03:28 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34FC81005500;
 Mon, 11 Nov 2019 16:03:27 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A1A7C5D9C9;
 Mon, 11 Nov 2019 16:03:26 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 22/23] iotests: Check that @replaces can replace
 filters
Date: Mon, 11 Nov 2019 17:02:15 +0100
Message-Id: <20191111160216.197086-23-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: DX4p-F7uOKW3Albyr_5N-g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/041     | 46 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index ab0cb5b42f..9a00cf6f7b 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1200,6 +1200,52 @@ class TestOrphanedSource(iotests.QMPTestCase):
         self.assertFalse('mirror-filter' in nodes,
                          'Mirror filter node did not disappear')
=20
+# Test cases for @replaces that do not necessarily involve Quorum
+class TestReplaces(iotests.QMPTestCase):
+    # Each of these test cases needs their own block graph, so do not
+    # create any nodes here
+    def setUp(self):
+        self.vm =3D iotests.VM()
+        self.vm.launch()
+
+    def tearDown(self):
+        self.vm.shutdown()
+        for img in (test_img, target_img):
+            try:
+                os.remove(img)
+            except OSError:
+                pass
+
+    """
+    Check that we can replace filter nodes.
+    """
+    @iotests.skip_if_unsupported(['copy-on-read'])
+    def test_replace_filter(self):
+        result =3D self.vm.qmp('blockdev-add', **{
+                                 'driver': 'copy-on-read',
+                                 'node-name': 'filter0',
+                                 'file': {
+                                     'driver': 'copy-on-read',
+                                     'node-name': 'filter1',
+                                     'file': {
+                                         'driver': 'null-co'
+                                     }
+                                 }
+                             })
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-add',
+                             node_name=3D'target', driver=3D'null-co')
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'mirror', devic=
e=3D'filter0',
+                             target=3D'target', sync=3D'full', replaces=3D=
'filter1')
+        self.assert_qmp(result, 'return', {})
+
+        self.complete_and_wait('mirror')
+
+        self.vm.assert_block_path('filter0', '/file', 'target')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
                  supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index ffc779b4d1..877b76fd31 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-..........................................................................=
...................
+..........................................................................=
....................
 ----------------------------------------------------------------------
-Ran 93 tests
+Ran 94 tests
=20
 OK
--=20
2.23.0


