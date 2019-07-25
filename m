Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B08C76194
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2236F2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2236F2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqg90-00079s-2E
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54862)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqg7r-0002pf-Nn
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:57:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqg7q-0006Po-9o
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38574)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqg7n-0006Mp-Ka; Thu, 25 Jul 2019 11:57:47 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EBCC4308427D;
 Thu, 25 Jul 2019 15:57:46 +0000 (UTC)
Received: from localhost (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 666DB60C05;
 Thu, 25 Jul 2019 15:57:46 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 17:57:31 +0200
Message-Id: <20190725155735.11872-4-mreitz@redhat.com>
In-Reply-To: <20190725155735.11872-1-mreitz@redhat.com>
References: <20190725155735.11872-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 25 Jul 2019 15:57:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/7] iotests: Keep testing broken relative
 extent paths
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We had a test for a case where relative extent paths did not work, but
unfortunately we just fixed the underlying problem, so it works now.
This patch adds a new test case that still fails.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/059     | 27 +++++++++++++++++++++++++++
 tests/qemu-iotests/059.out |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index fbed5f9483..2a883d0f21 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -114,6 +114,8 @@ $QEMU_IMG convert -f qcow2 -O vmdk -o subformat=3Dstr=
eamOptimized "$TEST_IMG.qcow2
=20
 echo
 echo "=3D=3D=3D Testing monolithicFlat with internally generated JSON fi=
le name =3D=3D=3D"
+
+echo '--- blkdebug ---'
 # Should work, because bdrv_dirname() works fine with blkdebug
 IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 64M
 $QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3Dblkdebug,file.image.=
filename=3D$TEST_IMG,file.inject-error.0.event=3Dread_aio" \
@@ -122,6 +124,31 @@ $QEMU_IO -c "open -o driver=3D$IMGFMT,file.driver=3D=
blkdebug,file.image.filename=3D$TE
     | _filter_testdir | _filter_imgfmt | _filter_img_info
 _cleanup_test_img
=20
+echo '--- quorum ---'
+# Should not work, because bdrv_dirname() does not work with blkdebug
+IMGOPTS=3D"subformat=3DmonolithicFlat" _make_test_img 64M
+cp "$TEST_IMG" "$TEST_IMG.orig"
+
+filename=3D"json:{
+    \"driver\": \"$IMGFMT\",
+    \"file\": {
+        \"driver\": \"quorum\",
+        \"children\": [ {
+            \"driver\": \"file\",
+            \"filename\": \"$TEST_IMG\"
+        }, {
+            \"driver\": \"file\",
+            \"filename\": \"$TEST_IMG.orig\"
+        } ],
+        \"vote-threshold\": 1
+    } }"
+
+filename=3D$(echo "$filename" | tr '\n' ' ' | sed -e 's/\s\+/ /g')
+$QEMU_IMG info "$filename" 2>&1 \
+    | sed -e "s/'json:[^']*'/\$QUORUM_FILE/g" \
+    | _filter_testdir | _filter_imgfmt | _filter_img_info
+
+
 echo
 echo "=3D=3D=3D Testing version 3 =3D=3D=3D"
 _use_sample_img iotest-version3.vmdk.bz2
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 120cddd207..f8895ba434 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2049,10 +2049,14 @@ wrote 512/512 bytes at offset 10240
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
 =3D=3D=3D Testing monolithicFlat with internally generated JSON file nam=
e =3D=3D=3D
+--- blkdebug ---
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
 format name: IMGFMT
 cluster size: 0 bytes
 vm state offset: 0 bytes
+--- quorum ---
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
+qemu-img: Could not open $QUORUM_FILE: Cannot use relative paths with VM=
DK descriptor file $QUORUM_FILE: Cannot generate a base directory for quo=
rum nodes
=20
 =3D=3D=3D Testing version 3 =3D=3D=3D
 image: TEST_DIR/iotest-version3.IMGFMT
--=20
2.21.0


