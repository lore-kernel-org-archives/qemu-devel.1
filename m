Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA5FFA372C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:42:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C32218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Khq5y/kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C32218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3at-00017D-HC
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:42:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tw-0002d0-A0
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iT3Tu-0003NC-9U
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iT3Tu-0003MD-4L
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573216512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fnhlJ1kNFDl7LtxUc2N0RSuv6nXz/HJqZ0VtYOFU2WI=;
 b=Khq5y/kRUFCZD3Dy9h5F3bp8XQn4lqZ6UTIcL/UMzni1uKV1i76DT6JI6U2OTntZqzILt1
 nN6kIqwjphGwpPx+cqnzaPzR9g+3sdI82iRljjqeFlSSYDyRl2KruclhKKVMR1ZGiMhERq
 nFADRIh05i5amMcBJ8fAzHaMw9sSSGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-ULlBqTUpOdem6n-ceQ_LgA-1; Fri, 08 Nov 2019 07:35:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B1A5477;
 Fri,  8 Nov 2019 12:35:08 +0000 (UTC)
Received: from localhost (ovpn-117-78.ams2.redhat.com [10.36.117.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D7C860BE1;
 Fri,  8 Nov 2019 12:35:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v4 5/5] iotests: Add test for failing mirror complete
Date: Fri,  8 Nov 2019 13:34:55 +0100
Message-Id: <20191108123455.39445-6-mreitz@redhat.com>
In-Reply-To: <20191108123455.39445-1-mreitz@redhat.com>
References: <20191108123455.39445-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: ULlBqTUpOdem6n-ceQ_LgA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/041     | 44 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/041.out |  4 ++--
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index 8568426311..d7be30b62b 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -1121,6 +1121,50 @@ class TestOrphanedSource(iotests.QMPTestCase):
                              target=3D'dest-ro')
         self.assert_qmp(result, 'error/class', 'GenericError')
=20
+    def test_failing_permission_in_complete(self):
+        self.assert_no_active_block_jobs()
+
+        # Unshare consistent-read on the target
+        # (The mirror job does not care)
+        result =3D self.vm.qmp('blockdev-add',
+                             driver=3D'blkdebug',
+                             node_name=3D'dest-perm',
+                             image=3D'dest',
+                             unshare_child_perms=3D['consistent-read'])
+        self.assert_qmp(result, 'return', {})
+
+        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'job', device=
=3D'src',
+                             sync=3D'full', target=3D'dest',
+                             filter_node_name=3D'mirror-filter')
+        self.assert_qmp(result, 'return', {})
+
+        # Require consistent-read on the source
+        # (We can only add this node once the job has started, or it
+        # will complain that it does not want to run on non-root nodes)
+        result =3D self.vm.qmp('blockdev-add',
+                             driver=3D'blkdebug',
+                             node_name=3D'src-perm',
+                             image=3D'src',
+                             take_child_perms=3D['consistent-read'])
+        self.assert_qmp(result, 'return', {})
+
+        # While completing, mirror will attempt to replace src by
+        # dest, which must fail because src-perm requires
+        # consistent-read but dest-perm does not share it; thus
+        # aborting the job when it is supposed to complete
+        self.complete_and_wait('job',
+                               completion_error=3D'Operation not permitted=
')
+
+        # Assert that all of our nodes are still there (except for the
+        # mirror filter, which should be gone despite the failure)
+        nodes =3D self.vm.qmp('query-named-block-nodes')['return']
+        nodes =3D [node['node-name'] for node in nodes]
+
+        for expect in ('src', 'src-perm', 'dest', 'dest-perm'):
+            self.assertTrue(expect in nodes, '%s disappeared' % expect)
+        self.assertFalse('mirror-filter' in nodes,
+                         'Mirror filter node did not disappear')
+
 if __name__ =3D=3D '__main__':
     iotests.main(supported_fmts=3D['qcow2', 'qed'],
                  supported_protocols=3D['file'])
diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
index 2c448b4239..f496be9197 100644
--- a/tests/qemu-iotests/041.out
+++ b/tests/qemu-iotests/041.out
@@ -1,5 +1,5 @@
-..........................................................................=
................
+..........................................................................=
.................
 ----------------------------------------------------------------------
-Ran 90 tests
+Ran 91 tests
=20
 OK
--=20
2.23.0


