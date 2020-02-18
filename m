Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8CBC3403D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CAB208C4
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJqJuiPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CAB208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43pT-0002kr-0B
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53579)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43YU-0000GV-1d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43YS-0001s0-Pe
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:53 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50690
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43YQ-0001pz-Vk
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f6ICy5PzVL5o2G4LzX1fDHHolAA5Nxih4ppS2A9HOB8=;
 b=OJqJuiPPsEymjbojjxeUKBNWBRacuDc9GnorPkLdkilApCe7cLfmsVF5jMHcEOiXLNZbXo
 FWUdUAL94hhmLLn4n+2wdHlFaCbF3tzmxO0usiHLXk/OFw14aol4L1D4hENC+1XgGryt5m
 vftCSiWmpwYic4HKChn5pspdDpe2mPY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-kycOHpg3N4WMKZrgbwGmPQ-1; Tue, 18 Feb 2020 09:08:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC537801E67;
 Tue, 18 Feb 2020 14:08:39 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4DEA19E9C;
 Tue, 18 Feb 2020 14:08:38 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 36/36] iotests: Check that @replaces can replace filters
Date: Tue, 18 Feb 2020 15:07:22 +0100
Message-Id: <20200218140722.23876-37-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kycOHpg3N4WMKZrgbwGmPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

From: Max Reitz <mreitz@redhat.com>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200218103454.296704-20-mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/041     | 46 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 7af6de9124..5d67bf14bf 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1190,6 +1190,52 @@ class TestOrphanedSource(iotests.QMPTestCase):
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
+    @iotests.skip_if_unsupported(['copy-on-read'])
+    def test_replace_filter(self):
+        """
+        Check that we can replace filter nodes.
+        """
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
                  supported_protocols=3D['file'],
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
2.20.1


